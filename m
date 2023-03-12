Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82DC6B63E1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCLI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCLI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 04:58:39 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD83A25E0F;
        Sun, 12 Mar 2023 00:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T1s9MEoNJxbmqXeBcJiadA+hN4toXj4XR7QKtfAnZFI=; b=fxFTupKXuWutLJ4pxsTAGSRpgg
        KMmnwJQvEEmzmN2WHYUHqbeeiDzW+XMPeFgStAGVDstLf+bXOJKTDW2SWcSkXXodK6iQvLJ2Ez4Pq
        QfXn/WAg5Ttf234EJlmiIlYTlbY1yjxCTIhTie9IxHt2AnPnMCm0RNgIzJO+5J5koa8U=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pbHX6-000pSo-Do; Sun, 12 Mar 2023 09:58:24 +0100
Message-ID: <a917ba35-bba4-9741-b7d4-c6ec4dfec4a0@nbd.name>
Date:   Sun, 12 Mar 2023 09:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
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
 <42185fa2-4191-fcf5-9c0f-fd7098bb856b@nbd.name>
 <b4427052-9e94-bce7-b745-2473be5686fa@wetzel-home.de>
 <f00171a1-7f6f-d708-9587-4f176457fdfd@wetzel-home.de>
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
In-Reply-To: <f00171a1-7f6f-d708-9587-4f176457fdfd@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.23 22:26, Alexander Wetzel wrote:
> Serialization helps. A (crude and in multiple ways incorrect) patch
> preventing two drv_wake_tx_queue() running for the same ac fixed the
> issue for Thomas:
> https://bugzilla.kernel.org/show_bug.cgi?id=217119#c20
> 
> So it looks like we'll now have soon a fix for the issue.
> 
> The driver wakes the queue for IEEE80211_AC_BE often for only a single
> skb and then stops it again.
> The short run time is insufficient for wake_txqs_tasklet to proper wake
> all queues itself and from time to time a new TX operation squeezes in
> after IEEE80211_AC_BE has been unblocked but prior of drv_wake_tx_queue
> being called from the wake_txqs_tasklet. When this happens
> drv_wake_tx_queue is called two times: Once from the tasklet, once from
> the userspace.
> 
> ieee80211_handle_wake_tx_queue is using ieee80211_txq_schedule_start,
> which has this documented requirement:
> "The driver must not call multiple TXQ scheduling rounds concurrently."
> Now I don't think that is causing the reported regression. Nevertheless
> we should prevent concurrent calls of ieee80211_handle_wake_tx_queue for
> that reason alone.
> 
> The real reason of the hangs is probably in the rt2800usb driver or
> hardware. I don't see anything in the driver code, so probably the HW
> itself has a problem with the two near-concurrent TX operations.
> 
> The real culprit of the regression should be commit a790cc3a4fad ("wifi:
> mac80211: add wake_tx_queue callback to drivers"), which switched
> rt2800usb over to iTXQs. But without the fix from commit 4444bc2116ae
> ("wifi: mac80211: Proper mark iTXQs for resumption") mac80211 omitted to
> schedule the required run of the wake_txqs_tasklet. Thus thus instead of
> two concurrent drv_wake_tx_queue we only got one and the driver
> continued to work.
> 
> I asked Thomas on bugzilla to test the "best" solution I came up with.
> 
> There seems to be multiple ways. But I can't find a simple, low risk and
> complete fix. So I compromised...
> 
> When Thomas can confirm the fix we can soon discuss the fix on
> linux-wireless.

I would recommend the following approach for properly fixing this issue:

On init if the .wake_tx_queue op is set to 
ieee80211_handle_wake_tx_queue, create a single kthread that iterates 
over all hw queues and schedules each one of them like 
ieee80211_handle_wake_tx_queue does now.
Change ieee80211_handle_wake_tx_queue to simply schedule the kthread 
without doing anything else.
This is how mt76 handles tx scheduling in the driver, and it works quite 
well.

- Felix
