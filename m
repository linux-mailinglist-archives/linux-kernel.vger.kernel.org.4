Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF46FF37B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjEKN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbjEKN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7275249;
        Thu, 11 May 2023 06:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A678964DB2;
        Thu, 11 May 2023 13:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7DC433D2;
        Thu, 11 May 2023 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683813415;
        bh=AFYNgBRlkZAIM+XPW/DgpQZP3bXSSbaVQ2TNqPf27Jg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dlWmPM4ySc1VWnSiCNCDl+iQH1JfRVLKkGL+EsLU8osKL/BmYaWWZNJut3wvKrW8f
         PwC9CVOJJujizIOrK4k9KFs5+CQWl09x6rdC3O5PQgn+OvQScst25QTZBWC5pJWsMM
         t0Z8w7rm//o0oFD4pih3jiPdtXB4bCE3LIKnLDXPW7bD36Hjxk9fXRgd5WZVINlRNb
         cjuo4mwyNEMnJNhfNh34boCMC1G0xtFXITcis56Z+sRYXRaVVlt34VsXH/x3dIfxQL
         6+C8Wmj0ZN2TyQIbiF7xQQ/Eb4DqspZNnSQAWnKDAo1l8hUJ11jDuC7YITDPy4SC8s
         zZIYEPOVZVLhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 95BE3CE0DB0; Thu, 11 May 2023 06:56:54 -0700 (PDT)
Date:   Thu, 11 May 2023 06:56:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Message-ID: <7a91a10d-3518-4452-b9ca-51240f00d29f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-3-paulmck@kernel.org>
 <CAEXW_YTHNbzdSn3RpJwnwKZOJX=rGdMabfsCw0ZuMZhsXZMjQA@mail.gmail.com>
 <IA1PR11MB6171FA965F8FF915621482E789749@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR11MB6171FA965F8FF915621482E789749@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:01:59AM +0000, Zhuo, Qiuxu wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> > Sent: Thursday, May 11, 2023 1:23 PM
> > To: Paul E. McKenney <paulmck@kernel.org>
> > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> > team@meta.com; rostedt@goodmis.org; Zhuo, Qiuxu
> > <qiuxu.zhuo@intel.com>
> > Subject: Re: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
> > kfree_scale_cleanup()
> > 
> > On Wed, May 10, 2023 at 10:12 AM Paul E. McKenney <paulmck@kernel.org>
> > wrote:
> > >
> > > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > >
> > > This code-movement-only commit moves the rcu_scale_cleanup() and
> > > rcu_scale_shutdown() functions to follow kfree_scale_cleanup().
> > > This is code movement is in preparation for a bug-fix patch that
> > > invokes
> > > kfree_scale_cleanup() from rcu_scale_cleanup().
> > >
> > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/rcuscale.c | 194
> > > +++++++++++++++++++++---------------------
> > >  1 file changed, 97 insertions(+), 97 deletions(-)
> > 
> > I wish diff was better at showing what really changed. The meld tool can help
> > but its gui...
> > 
> > Should I run meld later (I'm out at a conference so no access to meld-capable
> > machines) or are we sufficiently confident that the lines were moved as-is ? :)
> > 
> 
> Thank you, Joel for this concern. Good to know the meld diff GUI tool. 
> I just run the command below and confirmed that the lines were moved 
> as-is: rcu_scale_{cleanup,shutdown}() follows kfree_scale_cleanup().
> You may double check it ;-).
> 
>       meld --diff ./rcuscale.c.before ./rcuscale.c.after

Nice, thank you both!

Another option is to check out the commit corresponding to this patch,
then do "git blame -M kernel/rcu/rcuscale.c".  Given a move-only commit,
there should be no line tagged with this commit's SHA-1.

They say that another option is to use "git diff --color-moved", which
colors the changes.  That it does, but I am hard-pressed to work out
exactly what distinguishes a moved hunk from an added or removed hunk.
Fall colors vs. winter colors?  Exterior vs. interior?  Any particular
decade in the endless rush of changes to fashion?  Perhaps someone with
normal color vision (to say nothing of better fashion sense) could try it.

On the other hand: "default: Is a synonym for zebra. This may change to
a more sensible mode in the future."  So maybe it is not just me.  ;-)

You can also apparently choose colors using "color.diff.newMoved" and
"color.diff.oldMoved" when using "--color-moved=plain".

But "git diff --color-moved=dimmed-zebra" might be more to the point for
someone like me.  I would need to experiment with it more in order to
confirm my hypotheses about what it is doing.  To say nothing of building
trust in it.  Plus I have to open a color terminal to use it effectively.
So maybe "git blame -M" continues to be the tool for me?

							Thanx, Paul
