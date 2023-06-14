Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672B72FBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjFNKv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243806AbjFNKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:51:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7481725
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:51:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f762b3227dso1160615e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686739909; x=1689331909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HcQg/AyzdVW/+cUds8z7t+ww39/I3wQ1QMKuN6hW7c=;
        b=eqJzCvAgKola/j0t6fDI2UoVrzCQWl6xXkX2ivMDkt0FIqOrrU2DriXnqa9JMp25wh
         o++aeyGPZmUdjZv8FvudL8c71k64fOKwLgAeiohuq/AVqJOv+0OrJ55Mk6/WKwFs87ju
         YiYFKUq1gOZP/tXEHZJBHg+hcb3qGqNuWPLfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739909; x=1689331909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HcQg/AyzdVW/+cUds8z7t+ww39/I3wQ1QMKuN6hW7c=;
        b=gRRKWw3zrqWDek8mnFqloU8ZF9W06fsW4HkWIY1aUIIf17i4yRI7h84K9bR3Hpt54U
         AJvlSIRdQCYob5z04iYPw9dtpWxrh4VSAoM6yD8wHUxsX60tayLOSFAVBheCadEd5VrE
         +z4jRzHwpbkcNNZkByBH38IivePzMwMplWTGR9eUAKKJSqKZCb/IxD0g/Y9tiAe6Liuo
         9omQ7lQVzv1OKBwHrCiNZJf1mEwd3selFGavNcbvixHsp7G96Sk0dy6exedBE9lxdjO5
         COGCH7LKHA5jWcsVo1VOHm9ChjOpfSSHsouCkSe6Wsr5QhvGGNMSvH2PM2ZLghHfgwws
         hMhQ==
X-Gm-Message-State: AC+VfDy6fEr+z0P0FjV+sF3Gr+HiADVezshzSi2rpJE2sFaMhwN442vg
        KwogHb3TgdhTUuFD2GiX4Q4dQyVupPhOCC89LqGl9A==
X-Google-Smtp-Source: ACHHUZ7+GAjiixypdk6QSEB77KRqd/GHKCl/WEudnKALKQynyI5F1qT0/pxh7mXd9YRJpYXe7zM8rg==
X-Received: by 2002:a19:2d5a:0:b0:4f7:3ee8:eeda with SMTP id t26-20020a192d5a000000b004f73ee8eedamr465097lft.34.1686739908831;
        Wed, 14 Jun 2023 03:51:48 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q19-20020ac246f3000000b004f60d26e1d2sm2056057lfo.80.2023.06.14.03.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 03:51:48 -0700 (PDT)
Message-ID: <c826b8a9-ed12-a6cc-d089-47adbc200f37@rasmusvillemoes.dk>
Date:   Wed, 14 Jun 2023 12:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 8/8] rtc: isl12022: implement support for the
 #clock-cells DT property
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-9-linux@rasmusvillemoes.dk>
 <ZIiKTXmrxBHw+gkG@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZIiKTXmrxBHw+gkG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 17.25, Andy Shevchenko wrote:
> On Tue, Jun 13, 2023 at 03:00:10PM +0200, Rasmus Villemoes wrote:
>> If device tree implies that the chip's IRQ/F_OUT pin is used as a
>> clock, expose that in the driver. For now, pretend it is a
>> fixed-rate (32kHz) clock; if other use cases appear the driver can be
>> updated to provide its own clk_ops etc.
>>
>> When the clock output is not used on a given board, one can prolong
>> the battery life by ensuring that the FOx bits are 0. For the hardware
>> I'm currently working on, the RTC draws 1.2uA with the FOx bits at
>> their default 0001 value, dropping to 0.88uA when those bits are
>> cleared.
> 
> ...
> 
>> +#define ISL12022_INT_FO_MASK	GENMASK(3, 0)
>> +#define ISL12022_INT_FO_OFF	0x0
>> +#define ISL12022_INT_FO_32K	0x1
> 
> A nit-pick. Are they decimal or bit fields? 

-ENOPARSE. A number is a number. Its representation in C code may be
decimal or hexadecimal (or...). And sure, 0 and 0x0 are different
spellings of the same thing. The data sheet lists the possible values in
terms of individual bits, so I suppose I could even do 0b0000 and
0b0001, but that's too unusual (even if perfectly acceptable by gcc).

> To me seems like the 0x can be dropped.

Can, but won't, a single hex digit is more natural way to represent a
four-bit field.

>> +	ret = regmap_update_bits(regmap, ISL12022_REG_INT, ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);
> 
> Seems too long even for 100 limit.
> Maybe:
> 
> 	ret = regmap_update_bits(regmap, ISL12022_REG_INT,
> 				 ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);

Sure.

Rasmus

