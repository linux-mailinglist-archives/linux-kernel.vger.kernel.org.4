Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5349B6C2E44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCUJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCUJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:53:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD93E1E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:53:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k2so15413820pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679392414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rA/36GOkyq2lKA3k5UgPosSHflLhgYc8k77jVK2ZMbg=;
        b=jjrpZU9jNi7FcdtB5qiMx2Cu13tB+AdGvXk086Ea6aCNFfyC5aTecI0/Pv2yJuG1Xp
         5bFsbKFRMETz2L5NCPvj72WfZVYJQkqPc5wKeAPHeN9ZHTijHi+NFftS3VihYmUysPw0
         96KRFycK9sppCLw4N50xHjblJQY3ft8ImZNA/G4jTo2HYOtBu/0Snts+u4F9+QkcErVa
         5H4Tyai8Qf0R5OYC7r0Tce5x8snCyZEqC6OW1r9A/5SQacIz4FDxvqboGqoHhIfQQ01/
         /+cztbnMvjXZPc0E8LESr+c+LgnutJs5OuUYK8BaQzq6tCAdCz1F+Row6cotGfWIFqhT
         Eb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679392414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA/36GOkyq2lKA3k5UgPosSHflLhgYc8k77jVK2ZMbg=;
        b=NTnJqgz9BNm29uS9VTClC1KGCF108sYeV110IXyAjbANFfpkl1QnKivfRfkd5AUAXa
         fUaEMltfoIJheYW7OpGH62pEumMNwKdZ7pJfBpqMFnW+TZOfe4Ig/oO9npyEcfeN24fC
         dxp4z/1ZnXO9PmJgZLclNAx9OJZQj6UfVyidj5avQuswxKlA5DV2nemOw5+gFzPDK3Kc
         5G5ySdKiOMz6wb9Vl1wWScYPWrh/gRMgw2G3hhPqBDNB9GgJGSjef5hHWWXWzUdBNF2r
         TvfsN+wgJQP74L2xeHZJ1z63dr4cLBSG7xi+SqJ7oRLfVMwazvPe1jQIi+96VLiY08al
         IrxA==
X-Gm-Message-State: AO0yUKWlOTaxjlK+ES02WQ4e0RHwQEZyFmUQUNCNS2/06YLL0B2pOQWY
        X+oW8Lwf+ndb5Wy7uM01WN/wVqf0UwWLrFeRHlaFlZrOYxe9HwQR
X-Google-Smtp-Source: AK7set8qUCUagNV4rv+Ikfv0TXHxvpINQ67OmEGsL5YjLyjVQsj0cuRkFebZvcScUpC+OJEKvQ8jBcFh1AX7PUY2mEE=
X-Received: by 2002:a17:902:efc6:b0:1a0:d6b:1211 with SMTP id
 ja6-20020a170902efc600b001a00d6b1211mr583226plb.6.1679392414485; Tue, 21 Mar
 2023 02:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230317115728.1358368-1-suzuki.poulose@arm.com>
In-Reply-To: <20230317115728.1358368-1-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 09:53:23 +0000
Message-ID: <CAJ9a7Vh8VgPtdFNf1Y+QX+US7tJDQC7QwEpF_1ObwoiFVi6S4Q@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Do not access TRCIDR1 for identification
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, james.clark@arm.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Steve Clevenger <scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 at 11:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> CoreSight ETM4x architecture clearly provides ways to identify a device
> via registers in the "Management" class, TRCDEVARCH and TRCDEVTYPE. These
> registers can be accessed without the Trace domain being powered on.
> We additionally added TRCIDR1 as fallback in order to cover for any
> ETMs that may not have implemented TRCDEVARCH. So far, nobody has
> reported hitting a WARNING we placed to catch such systems.
>
> Also, more importantly it is problematic to access TRCIDR1, which is a "Trace"
> register via MMIO access, without clearing the OSLK. But we cannot
> mess with the OSLK until we know for sure that this is an ETMv4 device.
> Thus, this kind of creates a chicken and egg problem unnecessarily for systems
> "which are compliant" to the ETMv4 architecture.
>
> Let us remove the TRCIDR1 fall back check and rely only on TRCDEVARCH.
>
> Reported-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> Link: https://lore.kernel.org/all/143540e5623d4c7393d24833f2b80600d8d745d2.1677881753.git.scclevenger@os.amperecomputing.com/
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Fixes: 8b94db1edaee ("coresight: etm4x: Use TRCDEVARCH for component discovery")
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../hwtracing/coresight/coresight-etm4x-core.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 104333c2c8a3..c1b72d892d7d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1070,25 +1070,17 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>                                    struct csdev_access *csa)
>  {
>         u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
> -       u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
>
>         /*
>          * All ETMs must implement TRCDEVARCH to indicate that
> -        * the component is an ETMv4. To support any broken
> -        * implementations we fall back to TRCIDR1 check, which
> -        * is not really reliable.
> +        * the component is an ETMv4
>          */
> -       if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
> -               drvdata->arch = etm_devarch_to_arch(devarch);
> -       } else {
> -               pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
> -                       smp_processor_id(), devarch);
> -
> -               if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
> -                       return false;
> -               drvdata->arch = etm_trcidr_to_arch(idr1);
> +       if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH) {
> +               pr_warn_once("TRCDEVARCH doesn't match ETMv4 architecture\n");
> +               return false;
>         }
>
> +       drvdata->arch = etm_devarch_to_arch(devarch);
>         *csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>         return true;
>  }
> --
> 2.34.1
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
