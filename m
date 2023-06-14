Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653672236B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjFEK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFEK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:28:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA4EA6;
        Mon,  5 Jun 2023 03:28:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q67Rf-00050B-2m; Mon, 05 Jun 2023 12:28:15 +0200
Message-ID: <ebdd877d-f143-487c-04cd-606996eb6176@leemhuis.info>
Date:   Mon, 5 Jun 2023 12:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: nvsp_rndis_pkt_complete error status and net_ratelimit:
 callbacks suppressed messages on 6.4.0rc4
Content-Language: en-US, de-DE
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux on Hyper-V <linux-hyperv@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <15dd93af-fcd5-5b9a-a6ba-9781768dbae7@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <15dd93af-fcd5-5b9a-a6ba-9781768dbae7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685960901;a18d3986;
X-HE-SMSGID: 1q67Rf-00050B-2m
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

On 30.05.23 14:25, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:

Hmmm, nobody replied to this yet (or am I missing something?). Doesn't
seems like it's something urgent, but nevertheless:

Michael, Bagas didn't make it obvious at all, hence please allow me to
ask: did you notice that this is a regression that is apparently caused
by a commit of yours?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> After building 6.4.0rc4 for my VM running on a Windows 10 Hyper-V host, I see the following 
>>
>> [  756.697753] net_ratelimit: 34 callbacks suppressed
>> [  756.697806] hv_netvsc cd9dd876-2fa9-4764-baa7-b44482f85f9f eth0: nvsp_rndis_pkt_complete error status: 2
>> (snipped repeated messages)
>>
>> *but*, I'm only able to reliably reproduce this if I am generating garbage on another terminal, e.g. sudo strings /dev/sda
>>
>>
>> This doesn't appear to affect latency or bandwidth a huge amount, I ran an iperf3 test between the guest and the host while trying to cause these messages.
>> Although you if you take 17-18 gigabit as the "base" speed, you can see it drop a bit to 16 gigabit while the errors happen and "catch up" when I stop spamming the console.
>>
>> [  5]  99.00-100.00 sec  1.89 GBytes  16.2 Gbits/sec
>> [  5] 100.00-101.00 sec  1.91 GBytes  16.4 Gbits/sec
>> [  5] 101.00-102.00 sec  1.91 GBytes  16.4 Gbits/sec
>> [  5] 102.00-103.00 sec  1.91 GBytes  16.4 Gbits/sec
>> [  5] 103.00-104.00 sec  1.92 GBytes  16.5 Gbits/sec
>> [  5] 104.00-105.00 sec  1.94 GBytes  16.6 Gbits/sec
>> [  5] 105.00-106.00 sec  1.89 GBytes  16.2 Gbits/sec
>> [  5] 106.00-107.00 sec  1.90 GBytes  16.3 Gbits/sec
>> [  5] 107.00-108.00 sec  2.23 GBytes  19.2 Gbits/sec
>> [  5] 108.00-109.00 sec  2.57 GBytes  22.0 Gbits/sec
>> [  5] 109.00-110.00 sec  2.66 GBytes  22.9 Gbits/sec
>> [  5] 110.00-111.00 sec  2.64 GBytes  22.7 Gbits/sec
>> [  5] 111.00-112.00 sec  2.65 GBytes  22.7 Gbits/sec
>> [  5] 112.00-113.00 sec  2.65 GBytes  22.8 Gbits/sec
>> [  5] 113.00-114.00 sec  2.65 GBytes  22.8 Gbits/sec
>> [  5] 114.00-115.00 sec  2.65 GBytes  22.8 Gbits/sec
>> [  5] 115.00-116.00 sec  2.66 GBytes  22.9 Gbits/sec
>> [  5] 116.00-117.00 sec  2.63 GBytes  22.6 Gbits/sec
>> [  5] 117.00-118.00 sec  2.69 GBytes  23.1 Gbits/sec
>> [  5] 118.00-119.00 sec  2.66 GBytes  22.9 Gbits/sec
>> [  5] 119.00-120.00 sec  2.67 GBytes  22.9 Gbits/sec
>> [  5] 120.00-121.00 sec  2.66 GBytes  22.9 Gbits/sec
>> [  5] 121.00-122.00 sec  2.49 GBytes  21.4 Gbits/sec
>> [  5] 122.00-123.00 sec  2.15 GBytes  18.5 Gbits/sec
>> [  5] 123.00-124.00 sec  2.16 GBytes  18.6 Gbits/sec
>> [  5] 124.00-125.00 sec  2.16 GBytes  18.6 Gbits/sec
>>
> 
> See bugzilla for the full thread.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: dca5161f9bd052 https://bugzilla.kernel.org/show_bug.cgi?id=217503
> #regzbot title: net_ratelimit and nvsp_rndis_pkt_complete error due to SEND_RNDIS_PKT status check
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217503
> 
