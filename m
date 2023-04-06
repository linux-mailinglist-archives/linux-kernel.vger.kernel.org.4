Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9196D8FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjDFGwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjDFGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:52:36 -0400
Received: from 10.mo562.mail-out.ovh.net (10.mo562.mail-out.ovh.net [46.105.72.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A598A66
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:52:34 -0700 (PDT)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id 930A82455D;
        Thu,  6 Apr 2023 06:52:32 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <sven.schwermer@disruptive-technologies.com>; Thu,  6 Apr 2023 06:52:32 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.1.244])
        by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 6A5C51FE27;
        Thu,  6 Apr 2023 06:52:32 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 08:52:31 +0200
Message-ID: <f4616854-a0eb-9abe-e411-402c91cab43d@traphandler.com>
Date:   Thu, 6 Apr 2023 08:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 4/6] leds: class: store the color index in struct
 led_classdev
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230328161541.599463-1-jjhiblot@traphandler.com>
 <20230328161541.599463-5-jjhiblot@traphandler.com>
 <CAHp75Ve_=Gzpg9GO=2dqTKWuyU-Podezv_YSwHLqFPHXk1DUxg@mail.gmail.com>
Content-Language: en-US
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75Ve_=Gzpg9GO=2dqTKWuyU-Podezv_YSwHLqFPHXk1DUxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 7795730958712781275
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhrvddruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedv
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2023 19:15, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 7:15 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>>
>> This information might be useful for more than only deriving the led's
>> name. And since we have this information, we can expose it in the sysfs.
> 
> ...
> 
>> +Date:          March 2023
>> +KernelVersion: 6.3
> 
> Outdated version.
> 
> ...
> 
>> +               Color of the led.
>> +
>> +               This is a read-only file. Reading this file returns the color
>> +               of the led as a string (ex: "red", "green").
> 
> There are no strict rules about colour and I don't think it's a good
> idea. Why in such a case is it different to label? My proposal here at
> least documenting that the colour must follow one of the existing
> naming standards (like RGB in hex, HTML, or name in accordance with
> chosen standard).
Actually the colors are defined in an array: led_colors (led-core.c: 88)
So the color is one of the following: white, red, reen, blue, amber, 
violet, yellow, ir, multicolor, rgb

There is mention in the TODO file of changing the way RGB leds are 
handled and the RGB leds would probably show the hex RGB values here.

> 
> Yet, it won't technically prevent abusing that, but at least will show
> the intention and allow pointing out to the bugs or develop user space
> tooling based on existing parsers (if any).
> 
