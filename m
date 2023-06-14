Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EBA7300E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbjFNN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbjFNN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:58:13 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0319A;
        Wed, 14 Jun 2023 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686751093; x=1718287093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AuOUmQUyB3LBRB4iHogY+py0I5sFH1hn9FMxVrOj9Fk=;
  b=EkbPFfCBwt0a/XAsNBobRlBGh+904mbaD64qjTJcUmjee0snayq9562P
   F/Y5lxD6ogeU0Q7bd/BpMHA/q8WWxsVtrHcXEWxsgCUt8DbBmlof7n9f2
   Qm1rkXSGXA7FK5pIMR60LBrY9WRpduMr8tcPbG+COA/gw354hrnKXbCW+
   I=;
X-IronPort-AV: E=Sophos;i="6.00,242,1681171200"; 
   d="scan'208";a="654146650"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:58:07 +0000
Received: from EX19MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id A0FEA415B3;
        Wed, 14 Jun 2023 13:58:06 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 13:58:06 +0000
Received: from [10.95.176.26] (10.95.176.26) by EX19D028UEC003.ant.amazon.com
 (10.252.137.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 14 Jun
 2023 13:58:04 +0000
Message-ID: <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
Date:   Wed, 14 Jun 2023 09:57:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Content-Language: en-US
To:     Sven-Haegar Koch <haegar@sdinet.de>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, <abuehaze@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        <minipli@grsecurity.net>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.95.176.26]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
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



On 2023-06-14 09:45, Sven-Haegar Koch wrote:

> 
> 
> 
> On Wed, 14 Jun 2023, Luiz Capitulino wrote:
> 
>> On 2023-06-14 05:20, Sebastian Andrzej Siewior wrote:
>>
>>> On 2023-06-14 11:14:49 [+0200], gregkh@linuxfoundation.org wrote:
>>>> Oops, missed this.
>>>>
>>>> Yes, there might be, can you do 'git bisect' and track down the patch
>>>> that fixed this?
>>>
>>> There was a report of a lockup during boot in VMs yesterday. If I
>>> remember correctly this still exists and might be related to this
>>> report. I'm going to have a look.
>>
>> Thanks, Sebastian. Do you have a link for the discussion?
> 
> May be this, talking about the same commit as cause as this thread:
> 
> Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ
> tick. -- regression report
> https://lore.kernel.org/lkml/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net/

Thank you, Sven.

Sebastian, except for the detailed analysis which we haven't done yet, the
issue described by Mathias matches 100% what we're observing. Also, we do
observe this on bare-metal instances which could mean that the initial
reports are against VMs because those are rebooted more often (our quick
reproducer boots hundreds of instances in AWS and only 1 or 2 reproduces this).

IMHO, I'd suggest we revert this for now from Linus tree and stable trees.
We can help testing for the fix maybe for the next merge window.

- Luiz

> 
> May not have been the best idea to respond with such big analysis to a 3
> months old dead thread, gets lost extremely easy.
> 
> c'ya
> sven-haegar
> 
> --
> Three may keep a secret, if two of them are dead.
> - Ben F.
