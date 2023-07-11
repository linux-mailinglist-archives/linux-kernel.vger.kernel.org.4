Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4C74F7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGKSOm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGKSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:14:38 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C233170E;
        Tue, 11 Jul 2023 11:14:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b70357ca12so17765971fa.1;
        Tue, 11 Jul 2023 11:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099275; x=1689704075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TLXCb1Re20kCu+wyRFtE0SAFooY3rB0FDpaO7CDdmc=;
        b=bq1tQsBwHNBF7EY8lBWfrqhy2p4TGLJmuo9Dn1z0xDSuRwCzTDxl1DKpzilBcojLBQ
         mTcCpVQ+kpK8TihzbpYPsaaYCWnAPRz0+YN6A8qpajOF9JuWTUfp6CpiFaz/bN8kNUN2
         7I5OacmrnyBHCuvkEDAcTH/xqTLXKIaCNwkm94xh2Hm1w7QEXvvZs9WzUGk5W0LhR1kX
         jLbdgoSuIWd5BeBgFMG8x1cXGhKvjy3RySOq1a+yHcrl+vXin354NbiVQvrEt5yK9fdt
         AMUz6sdowZynMbsBsOi3/Es/DfLNbw0M/3W8rngY/nfXomoZ44Inupfq9QFziCg/AEWt
         nmUQ==
X-Gm-Message-State: ABy/qLY7OAJwbhCUSierY34IIo/5+Xacbb4pqh/HjbpWnou9iHe+9uAJ
        Lyrhs26g+Brw+GN+rAAOSqYFG/E68n7xjq3SYLXlfY34
X-Google-Smtp-Source: APBJJlFXHZaeCoMTMEjKYmQCkQzZN8qQ3DK1iLvN6hZcSYA+NfuPEQ9dKIkHiGkXKZjyb+qqkG+8wTxnF+sUGIvne7Y=
X-Received: by 2002:a2e:9886:0:b0:2b6:a662:b879 with SMTP id
 b6-20020a2e9886000000b002b6a662b879mr11071549ljj.3.1689099275200; Tue, 11 Jul
 2023 11:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050238.712223-1-rui.zhang@intel.com>
In-Reply-To: <20230704050238.712223-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jul 2023 20:14:23 +0200
Message-ID: <CAJZ5v0gZz1RCqp=Do0RTOCwPvWW9E_SQSyFjuRVuBkR9jxCJjw@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 7:02 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Fix a sparse warning in intel_rapl_tpmi driver.
>
> ../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse: warning: incorrect type in initializer (different address spaces)
> ../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:    expected unsigned long long [usertype] *tpmi_rapl_regs
> ../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:    got void [noderef] __iomem *
>
> Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307031405.dy3druuy-lkp@intel.com/
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_tpmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
> index 4f4f13ded225..05f664a096ab 100644
> --- a/drivers/powercap/intel_rapl_tpmi.c
> +++ b/drivers/powercap/intel_rapl_tpmi.c
> @@ -138,7 +138,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
>         enum tpmi_rapl_register reg_index;
>         enum rapl_domain_reg_id reg_id;
>         int tpmi_domain_size, tpmi_domain_flags;
> -       u64 *tpmi_rapl_regs = trp->base + offset;
> +       u64 *tpmi_rapl_regs = (u64 *)(trp->base + offset);
>         u64 tpmi_domain_header = readq((void __iomem *)tpmi_rapl_regs);
>
>         /* Domain Parent bits are ignored for now */
> --

Applied as 6.5-rc material, thanks!
