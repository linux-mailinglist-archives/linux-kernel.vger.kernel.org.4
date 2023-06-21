Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248D8739162
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFUVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFUVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:19:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82416197;
        Wed, 21 Jun 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0LvSQUp8WvXtAGQ4Ez7xlJWh7l4nI8L2oKtIOhjswdU=; b=1A8p1HhmdadYqjMQnx+zVWyu5+
        Ladz/59FpJjBs3OqTVrvo4cgy2X0TAsG1qf9oCRCfJ9HsvgKIH0tgtH90GUWaUNi/H0fUCxIxBEUl
        8qlTGD1mUcbgEI+vEtmoOvrBdB/l7JHljqlh0FsNd0ej7hlWvhl+pCWfjlzLCvy4Ap5xfqitK/pQN
        WIxrjcshc+HPms5Jx+J/7ihZeW4OWL5aAuRac0aOZyRFTB8aVe4M85XJpJlh1ijiszehnHn1m/5+s
        i7jRvnuMvPc9lDT4L6axQ3BIc8fjOFBSr06RW1CgobbtIs7FMp/un9dUYKicv3kqItFyjZGlnR8kE
        zkFsLRDA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC5ER-00FllS-36;
        Wed, 21 Jun 2023 21:19:16 +0000
Message-ID: <b5306c89-eaaa-b357-0518-bdb9a0e5ae9f@infradead.org>
Date:   Wed, 21 Jun 2023 14:19:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230615222152.13250-1-rdunlap@infradead.org>
 <ea55623d-d469-ddaf-92ce-3daf1d2d726f@infradead.org>
 <ZJMc3oS2nxORPASN@corigine.com>
 <66fd6106-16a5-d61a-4202-02ff99b84f76@infradead.org>
 <ZJNRZZCkGdvp+k34@corigine.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZJNRZZCkGdvp+k34@corigine.com>
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



On 6/21/23 12:37, Simon Horman wrote:
> On Wed, Jun 21, 2023 at 11:08:05AM -0700, Randy Dunlap wrote:
>> Hi Simon,
>>

>>> I did have better luck with this.
>>>
>>> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
>>> index 9c67b97faba2..303220251495 100644
>>> --- a/drivers/s390/net/Kconfig
>>> +++ b/drivers/s390/net/Kconfig
>>> @@ -6,6 +6,7 @@ config LCS
>>>         def_tristate m
>>>         prompt "Lan Channel Station Interface"
>>>         depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>>> +       depends on FDDI=y || FDDI=n
>>>         help
>>>           Select this option if you want to use LCS networking on IBM System z.
>>>           This device driver supports FDDI (IEEE 802.7) and Ethernet.
>>>
>>> I am assuming that LCS=m and FDDI=m can't work at runtime
>>> because there is no guarantee that FDDI is loaded before LCS.
>>> But I could well be wrong here.
>>
>> There's probably some way to make that work, but I don't know.
>>
>> I think that your patch is acceptable.
>> I would prefer to also add to the help text that if FDDI is used,
>> it must be builtin (=y).
> 
> Thanks Randy,
> 
> Feel free to take the snippet above and work it into a proper patch.
> Else I can take a shot at it.
> 

OK, I'll send that. Thanks.

-- 
~Randy
