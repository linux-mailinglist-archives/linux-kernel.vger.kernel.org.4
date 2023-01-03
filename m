Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DEC65BF8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjACMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjACMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:02:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33984300
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:02:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3CDA61275
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3088CC4339B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672747341;
        bh=u09dmYLA0SDPWsgNwZ9uhqIUCV6VVDIbZmE7qi9Ae2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GXo+LdxTU093+n9amq3pGlFQHldCgP69AWWKrfXC/udm27V+iUqH+p8kQKYhfXQRF
         q2S9aZM+FZF6fQmfQGteCk/6UEnFwH5Y85vGSjlz3Y5cNUvyuH+XCceenL7vVzpHt+
         fH8AFL/2EIVpYycZZP2GAhyQvsQ1QNsX2QkquKBzqTW8cJsW2+dPYvZBiwE75OVhtH
         R1y61aFDnRxkI/xeRZg1PKMz/TLY4yCwZyL6LGPUpSQiUl4Jg2TvB+zKFpIGz5jlw6
         an+PB3xa6+VEtnj/eHtFTJVWKenx5sASGzfrNzcxIlYs3I+T5cFSuDuy+snoR1CFCj
         Q03mOTZBlnZaw==
Received: by mail-ej1-f41.google.com with SMTP id gh17so73107160ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:02:21 -0800 (PST)
X-Gm-Message-State: AFqh2kqdfYq6BDJZMJjDMykMZf5erO4ziNc8ROvmI30nJe0VYt7kQmSr
        DXikTMBpUo4dZCVg42wFDSu6V6MUqakZ35NIeow=
X-Google-Smtp-Source: AMrXdXsMBhSpsz7iv9ITErqmE108Ci0Q3c6egXKkT6WOdkwE62RHbex3+RfKS5QYoi/M8W/9aaXEAB6h2vf6HeQ6H2o=
X-Received: by 2002:a17:906:cc87:b0:7c4:ec55:59e with SMTP id
 oq7-20020a170906cc8700b007c4ec55059emr2584461ejb.611.1672747339331; Tue, 03
 Jan 2023 04:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20230103062610.69704-1-uwu@icenowy.me>
In-Reply-To: <20230103062610.69704-1-uwu@icenowy.me>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 3 Jan 2023 20:02:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQkd_it0msNvUV_jBf8ei0N7-TVLO1LqwC3SQc=wipvgw@mail.gmail.com>
Message-ID: <CAJF2gTQkd_it0msNvUV_jBf8ei0N7-TVLO1LqwC3SQc=wipvgw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] riscv: errata: fix T-Head dcache.cva encoding
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Tue, Jan 3, 2023 at 2:26 PM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> The dcache.cva encoding shown in the comments are wrong, it's for
> dcache.cval1 (which is restricted to L1) instead.
>
> Fix this in the comment and in the hardcoded instruction.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> ---
> Included when resending:
> - Sergey's Tested-by tag.
>
>  arch/riscv/include/asm/errata_list.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 4180312d2a70..605800bd390e 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -102,7 +102,7 @@ asm volatile(ALTERNATIVE(                                           \
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01001      rs1       000      00000  0001011
>   * dcache.cva rs1 (clean, virtual address)
> - *   0000001    00100      rs1       000      00000  0001011
> + *   0000001    00101      rs1       000      00000  0001011
>   *
>   * dcache.cipa rs1 (clean then invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -115,7 +115,7 @@ asm volatile(ALTERNATIVE(                                           \
>   *   0000000    11001     00000      000      00000  0001011
>   */
>  #define THEAD_inval_A0 ".long 0x0265000b"
> -#define THEAD_clean_A0 ".long 0x0245000b"
> +#define THEAD_clean_A0 ".long 0x0255000b"
>  #define THEAD_flush_A0 ".long 0x0275000b"
>  #define THEAD_SYNC_S   ".long 0x0190000b"
>
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
