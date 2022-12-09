Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C8647DC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLIG3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLIG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:29:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F136DA431F;
        Thu,  8 Dec 2022 22:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Q+uZ2ARHSjzeA60hiURYgn9RnClC8iOtQ6mnjPbu5q8=; b=3j8oA1bzIOuM0rBe3CADYUF4hI
        iSXBgs5hGVdr1Tw2VgebiplbsA7wUUoF8GttXw4PFRRENDALYuMnOC4Qt03OQA4K9vEx9Ttye4n21
        O6koEgMp3ZIETEqZs68rwxJ5dn++Kcel7T5dUwnnjyUUhQeBzuHsAxzvfizdDVFnSTiBTi169jT6m
        pFBO9cgpDDQGR4QWHJVsnVDkLxGALCsxROkq21ZV+1ZBYPf1SAQoxam4K6q6Ka7hgF3BiRHLcvpyP
        oPtWgSxsb4xDPmfxbO5Erh/Z8TdM8GiZtZbtfbtk0QEiTDOjJR81G2Xww7cKUNivqiLAX8bi9R31m
        4DxOmOww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3Wsr-004bLW-QQ; Fri, 09 Dec 2022 06:29:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     dave@stgolabs.net, a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/acpi: fix null dereference on probe for missing ACPI_COMPANION()
Date:   Thu,  8 Dec 2022 22:29:19 -0800
Message-Id: <20221209062919.1096779-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply loading cxl_test ends up triggering a null pointer dereference
on next-20221207, and it happens because the fetched ACPI_COMPANION() can
end up not correct / missing. As with other code which uses ACPI_COMPANION()
(drivers/acpi/device_pm.c comes to mind) be defensive over the assumption
the companion is always present and bail right away.

This can be easily reproduced with kdevops [0] with linux next-20221207 [1]
and cxl enabled workflows:

make menuconfig      # enable cxl and linux-next
make                 # sets up variables, builds qemu from source
make linux           # builds and install next-20221207
make cxl             # installs cxl tool
make cxl-test-probe  # loads cxl_test

The oops:

 # modprobe cxl_test
No TPM handle discovered.
failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory

[0] https://github.com/linux-kdevops/kdevops
[1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20221207

cxl_mock: loading out-of-tree module taints kernel.
cxl_mock: loading test module taints kernel.
cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
cxl_mem mem8: at cxl_root_port.4 no parent for dport: platform
cxl_mem mem9: at cxl_root_port.4 no parent for dport: platform
cxl_mem mem10: CXL port topology not found
BUG: kernel NULL pointer dereference, address: 00000000000002c0
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 4 PID: 1644 Comm: systemd-udevd Kdump: loaded Tainted: G           O     N 6.1.0-rc8-next-20221207 #5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
RIP: 0010:cxl_acpi_probe+0xeb/0x2f0 [cxl_acpi]
Code: ff ff ff 48 c7 40 08 ff ff ff ff 48 c7 40 18 00 02 00 00 e8 57 29 fd ff 49 89 c7 41 89 c4 48 3d 00 f0 ff ff 0f 87 73 ff ff ff <49> 8b bd c0 02 00 00 48 c7 c1 c0 64 e4 c0 48 89 c2 31 f6 e8 bd f1
RSP: 0018:ffffbe6d008b7c30 EFLAGS: 00010287
RAX: ffff97a7c6e01000 RBX: ffff97a7c51fd810 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000282 RDI: 00000000ffffffff
RBP: 0000000000000000 R08: ffff97a7c51fdaa8 R09: 0000000000000010
R10: 0000000000000002 R11: 00000000000013c7 R12: 00000000c6e01000
R13: 0000000000000000 R14: ffff97a7d9c653a8 R15: ffff97a7c6e01000
FS:  00007f34b038ed00(0000) GS:ffff97a83bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002c0 CR3: 0000000102f7e005 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? kernfs_create_link+0x5d/0xa0
 platform_probe+0x41/0x90
 really_probe+0xdb/0x380
 ? pm_runtime_barrier+0x50/0x90
 __driver_probe_device+0x78/0x170
 driver_probe_device+0x1f/0x90
 __driver_attach+0xce/0x1c0
 ? __pfx___driver_attach+0x10/0x10
 bus_for_each_dev+0x73/0xc0
 bus_add_driver+0x1ae/0x200
 driver_register+0x89/0xe0
 ? __pfx_init_module+0x10/0x10 [cxl_acpi]
 do_one_initcall+0x43/0x220
 ? kmalloc_trace+0x26/0x90
 do_init_module+0x4a/0x1f0
 __do_sys_init_module+0x17f/0x1b0
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f34b061baaa
Code: 48 8b 0d 59 83 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 26 83 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff6a198408 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
RAX: ffffffffffffffda RBX: 00005635afc7e5e0 RCX: 00007f34b061baaa
RDX: 00007f34b07a5efd RSI: 0000000000060a29 RDI: 00005635afdd6510
RBP: 00007f34b07a5efd R08: 000000000001f5b3 R09: 0000000000000000
R10: 000000000000eb81 R11: 0000000000000246 R12: 00005635afdd6510
R13: 0000000000000000 R14: 00005635afca6f40 R15: 00005635af874e50
 </TASK>
Modules linked in: cxl_acpi(+) cxl_pmem cxl_mem cxl_port cxl_mock_mem(ON) cxl_test(ON) cxl_mock(ON) cxl_core libnvdimm cbc encrypted_keys kvm_intel kvm 9p netfs irqbypass crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel crypto_simd cryptd cirrus drm_shmem_helper 9pnet_virtio virtio_balloon i6300esb drm_kms_helper joydev evdev button serio_raw drm configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse virtio_pci virtio_pci_legacy_dev nvme virtio_pci_modern_dev crc32_pclmul nvme_core virtio crc32c_intel t10_pi virtio_ring crc64_rocksoft crc64

And gdb:

(gdb) l *(cxl_acpi_probe+0xeb)
0xa8b is in cxl_acpi_probe (tools/testing/cxl/../../../drivers/cxl/acpi.c:648).
643
644             root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
645             if (IS_ERR(root_port))
646                     return PTR_ERR(root_port);
647
648             rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
649                                   add_host_bridge_dport);
650             if (rc < 0)
651                     return rc;
652

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Note: kdevops also suports now the target:

  make cxl-test-meson

But that does not *at least* crash the kernel although the tests fail too...
This is likely a misconfiguration of some sort, but the same kernel
works fine when I enable a Type 3 memory device (also supported on
kdevops via CONFIG_QEMU_ENABLE_CXL_DEMO_TOPOLOGY_1). This test was run
without that enabled, so a naked cxl system.

Even if it *was* a mis-configuration, such things should not crash the kernel.

 drivers/cxl/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ad0849af42d7..cf5d1a455efc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -633,6 +633,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(host);
 	struct cxl_cfmws_context ctx;
 
+	if (!adev)
+		return -ENODEV;
+
 	device_lock_set_class(&pdev->dev, &cxl_root_key);
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
 				      &pdev->dev);
-- 
2.35.1

