Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1B745E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGCOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:18:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A3E52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:18:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f64817809so421042a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688393921; x=1690985921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJ5C0VubaymiW7q0tMGhf3MIIRcI6jDDTSwTFWevUc4=;
        b=5cW57S46H5CLUMFlegRNHZopAiYjUV3v8GhmjmXGJC3NaKHAzHzvrudF8yyazoKPna
         ZDfTmMsPUHbD8suDQdALQ8uWSVBjoMYzUjEOQRlrRJijMqAj4EzpCYzRR6wwIykSFLL4
         9wycoq+Ofq6Wo+X25h9GfHvcxF0hOMvCVNcczFofbRBQILxgSxfMznsTM7z60Z4V1FT1
         yG22KZeVhUMuFFR5drSC2PgmPiAvtX3/psYu0s+8d1V5oVUT32n2BAWs8viRt5WqbAjJ
         dKSkEFYw1WVjrpxbzVCsSIpL7m0QsD24QQZTCRZtPlO6u+kWjodbymTz0pRyt010kPyA
         /yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393921; x=1690985921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ5C0VubaymiW7q0tMGhf3MIIRcI6jDDTSwTFWevUc4=;
        b=SP2dkKIMJ82TMyGQ5SukxmY0azi5UjhDvXzb/APhBzw+lMiRpWSJKt+MuSnhaozLGy
         oDME70HJRW+shQ9PS0RVzcrOsm1tRG9F7drnknVujyvlmMmG3aDUzXYtM7SYYlKyNmxA
         sPjmnXHmglGhrd31oRuvgLFH3jY9BD8PlKWyEBPTbhGlE0UjXK3K7rCCMDpVldVPub3h
         PnwS3M2sslW3xp6128RCg4V2kCXizdh8ai6etF+JKkzhOQwwqE4Onfab6QWVgWFeYnu3
         t8FfxpmA9A3vG0nA/Ql3juTEgrCRAie9YAZit3Q2iTd7/yt1Pi63o57kBfy2svk7hsoh
         jgFw==
X-Gm-Message-State: AC+VfDw4k7dZQfT1IAOPHFRktt18haG6jjJ8FQ76pdyyRLCutPt+68jp
        NfqqY69ng/ADqNwSv6YzoPkOX3MfAwvUFcAFUCI=
X-Google-Smtp-Source: ACHHUZ4bt58Hmbc8I8JkYmlyLZrcWvH65+rRL6WcYmGDMjf4afjY8Y9Wj8Hy3+h5Jz1bRd7GDSHE8A==
X-Received: by 2002:a05:6a21:6d82:b0:12d:2abe:549a with SMTP id wl2-20020a056a216d8200b0012d2abe549amr16341915pzb.6.1688393920859;
        Mon, 03 Jul 2023 07:18:40 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7800a000000b0065446092699sm14567501pfi.141.2023.07.03.07.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:18:40 -0700 (PDT)
Message-ID: <c47b8ba6-1384-8864-8767-949ec45c3bbe@kernel.dk>
Date:   Mon, 3 Jul 2023 08:18:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <20230616124354.GD4253@hirez.programming.kicks-ass.net>
 <20230703110405.GU38236@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230703110405.GU38236@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 5:04?AM, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 02:43:55PM +0200, Peter Zijlstra wrote:
> 
>> I've been getting reports from some anonymous people still using ancient
>> GCCs (10.4) that also need the following:
> 
> Jens, will you pick this up or should I route it through the objtool
> tree?

Sorry, guess it was waiting on me. Would be great if you could route it
through the objtool tree. Thanks!

-- 
Jens Axboe

