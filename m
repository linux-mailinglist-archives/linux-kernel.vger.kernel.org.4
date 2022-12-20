Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552C4652231
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiLTOPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiLTOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:15:00 -0500
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 06:14:59 PST
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D928E53
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:14:59 -0800 (PST)
Received: from eig-obgw-5012a.ext.cloudfilter.net ([10.0.29.230])
        by cmsmtp with ESMTP
        id 7dF6pVURyE9lP7dN2pSQc8; Tue, 20 Dec 2022 14:13:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id 7dN1pAbFH97j47dN1pI5rR; Tue, 20 Dec 2022 14:13:27 +0000
X-Authority-Analysis: v=2.4 cv=VN3OIvDX c=1 sm=1 tr=0 ts=63a1c307
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=sHyYjHe8cH0A:10
 a=wYkD_t78qR0A:10 a=639K83N8K81KkhpRCrwA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ru/CWfY1zVyiTyJwoTKjmy7OCqcrMyO4TLbc3pFhpbc=; b=rV+/MUtKiXZK+lMISNI1rK+Ntl
        CKJeMbqOHAUowT9ymyRLjYRrBUcG+dL1AHa7B/kxrzkXx2pmFLz6FWsN0Zwgvv9TzfquDWS2826ow
        QikhurLgHTVQFgwrpuqIgMXRCh7UlezVA+fDuSJJVma2DKakKHcEcOouBLFeTl3/yx2U5zzL1+Vj+
        ybjnVF1mIG2SHgogY7CV4z96Cqsy00H1IPpaln35twdy2l3F0kDVO7YwpXwjC67XDkNfoCu3rshLN
        urcWl/OIFzuIWxub94U9QCz2vts8xoma99s+ONW0r1jGRGvofkX+UXCloFbdbYppOrgfQSeQfj3/4
        JDiWjqJA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:43264 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1p7dN0-001StS-JD;
        Tue, 20 Dec 2022 08:13:26 -0600
Message-ID: <dbf47e34-9d28-439c-e4fe-34aa9cc41ee3@embeddedor.com>
Date:   Tue, 20 Dec 2022 08:13:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: kvzalloc vs kvcalloc
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>,
        Deepak R Varma <drv@mailo.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <Y6FJhxO8R6W0ykaB@qemulion>
 <alpine.DEB.2.22.394.2212200707250.3070@hadrien> <Y6FTDAHxw6ws42Cf@qemulion>
 <da83b74f-7f77-b267-6b12-7afce3ee761e@inria.fr> <Y6FoAOXAkrr4n7Mp@qemulion>
 <26b8353-dd33-1a57-d7b5-dc6a8583219@inria.fr>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <26b8353-dd33-1a57-d7b5-dc6a8583219@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1p7dN0-001StS-JD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:43264
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfObWq9TI0FQGkeBo1oXHANfQTbNKwmENRD8fSRR3uSB2gn+VWQLnPwn5IazR11d4U5ha+vB/EvTxAZJ8SwUmLWfORwcGw6GTezGKqR1mmq894dmfH1BX
 OkoHTDslIGwT/p2bYyy59Fbv6AiUwNlpJGYvfFB5s+sHlxG+jAJPZmi9R16esoY1Aeb6ASWS1u2ivlQchzJD84aMkObMEMuc5jbNiwI4TYTs++o8gToMTw1v
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/22 01:48, Julia Lawall wrote:
> 
> 
> On Tue, 20 Dec 2022, Deepak R Varma wrote:
> 
>> On Tue, Dec 20, 2022 at 08:39:09AM +0100, Julia Lawall wrote:
>>>
>>>
>>> On Tue, 20 Dec 2022, Deepak R Varma wrote:
>>>
>>>> On Tue, Dec 20, 2022 at 07:08:24AM +0100, Julia Lawall wrote:
>>>>>
>>>>>
>>>>> On Tue, 20 Dec 2022, Deepak R Varma wrote:
>>>>>
>>>>>> Hello Gustavo and Julia,
>>>>>> I was working on building a patch proposal using the kvmalloc.cocci file for a
>>>>>> driver. The recommendation from the semantic patch is to use kvzalloc instead of
>>>>>> a fallback memory allocation model. Please see my patch submitted here [1].
>>>>>>
>>>>>> I also found another patch submitted by Gustavo [2] which suggests using
>>>>>> kvcalloc instead of kvzalloc. Unfortunately, I was not able to understand the
>>>>>> reasons/advantages using kvcalloc over kvzalloc.

Look for the definitions of those functions and try to understand their differences.
In many cases you have go down the rabbit hole, but you should be able to get a good
grasp of the thing in question before hitting the bottom. :)

Look for a couple of instances in the codebase where those functions are being used
and try to understand a bit of the context around them. In some cases reading the
commit logs is necessary.

>>>>>
>>>>> The calloc variants are for zeroed arrays.  zalloc variants just zero.
>>>>
>>>> Thank you Julia and sorry to have missed the references in my email:
>>>
>>> In Gustavo's case, the array has a certain number of elements of a certain
>>> size.  I don't know if you have both pieces of information in your case.
>>> calloc functions take them in separately, and do the multiplication in a
>>> way that checks for overflows.
>>
>> That is correct and I do have both the pieces, the size and number. This
>> actually further optimizes the code. We can eliminate the array_size variable
>> with the kvcalloc implementation. It is not used beyond the memory allocation.
>>
>> Please this code snip:
>>
>> 	853          int count = size >> PAGE_SHIFT;
>> 	   1         int array_size = count * sizeof(struct page *);
>> 	   2         int i = 0;
>> 	   3         int order_idx = 0;
>> 	   4
>> 	   5         pages = kvzalloc(array_size, GFP_KERNEL);
>> 	   6         if (!pages)
>> 	   7                 return NULL;
>>
>> Thank you for your advise. I will wait to see Gustavo has any further guidance.
>> I will send in a revision to my patch accordingly.
> 
> Great.  A calloc function definitely looks like a good choice here.

As Julia suggested, and as you may had realized already, the calloc function is the
way to go, in this case.

--
Gustavo


