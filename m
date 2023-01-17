Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF3766DD05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbjAQL6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbjAQL6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:58:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B51E9EF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a+Z1S1xLoCDY3+cEJ4MNUOsPlXtKXXWmP1+DQ4QDsac=; b=evMQhc5/xMEy+lhk6J7pBkUh8b
        nhYD9qQYyxgSYOKUhBcEB6FN+q4d3+76POpvVi3Kwnh4t6iZr9bnzmPH35XwZsEWX9VpjSu/iJ2qY
        6FGKZPeNYW/xByoKChnP3sj3BHAv59X36zTLnB5UsmYB1c2exkEiNof3OiLa1AwTelAJirDSum+UT
        vWX4iTxx0P7lzSf/2wPpcYks84YO0dhwXEfyNc2Nn3XvSVMdvZ4RyR+W4Fq7VqLZBxaW8J5v53pyQ
        Vr4BXcj2QDslVT5oi5ZePwjDOBaKrA0qbKvLGDog/P3faF8Cgt638yoYmaBgjpHoIHCB8UnuDr4M7
        kF/EBoZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHkbC-009ec6-W2; Tue, 17 Jan 2023 11:57:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A904A300094;
        Tue, 17 Jan 2023 12:57:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8495A2B305DE7; Tue, 17 Jan 2023 12:57:39 +0100 (CET)
Date:   Tue, 17 Jan 2023 12:57:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 20/20] jump_label: RFC - tolerate toggled state
Message-ID: <Y8aNMxHpvZ8qecSc@hirez.programming.kicks-ass.net>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
 <20230113193016.749791-21-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113193016.749791-21-jim.cromie@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:30:16PM -0700, Jim Cromie wrote:
> __jump_label_patch currently will "crash the box" if it finds a
> jump_entry not as expected.  ISTM this overly harsh; it doesn't
> distinguish between "alternate/opposite" state, and truly
> "insane/corrupted".
> 
> The "opposite" (but well-formed) state is a milder mis-initialization
> problem, and some less severe mitigation seems practical.  ATM this
> just warns about it; a range/enum of outcomes: warn, crash, silence,
> ok, fixup-continue, etc, are possible on a case-by-case basis.
> 
> Ive managed to create this mis-initialization condition with
> test_dynamic_debug.ko & _submod.ko.  These replicate DRM's regression
> on DRM_USE_DYNAMIC_DEBUG=y; drm.debug callsites in drivers/helpers
> (dependent modules) are not enabled along with those in drm.ko itself.
> 

> Ive hit this case a few times, but havent been able to isolate the
> when and why.
> 
> warn-only is something of a punt, and I'm still left with remaining
> bugs which are likely related; I'm able to toggle the p-flag on
> callsites in the submod, but their enablement still doesn't yield
> logging activity.

Right; having been in this is state is bad since it will generate
inconsistent code-flow. Full on panic *might* not be warranted (as it
does for corrupted text) but it is still a fairly bad situation -- so
I'm not convinced we want to warn and carry on.

It would be really good to figure out why the site was skipped over and
got out of skew.

Given it's all module stuff, the 'obvious' case would be something like
a race between adding the new sites and flipping it, but I'm not seeing
how -- things are rather crudely serialized by jump_label_mutex.

The only other option I can come up with is that somehow the update
condition in jump_label_add_module() is somehow wrong.

