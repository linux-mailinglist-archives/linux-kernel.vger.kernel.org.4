Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F772DAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbjFMH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjFMH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:27:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707790
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:27:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so5941581e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686641231; x=1689233231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCo9VX6y9eskW7XjUhZdDSOq/PCOqTXRwWrOd9wTu+s=;
        b=XYA14pIhapBKivqyi3B9Ed9HUVcA0lKpuz2vxCxtj8/5rWSJ8C1VCgk+GIdV7X66xa
         kN5ndtyrdGmXN6zQQXpNy5Sz0dP56rvMvPNv7UlWHQJniiWRuKfTmBkzYXyU27yf0GfD
         RK9vUQyEbi6qr/C/0geRHm1FhKhtRUffLe/zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641231; x=1689233231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCo9VX6y9eskW7XjUhZdDSOq/PCOqTXRwWrOd9wTu+s=;
        b=b9IqKgp6lgJoASRSaABwX3nKNP2wNAqPbwjGOjmzy0J/gkwoYcl3f6m3L5gy8PvRZs
         ajeKKuqe7uSrafgplA5n+Bc1ak013utLP7pm5c7MOclgR9t5PR3JsHiXsUnh7OLSf41E
         S+xkNxhw4ncG6U/cErqN2Syz6Hih7tgWwr66ajYr6d+JjcpengdosyAcNu5AryJO0NZp
         F9a/DXeAO/vnBBWCDbKcBbgJXhRaPR1mBLM9SEUns7x7+jqsAN+DWW7rW5Cd6CqKBESY
         H4cPpoTUJ46A1nYrHVh2MRVQoSwo8FpuC1t3sVCaAPP6iYTtskPydRILXs3eUnEZ66Zt
         EiCA==
X-Gm-Message-State: AC+VfDxtsZFk/0gHK+2BssLHMnp/mycjnTCvcSPB+KBZQtQbLLT9CoIK
        TzisRe8JrMblImwD/Ujv9CikEG5QgQnpI23HNi7/GA==
X-Google-Smtp-Source: ACHHUZ7b79zF1t3JexEgFXaaW0BEgSSi2mVnZwe64OwRddvWIYqYcVYq/ieGRFeTDhaQJKFKuKaiSw==
X-Received: by 2002:a19:4312:0:b0:4f4:b28f:6b9c with SMTP id q18-20020a194312000000b004f4b28f6b9cmr4619711lfa.29.1686641231173;
        Tue, 13 Jun 2023 00:27:11 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j7-20020ac24547000000b004f251cf3d31sm1678280lfm.153.2023.06.13.00.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:27:10 -0700 (PDT)
Message-ID: <76f0f62d-e53f-8708-e8a8-f71777a95f21@rasmusvillemoes.dk>
Date:   Tue, 13 Jun 2023 09:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR
 ioctls
Content-Language: en-US, da
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-6-linux@rasmusvillemoes.dk>
 <2023061214074623dcc0cf@mail.local>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <2023061214074623dcc0cf@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 16.07, Alexandre Belloni wrote:
> On 12/06/2023 13:30:55+0200, Rasmus Villemoes wrote:

>> +static int isl12022_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>> +{
>> +	struct regmap *regmap = dev_get_drvdata(dev);
>> +	u32 user = 0;
>> +	int ret;
>> +
>> +	switch (cmd) {
>> +	case RTC_VL_READ:
>> +		ret = isl12022_read_sr(regmap);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (ret & ISL12022_SR_LBAT85)
>> +			user |= RTC_VL_BACKUP_LOW;
>> +
>> +		if (ret & ISL12022_SR_LBAT75)
>> +			user |= RTC_VL_BACKUP_EMPTY;
>> +
>> +		return put_user(user, (u32 __user *)arg);
>> +
>> +	case RTC_VL_CLR:
>> +		return regmap_clear_bits(regmap, ISL12022_REG_SR,
>> +					 ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75);
> 
> I'm against using RTC_VL_CLR for this as it deletes important
> information (i.e. the date is probably invalid). You should let the RTC
> clear the bits once the battery has been changed:
> 
> "The LBAT75 bit is set when the
> VBAT has dropped below the pre-selected trip level, and will self
> clear when the VBAT is above the pre-selected trip level at the
> next detection cycle either by manual or automatic trigger."

Well, the same thing means that the bit would get set again within a
minute after the RTC_VL_CLR, so the information isn't lost as such. I
actually don't understand what RTC_VL_CLR would be for if not this
(though, again, in this case at least it would only have a very
short-lived effect), but I'm perfectly happy to just rip out the
RTC_VL_CLR case.

Rasmus

