Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC6680BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjA3LN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjA3LNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:13:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738455AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:12:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEEBF1FE33;
        Mon, 30 Jan 2023 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675077174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hy6PhjQIM94/VEYbDfCxAxF/aDtP712Et69pSMk53/8=;
        b=WLkoXhKb2AfdZhClLWk8z1E0OMtyyRxY4xFj0q0ojOXNI9wTvXWj7ham4H4nllKiWb4Maf
        d6SLYCx/ttobJ70fdxVCojXKAIYiTJB5xvcXgJKnIxuVqs0E3LqwZ75IBnoinI4fok1Mr6
        D+bcdi2ViJ9tk9+N8Ybnb+AXX6USY4c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE64B13A06;
        Mon, 30 Jan 2023 11:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5C3VKTam12OtHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 30 Jan 2023 11:12:54 +0000
Date:   Mon, 30 Jan 2023 12:12:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9emNtEK7z8G7G08@dhcp22.suse.cz>
References: <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
 <Y9Grb2rggptkCu+n@google.com>
 <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
 <Y9K0Fn9MFPAgJjlM@google.com>
 <Y9LbgUDVnSBazIYW@dhcp22.suse.cz>
 <Y9MWC8xh8gOKDrUU@google.com>
 <Y9Od6ccvXujj+YJ/@dhcp22.suse.cz>
 <Y9SPv/QWqJ3t7w8J@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9SPv/QWqJ3t7w8J@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-01-23 19:00:15, Minchan Kim wrote:
[...]
> Then, let me ask back to you.
> 
> What statistcis in the current vmstat fields or pending fields
> (to be merged) among accumulated counter stats sound reasonable
> to be part of vmstat fields not tracepoint from your perspective?

Most of those could be replaced but for historical reasons a counter was
an only solution back then. Some metrics make a lot of sense these days
as well. Regular snapshots of vmstat can give a nice overview of the
_system_ reclaim activity.

> Almost every stat would have corner cases by various reasons and
> people would want to know the reason from process, context, function
> or block scope depending on how they want to use the stat.
> Even, tracepoint you're loving couldn't tell all the detail what they want
> without adding more and more as on growing code chages.

Quite possible but tracepoints are much easier to modify and shape to a
particular need.

> However, unlike your worry, people has used such an high level vague
> vmstat fields very well to understand/monitor system health even though
> it has various miscounting cases since they know the corner cases
> are really minor.
> 
> I am really curious what metric we could add in the vmstat instead of
> tracepoint in future if we follow your logic. 

I would say that we should be more and more conservative when extending
vmstat counters and use tracing instead as much as possible. I can
imagine there could be cases where tracing is not a preferable option.
Then we can judge case by case. So far you have presented no real
argument, except you already collect vmstat on a larger scale and that
would be easier (essentially free from the tool modification POV). That
is a weak argument. Especially with a major design flaw already
mentioned.

I do not have much more to add here.
-- 
Michal Hocko
SUSE Labs
