Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A16A42CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjB0Nec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB0NeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:34:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF7211F8;
        Mon, 27 Feb 2023 05:34:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E85F1FD67;
        Mon, 27 Feb 2023 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677504842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZr+AZDZ1RO7fX8oz8OymIMfvIwgMjhP3rsgS91awvk=;
        b=okZ1/IuksZE8Qw6ct66OfkQDzZ4k/FhzTDScvCH0c+HWNkDSJ52JK/l7f8QuZR2M8d7emO
        ptv2ffu0+m65Suh2nXxQ+vEaroIu6+hESzZbyyCHUd3qtNDB/QdGXNaCMXZME69BOq/nwM
        5JzW//fdLAHOryfXiNc/dBU/E9nDabs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E9C713912;
        Mon, 27 Feb 2023 13:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J8JCFkqx/GOSaQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 27 Feb 2023 13:34:02 +0000
Date:   Mon, 27 Feb 2023 14:34:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>
Subject: Re: [PATCH] psi: reduce min window size to 50ms
Message-ID: <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz>
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com>
 <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
 <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com>
 <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz>
 <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
> On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 14-02-23 11:34:30, Suren Baghdasaryan wrote:
> > [...]
> > > Your suggestion to have this limit configurable sounds like obvious
> > > solution. I would like to get some opinions from other maintainers.
> > > Johannes, WDYT? CC'ing Michal to chime in as well since this is mostly
> > > related to memory stalls.
> >
> > I do not think that making this configurable helps much. Many users will
> > be bound to distribution config and also it would be hard to experiment
> > with a recompile cycle every time. This seems just too impractical.
> >
> > Is there any reason why we shouldn't allow any timeout? Shorter
> > timeouts could be restricted to a priviledged context to avoid an easy
> > way to swamp system by too frequent polling.
> 
> Hmm, ok. Maybe then we just ensure that only privileged users can set
> triggers and remove the min limit (use a >0 check)?

This could break existing userspace which is not privileged. I would
just go with CAP_SYS_NICE or similar with small (sub min) timeouts.

> > Btw. it seems that there is is only a limit on a single trigger per fd
> > but no limits per user so it doesn't sound too hard to end up with too
> > much polling even with a larger timeouts. To me it seems like we need to
> > contain the polling thread to be bound by the cpu controller.
> 
> Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
> poll_min_period for each thread is chosen as the min() of polling
> periods between triggers created in that group. So, a bad trigger that
> causes overly aggressive polling and polling thread being throttled,
> might affect other triggers in that cgroup.

Yes, and why that would be a problem?
-- 
Michal Hocko
SUSE Labs
