Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA6714BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjE2OIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjE2OIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:08:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10283D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:07:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 906A21F8D7;
        Mon, 29 May 2023 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685369273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TOnFBqxMFw5mkdOSJtN9NSvECUvVAhEvS+IQVCBonZg=;
        b=UiaIEH3o/d6TF63fzY1N1HMbDaaLsLuVLiursleq9J5NVeAOR7/VlVVJikwQzGAXJCrpCg
        O3BWQuqEFqvqpwf59hUSU1KNtXzI0ofJF+ecF7fCt/oy6jKzv/j87vsFlidvia37Swl3u5
        u3kgoF4dpfryOdQ6hWaRGi3c1AsvgRM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9DF12C141;
        Mon, 29 May 2023 14:07:52 +0000 (UTC)
Date:   Mon, 29 May 2023 16:07:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: delete old declarations for
 watchdog_soft,hardlockup_user_enabled + make static
Message-ID: <ZHSxuOccanSpmL1-@alley>
References: <20230525162822.1.I0fb41d138d158c9230573eaa37dc56afa2fb14ee@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525162822.1.I0fb41d138d158c9230573eaa37dc56afa2fb14ee@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-05-25 16:28:32, Douglas Anderson wrote:
> From: Tom Rix <trix@redhat.com>
> 
> smatch reports
> kernel/watchdog.c:40:19: warning: symbol
>   'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
> kernel/watchdog.c:41:19: warning: symbol
>   'watchdog_softlockup_user_enabled' was not declared. Should it be static?
> 
> These variables are only used in their defining file, so they should
> be static.
> 
> This problem showed up after the patch ("watchdog/hardlockup: rename
> some "NMI watchdog" constants/function") because that rename missed
> the header file. That didn't cause any compile-time errors because,
> since commit dd0693fdf054 ("watchdog: move watchdog sysctl interface
> to watchdog.c"), nobody outside of "watchdog.c" was actually referring
> to them. Thus, not only should we make these variables static but we
> should remove the old declarations in the header file that we missed
> renaming.
> 
> Fixes: 4b95b620dcd5 ("watchdog/hardlockup: rename some "NMI watchdog" constants/function")

This would need to be a hash which exists or is going to be merged
into Linus' tree. I am afraid that this is not the case here.
Andrew maintains branches in quilt and the patches have different
time in linux-next each time. Also the patchset might still need
a rebase even when it was maintained in git.

> Signed-off-by: Tom Rix <trix@redhat.com>
> [dianders: updated subject + commit message; squashed in Petr's suggestion]
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This is a squash of two patches that were posted to mailing lists, one
> official patch posted by Tom [1] and one that was posted in reply to
> my previous patch by Petr [2].
> 
> IMO it makes sense to put these two things into one patch since
> they're basically dealing with the same issue. As promised [3] I'm
> posting the squash of the two patches.
> 
> I have no idea how to really tag this and set authorship. I've chosen
> to leave author/Signed-off-by from Tom. Peter didn't officially
> include his Singed-off-by on his patch (as is common when posting
> suggestions in reply to another patch), so I didn't add it but added a
> Suggested-by from him. Hopefully this is OK.

It looks OK. Or maybe something like:

Signed-off-by: Tom Rix <trix@redhat.com>
[pmladek@suse.com: changes in nmi.h]
[dianders@chromium.org: merged changes, updated subject and commit message]
Signed-off-by: Douglas Anderson <dianders@chromium.org>

Also feel free to add:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
