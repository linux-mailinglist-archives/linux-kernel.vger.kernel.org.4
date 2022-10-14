Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78745FEB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJNJRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNJRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:17:10 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8672AF1A6;
        Fri, 14 Oct 2022 02:17:08 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.4.248])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 74978130870B3;
        Fri, 14 Oct 2022 11:17:07 +0200 (CEST)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 14 Oct
 2022 11:17:06 +0200
Message-ID: <fb513ce8-3c2a-6b67-7abe-1d5671b682d0@traphandler.com>
Date:   Fri, 14 Oct 2022 11:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/6] devres: provide devm_krealloc_array()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <bjorn.andersson@linaro.org>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221007145641.3307075-1-jjhiblot@traphandler.com>
 <20221007145641.3307075-2-jjhiblot@traphandler.com>
 <CAHp75VcX2w9mdzbKtfRpc-4zrz8tp33Q5uHyBfds8MJfyeVYvQ@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75VcX2w9mdzbKtfRpc-4zrz8tp33Q5uHyBfds8MJfyeVYvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS4.emp2.local (172.16.1.4) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 2959709381908183515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrnhguhidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdgsrhhglhessghguggvvhdrphhlpdhlvggvrdhjohhnvghssehlihhnrghrohdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskh
 hiodgutheslhhinhgrrhhordhorhhgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrihhnlhhinhgvrdhorhhgpdgsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvkedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/2022 18:18, Andy Shevchenko wrote:
>>   {
>>          return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>>   }
> Missed blank line?

There is no blank line after the definitions of devm_kzalloc(), 
devm_kmalloc_array() and devm_kcalloc() defined just above.

>
>> +static inline void *devm_krealloc_array(struct device *dev,
>> +                                       void *p,
>> +                                       size_t new_n,
>> +                                       size_t new_size,
>> +                                       gfp_t flags)
>> +{
>> +       size_t bytes;
>> +
>> +       if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
>> +               return NULL;
> I'm not sure it is what we want, but I have read the man realloc and found this:
>
>        ... reallocarray() fails safely in the case where the multiplication
>        would overflow.  If such an overflow occurs, reallocarray() returns NULL,
>        sets  errno  to  ENOMEM,  and leaves the original block of memory
>        unchanged.
>
> So, perhaps you can add that this behaviour mimics reallocarray()?

except for the errno part, that is what is does. I don't think we should 
use ERR_PTR in this case as the other allocation functions don't use it.

>
>> +       return devm_krealloc(dev, p, bytes, flags);
>> +}
> ...
>
> All comments are minor, feel free to add
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
