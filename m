Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCBF5DEA93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiIUSRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIUSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:17:49 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E90A3450;
        Wed, 21 Sep 2022 11:17:46 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id d17so4541708qko.13;
        Wed, 21 Sep 2022 11:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MgICOmEndpQv6u1SEkzGGT0sq5VCPnzIGdnf/Sw5Y8Q=;
        b=26kC/16qaKHqFmtgD2QweCEeP9LL8EyK5I/8XqMpuhB9pmzFgh/xJ8qx4vAC4Kmrl+
         4RmC/w1D+RVwvo7+I0aflnQUFu9f+mkKexZNgq9Sjru2huITMZqZZONi9i5dGPDJoAEO
         ob3ml7WKgkh9ogIGt8eGtqGd8a43TdzSp5xNT5aljFbJGA/9kWxEDAmulaET8YYvo98b
         jhVzfRGqXtadzGoLO3s7Fp+8DCbenKboct0Wx5ql+STy/vWlrX26Kt7aUe4oT+zWrrsy
         LzvP1GZStwOvKpldCPuzayUvsYouLtHRCFYBsL/MWDrhPoshABaFUich9sdBcHeG04g/
         eZEg==
X-Gm-Message-State: ACrzQf0pTxnvrAY5DF4akETBKcL09nlSaODE6bVrkfC5zhSvDfED/byM
        1aQjo8p/r01e0WAde6Kf5uXZrJntgmdFMrs2RMEEnV6t
X-Google-Smtp-Source: AMsMyM4VKFt4WAhZKQ6jLHvXP5jNyNMgK5uPfn0ipO5XDCuHbBOr9JesQlnyxanLUcnCOJUZ2+W+50iJurgPQFXFyTg=
X-Received: by 2002:a37:a907:0:b0:6cb:be29:ac72 with SMTP id
 s7-20020a37a907000000b006cbbe29ac72mr20929641qke.505.1663784265716; Wed, 21
 Sep 2022 11:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220920060826.3631210-1-chao.qin@intel.com>
In-Reply-To: <20220920060826.3631210-1-chao.qin@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Sep 2022 20:17:34 +0200
Message-ID: <CAJZ5v0jmt7BTkmJZad9-7cC4xCc1W3iw1vb2CfOq1rUz-P6tOw@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: fix UBSAN shift-out-of-bounds issue
To:     chao.qin@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paul.mei@intel.com, lili.li@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 8:19 AM <chao.qin@intel.com> wrote:
>
> From: Chao Qin <chao.qin@intel.com>
>
> When value < time_unit, the parameter of ilog2() will be zero and
> the return value is -1. u64(-1) is too large for shift exponent
> and then will trigger shift-out-of-bounds:
>
> shift exponent 18446744073709551615 is too large for 32-bit type 'int'
> Call Trace:
>  rapl_compute_time_window_core
>  rapl_write_data_raw
>  set_time_window
>  store_constraint_time_window_us
>
> Signed-off-by: Chao Qin <chao.qin@intel.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 21d624f9f5fb..bf91248630c3 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -994,6 +994,9 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
>                 y = value & 0x1f;
>                 value = (1 << y) * (4 + f) * rp->time_unit / 4;
>         } else {
> +               if (value < rp->time_unit)
> +                       return 0;
> +
>                 do_div(value, rp->time_unit);
>                 y = ilog2(value);
>                 f = div64_u64(4 * (value - (1 << y)), 1 << y);
> --

Applied as 6.1 material, thanks!
