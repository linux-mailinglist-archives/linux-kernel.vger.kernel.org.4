Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7167133F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjE0KMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjE0KMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647AA10A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685182303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/CNOzVzf+mDbz4pPw1e7KenPWxmonVbCLBoJp3uezg=;
        b=hJC7YQyedrjszCh46qIKz54mTVClcAFM/btQiTnkrHHlLHanw7gsx1EYEY0+Xxv3W7L6kt
        rtWz+mQDnXAkXrYKgzqD4+vCFhOVt77q3PsOSZif2+7LwzpEg6crMSL/tZJEXtOOubuewE
        hTNJ9HVQ26wAkj5+OnRBl6aItHdg+9o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-BkoVgVm-NWiDAV7G7SpEBg-1; Sat, 27 May 2023 06:11:34 -0400
X-MC-Unique: BkoVgVm-NWiDAV7G7SpEBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3560D38117F0;
        Sat, 27 May 2023 10:11:34 +0000 (UTC)
Received: from localhost (ovpn-12-70.pek2.redhat.com [10.72.12.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45376140E954;
        Sat, 27 May 2023 10:11:32 +0000 (UTC)
Date:   Sat, 27 May 2023 18:11:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Message-ID: <ZHHXUd0KPbsvrZlV@MiWiFi-R3L-srv>
References: <20230524082424.10022-1-lstoakes@gmail.com>
 <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
 <b87ff2af-c89d-4ddd-8992-2ffb337fbe0c@lucifer.local>
 <ZHB0UTEYUMZVa23V@MiWiFi-R3L-srv>
 <368bbc1d-d810-4bc4-8091-7ed55631344f@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368bbc1d-d810-4bc4-8091-7ed55631344f@lucifer.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26/23 at 10:10am, Lorenzo Stoakes wrote:
> On Fri, May 26, 2023 at 04:56:49PM +0800, Baoquan He wrote:
> > > Umm, the function literally opens with:-
> > >
> > > 	/*
> > > 	 * Skip populated array elements to determine if any pages need
> > > 	 * to be allocated before disabling IRQs.
> > > 	 */
> > > 	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
> > > 		nr_populated++;
> >
> > OK, suppose page_array[] alreasy has three pages populated, if not
> > initialized and there's garbage data in page_array[], it could have
> > nr_populated > 3 finally? This is really risky.
> >
> > >
> > > And then later:-
> > >
> > > 		/* Skip existing pages */
> > > 		if (page_array && page_array[nr_populated]) {
> > > 			nr_populated++;
> > > 			continue;
> > > 		}
> >
> > This is interesting, I thought this place of nr_populated checking and
> > updating is meaningless, in fact it's skipping the element with vlaue
> > in the middle of page_array. I realize this when I recheck the code when
> > replying to your mail. Not sure if we should restrict that, or it's
> > really existing reasonablly.
> >
> > [x][x][x][][][][x][x][][]
> > x marks the element pointing to page.
> 
> All of this is fine, the caller is expected to provide a zeroed array or an
> array that contains existing elements. We only need to use it with a zeroed
> array. We zero the array. Problem solved. Other users use the 'already
> allocated pages' functionality, we don't care.
> 
> >
> > >
> > > This explicitly skips populated array entries and reads page_array to see
> > > if entries already exist, and literally documents this in the comments
> > > above each line, exactly as I describe.
> >
> > OK, I misread your words in log. While page_array[] is still output
> > parameter, just not pure output parameter? Not sure if I understand
> > output parameter correctly.
> 
> Well, output implies output i.e. writing to something. If you also read it,
> it's not just an output parameter is it?
> 
> I don't really want to get into semantics here, the point is the test's
> expectation is that it'd be write-only and it's not so we have to zero the
> array, that's it.
> 
> >
> > Well, I meant adding sentence above __alloc_pages_bulk() to tell:
> > page_array[] could have garbage data stored if you don't initialize
> > it explicitly before calling __alloc_pages_bulk();
> >
> 
> As I said I literally state in multiple places this is about needing to
> initialise the array:-
> 
>     lib/test_vmalloc.c: avoid garbage in page array
> 
> ...
> 
>     This is somewhat unexpected and breaks this test, as we allocate the pages
>     array uninitialised on the assumption it will be overwritten.
> 
> ...
> 
>     We solve both problems by simply using kcalloc() and referencing
>     sizeof(struct page *) rather than sizeof(struct page).
> 
> So I completely disagree we need to add anything more.
> 
> > This could happen in other place if they don't use kcalloc(),
> > kmalloc(GFP_ZERO) or something like this to allocate page_array[]?
> 
> We don't care? I'm fixing a test here not auditing __alloc_bulk_array().
> 
> > > A broader problem we might want to think about is how little anybody is
> > > running this test in order that it wasn't picked up before now... obviously
> > > there's an element of luck as to whether the page_array happens to be
> > > zeroed or not, but you'd think it'd be garbage filled at least a reasonable
> > > amount of the time.
> >
> > Hmm, that's why we may need notice people that there's risk in
> > __alloc_pages_bulk() if page_array[] is not initialized and the garbage
> > could be mistaken as a effective page pointer. My personal opinion.
> > People may argue it's caller's responsibility to do that.
> >
> > Thanks
> > Baoquan
> >
> 
> That's just irrelevant to this change. You're also not replying to my point here
> (that we're clearly not running this test very much).
> 
> I find this review super bikesheddy. Let's try not to bog things down in
> lengthily discussions when literally all I am doing here is:-
> 
> 1. Function expects a zeroed array
> 2. Change the code to zero the array
> 3. Change the array to be smaller since it only needs to store pointers
> 
> It's a two line change, can we try to be a little proportionate here?

Yes, I digressed from the patch itself. At the beginning, I truly didn't
understand why __alloc_bulk_array() would break the test. Sorry for
wasting your time.

While I have to say this is a great fix. As you said, people usually don't
run this test much. I guess maintainer like Uladzislau or you could run
the test to see if the whole code is working well. However, correct
testing code is also very important. If people read testing code, she/he
will know how the interface is used. Sometime if I am not sure about
some code writing, as a vim+ctags+cscope user, I will git grep or use
cscope to search, the testing code is also a good example to refer to.

> 
> You're not even giving me a tag because... I'm not auditing all uses of
> __alloc_bulk_array() or something? Seriously.

I am usually passive when adding a tag as long as the patch has been
acked by other people, or have been picked up by maintainer. Especially
in MM and kdump I maintained, if Andrew has taken the patch, I will
not add tag because I don't want to take up his time to add that tag.
Doing this because Andrew has been helping to merge kexec/kdump patches,
and he creates a very open and harmonious environment for us to study
code and review patch. I always suggest any newcomer to start from MM
and post patch to MM because people from maintainers to reviewers are
very friendly and very proactive.

But now I realize being passive on adidng tag is not good. People could
misunderstand I oppose or still have concern. From now on, I will add
tag as long as I agree on the patch, then expand the discussion if
people would like to.

