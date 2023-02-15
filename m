Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7981698773
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBOVjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBOVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:39:06 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5ED2B603
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:39:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i6so123948ilk.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676497145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFvfKun3G+3Pysa+VuG0s4TsxaGNFmRiVXcIK5NwZvI=;
        b=hYUSF2mOd4YPilq9cNbbsBsOvsr2vgsIQy+p0J3tk6vPvwkkTg+ctMeZ/Z4x8fxV+5
         Jclvj0hEthOxwQZi972MQd/fHuVrayQKbKAQmKYGQR4Ehyxq6t/u/qB81XaFWVCXBpxc
         Rebc9efHy/G1Rn+o32wGmQQvLtYtMd7csixt+JbFF/H4X5sVx/mZGF/GYxFYFTjbzO08
         TuVsSVKP1xDFVX2/pXcygIi0P5180SkguGlvnGNiNS8ZV5qRBGWxcB8E3vwGBnrq7Lgr
         Rf9OQf/fOsUIifiLhza8jHzZqp2vs+dK0if4wX6uzrIgPDtY1QqLoHsub5FZpGyvHSiA
         9N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676497145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFvfKun3G+3Pysa+VuG0s4TsxaGNFmRiVXcIK5NwZvI=;
        b=QCiqqXi/jGV1yTyKjsaUFm8dHMkYCm6YSiIZrrLgeDm/9VYCUoA4PdQ0upoUApVfCr
         A+8n999a0RJiTtfxdaiB5Tk3b59CxdhQUC2E/RVEQoW5341etV5jqscdh9wMGe9ON8Rj
         jv2CS9wJCRm04ryLRmlgoDLGtGTbkssoop1V3w8j/2O1jduYA3yzrh4UnLaVwW6/SfmP
         r4nYE30nevFVfpSl3BoHWfJo+MYQaZpMqtNzvf8ycvyYobe8ARoLWFP/d5IZXk0hav+4
         T2e+FDb5e7sxgD/uqalagYr7+kfpgiqTyRS9zqlOOVYs5cBE8+bHnXaXpA4h9EequfPQ
         hNnQ==
X-Gm-Message-State: AO0yUKUtKqYBnUBwFcguJxB3S+0BbbzvddgBL0HwluS4JHuSVtt9Nmcx
        ClLfKLJuOav6Al/g0w6ztFer7btOaNUR9f86
X-Google-Smtp-Source: AK7set9+1oBWX5BNpiqT9Cwc0DlEHC7B0uyqZvtcrHN3fJ6UJ+1jHh6F6Qs+PBjyNh2jkZqI3+ybXQ==
X-Received: by 2002:a05:6e02:e0e:b0:314:16ea:103b with SMTP id a14-20020a056e020e0e00b0031416ea103bmr3051709ilk.3.1676497145105;
        Wed, 15 Feb 2023 13:39:05 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p24-20020a02c818000000b003ba4aea63d1sm5884854jao.117.2023.02.15.13.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 13:39:04 -0800 (PST)
Message-ID: <4dc0f8fc-ef3a-341d-b2cc-41fa3fe647b0@kernel.dk>
Date:   Wed, 15 Feb 2023 14:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCHv2] io_uring: Support calling io_uring_register with a
 registered ring fd
Content-Language: en-US
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f2396369e638284586b069dbddffb8c992afba95.1676419314.git.josh@joshtriplett.org>
 <03895f24-3540-dae9-1cdd-e3f6d901dec6@kernel.dk> <Y+1BhMgNJVoqYlYf@localhost>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+1BhMgNJVoqYlYf@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 1:33?PM, Josh Triplett wrote:
> On Wed, Feb 15, 2023 at 10:44:38AM -0700, Jens Axboe wrote:
>> On 2/14/23 5:42?PM, Josh Triplett wrote:
>>> Add a new flag IORING_REGISTER_USE_REGISTERED_RING (set via the high bit
>>> of the opcode) to treat the fd as a registered index rather than a file
>>> descriptor.
>>>
>>> This makes it possible for a library to open an io_uring, register the
>>> ring fd, close the ring fd, and subsequently use the ring entirely via
>>> registered index.
>>
>> This looks pretty straight forward to me, only real question I had
>> was whether using the top bit of the register opcode for this is the
>> best choice. But I can't think of better ways to do it, and the space
>> is definitely big enough to do that, so looks fine to me.
> 
> It seemed like the cleanest way available given the ABI of
> io_uring_register, yeah.
> 
>> One more comment below:
>>
>>> +	if (use_registered_ring) {
>>> +		/*
>>> +		 * Ring fd has been registered via IORING_REGISTER_RING_FDS, we
>>> +		 * need only dereference our task private array to find it.
>>> +		 */
>>> +		struct io_uring_task *tctx = current->io_uring;
>>
>> I need to double check if it's guaranteed we always have current->io_uring
>> assigned here. If the ring is registered we certainly will have it, but
>> what if someone calls io_uring_register(2) without having a ring setup
>> upfront?
>>
>> IOW, I think we need a NULL check here and failing the request at that
>> point.
> 
> The next line is:
> 
> +               if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
> 
> The first part of that condition is the NULL check you're looking for,
> right?

Ah yeah, I'm just blind... Looks fine!

-- 
Jens Axboe

