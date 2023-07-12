Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC757503FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGLJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGLJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:59:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E851712;
        Wed, 12 Jul 2023 02:59:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJWd4-0002Ed-4Y; Wed, 12 Jul 2023 11:59:26 +0200
Message-ID: <c71e376e-4e44-a1b3-6feb-2ed1ba7d325b@leemhuis.info>
Date:   Wed, 12 Jul 2023 11:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [regression] iwlwifi driver broken on Intel 3165 network card
Content-Language: en-US, de-DE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Cc:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <6f8715af-95c2-8333-2b32-206a143ebb52@leemhuis.info>
 <047c7bdc8057175f2bb78981a5f1a1aa6b493153.camel@sipsolutions.net>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <047c7bdc8057175f2bb78981a5f1a1aa6b493153.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689155969;35066a2d;
X-HE-SMSGID: 1qJWd4-0002Ed-4Y
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 17:02, Johannes Berg wrote:
> On Mon, 2023-07-10 at 10:32 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>
>> Aloka Dixit, apparently it's cause by a change of yours: bd54f3c2907
>> ("wifi: mac80211: generate EMA beacons in AP mode") [v6.4-rc1]
>>
> 
> That bisect result seems unlikely to be correct. Those changes are in
> "how to get beacons" (in AP mode) which isn't even used in client mode
> here.

You where right, the second bisect resulted in a different outcome.
Currently looks like 5fc3f6c90cc ("r8169: consolidate disabling ASPM
before EPHY access") [v6.4-rc1] is the culprit; this is somewhat odd as
well, but confirmed partially, as blacklisting r8169 apparently fixes
the issue. I nevertheless asked the reporter to recheck by reverting
that commit. Once that happened I'll notify the author of 5fc3f6c90cc.

Thx again and sorry for the noise.

BTW, in case anyone wants details, see:
https://bugzilla.kernel.org/show_bug.cgi?id=217635

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
