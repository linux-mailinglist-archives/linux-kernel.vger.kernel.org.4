Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C266E7CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjDSOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjDSOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:36:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86167ECD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:35:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E64971FD93;
        Wed, 19 Apr 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681914952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zceTr3IJvZAOP6+2eeC0vH3EC5khW0Gmy792chY32s=;
        b=ogvZyIAjdJEHmhNihYmNWEk4ZzZW3kDWQU/3MM6QbERZwdcEHpaEx3D40HQHSaLZlGzH0J
        +xqSkOoVowITwW3e24rleVA7FbWaqvuYtngTcpoifDjW2h7SRi9HhEYJ9Wn/XZp4FQ7+o8
        qSr3pYdK/GRyC7PFofYV3Lkg7+rS7mc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFB1613580;
        Wed, 19 Apr 2023 14:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKqnK0j8P2QhdgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Apr 2023 14:35:52 +0000
Date:   Wed, 19 Apr 2023 16:35:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD/xE6kR4RSOvUlR@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 10:48:03, Marcelo Tosatti wrote:
> On Wed, Apr 19, 2023 at 02:24:01PM +0200, Frederic Weisbecker wrote:
[...]
> > 2) Run critical code
> > 3) Optionally do something once you're done
> > 
> > If vmstat is going to be the only thing to wait for on 1), then the remote
> > solution looks good enough (although I leave that to -mm guys as I'm too
> > clueless about those matters), 
> 
> I am mostly clueless too, but i don't see a problem with the proposed
> patch (and no one has pointed any problem either).

I really hate to repeat myself again. The biggest pushback has been on
a) justification and b) single purpose solution which is very likely
incomplete. For a) we are getting the story piece by piece which doesn't
speed up the process. You are proposing a non-trivial change to an
already convoluted code so having a solid justification is something
that shouldn't be all that surprising.

b) is what concerns me more though. There are other per-cpu specific
things going on that require some regular flushing. Just to mention
another one that your group has been brought up was the memcg pcp
caches. Again with a non-trivial proposal to deal with that problem
[1]. It has turned out that we can do a simpler thing [2]. I do not
think it is a stretch to expect that similar things will pop out every
now and then and rather than dealing with each one in its own way it
kinda makes sense to come up with a more general concept so that all
those cases can be handled at a single place at least. All I hear about
that is that the code of those special applications would need to be
changed to use that. Well, true but is that bar so impractical that we
are going to grow kernel complexity and therefore a maintenance burden?
Everything for a very specialized workloads?

[1] http://lkml.kernel.org/r/20221102020243.522358-1-leobras@redhat.com
[2] http://lkml.kernel.org/r/20230317134448.11082-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
