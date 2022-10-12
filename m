Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD95FC5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJLNH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJLNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:07:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4DECAE4B;
        Wed, 12 Oct 2022 06:07:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECC571F381;
        Wed, 12 Oct 2022 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665580068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=noRw341ciNnXF2Fe3Zu8GlyFJvJlbriboL+oH8utWA8=;
        b=Hpqv7y7duLf4qQYyRbwbcD9yTwe3/BS2Ob/qn6ah/cL/4k5nGbsLLVJaNvgdka6iCoKHEz
        HhTrfROTTyzpNtb/vSORr+hLkzWRMgMVxtM+60yAkiUTeqLzLUeYmuElHA14k9rN/neRMG
        yr7g4hiFxVLMJuR1KQxOvS0QXM9Om+I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2C5913ACD;
        Wed, 12 Oct 2022 13:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WS+OJSS8RmM7cAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Oct 2022 13:07:48 +0000
Date:   Wed, 12 Oct 2022 15:07:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vinicius Petrucci <vpetrucci@gmail.com>
Cc:     Frank van der Linden <fvdl@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0a8IxAXy43unTSb@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com>
 <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz>
 <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
 <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
 <CAEZ6=UOA6=ikSdxN662xyhT3wauGuqZReKLOb=_9EmSRckNr=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEZ6=UOA6=ikSdxN662xyhT3wauGuqZReKLOb=_9EmSRckNr=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-10-22 07:34:06, Vinicius Petrucci wrote:
> > Well, per address range operation is a completely different beast I
> > would say. External tool would need to a) understand what that range is
> > used for (e.g. stack/heap ranges, mmaped shared files like libraries or
> > private mappings) and b) by in sync with memory layout modifications
> > done by applications (e.g. that an mmap has been issued to back malloc
> > request). Quite a lot of understanding about the specific process. I
> > would say that with that intimate knowledge it is quite better to be
> > part of the process and do those changes from within of the process
> > itself.
> 
> Sorry, this may be a digression, but just wanted to mention a
> particular use case from a project I recently collaborated on (to
> appear next month at IIWSC 2022:
> http://www.iiswc.org/iiswc2022/index.html).
> 
> We carried out a performance analysis of the latest Linux AutoNUMA
> memory tiering on graph processing applications. We noticed that hot
> pages cannot be properly identified by the reactive approach used by
> AutoNUMA due to irregular/random memory access patterns.

Yes, I can see how a reactive approach might not be the best fit.
Automatic NUMA balancing can help quite a lot where memory regions
are accessed consistently. I can imagine situations where the user space
agent can tell much better what is the best node to place data when the
access pattern is not obvbious or hard to deduce from local metrics.

My main argument is though that those are rather specialized and it is
much easier to implement the agent as a part of the process as they are
unlikely to be generic enough to serve many different processes. I might
be wrong in this of course and I am also not saying that pidfd_mbind is
a completely unreasonable idea. We just need a strong usecase before
going that way.

> Thus, as a
> POC, we implemented and evaluated a simple idea of having an external
> user-level process/agent that, based on prior profiling results of
> memory regions, could make more effectively memory chunk/object-based
> mappings (instead of page-level allocation/migration) in advance on
> either DRAM or CXL/PMEM (via mbind calls). This kind of tiering
> solution could deliver up to 2x more performance for graph analytics
> workloads. We plan to evaluate other workloads as well.
> 
> Having a feature like "pidfd/process_mbind" would really simplify our
> user-level agent implementation moving forward, as right now we are
> adding a LD_PRELOAD wrapper (for signal handler) to listen and execute
> "mbind" requests from another process. If there's any other
> alternative solution to this already (via ptrace?), please let me
> know.

userfaultfd sounds like the closest match if #PF handling under control
of an external agent is viable.
-- 
Michal Hocko
SUSE Labs
