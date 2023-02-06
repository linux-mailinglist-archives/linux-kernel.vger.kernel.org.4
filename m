Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5468C817
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBFUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBFUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7132E0C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675716743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqLlmct7lX+JFmd+5pxF8+BD7yXad1T5vU6UwHJMxwY=;
        b=EbVUPG2YEq0LaEWzyoh9Shyd4/UkhoOjyhIsuzrRzIAS13NqSMjpLNuZyC6a+7/aNPKuWu
        WW3jYQ0GtKUoRfJKYgd7l/f5Rit900Xs5f7CFPMGKBuOomeYH0JiZx7+WnmONnPTN32FKx
        93ArRIqlanY7IGIzjdzTijk840xBzpY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-oe-RPAn1NgGDGCRRPyJgAw-1; Mon, 06 Feb 2023 15:52:22 -0500
X-MC-Unique: oe-RPAn1NgGDGCRRPyJgAw-1
Received: by mail-qk1-f199.google.com with SMTP id v186-20020a37dcc3000000b0072a264a6208so8657574qki.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqLlmct7lX+JFmd+5pxF8+BD7yXad1T5vU6UwHJMxwY=;
        b=h5R7NC8zx4BE69sU7uIlk5cKcg5++fzWywxIXlYx/XxM/dSF654i22rJl6z6D+jGNc
         FgL4awF9PWRTBNydAXFwbC/NLhSbExUq6QQAP41+BhSzpRx/J/ifP2KyYNqIQkimJz0t
         En5T7OCu2Rfs914KlBbeyjPRHBJxEaY5J/DtkhEG+5OUxZrNODmpGmloSgRHpDMUw55G
         eGHJQaiqYDTyt5Ts05/pKqAZaesBjwScqZVGSk5e052+E+bhgYICsztFAPJrAekeMvZc
         7pcuC1vsqdIGtOhLMv5m2t9Leyeedu+BAW/RResXig8xhqCCdaMCOG0NtYc0TVxGO+RL
         ag2A==
X-Gm-Message-State: AO0yUKV6fgbFSbh2F5lU8LtCiexdU5V0AEnIs98R2yust4q0yJ0cw1S0
        q/9wdu8S/c+OMYJ4kVGmjsRpci7iZyIW+RArDZwG26y2DZapN2mlVJG1auf42M3yNy2VdUj4yAy
        8xwxk/5X9cc2ZKBOm0clkt3TC
X-Received: by 2002:a05:622a:4b:b0:3b8:6d44:ca7e with SMTP id y11-20020a05622a004b00b003b86d44ca7emr1435594qtw.4.1675716741773;
        Mon, 06 Feb 2023 12:52:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+xt3VpKVSjbng5Isjbb9ILCPJQRmOIPFhgB09Fc0XTzyXKXefEhRFVU+CjRKGOYRPbyw2L9Q==
X-Received: by 2002:a05:622a:4b:b0:3b8:6d44:ca7e with SMTP id y11-20020a05622a004b00b003b86d44ca7emr1435563qtw.4.1675716741494;
        Mon, 06 Feb 2023 12:52:21 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a12aa00b0071d57a0eb17sm7923473qki.136.2023.02.06.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:52:20 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:52:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+Fog2dO1kpRBMvr@x1n>
References: <20230206112856.1802547-1-stevensd@google.com>
 <Y+FOk+ty7OKmkwLL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+FOk+ty7OKmkwLL@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:01:39PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> > This change first makes sure that the intermediate page cache state
> > during collapse is not visible by moving when gaps are filled to after
> > the page cache lock is acquired for the final time. This is necessary
> > because the synchronization provided by locking hpage is insufficient
> > for functions which operate on the page cache without actually locking
> > individual pages to examine their content (e.g. shmem_mfill_atomic_pte).
> 
> I've been a little scared of touching khugepaged because, well, look at
> that function.  But if we are going to touch it, how about this patch
> first?  It does _part_ of what you need by not filling in the holes,
> but obviously not the part that looks at uffd.  
> 
> It leaves the old pages in-place and frozen.  I think this should be
> safe, but I haven't booted it (not entirely sure what test I'd run
> to prove that it's not broken)

That logic existed since Kirill's original commit to add shmem thp support
on khugepaged, so Kirill should be the best to tell.. but so far it seems
reasonalbe to me to have that extra operation.

The problem is khugepaged will release pgtable lock during collapsing, so
AFAICT there can be a race where some other thread tries to insert pages
into page cache in parallel with khugepaged right after khugepaged released
the page cache lock.

For example, it seems to me new page cache can be inserted when khugepaged
is copying small page content to the new hpage.

-- 
Peter Xu

