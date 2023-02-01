Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A756B686DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBASQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBASQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:16:05 -0500
X-Greylist: delayed 93820 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 10:16:03 PST
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5B10254;
        Wed,  1 Feb 2023 10:16:03 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4P6VTp3jWPz9sjr;
        Wed,  1 Feb 2023 19:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1675275358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTa13PkDyAD5Fq00WCKRPhtlL382Rc6MKBWbBS0vN8U=;
        b=anz+I5B7rcrJv6dHk6f+Fs58QbKAObnFuF75K65qNfjem6PEjB+mNYe/dcg68Ja1i+0i7g
        2Ae2MrMs5rNwhGssVKgAFEn0nDCmc5yOW8CD9ALtr1WsvaA56amvrw6VRPp88At7UvTjZy
        zfLO0xkxaAmidwXgW2TwbGMCANkM0bKG6SUBeNnS96StLfB2C455j0mD/POXukDKtULvuy
        h+X5NAQX1uBNKgJ39aCyMKb9vTC7e1bBpBFkL1DPtaJ9CCVivGpciiLzqDL3VkJ2tfd19A
        dO6S+oUsf/XQhiGKpx9rWfGUy8AZpdM87yJWqL6wzIPyk8p9CP3BLIrSSzZT5g==
Message-ID: <dfacbc3f-beb3-73f3-7e44-f3d919839d7f@mailbox.org>
Date:   Wed, 1 Feb 2023 18:15:47 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] amd_pstate: Add guided autonomous mode support
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>, santosh.shukla@amd.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <20230119115017.10188-1-wyes.karny@amd.com>
 <8c09f806-b00d-515b-bd1d-2f433e44b1a4@mailbox.org>
 <20230131053427.cdpg5zaqyxf7ou2f@beas>
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <20230131053427.cdpg5zaqyxf7ou2f@beas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ws53a61rg81hufw5idcjtd9gi7bxwzf5
X-MBO-RS-ID: 9827835aedd8814a521
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.23 05:34, Wyes Karny wrote:
> Hi Tor Vic,
> 
> On 24 Jan 20:40, Tor Vic wrote:
> --------------------------------->8-----------------------------
>>
>> The "active" mode seems to be broken here on a Zen2 3900X running Linux 6.1.
>> Frequency remains stuck at minimum which is +-500 MHz.
> 
> I've fixed this in v4.
> 
>>
>> Some queries of the new /sys devices lead to I/O error:
>>
>>    # LANG=C cat /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_*
>>    166
>>    cat:
>> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq:
>> Input/output error
>>    cat: /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq:
>> Input/output error
>>
> This issue I'm not able to reproduce. Is this issue seen with only EPP
> patches also?
> Could you please check if this issue still there with v4?

No, it's gone. Could have been a mismerge, I'm sorry.

> 
> Thanks,
> Wyes

Thank you!

> 
>> The "guided" mode seems to work fine with no stuck frequency, but also
>> produces I/O error on some /sys files.
>>
>> I haven't tested "passive".
>>
>> Cheers,
>>
>> Tor Vic
