Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F374F865
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGKTbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGKTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:31:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D110D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:31:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573a92296c7so54651507b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689103865; x=1691695865;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U6UtC5qxREeMlW4N6rEKWdfK56uVbGJixzS0408EvGQ=;
        b=JAO7tXHxZBA2nKd7nzuamifXfMXgClVtvaaNVU0vsLgoy1VeK6MqhrgR02u7zvvbVE
         eClROfwfgF/G/wL36/zsNw7oS2dtkj24wClLNHdzQu9W4gmOi9axyDskNIuY1NFovM46
         4zWzIRh2Pt8uvtRfgGTywTE0ekKAbGLIQ1AdeZ2iGCIkUSbwmfpmPHptKpAkXJ4VKn7v
         IrkQ8Kwo5CZhfqYa0olRJT2AOTNerP/sPOPXJt/n9eJCj610qWKreO7ePvbVyAposaWO
         0DHu/CfuaJv6hyLk0eNU2iJYlNx6wwhEc96lpcSl7zYIQ/mzJuLCTjhWfAZqa3+57tbs
         5SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689103865; x=1691695865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6UtC5qxREeMlW4N6rEKWdfK56uVbGJixzS0408EvGQ=;
        b=j5+o/H5ylYWUrON/9OWbNACq1po5JrwJYPyHcTfRmidVl4rIzrH6jKD1snEEfrz/q2
         LMynk2mXegZ5y08TWuRpktbFiXy7JlW87bI9CK/+5KEtl4hQlc5Bm5bJq1VSH+c8/Ywf
         SRKUB5BVsVcPOm026tkRAWIPDfCCX9KW7WtW+m3FD2UI0il3xZAStM3UOnd4NPDV4cEf
         qlScHEurNE0CKnUweoNYlFVwQspmNDWH1zm33qr1DKuzOa9C4tNzoERnlCAc38oW55Bj
         uC81TDvnYq+iHkHn9HvVKf8/ttRKv/jnavLuk+uae+i1YamiyyZGg+EbVB71Ww1w2La5
         2COw==
X-Gm-Message-State: ABy/qLZTVJY86GELod8L7wlrRn/HG2F0q9hzEMBOky/1UdGa0nXcLYdZ
        zAsx3MM8PFE5l0g0XRB24jr4LdTxLblfiMMwYQj5nytBZngysUQweZMdEjBQWh6LEUqRFoq8cgj
        UnA18mqa41PWlbmwgimpHDuiGfvAqNTM=
X-Google-Smtp-Source: APBJJlFQi8/UiqCI1XXHpJ7mu1phqF/Ck5Vpr35Qy58kS59pfVKf7Xw7pcIsRSj+tuVh+5+fAx6GfQR7kX3mXNZi4XCfNA==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:8944:7c0b:5d4e:f65b])
 (user=isaacmanjarres job=sendgmr) by 2002:a5b:905:0:b0:c5d:2380:23d6 with
 SMTP id a5-20020a5b0905000000b00c5d238023d6mr105717ybq.7.1689103865297; Tue,
 11 Jul 2023 12:31:05 -0700 (PDT)
Date:   Tue, 11 Jul 2023 12:30:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711193059.2480971-1-isaacmanjarres@google.com>
Subject: [PATCH v1] regmap-irq: Fix out-of-bounds access when allocating
 config buffers
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating the 2D array for handling IRQ type registers in
regmap_add_irq_chip_fwnode(), the intent is to allocate a matrix
with num_config_bases rows and num_config_regs columns.

This is currently handled by allocating a buffer to hold a pointer for
each row (i.e. num_config_bases). After that, the logic attempts to
allocate the memory required to hold the register configuration for
each row. However, instead of doing this allocation for each row
(i.e. num_config_bases allocations), the logic erroneously does this
allocation num_config_regs number of times.

This scenario can lead to out-of-bounds accesses when num_config_regs
is greater than num_config_bases. Fix this by updating the terminating
condition of the loop that allocates the memory for holding the register
configuration to allocate memory only for each row in the matrix.

Amit Pundir reported a crash that was occurring on his db845c device
due to memory corruption (see "Closes" tag for Amit's report). The KASAN
report below helped narrow it down to this issue:

[   14.033877][    T1] ==================================================================
[   14.042507][    T1] BUG: KASAN: invalid-access in regmap_add_irq_chip_fwnode+0x594/0x1364
[   14.050796][    T1] Write of size 8 at addr 06ffff8081021850 by task init/1
[   14.057841][    T1] Pointer tag: [06], memory tag: [fe]
[   14.063124][    T1]
[   14.065349][    T1] CPU: 2 PID: 1 Comm: init Tainted: G        W   E      6.4.0-mainline-g6a4b67fef3e2 #1
[   14.075014][    T1] Hardware name: Thundercomm Dragonboard 845c (DT)
[   14.081432][    T1] Call trace:
[   14.084618][    T1]  dump_backtrace+0xe8/0x108
[   14.089144][    T1]  show_stack+0x18/0x30
[   14.093215][    T1]  dump_stack_lvl+0x50/0x6c
[   14.097642][    T1]  print_report+0x178/0x4c0
[   14.102070][    T1]  kasan_report+0xd4/0x12c
[   14.106407][    T1]  kasan_tag_mismatch+0x28/0x40
[   14.111178][    T1]  __hwasan_tag_mismatch+0x2c/0x5c
[   14.116222][    T1]  regmap_add_irq_chip_fwnode+0x594/0x1364
[   14.121961][    T1]  devm_regmap_add_irq_chip+0xb8/0x144
[   14.127346][    T1]  wcd934x_slim_status+0x210/0x28c [wcd934x]
[   14.133307][    T1]  slim_device_alloc_laddr+0x1ac/0x1ec [slimbus]
[   14.139669][    T1]  slim_device_probe+0x80/0x124 [slimbus]
[   14.145394][    T1]  really_probe+0x250/0x4d8
[   14.149826][    T1]  __driver_probe_device+0x104/0x1ac
[   14.155041][    T1]  driver_probe_device+0x80/0x218
[   14.159990][    T1]  __driver_attach+0x19c/0x2e4
[   14.164678][    T1]  bus_for_each_dev+0x158/0x1b4
[   14.169454][    T1]  driver_attach+0x34/0x44
[   14.173790][    T1]  bus_add_driver+0x1fc/0x328
[   14.178390][    T1]  driver_register+0xdc/0x1b4
[   14.182995][    T1]  __slim_driver_register+0x6c/0x84 [slimbus]
[   14.189068][    T1]  init_module+0x20/0xfe4 [wcd934x]
[   14.194219][    T1]  do_one_initcall+0x110/0x418
[   14.198916][    T1]  do_init_module+0x124/0x30c
[   14.203521][    T1]  load_module+0x1938/0x1ab0
[   14.208034][    T1]  __arm64_sys_finit_module+0x110/0x138
[   14.213509][    T1]  invoke_syscall+0x70/0x170
[   14.218015][    T1]  el0_svc_common+0xf0/0x138
[   14.222523][    T1]  do_el0_svc+0x40/0xb8
[   14.226596][    T1]  el0_svc+0x2c/0x78
[   14.230405][    T1]  el0t_64_sync_handler+0x68/0xb4
[   14.235354][    T1]  el0t_64_sync+0x19c/0x1a0
[   14.239778][    T1]
[   14.242004][    T1] The buggy address belongs to the object at ffffff8081021850
[   14.242004][    T1]  which belongs to the cache kmalloc-8 of size 8
[   14.255669][    T1] The buggy address is located 0 bytes inside of
[   14.255669][    T1]  8-byte region [ffffff8081021850, ffffff8081021858)
[   14.255685][    T1]
[   14.255689][    T1] The buggy address belongs to the physical page:
[   14.255699][    T1] page:0000000080887a30 refcount:1 mapcount:0 mapping:0000000000000000 index:0x85ffff8081021ee0 pfn:0x101021
[   14.275062][    T1] flags: 0x4000000000000200(slab|zone=1|kasantag=0x0)
[   14.275078][    T1] page_type: 0xffffffff()
[   14.275091][    T1] raw: 4000000000000200 49ffff8080002200 dead000000000122 0000000000000000
[   14.275103][    T1] raw: 85ffff8081021ee0 00000000810000ea 00000001ffffffff 0000000000000000
[   14.275110][    T1] page dumped because: kasan: bad access detected
[   14.275116][    T1]
[   14.275119][    T1] Memory state around the buggy address:
[   14.275125][    T1]  ffffff8081021600: fe fe fe 9a fe fe 5b 3c fe fe c9 fe b4 3f fe 54
[   14.275133][    T1]  ffffff8081021700: fe fe ad 6b fe fe fe 87 fe fe 39 c9 fe 03 fe ea
[   14.275143][    T1] >ffffff8081021800: fe fe e1 fe 06 fe fe 21 fe fe e7 fe de fe fe 70
[   14.275149][    T1]                                   ^
[   14.371674][    T1]  ffffff8081021900: d7 fe fe 87 fe a0 fe fe fe 80 e0 f0 05 fe fe fe
[   14.379667][    T1]  ffffff8081021a00: 94 fe 31 fe fe e5 c8 00 d0 fe a1 fe fe e2 e5 fe
[   14.387664][    T1] ==================================================================

Fixes: faa87ce9196d ("regmap-irq: Introduce config registers for irq types")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Closes: https://lore.kernel.org/all/CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com/
Tested-by: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org # v6.0+
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ced0dcf86e0b..45fd13ef13fc 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -717,7 +717,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		if (!d->config_buf)
 			goto err_alloc;
 
-		for (i = 0; i < chip->num_config_regs; i++) {
+		for (i = 0; i < chip->num_config_bases; i++) {
 			d->config_buf[i] = kcalloc(chip->num_config_regs,
 						   sizeof(**d->config_buf),
 						   GFP_KERNEL);
-- 
2.41.0.255.g8b1d071c50-goog

