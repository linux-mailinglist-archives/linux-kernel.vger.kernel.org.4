Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A22374997B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjGFK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E2123
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688639307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWSRtLdme6FJ70IV4C93Q8VXnr5yFBXVr0WOwSgrr+g=;
        b=erTQvC8h8rS8cXO9U5Nx9olT0qHZXZiqPST8Q/hMo/X3U+iwO/Bo66/qMb1O5lS6TbRb91
        JRy0hjwMDI6Smowb8ogvtTEYudH8pdFWEu+jH8MHfmohRpWFZZvTrAY2+EM7Mysfb0H0ae
        BuQ5YvXYINOpnEf2nwNYuL4KkiNTHW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-C_ZbWKdJPQad0nV88K3J4w-1; Thu, 06 Jul 2023 06:28:24 -0400
X-MC-Unique: C_ZbWKdJPQad0nV88K3J4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07D42101A54E;
        Thu,  6 Jul 2023 10:28:24 +0000 (UTC)
Received: from localhost (unknown [10.42.28.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75BEF5CE3;
        Thu,  6 Jul 2023 10:28:23 +0000 (UTC)
Date:   Thu, 6 Jul 2023 11:28:23 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <20230706102823.GO7636@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com>
 <20230705162830.GC17440@redhat.com>
 <20230705215008.GD17440@redhat.com>
 <c4b9f02f-3f6a-74b4-4e0d-3da314f90aa8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b9f02f-3f6a-74b4-4e0d-3da314f90aa8@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 07:30:50AM +0100, Richard Henderson wrote:
> On 7/5/23 22:50, Richard W.M. Jones wrote:
> >tb_invalidate_phys_range_fast() *is* called, and we end up calling
> >   tb_invalidate_phys_page_range__locked ->
> >     tb_phys_invalidate__locked ->
> >       do_tb_phys_invalidate
> >
> >Nevertheless the old TB (containing the call to the int3 helper) is
> >still called after the code has been replaced with a NOP.
> >
> >Of course there are 4 MTTCG threads so maybe another thread is in the
> >middle of executing the same TB when it gets invalidated.
> 
> Yes.
> 
> >tb_invalidate_phys_page_range__locked goes to some effort to check if
> >the current TB is being invalidated and restart the TB, but as far as
> >I can see the test can only work for the current core, and won't
> >restart the TB on other cores.
> 
> Yes.
> 
> The assumption with any of these sorts of races is that it is "as
> if" the other thread has already passed the location of the write
> within that block.  But by the time this thread has finished
> do_tb_phys_invalidate, any other thread cannot execute the same
> block *again*.
> 
> There's a race here, and now that I think about it, there's been mail about it in the past:
> 
> https://lore.kernel.org/qemu-devel/cebad06c-48f2-6dbd-6d7f-3a3cf5aebbe3@linaro.org/
> 
> We take care of the same race for user-only in translator_access, by
> ensuring that each translated page is read-only *before* performing
> the read for translation.  But for system mode we grab the page
> locks *after* the reads.  Which means there's a race.
> 
> The email above describes the race pretty clearly, with a new TB
> being generated before the write is even complete.
> 
> It'll be non-trivial fixing this, because not only do we need to
> grab the lock earlier, there are ordering issues for a TB that spans
> two pages, in that one must grab the two locks in the correct order
> lest we deadlock.

Yes I can see how this is hard to fix.  Even if we just lock the page
containing the first instruction (which we know) before doing
translation, we still have a problem when entering tb_link_page()
where we would need to only lock the second page, which might cause
ordering issues.

How about a new per-page lock, which would be grabbed by
do_tb_phys_invalidate() and tb_gen_code(), just on the first
instruction?  It would mean, I think, that no page can be having TBs
invalidated and generated at the same time.

Or something like scanning the bytes as they are being translated,
generate a secure-ish checksum, then recheck it after translation and
discard the TB if the code changed.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

