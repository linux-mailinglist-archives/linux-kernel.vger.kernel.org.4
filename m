Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622BD64FF2F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiLROyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiLROyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:54:24 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770EB1FD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:54:21 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p6v3T-0000bm-1R; Sun, 18 Dec 2022 15:54:19 +0100
Message-ID: <90e3aaf8-91b1-8a16-16da-4a9c491d8579@leemhuis.info>
Date:   Sun, 18 Dec 2022 15:54:18 +0100
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
 <cover.1671114724.git.kai@dev.carbon-project.org>
 <26b72b039d4150418cd37598d50112719c684344.1671114724.git.kai@dev.carbon-project.org>
 <da8bc9f50f8e19de9937a65ad82c3367e70959bb.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/3] checkpatch: warn when Reported-by: is not followed by
 Link:
In-Reply-To: <da8bc9f50f8e19de9937a65ad82c3367e70959bb.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1671375261;e2ec4e69;
X-HE-SMSGID: 1p6v3T-0000bm-1R
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.22 19:00, Joe Perches wrote:
> On Thu, 2022-12-15 at 15:43 +0100, Kai Wasserbäch wrote:
>> Encourage patch authors to link to reports by issuing a warning, if
>> a Reported-by: is not accompanied by a link to the report.
> 
> Please also expand Documentation/ as appropriate to encourage this too.

Well, I already updated it a few moths ago, but yeah, will revisit the
docs and make it even clearer if needed (I assume that's the case).

>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3155,6 +3155,20 @@ sub process {
>>  					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
>>  				}
>>  			}
>> +
>> +			# check if Reported-by: is followed by a Link:
>> +			if ($sign_off =~ /^reported-by:$/i) {
>> +				if (!defined $lines[$linenr]) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>> +				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
> 
> This capture group isn't necessary and does not guarantee there is
> an actual link.  Also this is allowing spaces before "Link:" when
> the reported-by test above does not allow spaces.  Please be
> consistent.  My preference would be to not allow spaces.

Good idea. FWIW, the section patch 3 changes has a space here as well:
```
> } elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
```
Hence I guess I'll remove it as well, unless you for some reason tell me
that's a bad idea.

>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Reported-by: should be immediately followed by Link: to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>> +				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
> 
> To make reading the match pattern easier, prefer m{} when the expected
> content uses / instead of using / as a delimiter.

Also a good idea. That being said:

I think I'll drop this check, as your comment made me think: why should
we check for "https?://" here at all? If we want to check that a "Link:"
is followed by a URI, then we should do that all the time, not just in
this single case.

Or am I missing something?

>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Link: following Reported-by: should contain a URL\n" . $herecurr . $rawlines[$linenr] . "\n");
>> +				}
>> +			}
>>  		}
>>  
>>  # Check Fixes: styles is correct

Ciao, Thorsten
