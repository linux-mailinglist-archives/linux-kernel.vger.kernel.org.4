Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA835BFFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIUOeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUOeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:34:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604962F2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:34:28 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id c4so5196146iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y9qJH4p5mVpa4a017Npx8Guug2HXx37SOnXReOlQQDI=;
        b=6neaLw7Rl2m8fqveO8b9p7b7NV80spZJC8zDn3ZoSFYLYAIH13wXecVlYPcFiOptaD
         vmaLnx9f7h95Ri0MaRTL/xBPTEWBF2r8FvErC5F9I1GpMaFmaYr9PgO7KOd1VR1WTc8/
         Fn3ju5Y42QSBnLEG4S24GK/vx8ymmiAaGu88Kq86/vq4x55nQNBly7VMEr+9ZSbDZfEn
         fWDiDZko4Qklq1qWsJXJoVZx7ukgrV7uG0gliFQlXxploBdaGFinQMVN39rFBz5PT6Ap
         +RNj8F7zrmIwDH5uTWLG6cNpEY/uP0J5rKC2AiVCd/ZsfrE3dgwojQ+3o/JC32rPOpSi
         MfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y9qJH4p5mVpa4a017Npx8Guug2HXx37SOnXReOlQQDI=;
        b=Hcmp3IC3UoSoiekClXmCmDpUphyyNSMuyiky+Q09LN77yRZkz4RkOeLhJnc3/qIeDX
         Jn0Oo0My759R5KYJdAsCNcryTXZNrnH5BZ/Q+lfcECsjs+Xh7LSLRazlelVwIc5m5IMQ
         oNtJNvoh+MthvWcnZH4AREB9PS+RN0AQ6pZ37Bxy7Pim5MM3SFAzgiKpfoX2p7N2Wu+n
         l/v2DYyJZNGm7MdRCs+ojJrldAEPouicC3dsCC0nf5/dXDN1/bLp1y4AsHFofWYFQ/PM
         NUA7Vlbv9ml0aAu5evN0FPAW9bez63+1zOZBSBDekLI1RY4mcZsAcF4c7ShnN6K/r5UR
         /oHA==
X-Gm-Message-State: ACrzQf0u2QYL0SOU1HJLGHPoIDL8hr3W3DBEEn1FuxXWHoJnENph8iYh
        3BGpJFjLtu3EkmE2ZgY5QE6FCg==
X-Google-Smtp-Source: AMsMyM5Y0ov9derzD5xgJgr5MKwNddz0GhXBBijeLFlGJnuvIzG2ySlyP7j3WrnvuVf3gorGGI/Sxg==
X-Received: by 2002:a6b:7d05:0:b0:68b:7243:63ff with SMTP id c5-20020a6b7d05000000b0068b724363ffmr11874700ioq.191.1663770867802;
        Wed, 21 Sep 2022 07:34:27 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y97-20020a02956a000000b0035b0ea27606sm999417jah.79.2022.09.21.07.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 07:34:27 -0700 (PDT)
Message-ID: <c7c909aa-71d9-b43c-293e-d4801a00861e@kernel.dk>
Date:   Wed, 21 Sep 2022 08:34:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Christoph Hellwig <hch@lst.de>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
 <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
 <6a3660b2-fa7d-14a2-6977-f50926ad369c@leemhuis.info>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6a3660b2-fa7d-14a2-6977-f50926ad369c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 3:25 AM, Thorsten Leemhuis wrote:
> On 20.09.22 16:14, Jens Axboe wrote:
>> On 9/20/22 8:12 AM, Christoph Hellwig wrote:
>>> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
>>>> Christoph and I discussed this one last week, and he has a plan to try
>>>> a flag approach. Christoph, did you get a chance to bang that out? Would
>>>> be nice to get this one wrapped up.
>>>
>>> I gave up on that as it will be far too much change so late in
>>> the cycle and sent you the revert yesterday.
>>
>> Gotcha, haven't made it all the way through the emails of the morning yet.
>> I'll queue it up.
> 
> Thx to both of you for taking care of this.
> 
> Nitpicking: that patch is missing a "CC: stable@..." tag to ensure
> automatic and quick backporting to 5.19.y. Or is the block layer among
> the subsystems that prefer to handle such things manually?
> 
> Ohh, and a fixes tag might have been good as well; a "Link:" tag
> pointing to the report, too. If either would have been there, regzbot
> would have noticed Christoph's patch posting and I wouldn't have
> bothered you yesterday. :-) But whatever, not that important.

We'll just have to ensure we ping stable on it when it goes in.

-- 
Jens Axboe


