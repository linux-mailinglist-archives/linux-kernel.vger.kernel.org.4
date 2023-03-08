Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF66B067B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCHL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCHL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:57:36 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5033A36096;
        Wed,  8 Mar 2023 03:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t2+FdKzNbAwgnn+pWklJWP5J6JzG87Ysvje16z2B4ZY=; b=iuZwyZ/zezXnNnPt8ZpZYGyEUd
        8GZiAIXbUqhJENVTdQrPmPQUPfgImLRTE9qd5cnWnwPgIIqPIbZ6xy2Wi711g7nyng8ySDj4aWuwQ
        rlb+zNNbc28wgR4jX6JofCDIawBOi1gtf3geU8BcNNfiDhuS86Yi4r1ndRrn4Rn5bzuA=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pZsQB-00FrPN-EZ; Wed, 08 Mar 2023 12:57:27 +0100
Message-ID: <42185fa2-4191-fcf5-9c0f-fd7098bb856b@nbd.name>
Date:   Wed, 8 Mar 2023 12:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Mann <rauchwolke@gmx.net>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
 <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
 <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
 <4a02173f-3a60-0a7e-8962-3778e6c55bf3@nbd.name>
 <cfa5cc30-bf5a-bffd-4c2f-eec8a6522dd5@wetzel-home.de>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <cfa5cc30-bf5a-bffd-4c2f-eec8a6522dd5@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.23 12:41, Alexander Wetzel wrote:
> On 08.03.23 08:52, Felix Fietkau wrote:
> 
>>> I'm also planning to provide some more debug patches, to figuring out
>>> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs
>>> for resumption") fixes the issue for you. Assuming my understanding
>>> above is correct the patch should not really fix/break anything for
>>> you...With the findings above I would have expected your git bisec to
>>> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue
>>> callback to drivers") as the first broken commit...
>> I can't point to any specific series of events where it would go wrong, 
>> but I suspect that the problem might be the fact that you're doing tx 
>> scheduling from within ieee80211_handle_wake_tx_queue. I don't see how 
>> it's properly protected from potentially being called on different CPUs 
>> concurrently.
>> 
>> Back when I was debugging some iTXQ issues in mt76, I also had problems 
>> when tx scheduling could happen from multiple places. My solution was to 
>> have a single worker thread that handles tx, which is scheduled from the 
>> wake_tx_queue op.
>> Maybe you could do something similar in mac80211 for non-iTXQ drivers.
>> 
> 
> I think it's already doing all of that:
> ieee80211_handle_wake_tx_queue() is the mac80211 implementation for the
> wake_tx_queue op. The drivers without native iTXQ support simply link it
> to this handler.
I know. The problem I see is that I can't find anything that guarantees 
that .wake_tx_queue_op is not being called concurrently from multiple 
different places. ieee80211_handle_wake_tx_queue is doing the scheduling 
directly, instead of deferring it to a single workqueue/tasklet/thread, 
and multiple concurrent calls to it could potentially cause issues.

- Felix
