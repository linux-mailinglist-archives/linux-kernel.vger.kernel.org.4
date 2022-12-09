Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEDB64802A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiLIJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLIJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:33:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BD1F614
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:33:19 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3Zks-0003zj-1p; Fri, 09 Dec 2022 10:33:18 +0100
Message-ID: <35f626fb-9524-a7e3-664f-1b3150fe08c8@leemhuis.info>
Date:   Fri, 9 Dec 2022 10:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, de-DE
To:     Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
 <869badb999d4021dd6efd792f53fc2859257c350.1670527774.git.kai@dev.carbon-project.org>
 <a7de235e15dbba2df9eb7ef82750ea8b6eae2b7b.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 1/2] checkpatch: warn when unknown tags are used for links
In-Reply-To: <a7de235e15dbba2df9eb7ef82750ea8b6eae2b7b.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670578400;8d25fb65;
X-HE-SMSGID: 1p3Zks-0003zj-1p
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.22 20:58, Joe Perches wrote:
> On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
>> Issue a warning when encountering URLs behind unknown tags, as Linus
>> recently stated ```please stop making up random tags that make no sense.
>> Just use "Link:"```[1]. That statement was triggered by an use of
>> 'BugLink', but that's not the only tag people invented:
>>
>> $ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \
> 
> Please use the --no-merges output

Done, good point.

> [...]
>> @@ -3239,6 +3239,13 @@ sub process {
>>  			$commit_log_possible_stack_dump = 0;
>>  		}
>>  
>> +# Check for odd tags before a URI/URL
>> +		if ($in_commit_log &&
>> +		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^Link/) {
>> +			WARN("COMMIT_LOG_USE_LINK",
>> +			     "Unknown link reference '$1:', use 'Link:' instead.\n" . $herecurr);
> 
> This would allow LinkFoo: so better would be
> 
> 		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link')
> or
> 		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^Link$/) {
> 
> (and checkpatch doesn't use periods after output messages)
> 
> Maybe better as well would be to use something like the below to
> better describe the preferred location of patch versioning info.
> 
> # Check for odd tags before a URI/URL
> 		if ($in_commit_log &&
> 		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link') {
> 			if ($1 =~ /^v(?:ersion)?\d+/i) {
> 				WARN("COMMIT_LOG_VERSIONING",
> 				     "Patch version information should be after the --- line\n" . $herecurr);
> 			} else {
> 				WARN("COMMIT_LOG_USE_LINK",
> 				     "Unknown link reference '$1:', use 'Link:' instead\n" . $herecurr);
> 			}
> 		}
> 

Yeah, that looks like a really good idea. I went with that. But I'd say
this is the point where this really warrants a Co-developed-by: that
mentions you (and thus a Signed-off-by: from your side, too), don't you
think so?

Ciao, Thorsten
