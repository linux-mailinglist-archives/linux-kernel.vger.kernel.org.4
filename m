Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C360250F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJRHJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJRHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EA0FAE6;
        Tue, 18 Oct 2022 00:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05DB16148A;
        Tue, 18 Oct 2022 07:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD1C433D6;
        Tue, 18 Oct 2022 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666076986;
        bh=62JY3nEqhgUp3ZcdSeMtpc1uu5IEErz2whw8ZHrBvPU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nRoTV+UInWMbUAm3sfWNUJCjUiSThNfWBFf1MgP+2JJGhf+LNPfWgby/T20qZLOd0
         g+Xay5OZ2NVziVGkROaYlRCiykdSBeWsM4NM5bC0RncoD0ZjrSEiIznoC9Nr7W4Zkf
         NyOEJqtFoyKpOPXtIG6O0d2hjUm/rUWLX+xQMwDIS9Bc3w8Hb5xH6BNkiykhoiiwxE
         ThgVc8Oj/sGJF9Z7aqEzm+ZxYl+9CqqsQuKFpNYXNmiaNSLLq7omFY2GDfPer44LlQ
         qvAoNNBUy4nGvhloCakXgrn8rwxkgPQa+IZ3jM5AYT58rykIkJ1+BPgIJjZDdaJi2B
         C1ti9e8n1Cbsw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rtc@vger.kernel.org,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION v6.1-rc1] rtc: cmos: rtcwake broken on NUC8i7HVK
References: <87edv6mlow.fsf@kernel.org>
        <b2be77b0-bafb-0519-33cb-359d83ded4d8@leemhuis.info>
Date:   Tue, 18 Oct 2022 10:09:40 +0300
In-Reply-To: <b2be77b0-bafb-0519-33cb-359d83ded4d8@leemhuis.info> (Thorsten
        Leemhuis's message of "Tue, 18 Oct 2022 08:33:37 +0200")
Message-ID: <87a65tmwuj.fsf@kernel.org>
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

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 17.10.22 18:58, Kalle Valo wrote:
>> 
>> I upgraded my NUC8i7HVK test box to v6.1-rc1 and noticed that my suspend
>> tests with ath11k were broken, the box never woke up from suspend
>> automatically and I had to manually push the power button to trigger
>> resume. This is the command I used:
>> 
>> sudo rtcwake -m mem -s 30
>> 
>> v6.0 works without problems and a bisect found this commit:
>> 
>> commit 4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8
>> Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> AuthorDate: Wed Oct 12 20:07:01 2022 +0200
>> Commit:     Alexandre Belloni <alexandre.belloni@bootlin.com>
>> CommitDate: Thu Oct 13 23:27:52 2022 +0200
>> 
>>     rtc: cmos: Fix event handler registration ordering issue
>
> FWIW, Todd also reported this yesterday:
> https://lore.kernel.org/all/967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com/
> https://bugzilla.kernel.org/show_bug.cgi?id=216600
>
> And Zhang Rui provided a patch in bugzilla that should fix this.

Thanks, this is good info. Strangely enough Zhang's workaround in [1]
did not fix the issue for me, rtcwake is still broken. Unfortunately no
time right now to investigate further.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216600#c3

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
