Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4E6E0964
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDMIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDMIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:53:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454288A64
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3F131FD67;
        Thu, 13 Apr 2023 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681375984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bObO9oz/A9/0Sku2QXFt+M3BWDj0PJVpuCBGz+UzEfY=;
        b=U8D7w7I6lw4UxMtNivguYMGF+UVO9IPesvxKm5adMC2mHL97GUdLnQopN0y2UNt/z1ppq1
        OhpJVcsdljhA6eJjoCZ52fK/YJtZzd74GOR+ieITbYskOSEEyOM7ivHJqCgyLh7fYZ20sZ
        hVZu8in6xKZ1zyVlOpQDMOLxotW4IJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681375984;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bObO9oz/A9/0Sku2QXFt+M3BWDj0PJVpuCBGz+UzEfY=;
        b=22QvBKE18kaMf4Fyhj1tegWaNmCpG/0cNjsRhh6rkiQUUhJ27qOOVxNzRLvTu/IY42EznS
        Fmu8hs0BU1jCPvBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE27313421;
        Thu, 13 Apr 2023 08:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ymT2LfDCN2RyIAAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 13 Apr 2023 08:53:04 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v2 0/2] nvmem: rmem: Make reserved region name unique
Date:   Thu, 13 Apr 2023 11:52:04 +0300
Message-Id: <20230413085206.149730-1-iivanov@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They could be multiple reserved memory regions,
so let's make their names unique.

This fixes following kernel error:

[    9.831285] sysfs: cannot create duplicate filename '/bus/nvmem/devices/rmem0'
[    9.831304] CPU: 3 PID: 467 Comm: (udev-worker) Not tainted 6.2.9-1-default #1 openSUSE Tumbleweed a4aeb3a90c0f23041a8a7944b12739b07585f009
[    9.831326] Hardware name: raspberrypi rpi/rpi, BIOS 2023.01 01/01/2023
[    9.831335] Call trace:
[    9.831343]  dump_backtrace+0xe4/0x140
[    9.831366]  show_stack+0x20/0x30
[    9.831379]  dump_stack_lvl+0x64/0x80
[    9.831398]  dump_stack+0x18/0x34
[    9.831410]  sysfs_warn_dup+0x6c/0x90
[    9.831424]  sysfs_do_create_link_sd+0xf8/0x100
[    9.831437]  sysfs_create_link+0x28/0x50
[    9.831449]  bus_add_device+0x70/0x190
[    9.831468]  device_add+0x3e8/0x84c
[    9.831481]  nvmem_register+0x85c/0x9f0
[    9.831500]  devm_nvmem_register+0x24/0x70
[    9.831517]  rmem_probe+0xa0/0xf4 [nvmem_rmem 649243b01e5e28ee94e4dd53bd13b6ececa836f8]
[    9.831555]  platform_probe+0x70/0xd0
[    9.831566]  really_probe+0xc8/0x3e4
[    9.831582]  __driver_probe_device+0x84/0x190
[    9.831598]  driver_probe_device+0x44/0x11c
[    9.831613]  __driver_attach+0xf8/0x200
[    9.831629]  bus_for_each_dev+0x78/0xd0
[    9.831643]  driver_attach+0x2c/0x40
[    9.831657]  bus_add_driver+0x188/0x250
[    9.831672]  driver_register+0x80/0x13c
[    9.831688]  __platform_driver_register+0x30/0x40
[    9.831699]  rmem_driver_init+0x28/0x1000 [nvmem_rmem 649243b01e5e28ee94e4dd53bd13b6ececa836f8]
[    9.831727]  do_one_initcall+0x48/0x2bc
[    9.831740]  do_init_module+0x50/0x1f0
[    9.831753]  load_module+0x1e54/0x2250
[    9.831763]  __do_sys_init_module+0x2ac/0x2f0
[    9.831774]  __arm64_sys_init_module+0x24/0x30
[    9.831785]  invoke_syscall+0x78/0x100
[    9.831803]  el0_svc_common.constprop.0+0x15c/0x180
[    9.831820]  do_el0_svc+0x40/0xb0
[    9.831836]  el0_svc+0x34/0x134
[    9.831850]  el0t_64_sync_handler+0x114/0x120
[    9.831865]  el0t_64_sync+0x1a4/0x1a8
[    9.831956] rmem: probe of 3ef62ce0.nvram failed with error -17

Some background information about the issue could be found here:
https://bugzilla.suse.com/show_bug.cgi?id=1206846

Changes since v1

I dig into Raspberry Github repository and found original patches
from Tim and Phil which add new region and fix rmem driver.

Patch 1 - use NVMEM_DEVID_AUTO instead making region name unique from
the driver itself.

Patch 2 - New one.

Phil Elwell (1):
  nvmem: rmem: Use NVMEM_DEVID_AUTO

Tim Gover (1):
  ARM: dts: Add nvmem node for BCM2711 bootloader public key

 arch/arm/boot/dts/bcm2711-rpi.dtsi | 14 ++++++++++++++
 drivers/nvmem/rmem.c               |  1 +
 2 files changed, 15 insertions(+)

-- 
2.35.3

