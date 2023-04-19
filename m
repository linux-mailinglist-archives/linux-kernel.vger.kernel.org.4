Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8B6E79AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjDSMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjDSMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3A1FCE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8094D63E73
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424FAC433D2;
        Wed, 19 Apr 2023 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681907045;
        bh=VsH3Rfa+SSrVUfZObRgg0ssJsk3aX025Sp4TIkSmH8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=db5e0DGYh0jJ8BygAdHfCfab+ls8rvWYDyYVvgTvm9MM5M09vP9656kQmqGEw0OMO
         VJIkQKaySBTrmOukHlFifXV9pQ3xdOABwdO9fuJ57XWzB8xJBeaxeB4OKGhwBaqAZS
         yfQebVqtZeqA55RnjMfLUlNSt6T3j+5Ib6mG8GAm91GA+AvCtMpyg3vloewq4S1Z9R
         IyM8XFzo13QmNVSgZpJ0OLkUQMysgR8CNZxqnBgwo641fbpZIyxwWy19uRzxP5wFTY
         +ySd4eXktPJLeA4+6M1f5fWWtxu5/QSq7nBPm8+9wN21czPUSyb2C1A3J1sTHXwqsZ
         8ojYFLq2026Tw==
Date:   Wed, 19 Apr 2023 14:24:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZD/XoBTqJBL2G+Dk@tpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 19, 2023 at 08:59:28AM -0300, Marcelo Tosatti a écrit :
> On Wed, Apr 19, 2023 at 08:29:47AM -0300, Marcelo Tosatti wrote:
> > On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
> > > This was tried before:
> > > https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
> > > 
> > > My conclusion from that discussion (and work) is that a special system
> > > call:
> > > 
> > > 1) Does not allow the benefits to be widely applied (only modified
> > > applications will benefit). Is not portable across different operating systems. 
> > > 
> > > Removing the vmstat_work interruption is a benefit for HPC workloads, 
> > > for example (in fact, it is a benefit for any kind of application, 
> > > since the interruption causes cache misses).
> > > 
> > > 2) Increases the system call cost for applications which would use
> > > the interface.
> > > 
> > > So avoiding the vmstat_update update interruption, without userspace 
> > > knowledge and modifications, is a better than solution than a modified
> > > userspace.
> > 
> > Another important point is this: if an application dirties
> > its own per-CPU vmstat cache, while performing a system call,
> 
> Or while handling a VM-exit from a vCPU.
> 
> This are, in my mind, sufficient reasons to discard the "flush per-cpu
> caches" idea. This is also why i chose to abandon the prctrl interface
> patchset.

If you're running your isolated workloads on guests, which sounds quite
challenging but I guess you guys managed, I'd expect that VMEXITs are
absolutely out of question while the task runs critical code, so I'm not
sure why you would care. I guess not only your guests but also your hosts
run nohz_full, right?

I can't tell if the prctl solution which quiesces everything is the solution
for you, I don't know well enough your workloads, but I would expect that
the pattern is as follows:

1) Arrange for full isolation (no more interrupts/exceptions/VMEXITs)
2) Run critical code
3) Optionally do something once you're done

If vmstat is going to be the only thing to wait for on 1), then the remote
solution looks good enough (although I leave that to -mm guys as I'm too
clueless about those matters), if there is more to be expected, I guess the
quiescing prctl (or whatever syscall) is something to consider.

Thanks.
