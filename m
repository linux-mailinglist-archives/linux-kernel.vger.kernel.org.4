Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0C6E8BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjDTH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjDTH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:56:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD49F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:55:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB62B219DB;
        Thu, 20 Apr 2023 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681977341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SC0XXh8aaIBVsT5La85YQEUgHVR6YINUs0uzF8+7gE=;
        b=FTkjr+r4F5kCZcHxv+uUdshNK5PVu179W3/fCSSHyoCpXjpH1bJEM/Y5v1T+zh3KMVYHbH
        mTMabm+TUvZ5ny+vuH7uGro+T9xkBe9B4wzQ78fW+DMCWuBLqKAfatQbh4YJ+vlbrPYyqy
        foGZE9O2o+hxdGIFWhrbzo/eEJ3530k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99FD413584;
        Thu, 20 Apr 2023 07:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wuh4I/3vQGRGXAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 20 Apr 2023 07:55:41 +0000
Date:   Thu, 20 Apr 2023 09:55:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Theurer <atheurer@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZEDv/O30XLZfw/GX@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/NbAU8gHILW/6w@tpad>
 <98E08059-6607-43FF-84E3-BFF3FF193D09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98E08059-6607-43FF-84E3-BFF3FF193D09@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 08:44:23, Andrew Theurer wrote:
> > On Apr 19, 2023, at 6:15 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >> Andrew Theurer, can you please explain what problem is the vmstat_work
> >> interruption causing in your testing?
> > 
> > +CC Andrew.
> 
> Nearly every telco we work with for 5G RAN is demanding <20 usec CPU
> latency as measured by cyclictest & oslat.  We cannot achieve under 20
> usec with the vmstats interruption.

Are you able to get those latency requirements with PREEMPT_RT?
-- 
Michal Hocko
SUSE Labs
