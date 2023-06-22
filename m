Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F176273A530
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFVPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFVPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:36:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EA118;
        Thu, 22 Jun 2023 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hR/gHK5Osq4DM/s3OZoGTc7hEAA7J9aSxxw3XlwfbaI=; b=VWYq5eFIEnerNIsnZU192fVY6g
        RBaNgpQ9ovQ0SIcO9hNZDgzQCiiQ70Da+xmcINoETINVaM7NFPCbXAGdMEB3yDTKp9O43HqDapJSf
        zmwegLlz/XpjAuJrVjCiD7Lz28vlKeAuMt7KGo3+067yAOC/1MirZq79rmoo7TsIVMiFloY8QT3lz
        OeALNH4c6td82X/7QYzNkFPedIQWjRtQD1RsVbs3QbOfA6CAfGE5GOXpQjHU6ik3JWZgtO57mD9tw
        WOvtgPpegy5E9sQ/bF52QQHgitCQL+jzvBNW3X1Gm/Gcy/SE9zF8HaoxYwas619lgU/kX9bp/HTfd
        Ty74sRNg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCMMh-0018x8-18;
        Thu, 22 Jun 2023 15:36:55 +0000
Message-ID: <0b59dcd8-e730-588b-a627-216c4453065d@infradead.org>
Date:   Thu, 22 Jun 2023 08:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
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



On 6/22/23 00:15, Alexandra Winter wrote:
> 
> 
> On 21.06.23 23:37, Randy Dunlap wrote:
>> Require FDDI to be built-in if it is used. LCS needs FDDI to be
>> built-in to build without errors.
>>
>> Prevents these build errors:
>> s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
>> drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
>> s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'
>>
>> This FDDI requirement effectively restores the previous condition
>> before the blamed patch, when #ifdef CONFIG_FDDI was used, without
>> testing for CONFIG_FDDI_MODULE.
>>
>> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
>> Suggested-by: Simon Horman <simon.horman@corigine.com>
>> Cc: Alexandra Winter <wintera@linux.ibm.com>
>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Sven Schnelle <svens@linux.ibm.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/s390/net/Kconfig |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
>> --- a/drivers/s390/net/Kconfig
>> +++ b/drivers/s390/net/Kconfig
>> @@ -6,11 +6,13 @@ config LCS
>>  	def_tristate m
>>  	prompt "Lan Channel Station Interface"
>>  	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>> +	depends on FDDI=y || FDDI=n
>>  	help
>>  	  Select this option if you want to use LCS networking on IBM System z.
>>  	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
>>  	  To compile as a module, choose M. The module name is lcs.
>>  	  If you do not know what it is, it's safe to choose Y.
>> +	  If FDDI is used, it must be built-in (=y).
>>  
>>  config CTCM
>>  	def_tristate m
>>
> 
> 
> Wow Randy and Simon, you are reacting faster than I was able to evaluate this yesterday.
> 2 thoughts:
> 
> 1) As ETHERNET cannot be a module and this patch prevents FDDI from being a module, then 
> 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> is kind of pointless and can as well be reverted instead of doing this fix.
> Or am I missing something?

Hi,
I'll just send a revert for now and then work on the next step(s).

thanks.
-- 
~Randy
