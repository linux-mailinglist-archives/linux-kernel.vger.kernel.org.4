Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC6607177
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJUHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJUHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:52:24 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 00:52:20 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4112B23B6BE;
        Fri, 21 Oct 2022 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1666338263; bh=/bx/Se2pkwnaqQwmSRrQ80huEZGnVTvCcra/nmvP43I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=A32PqipNhzxcw0YQfVeJaYjUrKLqlHHtKg/m20hO8GY5jmB0jjjGd8YOHDgV02n6a
         9TVjTX9cvEbzEKsT0VCgXsAYFwgL9vAuwjWFZlV/k/tq9xI256lpu3DQrdOWhfnZtg
         Rmwp4x9Qijer9ZXBvn8ocFPwYftfbywH6w53RF7MlS21qTafs6j2D8R4Uu5yMV+d4X
         a65ZIz2Ne33b6e/QFawRUAxai3elCQNYo89X9pyUH9ikAo4gZ3OQeQi210akNsXe+b
         4fc9Qc9f6kg4vIU368tBDXgp451dzuenAAIcwUSjGvA1y3mOIYR+naet6OszLancUB
         vndw/wRJGtokg==
Received: by gentwo.de (Postfix, from userid 1001)
        id 80D65B00091; Fri, 21 Oct 2022 09:44:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 7EAB7B0002C;
        Fri, 21 Oct 2022 09:44:23 +0200 (CEST)
Date:   Fri, 21 Oct 2022 09:44:23 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH rcu 5/8] slab: Explain why SLAB_DESTROY_BY_RCU reference
 before locking
In-Reply-To: <20221019224659.2499511-5-paulmck@kernel.org>
Message-ID: <03d5730-9241-542d-76c6-728be4487c4@gentwo.de>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1> <20221019224659.2499511-5-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022, Paul E. McKenney wrote:

> It is not obvious to the casual user why it is absolutely necessary to
> acquire a reference to a SLAB_DESTROY_BY_RCU structure before acquiring
> a lock in that structure.  Therefore, add a comment explaining this point.

Sorry but this is not correct and difficult to comprehend.

1. You do not need a reference to a slab object after it was allocated.
   Objects must be properly protected by rcu_locks.

2. Locks are initialized once on slab allocation via a constructor (*not* on object allocation via kmem_cache_alloc)

3. Modifying locks at allocation/free is not possible since references to
   these objects may still persist after free and before alloc.

4. The old term SLAB_DESTROY_BY_RCU is used here.
