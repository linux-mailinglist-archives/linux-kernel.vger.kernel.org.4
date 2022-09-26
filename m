Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20F95E9878
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiIZEid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIZEib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:38:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B123162;
        Sun, 25 Sep 2022 21:38:30 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ocfst-0000Y3-E0; Mon, 26 Sep 2022 06:38:23 +0200
Message-ID: <4e7992e2-c635-e571-faa3-08fd9ee5c975@leemhuis.info>
Date:   Mon, 26 Sep 2022 06:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        jelonek.jonas@gmail.com, johannes.berg@intel.com,
        lorenzo.bianconi83@gmail.com, sean.wang@mediatek.com
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: After commit 44fa75f207d8a106bc75e6230db61e961fdbf8a8 Wi-Fi
 (mt7921e) speed significantly decreased
In-Reply-To: <CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664167110;576cf4e6;
X-HE-SMSGID: 1ocfst-0000Y3-E0
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 26.09.22 02:41, Mikhail Gavrilov wrote:
> 
> I bisected the issue and found the first bad commit.
> 
> 44fa75f207d8a106bc75e6230db61e961fdbf8a8 is the first bad commit

FWIW, there is a patch under discussion fixing a problem found in that
commit:

https://lore.kernel.org/all/20220829144147.484787-2-jelonek.jonas@gmail.com/

To quote the first para:

```
This patch modifies the annotation of supported tx-power levels for a
wifi device in ieee80211_hw. This annotation was introduced with commit
44fa75f207d8a106bc75e6230db61e961fdbf8a8 to be able to operate on power
indices instead of absolute power values, providing better support for
different hardware capabilities.
```

Not totally sure if that might be relevant to your problem

Anyway, for the rest of this mail:
[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

> commit 44fa75f207d8a106bc75e6230db61e961fdbf8a8
> Author: Jonas Jelonek <jelonek.jonas@gmail.com>
> Date:   Mon May 9 19:39:57 2022 +0200
> 
>     mac80211: extend current rate control tx status API
> 
>     This patch adds the new struct ieee80211_rate_status and replaces
>     'struct rate_info *rate' in ieee80211_tx_status with pointer and length
>     annotation.
> 
>     The struct ieee80211_rate_status allows to:
>     (1)     receive tx power status feedback for transmit power control (TPC)
>             per packet or packet retry
>     (2)     dynamic mapping of wifi chip specific multi-rate retry (mrr)
>             chains with different lengths
>     (3)     increase the limit of annotatable rate indices to support
>             IEEE802.11ac rate sets and beyond
> 
>     ieee80211_tx_info, control and status buffer, and ieee80211_tx_rate
>     cannot be used to achieve these goals due to fixed size limitations.
> 
>     Our new struct contains a struct rate_info to annotate the rate that was
>     used, retry count of the rate and tx power. It is intended for all
>     information related to RC and TPC that needs to be passed from driver to
>     mac80211 and its RC/TPC algorithms like Minstrel_HT. It corresponds to
>     one stage in an mrr. Multiple subsequent instances of this struct can be
>     included in struct ieee80211_tx_status via a pointer and a length variable.
>     Those instances can be allocated on-stack. The former reference to a single
>     instance of struct rate_info is replaced with our new annotation.
> 
>     An extension is introduced to struct ieee80211_hw. There are two new
>     members called 'tx_power_levels' and 'max_txpwr_levels_idx' acting as a
>     tx power level table. When a wifi device is registered, the driver shall
>     supply all supported power levels in this list. This allows to support
>     several quirks like differing power steps in power level ranges or
>     alike. TPC can use this for algorithm and thus be designed more abstract
>     instead of handling all possible step widths individually.
> 
>     Further mandatory changes in status.c, mt76 and ath11k drivers due to the
>     removal of 'struct rate_info *rate' are also included.
>     status.c already uses the information in ieee80211_tx_status->rate in
>     radiotap, this is now changed to use ieee80211_rate_status->rate_idx.
>     mt76 driver already uses struct rate_info to pass the tx rate to status
>     path. The new members of the ieee80211_tx_status are set to NULL and 0
>     because the previously passed rate is not relevant to rate control and
>     accurate information is passed via tx_info->status.rates.
>     For ath11k, the txrate can be passed via this struct because ath11k uses
>     firmware RC and thus the information does not interfere with software RC.
> 
>     Compile-Tested: current wireless-next tree with all flags on
>     Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
>                     Linux 5.10.113
> 
>     Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>     Link: https://lore.kernel.org/r/20220509173958.1398201-2-jelonek.jonas@gmail.com
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
>  drivers/net/wireless/ath/ath11k/dp_tx.c |  8 ++-
>  drivers/net/wireless/mediatek/mt76/tx.c |  5 +-
>  include/net/mac80211.h                  | 33 +++++++++++-
>  net/mac80211/status.c                   | 91 +++++++++++++++++++--------------
>  4 files changed, 92 insertions(+), 45 deletions(-)
> 
> 
> Before 44fa75f207d8a106bc75e6230db61e961fdbf8a8 speed was:
> Idle Latency:     1.86 ms   (jitter: 0.06ms, low: 1.79ms, high: 1.99ms)
>     Download:   834.57 Mbps (data used: 698.7 MB)
>                  25.53 ms   (jitter: 6.82ms, low: 4.79ms, high: 234.55ms)
>       Upload:   818.72 Mbps (data used: 881.9 MB)
>                  17.98 ms   (jitter: 5.49ms, low: 4.66ms, high: 53.61ms)
> 
> After 44fa75f207d8a106bc75e6230db61e961fdbf8a8 speed became:
> Idle Latency:     1.86 ms   (jitter: 0.42ms, low: 1.63ms, high: 2.73ms)
>     Download:   546.18 Mbps (data used: 629.1 MB)
>                   5.89 ms   (jitter: 1.62ms, low: 2.64ms, high: 22.30ms)
>       Upload:   171.69 Mbps (data used: 141.0 MB)
>                   3.07 ms   (jitter: 1.06ms, low: 1.79ms, high: 7.98ms)
> 
> All measures I made by cli speedtest utility.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 44fa75f207d8a106
#regzbot title net: mt7921e: WiFi speed significantly decreased
#regzbot monitor:
https://lore.kernel.org/all/CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com/
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
