Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627E6F1D99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjD1RrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1RrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:47:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E29BC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:47:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E86C21F99;
        Fri, 28 Apr 2023 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682704024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3B7ysj5RSMckwSAEhrXWKnNSpUDd+G6jO7WJZ2JM5g=;
        b=kjfGmR0zDB9nGpI0Ku7KH/2tDox0WtG25rfviSnB9bsfIntkE1nBSGT7dINhg3Bv0u/A8K
        +IqHj0dPf/rHQi6oi9Tvkba2feblJ4r0aKqE3WZ0r20QHkOTQgg5mdYoqfNzU0/RSORp01
        0rJP80Jkw+ZR6WO1zB0/6dPdC0YtDyk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CA52138FA;
        Fri, 28 Apr 2023 17:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WK6YCJgGTGQpIAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 28 Apr 2023 17:47:04 +0000
Date:   Fri, 28 Apr 2023 19:47:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Frank van der Linden <fvdl@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Lsf-pc] Fwd: [LSF/MM/BPF TOPIC] userspace control of memory
 management
Message-ID: <ZEwGlyX6/ZSvfhfY@dhcp22.suse.cz>
References: <CAPTztWYAiroY3E8pwB+rnPGA1K9HLhkpQp1Gy9C1dEuS1FhWGg@mail.gmail.com>
 <CAPTztWY49XP-7GDHuvV2fNDCeJzd0vAac6n+rJ9KfWr6cyZ5ww@mail.gmail.com>
 <ZEvVqMtnU142GMEU@dhcp22.suse.cz>
 <ZEveJ3OmysVDVZ8m@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEveJ3OmysVDVZ8m@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-04-23 15:54:31, Matthew Wilcox wrote:
> On Fri, Apr 28, 2023 at 04:18:16PM +0200, Michal Hocko wrote:
> > For some reason I cannot find this email in my linux-mm inbox and I
> > cannot find it in any archives so let me add linux-mm and lkml again for
> > future reference.
> 
> Hm, I found it by searching for 'lsf' on lore.kernel.org in the linux-mm
> archive.
> 
> https://lore.kernel.org/linux-mm/CAPTztWYAiroY3E8pwB+rnPGA1K9HLhkpQp1Gy9C1dEuS1FhWGg@mail.gmail.com/

I have tried to search for the msg-id via lore.kernel.org
(https://lore.kernel.org/all/?q=CAPTztWY49XP-7GDHuvV2fNDCeJzd0vAac6n%2BrJ9KfWr6cyZ5ww%40mail.gmail.com)
as well as the subject
(https://lore.kernel.org/?q=userspace+control+of+memory+management).

I've had the email in my lsf-pc mailbox but that is not archived at lore
and we are trying to prepare schedule with links to the archive so that
people can find associated disucssions easier.

> Here are the other topics I found:

This matches my list as well

> Memory profiling using code tagging

Except for this one which somehow escaped my attention. Now added and
scheduled. Thanks Matthew!

-- 
Michal Hocko
SUSE Labs
