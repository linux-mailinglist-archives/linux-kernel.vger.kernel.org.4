Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42D74FE84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGLEzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGLEzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:55:33 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B210C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:55:32 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6348a8045a2so42914546d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689137731; x=1691729731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=idYVulynbBuRNdgvqPl4F9p/PBeAuDZ2z8V50Rf/KPc=;
        b=G0c2Oa7I6ZO0xXG2wulIQktiX78HUSFkcNvJlk0AEtrXKaruKzO92ZRTfqSt45qqo6
         ePp0CZzeel6ECAIl0woCx19al7EV5VHqZOgVw+VmkPL7oHy32YCb/0obNX3gMOnE0UJP
         DsrXHSdylLVEA5b3GsK1x8O21PU+u0L9KsJ0i7OUj6z7UIFSKahkiJs+6RwW7uvdutzq
         v+09OguTm0FmFdiPzPOgthUK17lRNIf2tW4ALMyYItEOJpVEGGySJwiiGN76FR8uII3W
         m96IZtXS9t491wfpF1yLGqIiCGeRfyWgyzX5l/zan4zzRaAgrSMAJvW/Arp6GVXyLLeP
         fwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137731; x=1691729731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idYVulynbBuRNdgvqPl4F9p/PBeAuDZ2z8V50Rf/KPc=;
        b=JYWnmFgi1XubeWiXYye2sV8rxnd6lj/20gdxRls+RR8ArzFMPbAFa2zooJF0e4iKx6
         sOsJCBMpq9Qi3HvU9lUwRttgOxLSaBLoHcZxe+N5ShHtewkwY6iL28iseBF/pnBWq8J4
         AiiA5ChrNhm09DzpQVs4EWJOjf6PNDAdwQ9ckdwYuph4zeIRdILd6gsIXnIkYrmgc2xN
         guc6gP0a5N9/auN9K07w8EK8z7tUH/HHJLwtw4bSzQND3P55Hdf5lyK7Nma76wa3y4Uk
         yWvuVcglwGaemA3dYVGF9Jgp8+pRI4y2CHD2euTYf+Vg3u+KDYisJpraFtytPOomZJro
         foJw==
X-Gm-Message-State: ABy/qLaCi5V41PLRSIuE3GrPZjrLrAtaOeOVh7qJkOOUc80/zz7vSXwj
        cGgnzYdk478Xj8o4QW+QYPFBdePxOF48M+sqqKMQEg==
X-Google-Smtp-Source: APBJJlF6hKGMmqvNNOYGbiO6MHeAE6BJOFtghPVlKlh1MzJJujybddPW9AazFThI7Zf52dS5LGlJolzNIo1xTkkPAzg=
X-Received: by 2002:a0c:e150:0:b0:62d:e3d7:5b89 with SMTP id
 c16-20020a0ce150000000b0062de3d75b89mr14932782qvl.38.1689137731231; Tue, 11
 Jul 2023 21:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230711193059.2480971-1-isaacmanjarres@google.com>
In-Reply-To: <20230711193059.2480971-1-isaacmanjarres@google.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 12 Jul 2023 10:24:55 +0530
Message-ID: <CAMi1Hd3K=Vc+j+s-AXDimkgEny+ZX9Lg=L+E9M-9VYSuw61-mw@mail.gmail.com>
Subject: Re: [PATCH v1] regmap-irq: Fix out-of-bounds access when allocating
 config buffers
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 01:01, Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> When allocating the 2D array for handling IRQ type registers in
> regmap_add_irq_chip_fwnode(), the intent is to allocate a matrix
> with num_config_bases rows and num_config_regs columns.
>
> This is currently handled by allocating a buffer to hold a pointer for
> each row (i.e. num_config_bases). After that, the logic attempts to
> allocate the memory required to hold the register configuration for
> each row. However, instead of doing this allocation for each row
> (i.e. num_config_bases allocations), the logic erroneously does this
> allocation num_config_regs number of times.
>
> This scenario can lead to out-of-bounds accesses when num_config_regs
> is greater than num_config_bases. Fix this by updating the terminating
> condition of the loop that allocates the memory for holding the register
> configuration to allocate memory only for each row in the matrix.
>
> Amit Pundir reported a crash that was occurring on his db845c device
> due to memory corruption (see "Closes" tag for Amit's report). The KASAN
> report below helped narrow it down to this issue:

Tested-by: Amit Pundir <amit.pundir@linaro.org> # tested on Dragonboard 845c

>
> [   14.033877][    T1] ==================================================================
> [   14.042507][    T1] BUG: KASAN: invalid-access in regmap_add_irq_chip_fwnode+0x594/0x1364
> [   14.050796][    T1] Write of size 8 at addr 06ffff8081021850 by task init/1
> [   14.057841][    T1] Pointer tag: [06], memory tag: [fe]
> [   14.063124][    T1]
> [   14.065349][    T1] CPU: 2 PID: 1 Comm: init Tainted: G        W   E      6.4.0-mainline-g6a4b67fef3e2 #1
> [   14.075014][    T1] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   14.081432][    T1] Call trace:
> [   14.084618][    T1]  dump_backtrace+0xe8/0x108
> [   14.089144][    T1]  show_stack+0x18/0x30
> [   14.093215][    T1]  dump_stack_lvl+0x50/0x6c
> [   14.097642][    T1]  print_report+0x178/0x4c0
> [   14.102070][    T1]  kasan_report+0xd4/0x12c
> [   14.106407][    T1]  kasan_tag_mismatch+0x28/0x40
> [   14.111178][    T1]  __hwasan_tag_mismatch+0x2c/0x5c
> [   14.116222][    T1]  regmap_add_irq_chip_fwnode+0x594/0x1364
> [   14.121961][    T1]  devm_regmap_add_irq_chip+0xb8/0x144
> [   14.127346][    T1]  wcd934x_slim_status+0x210/0x28c [wcd934x]
> [   14.133307][    T1]  slim_device_alloc_laddr+0x1ac/0x1ec [slimbus]
> [   14.139669][    T1]  slim_device_probe+0x80/0x124 [slimbus]
> [   14.145394][    T1]  really_probe+0x250/0x4d8
> [   14.149826][    T1]  __driver_probe_device+0x104/0x1ac
> [   14.155041][    T1]  driver_probe_device+0x80/0x218
> [   14.159990][    T1]  __driver_attach+0x19c/0x2e4
> [   14.164678][    T1]  bus_for_each_dev+0x158/0x1b4
> [   14.169454][    T1]  driver_attach+0x34/0x44
> [   14.173790][    T1]  bus_add_driver+0x1fc/0x328
> [   14.178390][    T1]  driver_register+0xdc/0x1b4
> [   14.182995][    T1]  __slim_driver_register+0x6c/0x84 [slimbus]
> [   14.189068][    T1]  init_module+0x20/0xfe4 [wcd934x]
> [   14.194219][    T1]  do_one_initcall+0x110/0x418
> [   14.198916][    T1]  do_init_module+0x124/0x30c
> [   14.203521][    T1]  load_module+0x1938/0x1ab0
> [   14.208034][    T1]  __arm64_sys_finit_module+0x110/0x138
> [   14.213509][    T1]  invoke_syscall+0x70/0x170
> [   14.218015][    T1]  el0_svc_common+0xf0/0x138
> [   14.222523][    T1]  do_el0_svc+0x40/0xb8
> [   14.226596][    T1]  el0_svc+0x2c/0x78
> [   14.230405][    T1]  el0t_64_sync_handler+0x68/0xb4
> [   14.235354][    T1]  el0t_64_sync+0x19c/0x1a0
> [   14.239778][    T1]
> [   14.242004][    T1] The buggy address belongs to the object at ffffff8081021850
> [   14.242004][    T1]  which belongs to the cache kmalloc-8 of size 8
> [   14.255669][    T1] The buggy address is located 0 bytes inside of
> [   14.255669][    T1]  8-byte region [ffffff8081021850, ffffff8081021858)
> [   14.255685][    T1]
> [   14.255689][    T1] The buggy address belongs to the physical page:
> [   14.255699][    T1] page:0000000080887a30 refcount:1 mapcount:0 mapping:0000000000000000 index:0x85ffff8081021ee0 pfn:0x101021
> [   14.275062][    T1] flags: 0x4000000000000200(slab|zone=1|kasantag=0x0)
> [   14.275078][    T1] page_type: 0xffffffff()
> [   14.275091][    T1] raw: 4000000000000200 49ffff8080002200 dead000000000122 0000000000000000
> [   14.275103][    T1] raw: 85ffff8081021ee0 00000000810000ea 00000001ffffffff 0000000000000000
> [   14.275110][    T1] page dumped because: kasan: bad access detected
> [   14.275116][    T1]
> [   14.275119][    T1] Memory state around the buggy address:
> [   14.275125][    T1]  ffffff8081021600: fe fe fe 9a fe fe 5b 3c fe fe c9 fe b4 3f fe 54
> [   14.275133][    T1]  ffffff8081021700: fe fe ad 6b fe fe fe 87 fe fe 39 c9 fe 03 fe ea
> [   14.275143][    T1] >ffffff8081021800: fe fe e1 fe 06 fe fe 21 fe fe e7 fe de fe fe 70
> [   14.275149][    T1]                                   ^
> [   14.371674][    T1]  ffffff8081021900: d7 fe fe 87 fe a0 fe fe fe 80 e0 f0 05 fe fe fe
> [   14.379667][    T1]  ffffff8081021a00: 94 fe 31 fe fe e5 c8 00 d0 fe a1 fe fe e2 e5 fe
> [   14.387664][    T1] ==================================================================
>
> Fixes: faa87ce9196d ("regmap-irq: Introduce config registers for irq types")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/all/CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com/
> Tested-by: John Stultz <jstultz@google.com>
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  drivers/base/regmap/regmap-irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index ced0dcf86e0b..45fd13ef13fc 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -717,7 +717,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>                 if (!d->config_buf)
>                         goto err_alloc;
>
> -               for (i = 0; i < chip->num_config_regs; i++) {
> +               for (i = 0; i < chip->num_config_bases; i++) {
>                         d->config_buf[i] = kcalloc(chip->num_config_regs,
>                                                    sizeof(**d->config_buf),
>                                                    GFP_KERNEL);
> --
> 2.41.0.255.g8b1d071c50-goog
>
