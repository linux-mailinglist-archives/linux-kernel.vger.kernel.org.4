Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D6B7017F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjEMPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 11:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7139C2684;
        Sat, 13 May 2023 08:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A01E60F53;
        Sat, 13 May 2023 15:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68332C433EF;
        Sat, 13 May 2023 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683990322;
        bh=c85IViv6QwewReUtlp/L4CrdzRU/fQhVYnG5tMWoEmM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M6XJKNmg3f02SB3GbQ37ctu+aHA9Vwpl0Ke4BLPEo6qBRa6CjNb6OWDOx84nr7U9d
         KRQ19fK1vGUodzb6Ju3mj3IGb8aSKnMAoJHZ62D6voi5fAs+XZiRDCjPDtDyrvKQr0
         Vo1KPjtWyh0Kj4hXbVKtP+ArxCtXxFoLYIXAclJRnyln5MdlahknuuCt/p23dCMrOZ
         iGV7IcwDnJU/B4DKWpDlQuAgIZ7NrSSqC6pCFVQbjrskeD55MhgXcjPOP/P/4zcoha
         M3NV3UsmcnUfQoxbeAHzEZu4UIeTA6S5LUe5QoPocSEXCc1IGXiy/rfrZN8z9kdcgs
         06GHIwxOCgCCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EEBA5CE001B; Sat, 13 May 2023 08:05:21 -0700 (PDT)
Date:   Sat, 13 May 2023 08:05:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Message-ID: <527de9fa-1ec6-4ba7-8bce-b0447e751c07@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
 <30F06C03-6950-4E2B-B3CE-3939B3CDD295@joelfernandes.org>
 <4d508096-300c-4d16-9c39-18598d00b500@paulmck-laptop>
 <IA1PR11MB6171866D6AEE79DD3413157E897A9@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6171866D6AEE79DD3413157E897A9@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 09:52:46AM +0000, Zhuo, Qiuxu wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > ...
> > > >>>> I wish diff was better at showing what really changed. The meld
> > > >>>> tool can help but its gui...
> > > >>>>
> > > >>>> Should I run meld later (I'm out at a conference so no access to
> > > >>>> meld-capable
> > > >>>> machines) or are we sufficiently confident that the lines were
> > > >>>> moved as-is ? :)
> > > >>>>
> > > >>>
> > > >>> Thank you, Joel for this concern. Good to know the meld diff GUI tool.
> > > >>> I just run the command below and confirmed that the lines were
> > > >>> moved
> > > >>> as-is: rcu_scale_{cleanup,shutdown}() follows kfree_scale_cleanup().
> > > >>> You may double check it ;-).
> > > >>>
> > > >>>      meld --diff ./rcuscale.c.before ./rcuscale.c.after
> > > >>
> > > >> Nice, thank you both!
> > > >>
> > > >> Another option is to check out the commit corresponding to this
> > > >> patch, then do "git blame -M kernel/rcu/rcuscale.c".  Given a
> > > >> move-only commit, there should be no line tagged with this commit's
> > SHA-1.
> > > >
> > > > Just had a good experiment with the "git blame -M" option:
> > > > - Used this option to prove a move-only commit quickly (no line tagged
> > with that commit) (the fastest method to me).
> > > > - Then just only needed to quickly check the positions of the moved code
> > chunk by myself (easy).
> > > >
> > > > Thank you, Paul for sharing this. It's very useful to me.
> > >
> > > Looks good to me as well and thank you both for sharing the tips.
> > 
> > Here is one way to script this, where "SHA" identifies the commit to be
> > checked and PATHS the affected pathnames:
> > 
> > 	git checkout SHA^
> > 	git show SHA | git apply -
> > 	git blame -M PATHS | grep '^0* '
> 
> Cool ~. Thank you, Paul.  
> I took them and made them into a script below for future use ;-)

Nice!!!

> #!/bin/bash
> 
> SHA=$1
> 
> if [ -z "$SHA" ]; then
>     echo "Usage: $0 <commit-id>"
>     exit 1
> fi
> 
> if ! git cat-file -t "$SHA" &> /dev/null; then
>         echo "$SHA does not exist in the repository"
>         exit 1
> fi

You might want to record the current position so that you can return
to it automatically.  One approach is to parse the output of
"git status".

> git checkout ${SHA}^ &> /dev/null
> git show ${SHA} | git apply - &> /dev/null
> 
> PATHS=`git status| grep "modified:" | cut -d: -f2 | xargs`

The '--porcelain' argument makes 'git status' is a bit easier to parse
robustly.

> for P in ${PATHS}; do
>         R=`git blame -M $P | grep '^0* '`

You can avoid any bash-variable length limitations by using
'grep -q' and capturing the exit status using "$?".

							Thanx, Paul

>         if test -n "$R"; then
>                 echo "$SHA is NOT a move-only commit"
>                 exit 1
>         fi
> done
> 
> echo "$SHA is a move-only commit"
> 
> > If there is no output, there were no non-move changes.
> > 
> > Or just do the "git blame -M PATHS | grep '^0* '" before doing the checking.
> > 
> > And yes, you can derive PATHS using "git status" if you want.  ;-)
> > 							Thanx, Paul
