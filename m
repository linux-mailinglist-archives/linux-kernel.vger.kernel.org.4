Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376E6E4F32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDQR1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDQR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:27:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7F44B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE51661169
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407CAC433EF;
        Mon, 17 Apr 2023 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681752419;
        bh=vEWkokyirFhRtj/YWmCPS6fJqqBTAPVAZdVM7XsRP/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBxoJpT0UWy+yulrd7i+AZtLb5bXUGAskJS7oq6+UWBmmMZ877YDw4x+r9MwtZmyI
         0j1Hvv/qv3Orw3IyN6R7EvroVejgIuOAoVHRNOqZMDL+hpXKFstPU47B0+7pK7WKDx
         AOQ1LL/ao2tlosTkutFq/WvFZxxC53zIy2FSdywpfxTVjfKc4v+7fqWBjWaop2aIgH
         TWVrMII8IuJBi/U8+uU++ECPHN9lU+QVS3q048J8xcmsS/jmA0k2YpXElKyy8+EplF
         flqXtop7yryfuXpm7OwOFWaWKMf7nl8RIUchQDbSW6k9Qd3znSMemRXYN9Bqnw9B1g
         m5LA6PpkNePuA==
From:   SeongJae Park <sj@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Mon, 17 Apr 2023 17:26:57 +0000
Message-Id: <20230417172657.21925-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e2561303-8853-7e16-7eba-001415d34e09@suse.cz>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On Mon, 17 Apr 2023 13:05:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/15/23 05:31, SeongJae Park wrote:
> > The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
> 
> Since "tiny RCU" means something quite specific in the RCU world, it can be
> confusing to read it in this sense. We could say e.g. "... snippet uses a
> single RCU read-side critical section for retries"?

Looks much better, thank you for this suggestion!

> 
> > read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> > similar example code snippet, and commit da82af04352b ("doc: Update and
> > wordsmith rculist_nulls.rst") has broken it.
> 
> "has broken it" has quite different meaning than "has broken it up" :) I
> guess we could just add the "up", unless someone has an even better wording.

Good point, thank you for your suggestion!

I will apply above suggestion on the next spin.


Thanks,
SJ

> 
> > Apply the change to
> > SLAB_TYPESAFE_BY_RCU example code snippet, too.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/linux/slab.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index b18e56c6f06c..6acf1b7c6551 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -53,16 +53,18 @@
> >   * stays valid, the trick to using this is relying on an independent
> >   * object validation pass. Something like:
> >   *
> > + * begin:
> >   *  rcu_read_lock();
> > - * again:
> >   *  obj = lockless_lookup(key);
> >   *  if (obj) {
> >   *    if (!try_get_ref(obj)) // might fail for free objects
> > - *      goto again;
> > + *      rcu_read_unlock();
> > + *      goto begin;
> >   *
> >   *    if (obj->key != key) { // not the object we expected
> >   *      put_ref(obj);
> > - *      goto again;
> > + *      rcu_read_unlock();
> > + *      goto begin;
> >   *    }
> >   *  }
> >   *  rcu_read_unlock();
> 
