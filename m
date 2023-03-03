Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386816A8F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCCCKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCCKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:10:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A8222D7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1B0461700
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E710C433D2;
        Fri,  3 Mar 2023 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677809412;
        bh=CXprjgttjcNhTZRdnnWpGCKK5+rU8482L6ioskIdys0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vxcWv0/WZvAi32V5w0khxosgYuH3j5vIIicPgQ2GfYOB17I42nEybfV7qnSgmAylw
         VvL5CiQuD2qX6slNl4DCbeuhgTBNdCJxgzENXPjwTA33ktdtJh/PrmD/z2g5CM/8Mh
         QrUDA/jaTgc5It7Bhg1Gzy0NnkUlln09En//m6zM=
Date:   Thu, 2 Mar 2023 18:10:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not
 followed by Link:
Message-Id: <20230302181010.859456e24e8aaf0990b0dead@linux-foundation.org>
In-Reply-To: <3275c17f-1a62-4e4a-4a5b-06b34098f8d2@leemhuis.info>
References: <cover.1674217480.git.linux@leemhuis.info>
        <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
        <20230301204602.5e9bf3c0@kernel.org>
        <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
        <20230301214023.610a9feb@kernel.org>
        <CACT4Y+bxUA1v14y0SGC887er5Nif3ZEanjO_m=K4WBwyNfmZHA@mail.gmail.com>
        <17fdf6f1-60ab-bfde-afc8-5afef6cc797b@leemhuis.info>
        <CACT4Y+Zm3d9jqK=R-E4xTihEUNdahagPyMPcinWowx8RABawrw@mail.gmail.com>
        <3275c17f-1a62-4e4a-4a5b-06b34098f8d2@leemhuis.info>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 10:48:22 +0100 Thorsten Leemhuis <linux@leemhuis.info> wrote:

> > We can parse out our hash from any tag, but the problem is that the
> > current email api we use, does not allow to specify Message-ID before
> > sending, so we don't know it when generating the text.
> > We don't even know it after sending, the API is super simple:
> > https://pkg.go.dev/google.golang.org/appengine/mail
> > So we don't know what the lore link will be...
> 
> That's... unfortunate, as from my understanding of things that would be
> the most important "Link:" to have in any patches that fix issues report
> by syzbot. But well, that's how it is for now. In that case I'd vote for
> this:
> 
> Reported-by: syzbot@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/b/cafecafecaca0cafecafe

As you previously mentioned, patch preparers should also include
the lore link so any followup discussion is easily located.
