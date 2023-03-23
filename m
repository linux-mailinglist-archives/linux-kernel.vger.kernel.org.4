Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08B6C6125
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCWHvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCWHvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:51:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4620A10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:51:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CB2D339C9;
        Thu, 23 Mar 2023 07:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679557875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFRffw+9SvcdtX5CuPeFnJlovLn9+suOg3bbTvNjZ/k=;
        b=PMZwY6SCQEocvy4dhNouktfWgxmXrsBQGWar+MXVsF+3wdLQAWq/f+cnwsZf1abMaQf6vT
        3xAia7Kt3CgmVfx1BMnUnZK4qFTdr5YJNfvZZbTpKEfWM7OkQZUXg7h+gGU3M9lsaWcXEt
        9jNm2ZL1edCXAkBy6P9EEMaVRZu4il0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 199FB132C2;
        Thu, 23 Mar 2023 07:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iqDPA/MEHGRvDgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 23 Mar 2023 07:51:15 +0000
Date:   Thu, 23 Mar 2023 08:51:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZBwE8gUUxI+aKuAm@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
 <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
 <ZBiu8csaxB/zrOAS@tpad>
 <ZBrUruIsOjdaqiFv@dhcp22.suse.cz>
 <ZBrlKeZTsHgRW021@tpad>
 <ZBsEGMEfEI98Wpwq@dhcp22.suse.cz>
 <ZBsOx1abWfBTdGFl@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsOx1abWfBTdGFl@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-03-23 11:20:55, Marcelo Tosatti wrote:
> On Wed, Mar 22, 2023 at 02:35:20PM +0100, Michal Hocko wrote:
[...]
> > > "Performance details for the kworker interruption:
> > > 
> > > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > > 
> > > The example above shows an additional 7us for the
> > > 
> > >         oslat -> kworker -> oslat
> > > 
> > > switches. In the case of a virtualized CPU, and the vmstat_update
> > > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > > observed in the guest is higher than 50us, violating the acceptable
> > > latency threshold for certain applications."
> > 
> > Yes, I have seen that but it doesn't really give a wider context to
> > understand why those numbers matter.
> 
> OK.
> 
> "In the case of RAN, a MAC scheduler with TTI=1ms, this causes >100us
> interruption observed in a guest (which is above the safety
> threshold for this application)."
> 
> Is that OK?

This might be a sufficient information for somebody familiar with the
matter (not me). So no, not enough. We need to hear a more complete
story. 

-- 
Michal Hocko
SUSE Labs
