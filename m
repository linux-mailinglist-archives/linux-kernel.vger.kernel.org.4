Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5556DF65A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDLNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:02:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577624C1F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:02:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FB4C1F891;
        Wed, 12 Apr 2023 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681304519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/X0WTWLoxqqFjJO52ZfP5BN4qu+yplrU+rRnlYdPoXk=;
        b=pNLK7FQP3MNurs33UmEEFf6ipceVPDMl74m5UhbRsSH0a/iritNuTydiQT5gP8wEGQrn+a
        LVHnZhnknQonAvy8O6vMlYEQCkcWCCvZxQtN0fHMz8eU51qKgvlhIIoG8Q/7y/MAlWBqT/
        LHHCcNwr5W1rJ2lyRe+l3c6e2H+ZhFw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCE85132C7;
        Wed, 12 Apr 2023 13:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +nPIMsarNmTdaAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 13:01:58 +0000
Date:   Wed, 12 Apr 2023 15:01:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
Message-ID: <ZDarxo2Q4cgFHdbh@dhcp22.suse.cz>
References: <ZDabMEUFE2N3dvxZ@dhcp22.suse.cz>
 <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
 <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
 <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
 <20230410073228.23043-1-jaewon31.kim@samsung.com>
 <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
 <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
 <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
 <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p2>
 <20230412123532epcms1p23092e51df04b3fb4e18e90b324ebcaa4@epcms1p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412123532epcms1p23092e51df04b3fb4e18e90b324ebcaa4@epcms1p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 21:35:32, Jaewon Kim wrote:
> >On Wed 12-04-23 20:37:59, Jaewon Kim wrote:
> >> Limiting dmabuf memory may be required. But I think there
> >> is no nice and reasonable way so far.
> >
> >If that is really the way then the patch doesn't really add a big
> >benefit. It doesn't really prevent OOMs (or panics due to OOM) as the
> >allocator still allows to consume arbitrary amount of memory. The
> >provided check is not able to tell between buggy and legit calls.
> >-- 
> >Michal Hocko
> >SUSE Labs
> 
> Yes it could be. Though the buggy call is blocked by totalram_pages check,

It seems our definitions of buggy differ here. I do not see much
difference between totalram_pages +- PAGE_SIZE (or any epsilon for that
matter). Both would put the system down to its knees without a way out
other than panic.

> mm may suffer memory shortage due to the huge memory consumption through
> dma-buf system heap. We just hope Android LMKD or oomk kills the memory
> hoggers prior to oom panic.

You seem to be missing an important point. If the global OOM killer is
not able to find a victim the LMKD or oomk are highly unlikely as well
(unless they ignore OOM_SCORE_ADJ_MIN).

> IMO if possible mm should be able to track the dma-buf size as stat in
> mm_rss_stat for each process.

I do remember some proposals from the past and IIRC the main problem was
how to attribute those buffers to the actual owner.

I believe I have give you some arguments to consider. The rest is up to
you. As I've said I do not have any stakes in dmabuf. The patch itself
is not actively harmful, it is just adding an illusion of a fix while it
doesn't give much.
-- 
Michal Hocko
SUSE Labs
