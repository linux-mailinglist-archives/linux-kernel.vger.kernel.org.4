Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD47392F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFUXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:16:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13EBC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:16:48 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39ec45b22f6so3480015b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687389408; x=1689981408;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4rVo+mVuxwtsu5V/lfGRBX4yPfbkTSPEFbP6fD5ewc=;
        b=ynlXNaUoh/2z3rEdd1Va2R2axXixILIPeHORpLCzMZFE4V5uoPzD6gTlz8xvGi7FLw
         +VRVTQYk/pcqdjxOvJYSGgg0swZPDjpZiJatNrSWftPI41PnMZDHh8sVzH0r4ggzZAgM
         Iiv9tLFyNubuodIKnHaT1YYYAVw2SYUPnLG3wJ5TNr6B17otEm4BgQyBE9hB+41xUKz0
         9oi0CRc3jOzbiD2XLIxegSmBkuLzWq7hwxQnE+N1/CL0YdiqdSV3JhJ5/SRpkXdxTYv6
         sBX531AaxRF/fVBfP6jHV1N9v8xWdbltKqut2dfIMIkPnUTPix9LpjZwtS8hg5N8XneG
         dWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687389408; x=1689981408;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4rVo+mVuxwtsu5V/lfGRBX4yPfbkTSPEFbP6fD5ewc=;
        b=HoWq27zlUR0RpNjy9jsVv3Y+pTzZ7AUH8cdtcPtYbhFdLzBD4NF2zZLMJeB1mHwmz+
         gKSExz2Zy9GUzwK18scvsckHTDySMfGpD9M9UvzHjMreSfOdbTbEm6qN1uPgGwRjWcCR
         sDaBB3hJHPI39CkeC7f+jtyO7KdlEDgL1qB5PfTsHCAOQ82qPrhR8q2+RnhMxQFC2FQM
         qu2coB+XD3egeQg1rzAiDj0X4S3QivSFgNdfi39SCrU2oh7jc+n8qg7e20/jB6+3/KTE
         TOlrApnPXJQ1COB6b5dbfoNemmIhTKcbrUXzFfZnnYhmelSolsBQKqROaNTpFwzcFPU+
         5Fjw==
X-Gm-Message-State: AC+VfDySRrdv025y8BF3KbVBO8S1i9elYymqfhzdq3VstaRimumrq/73
        EzUxpAK/AfWMW0XVPHGSj/7Dnw==
X-Google-Smtp-Source: ACHHUZ7FzNIAt4g+zr/JDyKcWdgMUIdnWlvI6D6LcF1SXHZE1wWG50I3TVQxeb7L9o0KolDHaB+/Bw==
X-Received: by 2002:a54:4095:0:b0:39e:e048:410 with SMTP id i21-20020a544095000000b0039ee0480410mr9145253oii.42.1687389407789;
        Wed, 21 Jun 2023 16:16:47 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090a72c300b0025930e50e28sm9355230pjk.41.2023.06.21.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:16:47 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:16:47 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 16:16:07 PDT (-0700)
Subject:     Re: [PATCH v1] RISC-V: make ARCH_THEAD preclude XIP_KERNEL
In-Reply-To: <20230621-grass-pregame-8fa7cd7bdb96@spud>
CC:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        rdunlap@infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-462c879c-bdd5-4b0c-8144-4618bd2e0499@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 13:00:38 PDT (-0700), Conor Dooley wrote:
> On Wed, Jun 21, 2023 at 12:57:02PM -0700, Palmer Dabbelt wrote:
>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> I don't have an ARCH_THEAD, though, so not sure where this is aimed at.
>
> I need to take it, I applied the patches.
> Sorry, probably should have said it below the --- line.

No problem, I figured they were over there somewhere -- just kind of 
hard to keep track with how much is in flight right now ;)
