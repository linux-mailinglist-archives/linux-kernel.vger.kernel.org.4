Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98896AB2F7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCEW2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:28:47 -0500
X-Greylist: delayed 821 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 14:28:44 PST
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C35193E2;
        Sun,  5 Mar 2023 14:28:44 -0800 (PST)
Message-ID: <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1678053950;
        bh=abs0MlA44AoyhsNUl+R1/yY5c31L/YIRs431E1VKA2s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oNgp3H0b1i1axouXFKpeFlfKkHiWCbs8cPe9dceUFt77Jz6DHos5OToswLcC0W84d
         HdJVQmoWsXzyhj3vKqANDyzFrBxr6a8IzIMmt2rIrwmvsH9dLdFZsPlEV9rqosBYxi
         nTyxwiWemyZoqgkI0Fpg14aSF1BgU9QoytsBWPVU=
Date:   Sun, 5 Mar 2023 23:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Mann <rauchwolke@gmx.net>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Quick update from bugzilla:
> 
> ```
> --- Comment #4 from Thomas Mann (rauchwolke@gmx.net) ---
> i bisected and found the commit that introduced the regression:
> 
> # first bad commit: [4444bc2116aecdcde87dce80373540adc8bd478b] wifi:
> mac80211: Proper mark iTXQs for resumption
> ```
> 
> That's a commit from Alexander, applied by Johannes.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 

I just uploaded a test patch to bugzilla.
Please have a look if that fixes the issue.

If not I would be interested in the output of your iTXQ status.
Enable CONFIG_MAC80211_DEBUGFS and run this command when the connection 
is bad and send/share/upload to bugzilla the resulting debug.out:

k=1; while [ $k -lt 10 ]; do \
cat /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm; \
k=$(($k+1)); done >> debug.out

Alexander
