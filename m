Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA18F5E7E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiIWP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIWP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:28:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388D143576;
        Fri, 23 Sep 2022 08:28:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso490948pjd.1;
        Fri, 23 Sep 2022 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=5r7foWQmgnElkTtlj2t11gwXHrDcKejvsb3U8D3RKiE=;
        b=CME6FiUdsbwMGLzNgML6WHHl1lM9nFZE7vx7IzFUZRa/XbKB8NDkcto6BiUp759bV9
         7r862R6CjsSoGCnmpL+41+hVunsCJjoGMXymp0R7Y8Zqxaed1kZEIL0i1tno1wiFta14
         jDYVEVndeuszvfDVLmcN1ZWzzcJYK5yleexxpDYQ2kwKg8ZV0BOerRBch2oONh0denaD
         lMDWdFMkd7McKfKnErgCx/kVfT1S64SKIpeAmn0fG0ljoRFoAciqPfTwVNQstTTm38vA
         l20Vf9rljn53hxlAXjYXbP3NGVmpwqPmgsukOtjbJ7qYlDo6jO0zGDdno3Ho30fJb8kq
         Xvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=5r7foWQmgnElkTtlj2t11gwXHrDcKejvsb3U8D3RKiE=;
        b=O4d1+J6Tf0kU8ELmX+6TqFaLbBBm5t0TccKa2qakdL4qvusc5CYFzpORYyWGyKYYSq
         cuU6KOCP5FZNw/uX7+KNcE8gvhtSLNKqXoctnomkL37EfKkQc27kFqyQjyJc/PmtOD7s
         DpUlASdWDC9cbob7dfTxJbGU68xkY/EqYRzlD0vgIARaOA76V1E8H8sPkMd9iHpSOeHD
         sZK9CY1KXtQMP8Q7EnYe26yxvKzLJYAA5PCfGrn2C2j4fjW828PfCmgTFaxkpvevHr6U
         U6Oqzol1GG0tzNkJy018YuIC2wGXNSMFwF3drl3/PVJhJvVJclDB9SE2c2UZvjDgQqV8
         wsBA==
X-Gm-Message-State: ACrzQf2jAtMXMHq9qkoUrYR7z3nbv5E80lfjpv7nZM5MYyi0CgQlu8uK
        CD7b+QXXTTH94KN9pcg3r/8=
X-Google-Smtp-Source: AMsMyM6Q+wxHrhd5Z1U8d4zBgf7c0opVTeT/ajm9hG/mwLKjWxsSuYka/83LtH8DJGgJk6NpllHvbg==
X-Received: by 2002:a17:902:f08a:b0:176:b477:8be0 with SMTP id p10-20020a170902f08a00b00176b4778be0mr9293590pla.66.1663946892310;
        Fri, 23 Sep 2022 08:28:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a740f00b002036006d65bsm1688463pjg.39.2022.09.23.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:28:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Sep 2022 08:28:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kbuild@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to
 subsys_initcall
Message-ID: <20220923152809.GA455235@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:38:35PM +0900, Masahiro Yamada wrote:
> sg_alloc_table_chained() is called by several drivers, but if it is
> called before sg_pool_init(), it results in a NULL pointer dereference
> in sg_pool_alloc().
> 
> Since commit 9b1d6c895002 ("lib: scatterlist: move SG pool code from
> SCSI driver to lib/sg_pool.c"), we rely on module_init(sg_pool_init)
> is invoked before other module_init calls but this assumption is
> fragile.
> 
> I slightly changed the link order while Kbuild refactoring Kbuild,
> then uncovered this issue. I should keep the current link order, but
> depending on a specific call order among module_init is so fragine.
> 
> We usually define the init order by specifying *_initcall correctly,
> or delay the driver probing by returning -EPROBE_DEFER.
> 
> Change module_initcall() to subsys_initcall(), and also delete the
> pointless module_exit() because lib/sg_pool.c is always compiled as
> built-in. (CONFIG_SG_POOL is bool)
> 
> Link: https://lore.kernel.org/all/20220921043946.GA1355561@roeck-us.net/
> Link: https://lore.kernel.org/all/8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com/
> Fixes: 9b1d6c895002 ("lib: scatterlist: move SG pool code from SCSI driver to lib/sg_pool.c")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
