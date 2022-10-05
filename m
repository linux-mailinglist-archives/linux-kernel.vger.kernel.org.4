Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333965F592B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJERjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJERjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:39:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6932B75480
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:39:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o21so692594ejm.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GEEqv6JUw04KMv9WcWH7KJHOv/rriPAH+GJIx70ffZk=;
        b=VJHkutAH6JmqngkefDS4W1u9yXaZmybou+ReWLPQlhc8KLxKuD+SRbbT2WJ/14Moq4
         vrhDuP5ok6Q89f027q4cD0Eyht3Cd5GqWnpSoTbOJ5VmDahDurYei5TtLFFTFTnURtoO
         gLJ7DYE14hOIkoASC0fk+6Sc6K68Wx3biqMnMXfWI+TqOvYh3oivYbHvpC7prVAd8a9A
         mCgleJ/BJQEp9iMHUfE+2fXLJGlyVr+g/tDgzBMz1IUx/yvXwEDyFMtQattzLD5j2NS1
         mUAGbDleHkHEy+2DFRTL9JGLIozImOudD+c5MNtHUwtxnWSk2L67CNmgactPseB8MEXC
         Mm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GEEqv6JUw04KMv9WcWH7KJHOv/rriPAH+GJIx70ffZk=;
        b=qQkye68Zi9sotDq8uRvNPp9Vly071Jej8UKAK8CBEhYT3EuDhKCKtMBR9i6mQ6VmAV
         1NJiGwWZhjTOTj+EOox1A9IK60vf3luWn7GoGkX4hWZZ/t0/ZctQW0/Q7tGYjnYcDUW2
         EPlThjbcAWeIgQEqC3OqmIfR9qUJKMihhzyi2hGc1CRVQ+VASQZeDFNiQK61lfDXsT/G
         /8apM7pdHqauqrMlg9Q3RmBFPHtBHLb2574fF/JeMo0Lp8jS3hwHL+ET0a9twmpl77tk
         mzADJqdkQRhxfRohJQ6omfGyxe7BxRgL5JFkMAjoj+GYDM6o76xu1uCRhK9uAR9hOAST
         PBig==
X-Gm-Message-State: ACrzQf2pH3bWTgmEfa+Y37YnuhP+zjSH0AofmsWni0MqYmYCD0pTgBm+
        6mtbc1EdzAlC0B/x3Mpx8Id+/A==
X-Google-Smtp-Source: AMsMyM7WyYk0PAsuFDiEHWqpCGiTfNFke7pJfBsSDMFkAL8sbci2aWR5Ojdt0qDVNNr1SysWBO9XAA==
X-Received: by 2002:a17:907:da6:b0:787:baf3:1c79 with SMTP id go38-20020a1709070da600b00787baf31c79mr583903ejc.458.1664991540956;
        Wed, 05 Oct 2022 10:39:00 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090778c300b0074a82932e3bsm5552301ejc.77.2022.10.05.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:39:00 -0700 (PDT)
Date:   Wed, 5 Oct 2022 19:38:59 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        cmuellner@linux.com, samuel@sholland.org
Subject: Re: [PATCH 2/2] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
Message-ID: <20221005173859.apuj4a6iq7fxbffp@kamzik>
References: <20221004203724.1459763-1-heiko@sntech.de>
 <20221004203724.1459763-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004203724.1459763-3-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:37:24PM +0200, Heiko Stuebner wrote:
> With the T-HEAD C9XX cores being designed before or during the ratification
> to the SSCOFPMF extension, it implements functionality very similar but
> not equal to it.
> 
> It implements overflow handling and also some privilege-mode filtering.
> While SSCOFPMF supports this for all modes, the C9XX only implements the
> filtering for M-mode and S-mode but not user-mode.
> 
> So add some adaptions to allow the C9XX to still handle
> its PMU through the regular SBI PMU interface instead of defining new
> interfaces or drivers.
> 
> To work properly, this requires a matching change in SBI, though the actual
> interface between kernel and SBI does not change.
> 
> The main differences are a the overflow CSR and irq number.
> 
> As the reading of the overflow-csr is in the hot-path during irq handling,
> use an errata and alternatives to not introduce new conditionals there.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas           | 13 +++++++++++
>  arch/riscv/errata/thead/errata.c     | 18 +++++++++++++++
>  arch/riscv/include/asm/errata_list.h | 16 +++++++++++++-
>  drivers/perf/riscv_pmu_sbi.c         | 33 +++++++++++++++++++---------
>  4 files changed, 69 insertions(+), 11 deletions(-)

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
