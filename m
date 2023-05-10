Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E346FDE50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjEJNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjEJNRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5B61B2;
        Wed, 10 May 2023 06:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 143526341D;
        Wed, 10 May 2023 13:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08706C433EF;
        Wed, 10 May 2023 13:17:00 +0000 (UTC)
Message-ID: <88ff9837-36e3-b16f-537f-af21f738383a@xs4all.nl>
Date:   Wed, 10 May 2023 15:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
 <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
 <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
 <20230510090527.25e26127@sal.lan>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230510090527.25e26127@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:05, Mauro Carvalho Chehab wrote:
> Hi Linus,
> 
> Em Mon, 8 May 2023 09:27:28 -0700
> Linus Torvalds <torvalds@linux-foundation.org> escreveu:
> 
>> On Mon, May 8, 2023 at 3:55 AM Linux regression tracking #adding
>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> Thanks for the report. The fixes (see the mail from Laurent) apparently
>>> are still not mainlined (or am I missing something?), so let me add this
>>> report to the tracking to ensure this is not forgotten:  
>>
>> Gaah. I was intending to apply the patch directly before rc1, but then
>> I forgot about this issue.
>>
>> Mauro: I'm currently really *really* fed up with the media tree. This
>> exact same thing happened last merge window, where the media tree
>> caused pointless build errors, and it took way too long to get the
>> fixes the proper ways.
>>
>> If something doesn't even build, it should damn well be fixed ASAP.
>>
>> Last release it was imx290.c and PM support being disabled, and I had
>> to apply the fix manually because it continued to not come in the
>> proper way.
>>
>> See commit 7b50567bdcad ("media: i2c: imx290: fix conditional function
>> defintions").
>>
>> But also see commit b928db940448 ("media: i2c: imx290: fix conditional
>> function definitions"), which you *did* commit, but note this on that
>> commit:
>>
>>     AuthorDate: Tue Feb 7 17:13
>>     CommitDate: Sat Mar 18 08:44
>>
>> so it took you a MONTH AND A HALF to react to a build failure.
>>
>> And see this:
>>
>>     git name-rev b928db940448
>>     b928db940448 tags/v6.4-rc1~161^2~458
>>
>> ie that build fix that you finally committed came in *AFTER* the 6.3
>> release, even though the bug it fixes was introduced in the 6.3 merge
>> window:
>>
>>     git name-rev 02852c01f654
>>     02852c01f654 tags/v6.3-rc1~72^2~2^2~193
>>
>> and now we're in the *EXACT*SAME* situation, with me applying a build
>> fix directly, because you couldn't get it fixed in a timely manner.
> 
> Sorry for the mess. I'll work to improve the process to avoid this
> to happen again.
> 
> FYI, in order to reduce build issues, we have a Jenkins instance
> doing builds with gcc and CLANG at the media stage tree, before we even merge
> them at the main media development tree. They run with allyesconfig for
> x86_64 arch, with W=1:
> 
> 	https://builder.linuxtv.org/job/media_stage_clang/
> 	https://builder.linuxtv.org/job/media_stage_gcc/
> 
> And another CI job testing bisect breakages as I receive pull requests,
> applying patch per patch and using both allyesconfig and allmodconfig,
> also on x86_64 arch with W=1:
> 
> 	https://builder.linuxtv.org/job/patchwork/
> 
> The rule is to not merge stuff on media tree if any of those jobs
> fail. I also fast-forward merging patches whose subject states that
> the build has failed.
> 
> In order to help with that, on normal situation, I usually take one week
> to merge stuff from media_stage into media_tree, doing rebases at
> media_stage if needed to avoid git bisect build breakages at media_tree
> (which is from where I send my update PRs to you).
> 
> Unfortunately, currently we don't have resources to do multiple randconfig
> on Jenkins, as the build machines on the server are very slow. Yet, I'll
> add CONFIG_PM disabled to the test set, as it seems to be a recurrent source
> of troubles those days. I'll also try to identify a couple of other 
> randconfigs that would help to catch earlier problems like that.
> If some other problematic Kconfig variables comes to your mind, please
> feel free to suggest them for us to add to the CI automation.
> 
> -
> 
> In the specific case of this fixup patch, I didn't identify it as a build
> issue, so it followed the usual workflow. We have a huge number of patches
> for media, and it usually takes some time to handle all of them. This one
> just followed the normal flow, as it didn't break Jenkins builds nor the
> subject mentioned anything about build breakage.

In the end it was my fault: I pushed the fix to our staging tree thinking
that there was enough time for it to be included in the PR for 6.4.
But I was wrong, the window for that closed a week earlier (which Mauro
even documented!). So Mauro never knew that this patch had to be included
in the PR to you. The right procedure would have been for me to tell Mauro
about this patch. Hopefully this will be the first and also last time that
I make that mistake.

We do have a major problem with too many incoming patches and not enough
maintainers & time. Some of it can be improved with better procedures and
testing, but that won't help the often slow code review times. It will be a
big topic during the upcoming media mini summit in Prague.

Regards,

	Hans
