Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB76B062D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCHLlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCHLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:41:35 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02AD6B9CBC;
        Wed,  8 Mar 2023 03:41:30 -0800 (PST)
Message-ID: <cfa5cc30-bf5a-bffd-4c2f-eec8a6522dd5@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1678275688;
        bh=fBPyXjC2sm40FIorgDXaQx2GZRyrNRK6b9kMkcrZTjk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eB5cKKkYq+81R/hQcdGmlRcnIjcgFAYDkjclS/5zsam76068g3KHQWbPXipkiGdae
         cOdXGWcU48zsNFH1NK17P0qhUCnGnuWgJr2O5c7p3M0mDG5QNjX8S0tOMXseh2z7D/
         FCeV+8oJgJehSy51KlENKcgjsGJ3b+dMZF9xF2mU=
Date:   Wed, 8 Mar 2023 12:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>,
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
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <4a02173f-3a60-0a7e-8962-3778e6c55bf3@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.23 08:52, Felix Fietkau wrote:

>> I'm also planning to provide some more debug patches, to figuring out
>> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs
>> for resumption") fixes the issue for you. Assuming my understanding
>> above is correct the patch should not really fix/break anything for
>> you...With the findings above I would have expected your git bisec to
>> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue
>> callback to drivers") as the first broken commit...
> I can't point to any specific series of events where it would go wrong, 
> but I suspect that the problem might be the fact that you're doing tx 
> scheduling from within ieee80211_handle_wake_tx_queue. I don't see how 
> it's properly protected from potentially being called on different CPUs 
> concurrently.
> 
> Back when I was debugging some iTXQ issues in mt76, I also had problems 
> when tx scheduling could happen from multiple places. My solution was to 
> have a single worker thread that handles tx, which is scheduled from the 
> wake_tx_queue op.
> Maybe you could do something similar in mac80211 for non-iTXQ drivers.
> 

I think it's already doing all of that:
ieee80211_handle_wake_tx_queue() is the mac80211 implementation for the 
wake_tx_queue op. The drivers without native iTXQ support simply link it 
to this handler.

Alexander


