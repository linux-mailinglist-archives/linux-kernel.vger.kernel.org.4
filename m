Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9824615D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKBHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiKBHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:50:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742C27DFA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:49:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C4D322B26;
        Wed,  2 Nov 2022 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mA1wIkmYOej/UB8MIjoht/ySvMPSdMJKGDRaYcOsbG0=;
        b=SwwhwP+GayFi6VhdsrT8m4Po5s9nz5HUjtkMCkGPHe4tF5iIUVab/dXz3ZZD6fEpE1GX7u
        Xbffz7wJ1EgH1uhbkZiYdSYmukeQuwXFA4utZEz+VusJBZEQA/rg8/ANvPzrq6qPe2QxTH
        8CZNigvslRGhXOolnIm7DaX0b6ifR7k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F1E31376E;
        Wed,  2 Nov 2022 07:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6qyhCBEhYmOzcwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 07:49:37 +0000
Date:   Wed, 2 Nov 2022 08:49:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2IhEApQnucOX75V@dhcp22.suse.cz>
References: <20221031183122.470962-1-shy828301@gmail.com>
 <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
 <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 08:39:25, Michal Hocko wrote:
> On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> [...]
> > This is slightly tangential - but I don't want to send a new mail
> > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > explicit node vs having hpage_collapse_find_target_node() set a
> > nodemask. We could then provide fallback nodes for ties, or if some
> > node contained > some threshold number of pages.
> 
> I would simply go with something like this (not even compile tested):

Btw. while at it. It is really ugly to allocate 4kB stack space for node
mask for !NUMA configurations! If you are touching that area then this
shouldn't be hard to fix.
-- 
Michal Hocko
SUSE Labs
