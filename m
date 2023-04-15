Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AE6E2EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDODXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDODXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A14C3C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 20:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA13B64A0F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5449C433EF;
        Sat, 15 Apr 2023 03:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681528988;
        bh=AzxKYq5yEA+LGDBj0JIEH82z1x96b37gP4y9wuEr+y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXcFTfvbBCfAjQN/aRyRZVC9kBXGx/sTAYkV2s4fy+6lg6CoC6B+qpNBkO808//cA
         DwF62XT16Fg1sJ/OHMoRNgN3TjigxFclihZOZID79ry/tn7S9/lWJzYHOp2RPtEG52
         ikS8jmIMJmj+5TxG2GwxEUoUCohkxVYRCYWJ3VeuXXb6NYyj6XRZJvCsms4R5jiDTT
         Jqqys1+/kJ3c6usm8fo7YK1nbppUeUTZrpLlPS8XfGl7vivCqUjZ8e9bUGiVrqRQUa
         GwsrqKb53RkHTge/G+cFitmIQow1KZ6slFqMy8CNL0Abc8pPK+wFhJprMJ8T3KUjhe
         pqQTL0WKFeAyg==
From:   SeongJae Park <sj@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 03:23:05 +0000
Message-Id: <20230415032305.3860-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415030452.3223-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 03:04:52 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 15 Apr 2023 03:51:54 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Sat, Apr 15, 2023 at 12:37:53AM +0000, SeongJae Park wrote:
> > >   *
> > > + * begin:
> > >   *  rcu_read_lock();
> > > - * again:
> > >   *  obj = lockless_lookup(key);
> > >   *  if (obj) {
> > >   *    if (!try_get_ref(obj)) // might fail for free objects
> > > - *      goto again;
> > > + *      goto begin;

I simply followed the commit da82af04352b ("doc: Update and wordsmith
rculist_nulls.rst") for this change, and I think I overlooked this part.  If
I'm not missing something, I think we should call rcu_read_unlock() here too,
just before 'goto begin'.

I will post another patch for rculist_null.rst later.


Thanks,
SJ

> > >   *
> > >   *    if (obj->key != key) { // not the object we expected
> > >   *      put_ref(obj);
> > > + *      rcu_read_unlock();
> > >   *      goto again;
> > 
> > - *      goto again;
> > + *      goto begin;
> 
> Oops, thank you for catching, Matthew!
> 
> 
> Thanks,
> SJ

