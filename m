Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817668B0F1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBEQdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBEQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:33:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA913DFA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 08:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KIcvyvw+LNiAuiat+2Ged5NHWXEzUL/DzXjZ99VJcbw=; b=OvqxQLBLftL5yVLAHQaCQJrPKT
        jK0eJJ6MEoDzTrGyNDfWH3t+4fk2vCQMLH+K9hjN3c1bDRDxDvfDIHIJk7bp02KI4SzKsgWrSFROX
        AYVWcSWQkjGN4GB2HYAgD9Yb9dVXH9FWwjP3yHg6XxWNCw3CuT7JtJZoIzn1nRQ9atG5Kh+KBoXY6
        kKXpeXtvWSEau1fcGYXAVMFILV0wWGcIPbXmeKq+Z+LXs0nQEqd/Pl9FO6HtQUeCdaw9EhIIDR5KN
        i7TSD6xU4jM3Rkqm/HCaQItJC+uj9Oi5xobx2A4/x2IYN48ZdNV1YBYjI5KVJKXr+E6Q5nfELMb1o
        b0vfIKtQ==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOhx3-006Z24-IA; Sun, 05 Feb 2023 16:33:13 +0000
Message-ID: <99b808ba-a66f-784f-827e-1ceeade8b87f@infradead.org>
Date:   Sun, 5 Feb 2023 08:33:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
 <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
 <Y9+HnJ9ldBZP16zp@probook>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y9+HnJ9ldBZP16zp@probook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/23 02:40, Jonathan Neuschäfer wrote:
> On Sat, Feb 04, 2023 at 08:57:59AM -0800, Joe Perches wrote:
>> On Sun, 2023-01-29 at 09:52 -0800, Joe Perches wrote:
>>> On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neuschäfer wrote:
>>>> By now, `git log --pretty=%h` (on my copy of linux.git) prints commit
>>>> hashes with 13 digits, because of the number of objects.
>>>>
>>>> Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
>>>
>>> NAK without updating the process docs first.
>>
>> btw: it looks like 12 will still be sufficient for awhile yet
>>
>> $ git count
>> total 1154908
>> $ git -c core.abbrev=5 log --pretty=format:%h | \
>>   perl -nE 'chomp;say length' | sort | uniq -c | sort -n -k2
>>     198 5
>>  664613 6
>>  450955 7
>>   36667 8
>>    2312 9
>>     155 10
>>       8 11
> 
> Ok, I get similar stats on my tree (which includes linux-next and a few
> other remotes).
> 
> However, git's default heuristic for %h length uses 13 digits here, so I
> think other people might get 13 digits as well. I could force git to use
> less digits than it naturally would, by setting core.abbrev=12 (and
> document this idea in the documentation), but that doesn't seem nice.
> Therefore, I still think allowing a few more digits is a good idea.

I have core.abbrev=12 and I still get 13 "digits" often.
Then I just chop it off at 12 to satisfy checkpatch...

-- 
~Randy
