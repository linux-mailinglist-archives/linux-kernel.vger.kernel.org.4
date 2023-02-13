Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656A693C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBMCVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBMCVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:21:23 -0500
Received: from out-101.mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F0FF03
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 18:21:21 -0800 (PST)
Date:   Sun, 12 Feb 2023 21:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676254879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sPabmvOU1hg2KuYBK+qaRkKRnOlxf/H3iLPmgTbbes=;
        b=Y0wVnUMEKFsId2cM4UIRDs5J1PqmwN88CQVIcZMfvP3YkN8eT693APRJS5vLGjFqPTjIlt
        NcyhNwpS5kb4AFeOp337Nv9LS/0c3HsVsjgeWBDk/ipOh+FCcJDCfAiSv/GKmBPeKlbE5S
        mn/O/yu2kBnE5JFlcgFtMdWlyNuv/Is=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+memjO1BxrVF20h@moria.home.lan>
References: <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
 <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
 <Y+lROV3Ii+WbmZCh@moria.home.lan>
 <Y+mRFUws3dOpU8qS@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+mRFUws3dOpU8qS@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 08:23:34PM -0500, Alan Stern wrote:
> I really don't think that's a good idea here.  When you've got a bus 
> containing multiple devices, typically all those device structures are 
> created by the same line of code.  So knowing the source code location 
> won't tell you _which_ device structure is involved in the locking 
> cycle or what driver it's using.

Yeah, I was thinking about this more and realized it'd be insufficient.

> By contrast, knowing the device name 
> would.
> 
> Furthermore, to the extent that the device's name identifies what kind 
> of device it is, the name would tell you what where the structure was 
> created and which driver it is using.

OTOH, with the device name, it seems like you'll additionally need the
full device topology to be able to do anything with lockdep splats, no?

What if we just added a way to set a comparison function for a lockdep
class? I'm looking at the lockdep code now, and I think I could do that
for you.
