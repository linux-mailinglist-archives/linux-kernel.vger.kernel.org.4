Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9A73DF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFZMZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjFZMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F592970;
        Mon, 26 Jun 2023 05:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C7E60E26;
        Mon, 26 Jun 2023 12:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6806C433C0;
        Mon, 26 Jun 2023 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687782168;
        bh=QFJoYAoa2djqSERhowqC20itD6kv95F3np82eWmAz+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3jnKCElPEbglru8D6DfI9k7iJ3oTU2OgLAtuSR1cTHVDbx5ifZGflwTYAg4yhF1O
         dQDDRBx/KXYZILa3/e164u2C7PBxgNDRXZIkWQ11X8yKy3Gvv44hS4ZuU1cI4lkfaV
         fwPPAEXiXjwAcyYLpvEjI7tX3ZAYfFe0XL5api/mri1HFt2lfrlcNXPGG0Z2RGhUOm
         YCaUbL88VvEEHyNrROXamBXPm9qNEMmoHALDylSN5P4GYYFfbzEippl1y9RHeCZt5j
         hGN+389eLoFso3N7Pv+WdeH79D4Sh3EVz2d3wX/didUC8GBoVLQUrvh685YFUBQXFM
         q1WSJ4f2++6TA==
Date:   Mon, 26 Jun 2023 13:22:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Add necessary WRITE_ONCE()
Message-ID: <20230626122243.GB19941@willie-the-truck>
References: <20230620171346.207076-1-mmpgouride@gmail.com>
 <50c4aa37-388b-449c-8184-00a9d69471fc@paulmck-laptop>
 <B9A94CB4-DB9B-43D2-9D34-ADB4F7EA737D@gmail.com>
 <2fd1169a-a695-4bff-9611-a84dd02025b2@paulmck-laptop>
 <C75370D0-3A0C-48AA-AF20-ABCD74969F11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C75370D0-3A0C-48AA-AF20-ABCD74969F11@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 02:31:12AM +0800, Alan Huang wrote:
> 
> > 2023年6月23日 下午1:17，Paul E. McKenney <paulmck@kernel.org> 写道：
> > 
> > On Wed, Jun 21, 2023 at 10:08:28AM +0800, Alan Huang wrote:
> >> 
> >>> 2023年6月21日 06:26，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>> 
> >>> On Tue, Jun 20, 2023 at 05:13:46PM +0000, Alan Huang wrote:
> >>>> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") and
> >>>> commit 860c8802ace1("rcu: Use WRITE_ONCE() for assignments to
> >>>> ->pprev for hlist_nulls") added various WRITE_ONCE() to pair with
> >>>> the READ_ONCE() in hlist_unhashed_lockless(), but there are still
> >>>> some places where WRITE_ONCE() was not added, this commit adds that.
> >>>> 
> >>>> Also add WRITE_ONCE() to pair with the READ_ONCE() in hlist_empty().
> >>>> 
> >>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >>> 
> >>> On hlist_nulls_add_tail_rcu(), good catch, thank you!
> >>> 
> >>> On the others, are there really cases where a lockless read races with
> >>> the update?  At first glance, that sounds like a usage bug.  For example,
> >>> as I understand it, when you use something like hlist_del(), you are
> >>> supposed to ensure that there are no concurrent readers.  Which is the
> >>> point of the assignment of the special value LIST_POISON2, right?
> >> 
> >> Do you mean there are cases where a lockless read races with hlist_add_head/hlist_add_before
> >> hlist_add_behind/__hlist_del, but there is no real case where a lockless read races with the hlist_del_init/hlist_del
> >> hlist_move_list?
> >> 
> >> There may be no real case where a lockless read races with the hlist_del_init/hlist_del
> >> hlist_move_list. But for the sake of completeness, I added those WRITE_ONCE, after all, if there is WRITE_ONCE
> >> in __hlist_del, why not add WRITE_ONCE in its caller, like hlist_del()?
> > 
> > You might well have located a larger issue.  We want to be able to use
> > KCSAN to find unintended data races, but as you noted, there might
> > be different requirements for RCU-protected linked lists and for
> > lock-protected linked lists.  If there are, then there is probably
> > existing linked-list code that is using the wrong primitive, for
> > example, using (or failing to use) the one that Eric Dumazet provided.
> > For example, mismatched API usage might be causing the differences in
> > uses of _ONCE() primitives that you are calling out.
> 
> I noticed a thread:
> 
> https://lore.kernel.org/lkml/20200324153643.15527-2-will@kernel.org/
> 
> It seems like Will wanted to remove that hlist_unhashed_lockless()?
> But I can’t find any further updates.
> 
> Will: Can you tell me what happened later?

IIRC, there were potential correctness issues with accesses being torn
(possibly by the compiler) which meant that some additional surgery was
needed to make some of the list accesses safe without locks.

I then ran into problems understanding how list_empty_careful() is supposed
to work which weren't resolved. I think the best summary of where I got
stuck (and moved onto more pressing things) is:

https://lore.kernel.org/lkml/20200424173932.GK21141@willie-the-truck/

Will
