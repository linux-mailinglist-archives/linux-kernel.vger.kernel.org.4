Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B966A7AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCBFgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBFgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:36:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD52ED41
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 21:36:20 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pXbc1-0005bd-Kl; Thu, 02 Mar 2023 06:36:17 +0100
Message-ID: <688cd6cb-90ab-6834-a6f5-97080e39ca8e@leemhuis.info>
Date:   Thu, 2 Mar 2023 06:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <cover.1674217480.git.linux@leemhuis.info>
 <3b036087d80b8c0e07a46a1dbaaf4ad0d018f8d5.1674217480.git.linux@leemhuis.info>
 <a27480c5-c3d4-b302-285e-323df0349b8f@tessares.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v4 1/3] checkpatch: warn when unknown tags are used for
 links
In-Reply-To: <a27480c5-c3d4-b302-285e-323df0349b8f@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1677735380;da84a019;
X-HE-SMSGID: 1pXbc1-0005bd-Kl
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.23 14:25, Matthieu Baerts wrote:
> On 20/01/2023 13:35, Thorsten Leemhuis wrote:
>> From: Kai Wasserbäch <kai@dev.carbon-project.org>
>>
>> Issue a warning when encountering URLs behind unknown tags, as Linus
>> recently stated ```please stop making up random tags that make no sense.
>> Just use "Link:"```[1]. That statement was triggered by an use of
>> 'BugLink', but that's not the only tag people invented:
>>
>> $ git log -100000 --no-merges --format=email -P \
>>    --grep='^\w+:[ \t]*http' | grep -Poh '^\w+:[ \t]*http' | \
>>   sort | uniq -c | sort -rn | head -n 20
>>  103958 Link: http
>>     418 BugLink: http
>>     372 Patchwork: http
>>     280 Closes: http
>>     224 Bug: http
>>     123 References: http
>> [...]
>>
>> Some of these non-standard tags make it harder for external tools that
>> rely on use of proper tags. One of those tools is the regression
>> tracking bot 'regzbot', which looks out for "Link:" tags pointing to
>> reports of tracked regressions.
> 
> I'm sorry for the late feedback but would it be possible to add an
> exception for the "Closes" tag followed by a URL?

As I just wrote in a reply to Jakub: Not sure. Every special case makes
things harder for humans and software that looks at a commits downstream.

> This tag is useful -- at least for us when maintaining the MPTCP subtree
> -- to have tickets being automatically closed when a patch is accepted.
> I don't think this "Closes" tag is a "random one that makes no sense"
> but I agree it is not an "official" one described in the documentation.
>
> On our side, we are using GitHub to manage issues but this also works
> with GitLab and probably others. Other keywords are also accepted [1][2]
> but I guess it is best to stick with one, especially when it is already
> used according to the list provided above.
> 
> Would it then be OK to allow this "Closes" tag in checkpatch.pl and
> mention it in the documentation (Submitting patches)?
> 
> Or should we switch to the "Link" tag instead (and re-do the tracking
> manually)?
> 
> [1]
> https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/using-keywords-in-issues-and-pull-requests
> [2]
> https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#default-closing-pattern

For the record, let me repeat and further elaborate what I already said
on social media before you wrote your mail:

 * I'm not mostly neutral here, but it was Linus who wrote "please stop
making up random tags that make no sense." in [1]. This was triggered by
a use of "BugLink:"; maybe there are tools out there that rely on that
tag, hence their users might ask for a exception as well. That's why I
think it's Linus call to grant any exceptions.

[1]
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/

 * if such an exception is made, it IMHO must be documented in our
documentation, so any software and humans that rely on these tags are
aware of it.

Ciao, Thorsten
