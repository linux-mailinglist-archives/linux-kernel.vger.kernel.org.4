Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A25BCF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiISOnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiISOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:43:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50739F1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:43:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B104221F82;
        Mon, 19 Sep 2022 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663598584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmGdRLJbXKoDHbtEsvS6wAys9F3jM3Uxx+Jt2KN/6yI=;
        b=bXiQD6KCrnLA+lwffE4pfxYaL//UVqTOB+6Q5NAWsdHWR+F1oNCfopQ19YqfTi1PF+egOL
        bcApiIW8isBRqOyywK3m6AW2d9Vp6Jf0ZWw+PG1TDaZotAayVAzS4eDPsFoyXLX5Cu/26v
        UdE8veyK286pLW2t79LP5GQtS9YWLk0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9373813ABD;
        Mon, 19 Sep 2022 14:43:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PvmvIfh/KGPGZgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 19 Sep 2022 14:43:04 +0000
Date:   Mon, 19 Sep 2022 16:43:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, quic_charante@quicinc.com,
        quic_pkondeti@quicinc.com
Subject: Re: [PATCH v2] mm: oom_kill: add trace logs in process_mrelease()
 system call
Message-ID: <Yyh/+HqwIXAnTARc@dhcp22.suse.cz>
References: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
 <20220816173556.cb493d6a85edd65e1fa52911@linux-foundation.org>
 <1326361c-44c3-d2e0-c7a9-1e4b3e84ab6e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1326361c-44c3-d2e0-c7a9-1e4b3e84ab6e@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-08-22 12:17:22, Pratyush Brahma wrote:
> 
> On 17-08-2022 06:05, Andrew Morton wrote:
> > On Tue, 16 Aug 2022 11:30:17 +0530 Pratyush Brahma <pbrahma@qti.qualcomm.com> wrote:
> > 
> > > The process_mrelease() system call[1] is used to release the memory of
> > > a dying process from the context of the caller, which is similar to and
> > > uses the functions of the oom reaper logic. There exists trace logs for
> > > a process when reaped by the oom reaper. Just extend the same to when
> > > done by the process_mrelease() system call.
> > Why?  Please describe in full detail the end-user value of this change.
> 
> This patch provides information on how much memory is freed from a process
> which is being reaped. Adding trace events in the process_mrelease() path when
> process is being reaped would enable more holistic debug as it happens in
> oom_reap_task_mm() currently.
> 
> This extends the debug functionality for the events as described in [1] to
> the process_mrelease() system call. Now the coverage of trace events is complete.

Yes this is all nice but why it is needed to extend process_mrelease to
be in par with the oom path? OOM path happens out of direct control of
while this is under direct control of the caller. So why do we need more
debugging data from the kernel? The information dumped by the tracing
can be queried already by other means and much more extensibly.
 
> [1]
> https://lore.kernel.org/all/20170530185231.GA13412@castle/T/#u

-- 
Michal Hocko
SUSE Labs
