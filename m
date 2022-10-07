Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55A5F7307
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJGDF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJGDFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:05:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9D1BE88
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:05:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b15so3331615pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0flw4m11S0YkBSfXTbnOZpdPQvclpjjpCP9ZUVoipg=;
        b=Zvkian0aIr7blYD6OMaPdxJzgrIEi3mAcpdPwjkvXe5Il6UvoATmwhKS2hmLMjMLJk
         v4khv7zNX/u7Uft1BCXbI2vLlBkYU7emGbUkI+IsH8nBCDrANfuTK/JkNTXzsde7F9B5
         unR1ErQrFRpu4hQ8YJxgsjq2Aa4r3XwlARx51/X+mdwfnittcqNrFxBYdUpIKSlHRh7T
         LqxuFBVsfH98fUWXId9oCZ6Me2KDCiiToc1SmaZcUeBRBxJNTbp7NnGKUoiPAoes9JmP
         W8s3X0WJ5M+RRALTOB4TjE0q4LE0IGH3KwjJc2h68bJt6DvxtPwdS0ztWifptNoWy8X8
         PAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0flw4m11S0YkBSfXTbnOZpdPQvclpjjpCP9ZUVoipg=;
        b=lFjC2sbMAWRCCpEgvGMLsUqxdp+oB4WcnMM3gVOh8EKPnP8MBdaX4yw1R5YPzC4MrJ
         yyILZAvT+mCiDLTaIrQ7gYBvpMBbKkaC6rcZEMKwbpV5hItkPH/4/C8JDoO/YiV1ZqUG
         51CLj/umyp9kQh3Z6j2m63IWEwvbdlWIiQ5MjZH0CG1L4HgPYG8FXVlCiLT7xBitMEmw
         HBRzNztqoDj1vueIh7H1HISqIkstHnfHU6Ve8+9F7vGU0hxrmIDcprtfru9ggmjSdKSP
         DsN9cHDzNPXKoNKDr6OaMgqXBppIeWTpmr/FmQqkO+KCMS6+xd/NsqadyoGry8HganrR
         QkAA==
X-Gm-Message-State: ACrzQf0Gkv592gKtOumRG8GwTPW0gFl6L7TBN54VE2x0DPrT5H+pr3Df
        RyN/EHtb0hTZ/0heojWXZ3lViA==
X-Google-Smtp-Source: AMsMyM6onODrgPKfFIvPd397f6B2dV1HH1hcB8Pqn6pkZPpaqhERaSy1DiQEr7M0ivHPTA39GIJuCQ==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr13444790pjs.222.1665111930878;
        Thu, 06 Oct 2022 20:05:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090340c300b00172e19c5f8bsm341162pld.168.2022.10.06.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 20:05:30 -0700 (PDT)
Date:   Thu, 06 Oct 2022 20:05:30 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Oct 2022 20:05:28 PDT (-0700)
Subject:     Re: [PATCH] riscv: enable THP_SWAP for RV64
In-Reply-To: <Yz57T4eob3pXAVSP@wendy>
CC:     jszhang@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     conor.dooley@microchip.com
Message-ID: <mhng-382406aa-3eaf-4318-b5e6-9fc8a370f4d9@palmer-ri-x1c9>
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

On Wed, 05 Oct 2022 23:53:03 PDT (-0700), conor.dooley@microchip.com wrote:
> On Wed, Oct 05, 2022 at 07:35:53PM -0700, Palmer Dabbelt wrote:
>> On Sun, 21 Aug 2022 10:05:59 PDT (-0700), jszhang@kernel.org wrote:
>> > I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
>> > memory optimizations such as swap on zram are helpful. As is seen
>> > in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
>> > commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
>> > swapped out"), THP_SWAP can improve the swap throughput significantly.
>> >
>> > Enable THP_SWAP for RV64, testing the micro-benchmark which is
>> > introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
>> > shows below numbers on the Lichee RV dock board:
>> >
>> > thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
>> > thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
>> >
>> > Improved by 382%!
>> >
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> > ---
>> >  arch/riscv/Kconfig | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index ed66c31e4655..19088c750c7f 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -45,6 +45,7 @@ config RISCV
>> >  	select ARCH_WANT_FRAME_POINTERS
>> >  	select ARCH_WANT_GENERAL_HUGETLB
>> >  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>> > +	select ARCH_WANTS_THP_SWAP if TRANSPARENT_HUGEPAGE
>> >  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>> >  	select BUILDTIME_TABLE_SORT if MMU
>> >  	select CLONE_BACKWARDS
>>
>> Thanks, this is on for-next.
>
> FYI, this is v1 of a patchset that went to v3.
> v3 only changed the commit message, but v2 had a functional change.
>
> v3 is here:
> https://lore.kernel.org/all/20220829145742.3139-1-jszhang@kernel.org/

Thanks, not sure why I missed those.  I've put the v3 on for-next.
