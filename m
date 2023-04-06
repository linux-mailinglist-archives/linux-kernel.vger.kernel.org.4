Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5A6DA4BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDFVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjDFVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:32:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D110C61B0;
        Thu,  6 Apr 2023 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=chn8p8fTTOkPGyLbQXcT8NlPwb7SWv+j2mvpCDHidvg=; b=ASF7PERFMEDzrvNGEmjrCfqpBK
        yDDmjGou1lNRg0MTqgcURtjEC1azaLAepuxGBEMRxJ0Msj1Phlmp42/EiGPsVT7N+7ANNgNnWNh/G
        frL5rIllOtdDzgxLeW0VcMYfP9IPmKDUEGvTNE+EFisrPr3h4WPJQwLaCKgphg08X9wRl1ylr/cnb
        KWNNLUDQMjRKJRS6rm/B0izphz4t24OaxNHA4J5FUmABTYX5wxLPQHBFQGHK5YEPR5h3v6BiyNYOe
        KmpnWk7BuSPiFzrgUnxkqWbjKHu4U3KugwNciLlCvcdeRtmixHQxaeUVrDI+8KuUjYvHrhEPA/lPZ
        /DgnalHA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkXD5-008dqf-1l;
        Thu, 06 Apr 2023 21:31:59 +0000
Message-ID: <af8d2f99-52f1-ae88-126e-cf90bd6cb3b2@infradead.org>
Date:   Thu, 6 Apr 2023 14:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
 <20230406203207.GA1534216@ravnborg.org>
 <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/23 14:01, Maciej W. Rozycki wrote:
> Hi Sam,
> 
>>>  This looks completely wrong to me, any ordinary PCI parallel port card 
>>> ought just to work as long as you have PCI (S390 is special I'm told).  
>>> What needs to be done is AFAICT just making `parport_pc_find_nonpci_ports' 
>>> in arch/sparc/include/asm/parport.h SPARC64-specific, i.e.:
>>>
>>> static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
>>> {
>>> 	return (IS_ENABLED(CONFIG_SPARC64) &&
>>> 		platform_driver_register(&ecpp_driver));
>>> }
>>>
>>> or suchlike and let the optimiser get rid of all the unwanted unsupported 
>>> stuff.
>>
>> arch/sparc/include/asm/parport.h is sparc64 specific - and it will
>> result in the wrong result if it is pulled in for sparc32 builds.
>> This is what we see today.
>>
>> Randy's suggestion is fine, as we avoid building parport support
>> for sparc32. If someone shows up and need parport support
>> for sparc32 then we could look into how to enable it.
>> Until then, we are better helped avoiding building the driver.
> 
>  I disagree.  Why artificially prevent perfectly good hardware from 
> working with a perfectly good driver especially as the fix is just a 
> trivial exercise?  And I offered a solution.
> 
>  I don't have a SPARC toolchain handy or I could even try and build it 
> (but I'm sure there are many people around who can do it without bending 
> backwards).

https://mirrors.edge.kernel.org/pub/tools/crosstool/


-- 
~Randy
