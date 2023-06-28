Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6537408B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjF1CxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1CxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:53:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B61BD9;
        Tue, 27 Jun 2023 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dlpR/21Irur/vl2Bba6LPVcNg/tvhnzdXj8x/ntUtHk=; b=h9543rTXTZgDs/8RTl0Bz0B9yE
        M116oqVCVPUSJCywA3/wGRMWSC5PootiKkuuCIVj4ZLCgyIOapcZqDjfLOWkI/zgqJSN2o+fG3m+5
        LNi4LObBb3C7+Tstoj9H5/0jL1jcqEwdfXrHwtiJUzjkCxWtGJQUlfpBhl61Jqtop/8glW6Ccw6yE
        s5dG7olz8uyRhgbdhV7y4VtfVDkINgMoKAG0nYF8+mfcvCHdM63tNzCb0I5PpzLqzy9zDRsZZhIVM
        hFO0dw/qPTsAF7ZlKIL9PIHWAqdHkD6kuAAWAv5XjnO0XghWj9KoDCmoz5lsjXByoki6omg+BeCHV
        YW2hbj2A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qELIr-00EdQb-1N;
        Wed, 28 Jun 2023 02:53:09 +0000
Message-ID: <7f585168-7296-58aa-7fdb-c2aa08f346f4@infradead.org>
Date:   Tue, 27 Jun 2023 19:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
 <ZJP99hSRt5MakBXC@corigine.com>
 <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for the delay.

On 6/22/23 05:16, Alexandra Winter wrote:
> 
> 
> On 22.06.23 09:53, Simon Horman wrote:
>> On Thu, Jun 22, 2023 at 09:15:24AM +0200, Alexandra Winter wrote:
>>>
>>>
>>> On 21.06.23 23:37, Randy Dunlap wrote:
>>>> Require FDDI to be built-in if it is used. LCS needs FDDI to be
>>>> built-in to build without errors.
>>>>
>>>> Prevents these build errors:
>>>> s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
>>>> drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
>>>> s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'
>>>>
>>>> This FDDI requirement effectively restores the previous condition
>>>> before the blamed patch, when #ifdef CONFIG_FDDI was used, without
>>>> testing for CONFIG_FDDI_MODULE.
>>>>
>>>> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> [...]
>>
>>> 2) I wonder whether
>>>
>>>   	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>>>  +	depends on FDDI || FDDI=n
>>>
>>> would do what we want here:
>>> When FDDI is a loadable module, LCS mustn't be built-in.
>>>
>>> I will do some experiments and let you know.
>>
>> It does seem to on my side.
>> But checking would be much appreciated.
>  
> 
> Here are my experiments:
> 
> Current net-next:
> -----------------
> if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
> 
> drivers/s390/net/KConfig:
> config LCS
> 	def_tristate m
> 	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> 
> .config:
> ETHERNET  |  FDDI | LCS choices | LCS | compile
> --------------------------------------------------------
> n		m	m,n	  m	success (failed before Randy's fix)
> y		m	y,m,n	  m	success (failed before Randy's fix)
> y		m		  y	fails: undefined reference to `fddi_type_trans'
> 
> 
> Simon's proposal:
> -----------------
>         depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> +       depends on FDDI=y || FDDI=n
> 
> ETHERNET  |  FDDI | LCS choices | LCS | compile
> --------------------------------------------------------
> n		m	-
> y		m	-
> y		m	-
> y		n	y,m,n	  y	success
> y		n	y,m,n	  m	success
> y		y	y,m,n	  m	success
> 
> 
> Alexandra's proposal:
> ---------------------
>         depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> +       depends on FDDI || FDDI=n
> 
> ETHERNET  |  FDDI | LCS choices | LCS | compile
> --------------------------------------------------------
> n		m	m,n	  m	success
> y		m	m,n	  m	success
> y		n	y,m,n	  y	success
> y		n	y,m,n	  m	success
> y		y	y,m,n	  m	success
> 
> -----------------------------------------------------------
> 
> Seems that 
> 	A[tristate] depends on B[tristate]
> means that A cannot be 'higher' than B.
> Meaning, if B=n -> A= must be n
> 	if B=m -> A can be m or n
> 	if B=y -> A can be y or m or n

Looks correct.

> Although I did not find documentation confirming that.

I think that it's in Documentation/kbuild/kconfig-language.rst,
under "Menu dependencies", but not quite in that format. :)

> 
> @Randy, do you want give a v2 a try with that?

Sure, I'll try that.

> I guess then it is safe to delete from drivers/s390/net/lcs.c
> -#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
> -#error Cannot compile lcs.c without some net devices switched on.
> -#endif

Yes, I was planning to do that as well.

Thanks for the time that you have spent on this.
-- 
~Randy
