Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502987417D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjF1SLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:11:48 -0400
Received: from fanzine2.igalia.com ([213.97.179.56]:48490 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjF1SLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xRSiq7Rafs7M34eS/OFYDfhULalnpTg/cuwzQtHQsco=; b=PI7udsyRTWNT8t+lHm0W16OI4g
        J97xeLtgbkhh1mHAe5gwSWFMp86rdK/uaIbJTtcZ+mOeqVutW0fIhcFbUqNF6P3r3Cjf0XFeXxcUS
        YzTOHvSu5ktbw+xBeHhcls4xox+GNOBN+OEvQAaUQetZW+0bRHaZvGvTqx4vhtH2QwoUJ7/18MKti
        48n6AqfUMNXP8P44ZCU1sX6qPX+a1Y6WofIysKnLTPbOZpQ5e+pMxTYr1ylDgq70sq6FsTo8GqPFd
        jhybfi4Xdj8YZ9JC81fQrNswIIYN6++urXGn4BxDkF5s9vpYBLwnIBwHdydNW7BucOU8Frzc9t8e0
        3Ci83m7Q==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qEZdd-005N4W-0I; Wed, 28 Jun 2023 20:11:33 +0200
Message-ID: <28718037-ccf1-c36b-4eb6-716c518ca98f@igalia.com>
Date:   Wed, 28 Jun 2023 15:12:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Content-Language: en-US
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
References: <2023062832-barrier-strenuous-9499@gregkh>
 <20230628171055.1312737-1-yuxiaozhang@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230628171055.1312737-1-yuxiaozhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 19:10, Yuxiao Zhang wrote:
> Thanks for reviewing the patch.
> 
> On 28 Jun 2023 07:30:16 +0200, Greg KH wrote:
>> What is that max size?
> 
> The max size is arch dependent, it should be 2^(PAGE_SIZE+MAX_ORDER). In our environment it is 4M.
> 
>> what in-kernel user is hitting this in the pstore implementation?
> 
> We are trying to use pmsg to hold a core dump file, so we have pmsg-size=32M and thus hit this issue.
> 
> Other than us, here is one I found that trying to save dmesg beyond kmalloc limitaton:
> https://lore.kernel.org/lkml/b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com/T/

Hi Yuxiao Zhang, thanks for the improvement! And also, thanks for
mentioning the thread above - I tested your patch today and was soon to
write you this message heh

So, first of all, the patch works for the Steam Deck case - kernel 6.4
with or without your patch behaved the same, i.e., pstore/ramoops worked
and it was possible to collect the dmesg.

But when I tried to increase the record size in ramoops, I got this
error: https://termbin.com/b12e

This is the same error as mentioned in the thread above. And it happens
when I try to bump the record size to 4MB, the biggest working value is
still 2MB. Maybe a missing spot, which remained using kmalloc() instead
of the virtual variant?

Also - Kees certainly knows that way better, but - are we 100% sure that
the region for pstore can be non-contiguous? For some reason, I always
thought this was a requirement - grepping the code, I found this
(wrong?) comment:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pstore/zone.c#n3

Cheers,


Guilherme
