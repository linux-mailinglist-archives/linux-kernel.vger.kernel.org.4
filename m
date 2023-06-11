Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261F72B416
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjFKVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFKVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:13:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCE18C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LL4lF0A6NSXr0LbjDzaHvYGCyKzFFbR+twf8UXEVekE=; b=FOopikjDC36FNtyYnGarhbnmlK
        F6Z4cDQhPPRF9zevq39Mi2IJAuojiFwCyuHYB43pVjsjjxewF5uDfEBe0L6t/i1ug8s3mD9pS+519
        /Abfh1LBMlMZEWFr34XOu/8uv09ah2v5CvzR2UeG3yrrnsyqYIDAZm6MwvbH/lYQiyyvkplu5IbKf
        VTp2xi91V77WFPOTRntdQAwEE+oOFg2ngrY9Y0T392eVDpnHq5fNXfRZ9uMwNMs06IdhFCs51/J9i
        8gD77w2nXdSOIW9suceNEjcotYIFH3ldGGfFTphlsUSQVH6VHMjqixSGWFtSojfNW/pzRpHlNY7PP
        bhv2qZGA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8SNP-001mXq-2c;
        Sun, 11 Jun 2023 21:13:31 +0000
Message-ID: <113ce08f-743d-ac6c-f051-10f5f665e043@infradead.org>
Date:   Sun, 11 Jun 2023 14:13:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mux: mmio: depend on REGMAP as the code has that
 dependency
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
 <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
 <20230210115625.GA30942@pengutronix.de>
 <31f2a49f-bc48-d502-df31-667ef1a83fab@axentia.se>
 <946cea0c-6d7f-c2e3-4412-4967ece40b94@axentia.se>
 <fc94fa7f-2e73-7b9f-ea4c-2c5dffcbf844@infradead.org>
 <8e3176e3-8eb2-de7f-cc79-d04fe48ab8e6@axentia.se>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8e3176e3-8eb2-de7f-cc79-d04fe48ab8e6@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/23 14:04, Peter Rosin wrote:
> Hi!
> 
> 2023-06-11 at 22:59, Randy Dunlap wrote:
>> On 5/24/23 05:52, Peter Rosin wrote:
>>> REGMAP is normally "selected", but that causes a recursive dependency.
>>> But since REGMAP is "depended on" in other places, do so here as well.
>>> The (implicit) REGMAP dependency was lost when the strict dependency
>>> on MFD_SYSCON was removed.
> 
> *snip*
> 
>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>>> index 80f015cf6e54..7f07ca06eb2b 100644
>>> --- a/drivers/mux/Kconfig
>>> +++ b/drivers/mux/Kconfig
>>> @@ -48,6 +48,7 @@ config MUX_GPIO
>>>  config MUX_MMIO
>>>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>>>  	depends on OF
>>> +	depends on REGMAP
>>
>> REGMAP is mostly selected, not depended on, so preferably
>>
>> 	select REGMAP
>>
>> here whenever this patch is ready to be merged.
> 
> I would have preferred that as well, and if that was without problems I
> would not be so hesitant as there are really few pre-existing "depends
> on REGMAP".
> 
> I do not know what to do here and am not sure whom to ask for guidance.

Oh, I did not recall all of that, but now that  you mention it, I do remember
that problem (cyclic dependencies...).
Sorry about that.

-- 
~Randy
