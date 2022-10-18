Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AE6031B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJRRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJRRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF17C187;
        Tue, 18 Oct 2022 10:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27AF3B82089;
        Tue, 18 Oct 2022 17:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0463BC433C1;
        Tue, 18 Oct 2022 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666114814;
        bh=qpNCpRKE3Sj2P0Bl9ndscSsJCK0UZNDnbBHlhXRYp8U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aCDKEnCRBZCgEXXGH1lV1s82cDWZJHnJ45aes63rV2j967JEXT33wiCbItGOC3viC
         Jd24ImQQV0+hodmr6UUg3dovWv3FFHgpiUw24J7WP/ZGVLVkjhfGsHFYLMd0GUDu9n
         iEyDHkidxHvPdTpxjc0J8bInF7nRnp3uKi0xijNyt02VdxYUpANUXOr8pEL2xM1fGt
         1V2Ij+DuceNviv8VmBznDsrtNS6pq5K+a+uV5O4xeiGwkDa/LIo8zaZHXEw3Z026zm
         OTiLIzMJT/nRkRWclkn1pET8h6k5dA4qK0n1G9FJMNARXcrmvKLvry1OIQ3sgYY05b
         JPNM4AayRXGGQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rtc@vger.kernel.org>, <regressions@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION v6.1-rc1] rtc: cmos: rtcwake broken on NUC8i7HVK
References: <87edv6mlow.fsf@kernel.org>
        <b2be77b0-bafb-0519-33cb-359d83ded4d8@leemhuis.info>
        <87a65tmwuj.fsf@kernel.org>
        <6b4aefb2-01a9-1489-8669-1af20e88f669@intel.com>
Date:   Tue, 18 Oct 2022 20:40:09 +0300
In-Reply-To: <6b4aefb2-01a9-1489-8669-1af20e88f669@intel.com> (Rafael J.
        Wysocki's message of "Tue, 18 Oct 2022 18:36:36 +0200")
Message-ID: <8735blm3nq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael.j.wysocki@intel.com> writes:

> On 10/18/2022 9:09 AM, Kalle Valo wrote:
>
>> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>>
>>> On 17.10.22 18:58, Kalle Valo wrote:
>>>> I upgraded my NUC8i7HVK test box to v6.1-rc1 and noticed that my suspend
>>>> tests with ath11k were broken, the box never woke up from suspend
>>>> automatically and I had to manually push the power button to trigger
>>>> resume. This is the command I used:
>>>>
>>>> sudo rtcwake -m mem -s 30
>>>>
>>>> v6.0 works without problems and a bisect found this commit:
>>>>
>>>> commit 4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8
>>>> Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> AuthorDate: Wed Oct 12 20:07:01 2022 +0200
>>>> Commit:     Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>> CommitDate: Thu Oct 13 23:27:52 2022 +0200
>>>>
>>>>      rtc: cmos: Fix event handler registration ordering issue
>>> FWIW, Todd also reported this yesterday:
>>> https://lore.kernel.org/all/967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com/
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216600
>>>
>>> And Zhang Rui provided a patch in bugzilla that should fix this.
>> Thanks, this is good info. Strangely enough Zhang's workaround in [1]
>> did not fix the issue for me, rtcwake is still broken. Unfortunately no
>> time right now to investigate further.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216600#c3
>
> Please try https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/

This works, thanks!

Tested-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
