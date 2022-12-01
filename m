Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F387F63ED67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLAKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLAKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:14:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445A934DB;
        Thu,  1 Dec 2022 02:14:41 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p0gaU-0007Pe-IB; Thu, 01 Dec 2022 11:14:38 +0100
Message-ID: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
Date:   Thu, 1 Dec 2022 11:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Dave <chiluk@ubuntu.com>
Subject: =?UTF-8?Q?=5bregression=5d_Bug=c2=a0216753_-_6e_6_ghz_bands_are_dis?=
 =?UTF-8?Q?abled_since_5=2e16_on_intel_ax211?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669889681;2c4e8b72;
X-HE-SMSGID: 1p0gaU-0007Pe-IB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

Luca, I noticed a regression report in bugzilla where I'd like your
advice on. To quote https://bugzilla.kernel.org/show_bug.cgi?id=216753

> It looks like the self-managed regulatory information is causing the 6ghz band to be disabled on my AX211 (in the US).  
> iw reg get shows no 6ghz bands (output at the bottom).
> 
> $ sudo iw phy0 channel 
> ...
> Band 4:
> 	* 5955 MHz [1] (disabled)
> 	* 5975 MHz [5] (disabled)
> 	* 5995 MHz [9] (disabled)
>         ....(continues with all disabled 
>         * 7115 MHz [233] (disabled)
> ...
> 
> I was able to narrow this down to having been introduced during the 5.16 development window, as 5.15.79 linux-stable kernel works and the 5.16.12 does 
> not (earlier builds of 5.16 kernel fail to boot on my machine for some reason). 
> 
> I found https://community.frame.work/t/kernel-5-16-6ghz-disabled-ax210/15675/5
> and they imply that this regression was introduced by 
> 698b166ed3464e1604a0e6a3e23cc1b529a5adc1
> I haven't independently verified this commit as the definitive issue.

You authored 698b166ed346 ("iwlwifi: mvm: read 6E enablement flags from
DSM and pass to FW"). As it is a regressions is ideally should be dealt
with. But this area in tricky due to the legal implications. Hence I
wonder: is there anything we can do about this, or is this simply a case
where we have to bite the bullet and live with this regression?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
