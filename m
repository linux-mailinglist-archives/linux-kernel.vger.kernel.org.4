Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8C60246B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJRGds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRGdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:33:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB40A7AA5;
        Mon, 17 Oct 2022 23:33:44 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1okgAU-0001va-AP; Tue, 18 Oct 2022 08:33:38 +0200
Message-ID: <b2be77b0-bafb-0519-33cb-359d83ded4d8@leemhuis.info>
Date:   Tue, 18 Oct 2022 08:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [REGRESSION v6.1-rc1] rtc: cmos: rtcwake broken on NUC8i7HVK
Content-Language: en-US, de-DE
To:     Kalle Valo <kvalo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rtc@vger.kernel.org,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <87edv6mlow.fsf@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87edv6mlow.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666074825;33a63ff8;
X-HE-SMSGID: 1okgAU-0001va-AP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 17.10.22 18:58, Kalle Valo wrote:
> 
> I upgraded my NUC8i7HVK test box to v6.1-rc1 and noticed that my suspend
> tests with ath11k were broken, the box never woke up from suspend
> automatically and I had to manually push the power button to trigger
> resume. This is the command I used:
> 
> sudo rtcwake -m mem -s 30
> 
> v6.0 works without problems and a bisect found this commit:
> 
> commit 4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8
> Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> AuthorDate: Wed Oct 12 20:07:01 2022 +0200
> Commit:     Alexandre Belloni <alexandre.belloni@bootlin.com>
> CommitDate: Thu Oct 13 23:27:52 2022 +0200
> 
>     rtc: cmos: Fix event handler registration ordering issue

FWIW, Todd also reported this yesterday:
https://lore.kernel.org/all/967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com/
https://bugzilla.kernel.org/show_bug.cgi?id=216600

And Zhang Rui provided a patch in bugzilla that should fix this.

HTH, Ciao, Thorsten

> And indeed reverting that commit fixed the issue and suspend works as
> before. Here's some info about my hardware:
> 
> $ dmesg | grep rtc
> [   10.884460] rtc_cmos 00:03: RTC can wake from S4
> [   10.888439] rtc_cmos 00:03: registered as rtc0
> [   10.888930] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
> 
> $ lshw
> nuc2
>     description: Desktop Computer
>     product: NUC8i7HVK
>     vendor: Intel(R) Client Systems
>     version: J71485-504
> [...]
>      *-cpu
>           description: CPU
>           product: Intel(R) Core(TM) i7-8809G CPU @ 3.10GHz
> [...]
>      *-pnp00:03
>           product: PnP device PNP0b00
>           physical id: 4
>           capabilities: pnp
>           configuration: driver=rtc_cmos
> 
> Do let me know if more info is needed, I can also test patches. But next
> week I'm travelling and do not have access to the box.
> 
> Kalle
> 
> 
