Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE7705207
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjEPPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjEPPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:24:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBD7DBA;
        Tue, 16 May 2023 08:24:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GFOCIC034787;
        Tue, 16 May 2023 10:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684250652;
        bh=6rAIJ1/IxMzmIB9RHD1AKzFTkg/d7qqPgWAWv+iLSek=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mMvxYgf8dLFMj/+IuMVbrHTz1cAk6Mv6gatUkBL4QvgKhJaR51PWwb294m9x6Iwxp
         xg8f6ByGEyRM9bihBKrjzXP4YIZQczPoA4xMbIc/OUBrT9S4tNd6gXBRYhxZI+1NTB
         IFNfg4ufPo8lcxyGSOqqGuxTlw2fmU5HtjcqgjXs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GFOCCQ021591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 10:24:12 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 10:24:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 10:24:12 -0500
Received: from [10.250.35.184] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GFOBHR063958;
        Tue, 16 May 2023 10:24:11 -0500
Message-ID: <44a19ea6-a7e3-51bb-6631-b7514ef88219@ti.com>
Date:   Tue, 16 May 2023 10:24:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] gpio: pisosr: Use devm_gpiochip_add_data() to simplify
 remove path
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>
CC:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515174321.494714-1-afd@ti.com>
 <ZGJ7POc8Qm9pE_WZ@surfacebook>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZGJ7POc8Qm9pE_WZ@surfacebook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 1:34 PM, andy.shevchenko@gmail.com wrote:
> Mon, May 15, 2023 at 12:43:21PM -0500, Andrew Davis kirjoitti:
>> Use devm version of gpiochip add function to handle removal for us.
>>
>> While here update copyright and module author.
> 
> ...
> 
>> +static void pisosr_mutex_destroy(void *data)
>> +{
>> +	struct mutex *lock = data;
>> +
>> +	mutex_destroy(lock);
>> +}
> 
> No need to cast void * explicitly.
> 

No need sure, but I really think it looks cleaner to be
explicit with the types here. If you feel strongly I
can change it though.

Andrew

> static void pisosr_mutex_destroy(void *lock)
> {
> 	mutex_destroy(lock);
> }
> 
