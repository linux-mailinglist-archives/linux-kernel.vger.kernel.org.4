Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2966B2B8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjCIRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCIREz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:04:55 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 077CE23129;
        Thu,  9 Mar 2023 09:00:09 -0800 (PST)
Message-ID: <7300e0c0-d28e-6b3d-86c9-038cbbe47c65@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1678381207;
        bh=ni9AfbwoWlwpFUP2KPNh4PVLwDKy3vKb7jlVYEfhVY4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=UEVgrsCo4WttG/IM02o9nZRsElylqlJZ479m50unNXF8kec6k5jqt2A5LhS0QhPPr
         QXYcQP8qNQNHB5k/XMVEzcYiVMKauOJy9F+gC73sS07rPjU+VUEQ6Hq+OSJOLdPQE/
         uT1qyoRp1yXhuoadqzCuQUKZ9fOrV0UiCfyuSpu0=
Date:   Thu, 9 Mar 2023 18:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Thomas Mann <rauchwolke@gmx.net>, sgruszka@redhat.com
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Stanislaw Gruszka <stf_xl@wp.pl>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
 <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
 <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
Content-Language: en-US
In-Reply-To: <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.23 21:54, Alexander Wetzel wrote:
>>>
>>
>> I just uploaded a test patch to bugzilla.
>> Please have a look if that fixes the issue.
>>
>> If not I would be interested in the output of your iTXQ status.
>> Enable CONFIG_MAC80211_DEBUGFS and run this command when the 
>> connection is bad and send/share/upload to bugzilla the resulting 
>> debug.out:
>>
>> k=1; while [ $k -lt 10 ]; do \
>> cat /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm; \
>> k=$(($k+1)); done >> debug.out
> 
> Thomas and I continued with some debugging in
> https://bugzilla.kernel.org/show_bug.cgi?id=217119
> 
> But the results so far are unexpected and we decided to continue the 
> debugging with the round here. Hoping someone sees something I miss.
> 
> A very summary where we are:
> I can't reproduce the bug with a very similar card and kernel config so 
> far. Thomas card stops the iTXQs for intervalls >30s. Mine operates 
> normally.
> 
> A more useful but longer summary:
> 
> Thomas updated to a 6.2 kernel and reported "connection drops and 
> bandwidth problems" with his rt2800usb wlan card. (6.1 is ok.) Asked for 
> some more details he reported:
> "...slow bandwidth stuff works better, but the main problem/test case is 
> to start a 8-16 mbit video stream, which sometimes runs for a few 
> seconds and then stops or it doesn't start at all"
> 
> He bisected the issue and identified my commit 4444bc2116ae ("wifi: 
> mac80211: Proper mark iTXQs for resumption") as culprit.
> 
> Checking the internal iTXQ status when the issue is ongoing shows, that 
> TID zero is flagged as dirty and thus is not transmitting queued 
> packets. Interesting line from 
> /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm:
> tid ac backlog-bytes backlog-packets new-flows drops marks overlimit 
> collisions tx-bytes tx-packets flags
> 0 2 619736 404 1681 0 0 0 1 4513965 3019 0xe(RUN AMPDU NO-AMSDU DIRTY)
> 
> --> The "normal" iTXQ handling IEEE80211_AC_BE has queued packets and is 
> flagged as DIRTY. There even is a potential race setting the DIRTY flag, 
> but the fix for that is not helping.
> 
> Thus Thomas applied two debug patches, to better understand why the 
> DIRTY flag is not cleared.
> 
> And looking at the output from those we see that the driver stops Tx by 
> calling ieee80211_stop_queue(). When ieee80211_wake_queue() mac80211 
> correctly resumes TX but is getting stopped by the driver after a single 
> packet again. (The start of the relevant log is missing, so that may be 
> initially more).
> I assume TX is still ok at that stage. But after some singe Tx 
> operations the driver stops the queues again. Here the relevant part of 
> the log:
> [  179.584997] XXXX __ieee80211_wake_txqs: waking TID 0
> [  179.585022] XXXX drv_tx: TX
> [  179.585027] XXXX ieee80211_stop_queue: called
> [  179.585028] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.585030] XXXX __ieee80211_wake_txqs: TID 3 NOT dirty
> [  179.585031] XXXX __ieee80211_wake_txqs: TID 8 NOT dirty
> [  179.585033] XXXX __ieee80211_wake_txqs: TID 11 NOT dirty
> [  179.585034] XXXX __ieee80211_wake_txqs: EXIT
> [  179.585035] XXXX __ieee80211_wake_txqs: ENTRY
> [  179.585036] XXXX __ieee80211_wake_txqs: TID 1 NOT dirty
> [  179.585037] XXXX __ieee80211_wake_txqs: TID 2 NOT dirty
> [  179.585038] XXXX __ieee80211_wake_txqs: TID 9 NOT dirty
> [  179.585040] XXXX __ieee80211_wake_txqs: TID 10 NOT dirty
> [  179.585041] XXXX __ieee80211_wake_txqs: EXIT
> [  179.585047] XXXX drv_tx: TX
> [  179.585056] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.585271] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.585868] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.586120] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.586544] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.586792] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.587317] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.587591] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.588569] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> ....
> [  214.307617] XXXX ieee80211_wake_queue: called
> 
> 
> --> So the driver blocked TX for more than 30s. Which is a good 
> explanation of what Thomas observes.
> 
> But there is nothing mac80211 can do differently here. Whatever is the 
> real reason for the issue, it's nothing obvious I see.

Best shot I have so far is a driver bug/issue now exposed by the changed 
traffic pattern from mac80211. And while digging into the rt2800usb 
driver I found a watchdog introduced here:
https://lore.kernel.org/20190615100100.29800-1-sgruszka@redhat.com

 From mac80211 debugging it looks like it may just be that: A random 
hang of the driver/card.

For sure rt2800usb tells mac80211 to stop TXing and needs ages (>30s in 
known sample) to unblock the queue. And this watchdog is disabled by 
default.

Now I'm clearly wondering, if the changed traffic pattern due to the 
mac80211 patch is just triggering the random hangs...

I've also uploaded more test patches to bugzilla.

@Thomas
Can you also try with this watchdog enabled? It must be enabled for 
rt2800lib. Since you have compiled in the driver the following boot 
parameter should enable it:
  rt2800lib.watchdog=1

@Stanislaw
Can you maybe also have a look at the issue and how that looks compared 
to the known random hangs you introduced the watchdog for?

> 
> Luckily I found a card using the same driver and nearly the same card:
> Thomas systems:Linux version 6.2.2-gentoo (root@foo) (gcc (Gentoo 
> Hardened 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld (Gentoo 2.39 
> p5) 2.39.0) #2 SMP Fri Mar  3 16:59:02 CET 2023ieee80211 phy0: 
> rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
> ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> 
> My system, using the kernel config from Thomas with only minor 
> modifications (different filesystems and initramfs settings and enabled 
> mac80211 debug and developer options):
> Linux version 6.2.2-gentoo (root@Perry.mordor) (gcc (Gentoo 
> 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld (Gentoo 2.40 p2) 
> 2.40.0) #2 SMP Tue Mar  7 18:18:47 CET 2023ieee80211 phy0: 
> rt2x00_set_rt: Info - RT chipset 3070, rev 0200 detected
> ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 
> 'rt2870.bin'
> ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - 
> version: 0.36
> 
> But there is one big difference on my system: I can't reproduce the bug 
> so far. It's working as it should... (I did not apply the debug patches 
> myself so far)
> 
> I'm now planning to look a bit more into the rt2800usb driver and 
> provide another debug patch for interesting looking code pieces in it.
> 
> @Thomas:
> I've also uploaded you my binary kernel I'm running at the moment here:
> https://www.awhome.eu/s/5FjqMS73rtCtSBM
> 
> That kernel should also be able to boot and operate your system. Can you 
> try that and tell me, if that makes any difference?
> 
> I'm also planning to provide some more debug patches, to figuring out 
> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs 
> for resumption") fixes the issue for you. Assuming my understanding 
> above is correct the patch should not really fix/break anything for 
> you...With the findings above I would have expected your git bisec to 
> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue 
> callback to drivers") as the first broken commit...
> 
> Alexander

