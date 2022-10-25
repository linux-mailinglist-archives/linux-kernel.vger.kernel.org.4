Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0F60C2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJYEwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJYEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:52:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2F5107CFE;
        Mon, 24 Oct 2022 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666673537; x=1698209537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Xclpbz6CzoT2N4k2dsAPSkon8bbf3eyJSQvC5r5ayqc=;
  b=QV0C7nmxrTM3cYE3SuZLJGM4qYjvqraSg0fdiGUH4JWU06qQ7wu7s21w
   WTJc8qJmXAzTPsl6lAtOAs0UFrAujq2QV+uE2u4PXx/1TY9FUp7fqRnQ7
   o8NBJtkH9Y2dvsMJ5hWoEdYgp33tTTN7BMRspfZble+2DXzz9NWm96+3v
   QRQFAKOoi2xk7kszTyd5FvZoRL+7yRth4uPgkIPQEMsf8Wpg7Qw/9mhlt
   8wlFjTLE3qVC7IvCKEkXZ9gB9FzU6lsDj+ereA+mWcuPqXjx7mqxc/Rh6
   iZpKOWzmqsJSTRdRo0LNaNAzcuj0FgJcThCduY1eJgXR6FkgUn3CsexwD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="294989583"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="294989583"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 21:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582644348"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="582644348"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga003.jf.intel.com with SMTP; 24 Oct 2022 21:52:08 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 25 Oct 2022 07:52:07 +0300
Date:   Tue, 25 Oct 2022 07:52:07 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1drd2gzxUJWdz5F@intel.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1LVYaPCCP3BBS4g@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:22:41PM +0300, Ville Syrjälä wrote:
> On Mon, Aug 22, 2022 at 01:18:22PM +0200, Peter Zijlstra wrote:
> > +#ifdef CONFIG_LOCKDEP
> > +	/*
> > +	 * It's dangerous to freeze with locks held; there be dragons there.
> > +	 */
> > +	if (!(state & __TASK_FREEZABLE_UNSAFE))
> > +		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > +#endif
> 
> We now seem to be hitting this sporadically in the intel gfx CI.
> 
> I've spotted it on two machines so far:
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12270/shard-tglb7/igt@gem_ctx_isolation@preservation-s3@vcs0.html
> https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_109950v1/shard-snb5/igt@kms_flip@flip-vs-suspend-interruptible@a-vga1.html

Sadly no luck in reproducing this locally so far. In the meantime
I added the following patch into our topic/core-for-CI branch in
the hopes of CI stumbling on it again and dumping a bit more data:

--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -125,8 +125,16 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 	/*
 	 * It's dangerous to freeze with locks held; there be dragons there.
 	 */
-	if (!(state & __TASK_FREEZABLE_UNSAFE))
-		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
+	if (!(state & __TASK_FREEZABLE_UNSAFE)) {
+		static bool warned = false;
+
+		if (!warned && debug_locks && p->lockdep_depth) {
+			debug_show_held_locks(p);
+			WARN(1, "%s/%d holding locks while freezing\n",
+			     p->comm, task_pid_nr(p));
+			warned = true;
+		}
+	}
 #endif
 
 	WRITE_ONCE(p->__state, TASK_FROZEN);
-- 
2.37.4

-- 
Ville Syrjälä
Intel
