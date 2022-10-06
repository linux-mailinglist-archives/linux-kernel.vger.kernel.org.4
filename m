Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7705F5EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJFCf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJFCfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:35:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194B51A00
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 19:35:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g28so795638pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzYCuMJ6p+Lody3rGbmn8WF2xPwU8C86ya7mCiVZOHo=;
        b=oIjVV9ZHj4GGDi8SFJItsfKMgtjpJSgxw60X0FYAdYvf7jqkgI65Z98amBNxp8soae
         K+5ZTBEq13ODrr6UTPo6jX6Owim8nKWDAhJyBhOxBN5XfAnb3BwC1YXyYdsCM5e8PkeP
         gu3viXESvkKNYbbFdtZk4app3Ffm/3r/u8KmK79sBWK1eEMPBYvuTgKEq2REicgQcNsI
         fvqr4FDFi/KnC3eGZIxIfNK6Eq0MRsev4Yue8r4q/rUXA9JWRKEsfLRs/lG8LJJ+l0bk
         OA0KS2W3PUPVyidsbIJfayH1mL02jGMIg40xYE03N9GwITGdxyLBrJGmB4nijz07RIf6
         /bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzYCuMJ6p+Lody3rGbmn8WF2xPwU8C86ya7mCiVZOHo=;
        b=CaX11LS2qTFjrxTv1FcCuae/MRLLrjaMKHvCVxWslAWwtnJprBUE6hyZtOIqJH5zwo
         zKV1frJczZ8cvCKn73/BP21tm3Mm86seOyLFRtAP37jNEbIv9wHWK8GeqPsaGxwxlT5K
         pG9RK7WEnSYJwvitsXxiuRk5JF1bRlwnbM54a6IVjw3dyCvLqsm/yIw1/9W3Mk9wJD3K
         rSVnSiJRGp7nrxqT7MahoXNkDcDUNuht3GWKFlSCxNrW712In6Po6jKVrM0GnBGX4R+x
         Eod99FBTTJMOn4iOjNIacFVy1b8oUr5zk0yvvitR9IJllb4rqgMG1jZSpwh3n1wFCS0N
         a9/w==
X-Gm-Message-State: ACrzQf32h/qlqtFcBOx2qOlMtxr6Nmj5JU9+cm8H0QKgKTDn8O+rswqD
        yYb/PDZgjDmZ5h7iGGgDTDMFrA==
X-Google-Smtp-Source: AMsMyM5lKJe5/EDcakfW1cb65IZbvyiGCALsJ4uURnN8IQRDtOZwNGHl5ZhIhZsy+D4e62Rn7ocvVw==
X-Received: by 2002:a05:6a00:124e:b0:561:7fa0:7307 with SMTP id u14-20020a056a00124e00b005617fa07307mr2746316pfi.5.1665023754319;
        Wed, 05 Oct 2022 19:35:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f80-20020a623853000000b00562362dbbc1sm1939327pfa.157.2022.10.05.19.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 19:35:53 -0700 (PDT)
Date:   Wed, 05 Oct 2022 19:35:53 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Oct 2022 18:09:45 PDT (-0700)
Subject:     Re: [PATCH] riscv: enable THP_SWAP for RV64
In-Reply-To: <20220821170559.840-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-a75e502f-0324-44ae-92c5-e93864fbf1cc@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2022 10:05:59 PDT (-0700), jszhang@kernel.org wrote:
> I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
> memory optimizations such as swap on zram are helpful. As is seen
> in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
> commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
> swapped out"), THP_SWAP can improve the swap throughput significantly.
>
> Enable THP_SWAP for RV64, testing the micro-benchmark which is
> introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
> shows below numbers on the Lichee RV dock board:
>
> thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
> thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
>
> Improved by 382%!
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4655..19088c750c7f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -45,6 +45,7 @@ config RISCV
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_WANTS_THP_SWAP if TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
>  	select CLONE_BACKWARDS

Thanks, this is on for-next.
