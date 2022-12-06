Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5362644108
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiLFKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiLFKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:11:25 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55214099
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:06:56 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p2Uqk-0000ld-GE; Tue, 06 Dec 2022 11:06:54 +0100
Message-ID: <8434c30b-52f5-2c23-cce4-8d66393f7635@leemhuis.info>
Date:   Tue, 6 Dec 2022 11:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, de-DE
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
 <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
 <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
 <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
 <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
 <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
 <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
 <9958a748-2608-8ed2-6e8f-2f3291286271@leemhuis.info>
 <15f7df96d49082fb7799dda6e187b33c84f38831.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
In-Reply-To: <15f7df96d49082fb7799dda6e187b33c84f38831.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670321216;0f180956;
X-HE-SMSGID: 1p2Uqk-0000ld-GE
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.22 10:21, Joe Perches wrote:
> On Tue, 2022-12-06 at 09:50 +0100, Thorsten Leemhuis wrote:
>> On 06.12.22 08:44, Joe Perches wrote:
>>> On Tue, 2022-12-06 at 08:17 +0100, Thorsten Leemhuis wrote:
>>>> On 06.12.22 07:27, Thorsten Leemhuis wrote:
>>>>> On 06.12.22 06:54, Joe Perches wrote:
> [...]
>> Ha, I considered doing something like that when I wrote my earlier mail,
>> but was to lazy. :-D thx!
>>
>> Yeah, they are not that often, but I grew tired arguing about that,
>> that's why I think checkpatch is the better place and in the better
>> position to handle that.
> 
> I'm not sure that "Patchwork:" is a reasonable prefix.

/me neither

> Is that documented anywhere?

Couldn't find anything.

>> Anyway, so how to move forward now? Do you insist on a allow list (IOW:
>> a Link: or Patchwork: before every http...)? Or is a disallow list with
>> the most common unwanted tags for links (that you thankfully compiled)
>> fine for you as well?
> 
> Maybe
> ---
>  scripts/checkpatch.pl | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1c3d13e65c2d0..a526a354cdfbc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3250,6 +3250,13 @@ sub process {
>  			$commit_log_possible_stack_dump = 0;
>  		}
>  
> +# Check for odd prefixes before a URI/URL
> +		if ($in_commit_log &&
> +		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^(?:Link|Patchwork)/) {
> +			WARN("PREFER_LINK",
> +			     "Unusual link reference '$1:', prefer 'Link:'\n" . $herecurr);
> +		}
> +

LGTM: I did some tests and it seem to do the right thing. Can we have
your Signed-off-by: for that snippet?

Ciao, Thorsten
