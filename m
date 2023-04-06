Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B66DA1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjDFTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjDFTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:51:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE334FF;
        Thu,  6 Apr 2023 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Te8ZrH71Rk+Gkv4W+M2hqxOfa8vOSAIYY2ySlw7ZxRA=; b=mbLM1S1EHCt6l2whra0NF3U+Gb
        1zyY1BAQVrety46BO3vbnVGK9V3iFWQRrKP3L2MDNFYjfQytqINWIsVD7vKcb2is/v9yFJ44NrWGB
        mvTqgf1LpRKXVa5L087A0RKAjrVq0WP/YHfPIqJqjZKFon5O40uZpVgrvPdif/nWHiDevohmlkIio
        pQu9uEmp69Q+W/Qw8Y5gyaPiCAhfe8KUKUl0nClHigarZtRYpA+ys2lI6UmeeYutqI7tC21v4vkc6
        6uUwRkyF9YFPSY9B9Y1gDjNtvDAc78vHi1iWTm4WPJ7YDwbP5rV08TtVq/8CPP/Jv8nVQUOZ+eIZf
        qdDdp3eQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkVdZ-008R7T-2k;
        Thu, 06 Apr 2023 19:51:13 +0000
Message-ID: <743b5d56-91b1-0b39-44f2-d353a95d59a0@infradead.org>
Date:   Thu, 6 Apr 2023 12:51:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-parport@lists.infradead.org
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
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



On 4/6/23 12:49, Maciej W. Rozycki wrote:
> On Thu, 6 Apr 2023, Randy Dunlap wrote:
> 
>> arch/sparc/kernel/ebus.o is only built for SPARC64.
>> ns87303_lock is only built for SPARC64.
>> arch/sparc/include/asm/parport.h says that it is for sparc64.
>> Various documentation on the internet says that ebus is for UltraSPARC
>> systems (64-bit).
>>
>> Therefore don't allow PARPORT_PC to be built for SPARC32.
> 
>  This looks completely wrong to me, any ordinary PCI parallel port card 
> ought just to work as long as you have PCI (S390 is special I'm told).  
> What needs to be done is AFAICT just making `parport_pc_find_nonpci_ports' 
> in arch/sparc/include/asm/parport.h SPARC64-specific, i.e.:
> 
> static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
> {
> 	return (IS_ENABLED(CONFIG_SPARC64) &&
> 		platform_driver_register(&ecpp_driver));
> }
> 
> or suchlike and let the optimiser get rid of all the unwanted unsupported 
> stuff.

Fine, please go ahead with that solution.

-- 
~Randy
