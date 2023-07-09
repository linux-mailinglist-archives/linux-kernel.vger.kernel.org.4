Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15774C59F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjGIPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjGIPQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202E26B5;
        Sun,  9 Jul 2023 08:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8B060BFA;
        Sun,  9 Jul 2023 15:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB30C433CD;
        Sun,  9 Jul 2023 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915710;
        bh=tuiAPWSGsj8CpKlD4MIYlrZCU2z67dmDNxy4V+3MrIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/+5R8OwQ/My/fN8JP/Ir75T5FwFpmC/UgT53e5VBIKUYRDLkF+Is6jEM9STwOb2S
         4ePiBZcNWTOBGVk7PdfKiz14jZR7R8aPo+23Au8z2zzL1otbdGNKQSZL8JiZY1BKhw
         sg2BWnbeVFOWOhBZUq3rtGljp1akV8sdxHgfuivT4bAH1/0VkEkldMW7xTeL6ZP3Hi
         RUFufv6RZvX+7Skce5ucADoFoSKe6KpO7WUHMnUOVPCPhcsfLpt9nJ7+3lOGa85RR7
         Af5+38eki2CAXbej5fRJhQ3oqQdYB/JBs5GcYIGZWi/H7BrksTASeJRS6gNBKoUS7m
         IZyZo6tzJWh3w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Oros <poros@redhat.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
        jacob.e.keller@intel.com, moshe@nvidia.com,
        michal.wilczynski@intel.com, vikas.gupta@broadcom.com,
        shayd@nvidia.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/18] devlink: report devlink_port_type_warn source device
Date:   Sun,  9 Jul 2023 11:14:40 -0400
Message-Id: <20230709151446.513549-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151446.513549-1-sashal@kernel.org>
References: <20230709151446.513549-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.38
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Oros <poros@redhat.com>

[ Upstream commit a52305a81d6bb74b90b400dfa56455d37872fe4b ]

devlink_port_type_warn is scheduled for port devlink and warning
when the port type is not set. But from this warning it is not easy
found out which device (driver) has no devlink port set.

[ 3709.975552] Type was not set for devlink port.
[ 3709.975579] WARNING: CPU: 1 PID: 13092 at net/devlink/leftover.c:6775 devlink_port_type_warn+0x11/0x20
[ 3709.993967] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nfnetlink bluetooth rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs vhost_net vhost vhost_iotlb tap tun bridge stp llc qrtr intel_rapl_msr intel_rapl_common i10nm_edac nfit libnvdimm x86_pkg_temp_thermal mlx5_ib intel_powerclamp coretemp dell_wmi ledtrig_audio sparse_keymap ipmi_ssif kvm_intel ib_uverbs rfkill ib_core video kvm iTCO_wdt acpi_ipmi intel_vsec irqbypass ipmi_si iTCO_vendor_support dcdbas ipmi_devintf mei_me ipmi_msghandler rapl mei intel_cstate isst_if_mmio isst_if_mbox_pci dell_smbios intel_uncore isst_if_common i2c_i801 dell_wmi_descriptor wmi_bmof i2c_smbus intel_pch_thermal pcspkr acpi_power_meter xfs libcrc32c sd_mod sg nvme_tcp mgag200 i2c_algo_bit nvme_fabrics drm_shmem_helper drm_kms_helper nvme syscopyarea ahci sysfillrect sysimgblt nvme_core fb_sys_fops crct10dif_pclmul libahci mlx5_core sfc crc32_pclmul nvme_common drm
[ 3709.994030]  crc32c_intel mtd t10_pi mlxfw libata tg3 mdio megaraid_sas psample ghash_clmulni_intel pci_hyperv_intf wmi dm_multipath sunrpc dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse
[ 3710.108431] CPU: 1 PID: 13092 Comm: kworker/1:1 Kdump: loaded Not tainted 5.14.0-319.el9.x86_64 #1
[ 3710.108435] Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.8.2 09/14/2022
[ 3710.108437] Workqueue: events devlink_port_type_warn
[ 3710.108440] RIP: 0010:devlink_port_type_warn+0x11/0x20
[ 3710.108443] Code: 84 76 fe ff ff 48 c7 03 20 0e 1a ad 31 c0 e9 96 fd ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 48 c7 c7 18 24 4e ad e8 ef 71 62 ff <0f> 0b c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f6 87
[ 3710.108445] RSP: 0018:ff3b6d2e8b3c7e90 EFLAGS: 00010282
[ 3710.108447] RAX: 0000000000000000 RBX: ff366d6580127080 RCX: 0000000000000027
[ 3710.108448] RDX: 0000000000000027 RSI: 00000000ffff86de RDI: ff366d753f41f8c8
[ 3710.108449] RBP: ff366d658ff5a0c0 R08: ff366d753f41f8c0 R09: ff3b6d2e8b3c7e18
[ 3710.108450] R10: 0000000000000001 R11: 0000000000000023 R12: ff366d753f430600
[ 3710.108451] R13: ff366d753f436900 R14: 0000000000000000 R15: ff366d753f436905
[ 3710.108452] FS:  0000000000000000(0000) GS:ff366d753f400000(0000) knlGS:0000000000000000
[ 3710.108453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3710.108454] CR2: 00007f1c57bc74e0 CR3: 000000111d26a001 CR4: 0000000000773ee0
[ 3710.108456] PKRU: 55555554
[ 3710.108457] Call Trace:
[ 3710.108458]  <TASK>
[ 3710.108459]  process_one_work+0x1e2/0x3b0
[ 3710.108466]  ? rescuer_thread+0x390/0x390
[ 3710.108468]  worker_thread+0x50/0x3a0
[ 3710.108471]  ? rescuer_thread+0x390/0x390
[ 3710.108473]  kthread+0xdd/0x100
[ 3710.108477]  ? kthread_complete_and_exit+0x20/0x20
[ 3710.108479]  ret_from_fork+0x1f/0x30
[ 3710.108485]  </TASK>
[ 3710.108486] ---[ end trace 1b4b23cd0c65d6a0 ]---

After patch:
[  402.473064] ice 0000:41:00.0: Type was not set for devlink port.
[  402.473064] ice 0000:41:00.1: Type was not set for devlink port.

Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230615095447.8259-1-poros@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/devlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 2aa77d4b80d0a..5a4a4b34ac15c 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -9826,7 +9826,10 @@ EXPORT_SYMBOL_GPL(devlink_free);
 
 static void devlink_port_type_warn(struct work_struct *work)
 {
-	WARN(true, "Type was not set for devlink port.");
+	struct devlink_port *port = container_of(to_delayed_work(work),
+						 struct devlink_port,
+						 type_warn_dw);
+	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
-- 
2.39.2

