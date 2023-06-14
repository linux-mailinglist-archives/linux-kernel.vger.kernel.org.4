Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1372FF80
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbjFNNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjFNNJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:09:11 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F21193;
        Wed, 14 Jun 2023 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686748151; x=1718284151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7J+WeyL9vuRm7vz4qO9VPyyieEGrzWEnSV0+4PYLnqU=;
  b=oq6CoNoJz1+p8yU29GlhO37zXa0maAx7fmIsqdoRas4IpjgQpFz92V3k
   hwoFFFjAqxOUJPk7nQs1exlh5zbKmP9i/AA3xiqKfn0UkST/q1xgfRIf7
   fljZbVwDht6zXS3SRATLTmifMj/tPgwRqBJosVe3da1EFQx6p8EYIXWXH
   g=;
X-IronPort-AV: E=Sophos;i="6.00,242,1681171200"; 
   d="scan'208";a="654136441"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:09:04 +0000
Received: from EX19MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id 0E850160D4B;
        Wed, 14 Jun 2023 13:09:02 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 13:08:55 +0000
Received: from [10.95.176.26] (10.95.176.26) by EX19D028UEC003.ant.amazon.com
 (10.252.137.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 14 Jun
 2023 13:08:53 +0000
Message-ID: <9fa0fcae-a857-eca4-6aea-2213af62d1ef@amazon.com>
Date:   Wed, 14 Jun 2023 09:08:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Content-Language: en-US
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>
CC:     <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, <abuehaze@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061457-king-broadcast-f47e@gregkh>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <2023061457-king-broadcast-f47e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.95.176.26]
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-14 05:14, gregkh@linuxfoundation.org wrote:

> 
> 
> 
> On Tue, Jun 13, 2023 at 11:58:05AM -0700, Bhatnagar, Rishabh wrote:
>>
>> On 6/13/23 11:49 AM, Bhatnagar, Rishabh wrote:
>>> Hi Sebastian/Greg
>>>
>>> We are seeing RCU stall warnings from recent stable tree updates:
>>> 5.4.243, 5.10.180, 5.15.113, 6.1.31 onwards.
>>> This is seen in the upstream stable trees without any downstream patches.
>>>
>>> The issue is seen few minutes after booting without any workload.
>>> We launch hundred's of virtual instances and this shows up in 1-2
>>> instances, so its hard to reproduce.
>>> Attaching a few stack traces below.
>>>
>>> The issue can be seen on virtual and baremetal instances.
>>> Another interesting point is we only see this on x86 based instances.
>>> We also did test this on linux-mainline but were not able to reproduce
>>> the issue.
>>> So maybe there's a fixup or related commit that has gone in?
>>>
>>> We tried bisecting the stable trees and found that after reverting the
>>> below commit we couldn't reproduce this in any of the kernels
>>> consistently.
>>>
>>> tick/common: Align tick period with the HZ tick. [ Upstream commit
>>> e9523a0d81899361214d118ad60ef76f0e92f71d ]
>>>
>>>
>>> Not exactly sure how this commit is affecting all stable kernels.
>>> Can you take a look at this issue and share your insight?
> 
> Does this issue also show up in 6.3.y and in 6.4-rc5?

We haven't tried those yet, will try it today.

Just to give you a bit of context: we have a quick and a long duration
reproducer for this (which is our internal testing infrastructure).
In the quick reproducer we can more or less reliably reproduce with
5.4.246 and 5.10.183 but not with 5.15.113, 6.1.33 and latest Linus
tree (64569520920a3ca5d456ddd9f4f95fc6ea9b8b45). However, we did
reproduce something similar in the long reproducer with our downstream
versions of 5.15.113 and 6.1.33 (starting with 6.1.28).

- Luiz
