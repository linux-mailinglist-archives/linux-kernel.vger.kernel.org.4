Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2F7264F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbjFGPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbjFGPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85010D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686152626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spKLLuP6O+r1s/hdstXAgJMud94UgSfX2gIBHfXK4vw=;
        b=Gv+ltwYGIzfjBQUMNm2UhE0IdwRYEBicPIwSEttR/iUGigdvnG5KndWnPA3VU3on1GCS7n
        msDq9jetfzUt45PB/6Y9jv5hkM8VkpfN+rlfy0yt3Fp8C0vAs60NfK7JbMCAXLPgj23SWk
        kC6QsWnUYqoTmvCbX7KNQ5fV6KRjOwg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-jbIJJPiEMtCc5fu10bQt1Q-1; Wed, 07 Jun 2023 09:42:03 -0400
X-MC-Unique: jbIJJPiEMtCc5fu10bQt1Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75edaf118b4so103926485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145323; x=1688737323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spKLLuP6O+r1s/hdstXAgJMud94UgSfX2gIBHfXK4vw=;
        b=TTjOWzw9F7ZGkh6AqAX0i/rWs8YRHxKZ+ghVR/7nHZqAW69cjcsAMeHGH93oa7T4WC
         BwhRioxRPFQQUXjBu/XfSpnC28Wa4eqlpgF+eScL/cf3K7tObPy/7SLSwFfPlEzo3oOt
         ZwQa6JZNYnGRuO9VCzqfKu6Tot0gbLv9ooDAmruLxR0hfadXjZuAx+SigoPt41y0GjMk
         FmHcMdghFb4OQLjRbU9vXPHactC5AaaRJBB65Gr2BNMBeGGBNrTuf1V4hzZPiyzr9Chz
         S+b7Ydi8liv8vImmaixRYiR4wN1eHJRHu6o2TUhTLgYsYWh0RrcQeeZRuRC/vY4RDD3N
         D2tw==
X-Gm-Message-State: AC+VfDwRC2SQnpIvutchxgZlSx9zJjOIsxUXB7oPsoLCt92yqz0GfxsA
        ulKUsOu5a+FULxWKNpz6Va7II6QOddOr49fSYdT8gFMEOkLwZ8KhfexlZZ8nXcZiEmi+cL0fbIs
        CFss8suw2fFH4sQY2uWI3z9Qa
X-Received: by 2002:a05:620a:8d1:b0:75e:c57b:474c with SMTP id z17-20020a05620a08d100b0075ec57b474cmr2068450qkz.13.1686145323170;
        Wed, 07 Jun 2023 06:42:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5l7U5JgSV5T13cY5RpvTXXPfzQF/3Pku47suOZclV2+2Jk7neTSNpvNSmo/U6zAtW9LufRcg==
X-Received: by 2002:a05:620a:8d1:b0:75e:c57b:474c with SMTP id z17-20020a05620a08d100b0075ec57b474cmr2068424qkz.13.1686145322889;
        Wed, 07 Jun 2023 06:42:02 -0700 (PDT)
Received: from optiplex-fbsd (c-73-249-122-233.hsd1.nh.comcast.net. [73.249.122.233])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a11b900b0075c9e048b19sm3139720qkk.29.2023.06.07.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:42:02 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:41:59 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] writeback: fix dereferencing NULL mapping->host on
 writeback_page_template
Message-ID: <ZICJJxBtxoy_Jz8u@optiplex-fbsd>
References: <20230606233613.1290819-1-aquini@redhat.com>
 <20230606174448.ba45510067bcb35b9ac7e739@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606174448.ba45510067bcb35b9ac7e739@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:44:48PM -0700, Andrew Morton wrote:
> On Tue,  6 Jun 2023 19:36:13 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > When commit 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for
> > wait_on_page_writeback()") repurposed the writeback_dirty_page trace event
> > as a template to create its new wait_on_page_writeback trace event, it
> > ended up opening a window to NULL pointer dereference crashes due to
> > the (infrequent) occurrence of a race where an access to a page in the
> > swap-cache happens concurrently with the moment this page is being
> > written to disk and the tracepoint is enabled:
> 
> I don't see what the race is, or why a race is involved.
> 
> >     BUG: kernel NULL pointer dereference, address: 0000000000000040
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 800000010ec0a067 P4D 800000010ec0a067 PUD 102353067 PMD 0
> >     Oops: 0000 [#1] PREEMPT SMP PTI
> >     CPU: 1 PID: 1320 Comm: shmem-worker Kdump: loaded Not tainted 6.4.0-rc5+ #13
> >     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-1.fc37 03/01/2023
> >     RIP: 0010:trace_event_raw_event_writeback_folio_template+0x76/0xf0
> >     Code: 4d 85 e4 74 5c 49 8b 3c 24 e8 06 98 ee ff 48 89 c7 e8 9e 8b ee ff ba 20 00 00 00 48 89 ef 48 89 c6 e8 fe d4 1a 00 49 8b 04 24 <48> 8b 40 40 48 89 43 28 49 8b 45 20 48 89 e7 48 89 43 30 e8 a2 4d
> >     RSP: 0000:ffffaad580b6fb60 EFLAGS: 00010246
> >     RAX: 0000000000000000 RBX: ffff90e38035c01c RCX: 0000000000000000
> >     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e38035c044
> >     RBP: ffff90e38035c024 R08: 0000000000000002 R09: 0000000000000006
> >     R10: ffff90e38035c02e R11: 0000000000000020 R12: ffff90e380bac000
> >     R13: ffffe3a7456d9200 R14: 0000000000001b81 R15: ffffe3a7456d9200
> >     FS:  00007f2e4e8a15c0(0000) GS:ffff90e3fbc80000(0000) knlGS:0000000000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000000000000040 CR3: 00000001150c6003 CR4: 0000000000170ee0
> >     Call Trace:
> >      <TASK>
> >      ? __die+0x20/0x70
> >      ? page_fault_oops+0x76/0x170
> >      ? kernelmode_fixup_or_oops+0x84/0x110
> >      ? exc_page_fault+0x65/0x150
> >      ? asm_exc_page_fault+0x22/0x30
> >      ? trace_event_raw_event_writeback_folio_template+0x76/0xf0
> >      folio_wait_writeback+0x6b/0x80
> >      shmem_swapin_folio+0x24a/0x500
> 
> shmem_swapin_folio->folio_wait_writeback will always pass in a page
> which has ->mapping==NULL, won't it?  So why doesn't it crash every
> time?
>

Hey Andrew,

Here's why we end up looking at the swapper_spaces[] address space, for
this particular case:

void folio_wait_writeback(struct folio *folio)
{
    while (folio_test_writeback(folio)) {
        trace_folio_wait_writeback(folio, folio_mapping(folio));
            struct address_space *folio_mapping(struct folio *folio)
            ... 
                if (unlikely(folio_test_swapcache(folio)))
                    return swap_address_space(folio_swap_entry(folio));

when the shmem swap-in path stumbles on a page in the swapcache that is still
under its way to disk (via swap_writepage->swap_writepage_bdev_async->submit_bio)
the tracepoint, will get a swap_address_space pointer back from folio_mapping()



