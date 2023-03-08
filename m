Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B666B0D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCHPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjCHPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:50:56 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35539C48A9;
        Wed,  8 Mar 2023 07:50:47 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 328Fogxt002975;
        Wed, 8 Mar 2023 09:50:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678290642;
        bh=jzszyWSCpzcY9s0rXEEp290pik8ZDl2g8aFhW2rZxBc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UEjgNcE/C2JyEb6BGTtbaxrAryMp1nU4jz1Sm2JZHGPXnq7AeeMmlGbnynkezBw9v
         jh3gg5FDIXL1uAwhZvUpfdrOt0Oe3b126vgZQxFw7L1BhOaS+oliQ4OeKnzd9Q0hCA
         W0T67x1RCKlWPDIn7b8wklMUTkQFFtbyZ3qi4OD4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 328FogP5014225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 09:50:42 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 09:50:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 09:50:41 -0600
Received: from [128.247.81.39] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 328FofGt007550;
        Wed, 8 Mar 2023 09:50:41 -0600
Message-ID: <9c705260-c04c-da2e-db9a-df3ddfb69efc@ti.com>
Date:   Wed, 8 Mar 2023 09:50:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-3-afd@ti.com>
 <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
 <CAMRc=MfAqx5Wz2d5K1wWM0ZZ4WBu+Jhercw-z95zGvo_-v=OTg@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAMRc=MfAqx5Wz2d5K1wWM0ZZ4WBu+Jhercw-z95zGvo_-v=OTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 4:32 AM, Bartosz Golaszewski wrote:
> On Wed, Mar 8, 2023 at 11:24 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Tue, Mar 7, 2023 at 5:54 PM Andrew Davis <afd@ti.com> wrote:
>>>
>>> Use devm version of gpiochip add function to handle removal for us.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   drivers/gpio/gpio-sch311x.c | 25 ++-----------------------
>>>   1 file changed, 2 insertions(+), 23 deletions(-)
>>>
>>
>> Applied, thanks!
>>
>> Bart
> 
> I see there's v2 out, backing it out then.
> 

Looks like I missed something that kernel test robot found, so there
will be a v3.

Andrew
