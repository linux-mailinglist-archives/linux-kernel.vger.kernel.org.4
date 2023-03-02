Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65A6A7AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCBFkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBFka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:40:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DE3D920
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 21:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA764B811F0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4E1C433EF;
        Thu,  2 Mar 2023 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677735625;
        bh=vvC4gpHcC1zYgTOCOVpo85krS63jHIVd8jwiE1Rn+ag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uUQ7PsEsAU/+yItoLCDrnkDOiyvLBQezzoXEDe4k6ScqTEdZVmOMwL+c5kx5vy5nT
         V8KBhuX/6wpYykWlSS+fBZhNl1zkmIpLTLEB0/62Sid9lKT6jswJ9mjdgYk/Y1NK0V
         07R1j2b9uLHPmdUEqZc53pcRahxRndAapjTWL3J6g8JRPJ9JHEIOB2zjQMmYo8dn8r
         3iIX1SkABHl0KwRqmDryRoawrR6Z79iQqKIdnJiSG7NR3quJYa6RDB3om+NM1xKu7a
         gn6ruGSfLhrF1vdFzDq4LJvnowAI0ySpJe4zTpF+uWbDfdJI0nUG7wz7592Yy3DQ+l
         usM45VagQ2EnA==
Date:   Wed, 1 Mar 2023 21:40:23 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?UTF-8?B?V2Fzc2VyYsOkY2g=?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not
 followed by Link:
Message-ID: <20230301214023.610a9feb@kernel.org>
In-Reply-To: <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
References: <cover.1674217480.git.linux@leemhuis.info>
        <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
        <20230301204602.5e9bf3c0@kernel.org>
        <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 06:17:22 +0100 Thorsten Leemhuis wrote:
> On 02.03.23 05:46, Jakub Kicinski wrote:
> > On Fri, 20 Jan 2023 13:35:19 +0100 Thorsten Leemhuis wrote:  
> >> Encourage patch authors to link to reports by issuing a warning, if
> >> a Reported-by: is not accompanied by a link to the report. Those links
> >> are often extremely useful for any code archaeologist that wants to know
> >> more about the backstory of a change than the commit message provides.
> >> That includes maintainers higher up in the patch-flow hierarchy, which
> >> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:  
> > 
> > Is it okay if we exclude syzbot reports from this rule?
> > If full syzbot report ID is provided - it's as good as a link.   
> 
> Hmmm. Not sure. Every special case makes things harder for humans and
> software that looks at a commits downstream. Clicking on a link also
> makes things easy for code archaeologists that might look into the issue
> months or years later (which might not even know how to find the report
> and potential discussions on lore from the syzbot report ID).

No other system comes close to syzbot in terms of reporting meaningful
bugs, IMHO special casing it doesn't risk creep.

Interestingly other bots attach links which are 100% pointless noise:

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4174

Oh, eh. Let's see how noisy this check is once the merge window is over.

> Hence, wouldn't it be better to ask the syzbot folks to change their
> reporting slightly and suggest something like this instead in their
> reports (the last line is the new one):
> 
> ```
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bba886ab504fcafecafe@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/cafecaca0cafecaca0cafecaca0@google.com/
> ```
> 
> This might not be to hard if they known the message-id in advance. Maybe
> they could even use the syzbot report ID as msg-id to make things even
> easier. And for developers not much would change afaics, they just need
> to copy and paste two lines instead of one.

Dmitry, WDYT?
