Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BD6C2DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCUJhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCUJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:37:22 -0400
X-Greylist: delayed 6983 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 02:37:17 PDT
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B479C2F071
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:Subject:To:Cc:References:From:
        Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
        Content-Transfer-Encoding:Content-Language; bh=9kWusDcXcObBpMbsN
        ytJAJucarMkS2bo9PDzyIf1iw4=; b=l5ullQRrLYeXJ9w21dfPDsRwc9gn/Qj5r
        PcMphdvdnHe1sxeNKaUTC5xWjD9TDHQ8LWyO3bowhCshfZQslhFKKeEvVajrvQAr
        e0bmnDURNipOElQq1hCRj7pv18z5BOVDIdbklH9Kp5ToqqBaXp6aOE+ONW0nfza5
        wM3e3NmiCI=
Received: from [192.168.1.101] (unknown [10.130.159.144])
        by coremail-app1 (Coremail) with SMTP id OCz+CgDX3pa_ehlkxWW4Ag--.10817S3;
        Tue, 21 Mar 2023 17:37:03 +0800 (CST)
Subject: Re: [PATCH] net: mac80211: Add NULL checks for sta->sdata
To:     Simon Horman <simon.horman@corigine.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZBlsh0JFBagmPNCA@corigine.com>
From:   Jia-Ju Bai <baijiaju@buaa.edu.cn>
Message-ID: <a8b12c2a-67d8-d932-7505-542f4dcfefd7@buaa.edu.cn>
Date:   Tue, 21 Mar 2023 17:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <ZBlsh0JFBagmPNCA@corigine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: OCz+CgDX3pa_ehlkxWW4Ag--.10817S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxtF1fXF4DCw1rJr1kXwb_yoW8CFWDpr
        95Ca4IqF4DJ340yr1fKrna93yjvw17Gr1UJryUGFy8J3Z0gFnakr48urZYvF9Y9r1UJw1a
        vFWjv39xAa17AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jbrc-UUUUU=
X-CM-SenderInfo: yrruji46exttoohg3hdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/21 16:36, Simon Horman wrote:
>>>> However, in the same call stack, sta->sdata is also used in the
>>>> following functions:
>>>>
>>>> ieee80211_ba_session_work()
>>>>     ___ieee80211_stop_rx_ba_session(sta)
>>>>       ht_dbg(sta->sdata, ...); -> No check
>>>>       sdata_info(sta->sdata, ...); -> No check
>>>>       ieee80211_send_delba(sta->sdata, ...) -> No check
>>>>     ___ieee80211_start_rx_ba_session(sta)
>>>>       ht_dbg(sta->sdata, ...); -> No check
>>>>       ht_dbg_ratelimited(sta->sdata, ...); -> No check
>>>>     ieee80211_tx_ba_session_handle_start(sta)
>>>>       sdata = sta->sdata; if (!sdata) -> Add check by previous commit
>>>>     ___ieee80211_stop_tx_ba_session(sdata)
>>>>       ht_dbg(sta->sdata, ...); -> No check
>>>>     ieee80211_start_tx_ba_cb(sdata)
>>>>       sdata = sta->sdata; local = sdata->local -> No check
>>>>     ieee80211_stop_tx_ba_cb(sdata)
>>>>       ht_dbg(sta->sdata, ...); -> No check
>>> I wonder if it would be better to teach ht_* do do nothing
>>> if the first argument is NULL.
>> Okay, I will use this way in patch v2.
> Maybe it is not a good idea.
> But I think it is worth trying, at least locally, to see how it goes.

After checking the code, I find that ht_* is actually a macro from _sdata_*.
Many code points use ht_* and _sdata_*, and thus I am not sure it is 
fine to try this way.

For simplification, I still think checking sdata before the calls to 
ht_* or _sdata_* should be more proper :)

>
>>> Also, are these theoretical bugs?
>>> Or something that has been observed?
>>> And has a reproducer?
>> These bugs are found by my static analysis tool, by extending a known bug
>> fixed in a previous commit 69403bad97aa.
>> Thus, they could be theoretical bugs.
> Thanks, understood.
> I think it would be worth making that a bit clearer in the
> patch description (commit message).

Okay.

I have sent the v2 patch, please have a look.
Thanks a lot :)


Best wishes,
Jia-Ju Bai

