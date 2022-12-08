Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E656477BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLHVLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLHVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:11:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7076FF25
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:11:35 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3OB3-0002Ow-4Z; Thu, 08 Dec 2022 22:11:33 +0100
Message-ID: <a834b2a3-273a-f40a-57c4-ae1e89aa67c4@leemhuis.info>
Date:   Thu, 8 Dec 2022 22:11:32 +0100
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
 <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
 <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] checkpatch: warn when Reported-by: is not followed by
 Link:
In-Reply-To: <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670533895;fb42e2eb;
X-HE-SMSGID: 1p3OB3-0002Ow-4Z
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe, many thx for your time and your valuable feedback. I agree with
most of it and will look into addressing it tomorrow, but there is one
area where I have a different option:

On 08.12.22 21:21, Joe Perches wrote:
> On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
>> +
>> +			# check if Reported-by: is followed by a Link:
>> +			if ($sign_off =~ /^reported-by:$/i) {
>> +				if (!defined $lines[$linenr]) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline);
>> +				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
>> +				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Link: following Reported-by: should contain an URL\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> 
> [...]
>
> Also the actual link line should likely be from lore
> 
> So maybe: 
> 				} elsif ($lines[$linenr] !~ m{https?://lore.kernel.org/.+}i) {
> 					WARN("BAD_REPORTED_BY_LINK",
> 					     "Link: following Reported-by: should use a lore.kernel.org URL\n" . $herecurr . $rawlines[$linenr]);

I'm pretty sure that's not want we want, as from regression tracking I
known that we have other links that should continue to work here. Links
to bugzilla.kernel.org immediately come to my mind, for example. Then
there are some subsystems that use issue trackers on github or in gitlab
instances (DRM for example), which must work here, too; and we
occasionally even have links to bugs in bugzilla instances from RH or
SUSE there, as sometimes valuable details for code archeologists can be
found there.

Ciao, Thorsten
