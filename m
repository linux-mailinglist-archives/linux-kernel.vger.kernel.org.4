Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A7D72E260
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbjFMMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjFMMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:00:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202AC5;
        Tue, 13 Jun 2023 05:00:02 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q92gl-0002a9-Fj; Tue, 13 Jun 2023 13:59:55 +0200
Message-ID: <98909a2f-cb55-b732-409c-ad14c802bf13@leemhuis.info>
Date:   Tue, 13 Jun 2023 13:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: w_scan hangs on 6.3.7 and does not react on kill -9
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Kalamlacki <kalamlacki@gmail.com>,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <67afa974-835a-77cc-d4bb-49cba0ff5bf5@gmail.com>
 <cc577237-7814-0bea-a152-8acdea844088@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <cc577237-7814-0bea-a152-8acdea844088@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686657602;40cc4f1c;
X-HE-SMSGID: 1q92gl-0002a9-Fj
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.23 13:23, Bagas Sanjaya wrote:
> On 6/12/23 20:52, Bagas Sanjaya wrote:
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> w_scan tool on kernel 6.3.7 hangs so badly that it cannot be killed by kill -9 
>>> I tried also w_scan_cpp 20230604 but it also fails I have 2040:8268 Hauppauge soloHD device as reported by lsusb. During reboot of the OS it prints a lot of kernel errors but it is after syslog is killed I guess and in syslog messages I do not see anything. On default Debian kernel 5.10.0-23 this problem does not exists.
>>
>>
>> See Bugzilla for the full thread and attached dmesg and kernel config.
>>
>> Lukasz: On what hardware you have this regression? Also, it is really
>> helpful if you can perform bisection (as outlined
>> in Documentation/admin-guide/bug-bisect.html) to find the culprit,
>> when developers can't figure it out by inspecting the code alone.
>> Last but not least, please also try latest mainline (currently v6.4-rc6).
>>
>> Anyway, I'm adding it to regzbot:
>>
>> #regzbot introduced: v5.10..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217540
>> #regzbot title: w_scan zombie (unkillable) on kernel v6.3
> 
> Another reporter on Bugzilla with similar regression as this one had
> bisected the culprit, so:
> 
> Hyunwoo Kim: It looks like this regression is caused by a backported
> commit of yours. Would you like to take a look on it?
> 
> #regzbot introduced: 8994830135b38b

TWIMC, revert for mainline already in preparation, for details see:

https://lore.kernel.org/all/23d5f9d6-f0db-a9af-1291-e9d6ac3cd126@leemhuis.info/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot monitor: https://lore.kernel.org/all/20230613053314.70839926@mir/
#regzbot monitor:
https://lore.kernel.org/all/20230609082238.3671398-1-mchehab@kernel.org/
