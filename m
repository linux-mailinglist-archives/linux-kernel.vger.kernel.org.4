Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE963EDDC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiLAKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLAKcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:32:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CCDA0560
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EECB81DEB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBD2C4347C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669890705;
        bh=T7g5uISnZ5nebA9inQJ6ZCETQI0m58pKIh7QyKGpeMg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BmWAdslWgXpt6BQWw0AzPB7Es1MyU5gfXoqoUEXxu+43KS17BlI0ZLlM+rXnalX5V
         KmObSZzbuJjzjW/WoaxUmoQ9QlwBt29mf5y8hMNGXhwV284a5604KHQUkIQz1Z4Hfd
         yj9vcfMotOaeBWPjy6y4xLFgQ1bVhH5Sa5pZ83OaIhhKg7RhpmoAFjMgUs+720jiof
         R/0iQxdGPcrOQ+RM1lG/advrrtposwUuF5pRN41BW+KJqwDHF6jOWwle9zP/BeqOxu
         2hguQOP8H4FQ0B96TmuVZAluwddkPs7MyMhLX5ZKtZJKXuyYFOy7MDuC4ZL+yNZ6Az
         I/ilvmNAmK0iA==
Received: by mail-yb1-f177.google.com with SMTP id j196so1479536ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:31:45 -0800 (PST)
X-Gm-Message-State: ANoB5plx65ibJE8QAlY3Q5SuWu4bJsxWeayWfrath70llQvCFwnMXdbO
        cdHGMBv/+nul81PdrGLMajFjv3gneF+KdzS1gbo=
X-Google-Smtp-Source: AA0mqf4zEMarRVsx8VGR5hYM/nJsZDAg9HVJ9ObB8YVkj5W9ErIJ4YABgbcSeQZqVBY52fOvX3TY73RyfXujyiEXdDU=
X-Received: by 2002:a5b:dcb:0:b0:6bc:eea6:2d66 with SMTP id
 t11-20020a5b0dcb000000b006bceea62d66mr42907791ybr.545.1669890704550; Thu, 01
 Dec 2022 02:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20221129115217.129290-1-marpagan@redhat.com>
In-Reply-To: <20221129115217.129290-1-marpagan@redhat.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 1 Dec 2022 12:31:18 +0200
X-Gmail-Original-Message-ID: <CAFCwf11cqNHZhAR0b8iKnGeT_XVy5Oa2KHjNo7ROVF2-MjYZfA@mail.gmail.com>
Message-ID: <CAFCwf11cqNHZhAR0b8iKnGeT_XVy5Oa2KHjNo7ROVF2-MjYZfA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix double assignment in MMU V1
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 1:52 PM Marco Pagani <marpagan@redhat.com> wrote:
>
> Removing double assignment of the hop2_pte_addr
> variable in dram_default_mapping_fini().
>
> Dead store reported by clang-analyzer.
>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/misc/habanalabs/common/mmu/mmu_v1.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
> index 8a40de4a4761..d925dc4dd097 100644
> --- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
> +++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
> @@ -344,7 +344,6 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
>                 }
>         }
>
> -       hop2_pte_addr = hop2_addr;
>         hop2_pte_addr = hop2_addr;
>         for (i = 0 ; i < num_of_hop3 ; i++) {
>                 clear_pte(ctx, hop2_pte_addr);
> --
> 2.38.1
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
