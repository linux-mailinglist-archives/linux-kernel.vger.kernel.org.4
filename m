Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC8736EED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjFTOl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjFTOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305041704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687272068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WB8Vx98WvIjwMvhjoGyjOvYXmiTaWo9Rv7qQZH0kMH0=;
        b=WLIzZjwUvKkbR4qv5GvewlHWO+ETam75Z0GnjnX9wh7p4OwVB7Qd+bJhzxysvejynHlaEA
        acn8YJ/PGpenr0PDkU28mBiYfpTNr5sdb8LIVb0aFHcZ2hvh/ru3KJBKUV+aDeCEy/WjF9
        SuVsFVG2eB6QzvfiJGBrscjRTirmlCo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-ZKWzdgM9Or6nvTtR4SIh3w-1; Tue, 20 Jun 2023 10:41:04 -0400
X-MC-Unique: ZKWzdgM9Or6nvTtR4SIh3w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62ff893f03bso11554316d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272059; x=1689864059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB8Vx98WvIjwMvhjoGyjOvYXmiTaWo9Rv7qQZH0kMH0=;
        b=G0wAIetiZW/jkA3bqWrgWYJuEZ7f/vZtMZznoOMpY11nyfjjW65SA+XTQcNX52lC1/
         Q84r2HvSJDQV7XprFpdRENm/nxh3OJqRdebK7Qn4roobTlkb4rl8daAIesmYE5aBrazm
         ABPmz0SGyyjl8SckmiEo0rGYcNTGOUg0mCEA+e3Wiqnx0eXkCQ+6q/ngHIhq/cqgLu8H
         pKyU+zAdftpzZHHp84XILqhGGuQvdQDCLeis8/SLADhQcqMoDb7+7yVNzeO5pdXCxfqD
         UsrwLS2aI2e3Iodq0IaT2q1I5zfs5J2TlFVStq/lL3gJvjL4Hkvyt83ilEy2mKyfXZxA
         JRhQ==
X-Gm-Message-State: AC+VfDw/z9Th4UREFZWmZZHWPuf31jFgW/NQri1ueFNtqbCQsmeArrdK
        XkPCQ0Wyu53KBxZELkI9AAgdyMTcqcs/4iWxZk7O9mA2VbUj1g1qsBim/nAwdtXvmEBEYLVZuJc
        +MB33FA6EHhIeFykeTsODvhKW
X-Received: by 2002:a05:6214:4111:b0:62a:cc88:1d44 with SMTP id kc17-20020a056214411100b0062acc881d44mr15480062qvb.4.1687272058915;
        Tue, 20 Jun 2023 07:40:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MQslOGdENtUV83YCcbGTXm2X2WKuRXg/EMIbpWXEy8JVVimj/zHdBOW33duoyJqF+au08aA==
X-Received: by 2002:a05:6214:4111:b0:62a:cc88:1d44 with SMTP id kc17-20020a056214411100b0062acc881d44mr15480045qvb.4.1687272058612;
        Tue, 20 Jun 2023 07:40:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id d5-20020ad450a5000000b0062ffcda34c6sm1267657qvq.137.2023.06.20.07.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:40:58 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:40:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/7] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
Message-ID: <ZJG6eDZNZFf4Xs7a@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-4-peterx@redhat.com>
 <ZJDMFDUZdGngQbzw@x1n>
 <24f4a22e-7d3b-544b-320f-bba5abb92285@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24f4a22e-7d3b-544b-320f-bba5abb92285@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:01:23AM +0200, David Hildenbrand wrote:
> On 19.06.23 23:43, Peter Xu wrote:
> > On Tue, Jun 13, 2023 at 05:53:42PM -0400, Peter Xu wrote:
> > > @@ -6506,6 +6507,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > >   		 * because we hold the ptl lock and have verified pte_present().
> > >   		 */
> > >   		WARN_ON_ONCE(try_grab_page(page, flags));
> > > +		*page_mask = huge_page_mask(h);
> > 
> > Sorry, I was wrong this line.  It should be:
> > 
> > 		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;
> > 
> 
> That's ... surprising. It feels like either page_mask or huge_page_mask()
> has a misleading name ....
> 
> h->mask = ~(huge_page_size(h) - 1);
> 
> 
> For PMDs, we do
> 
> ctx->page_mask = HPAGE_PMD_NR - 1;
> 
> 
> Maybe
> 
> *page_mask = PHYS_PFN(huge_page_size(h)) - 1;
> 
> Would be clearer.

Since I just posted a new version.. I'll see whether I should get that
cleaned up in a new one.

> 
> I guess "page_mask" should actually be "pfn_mask" ... but the meaning
> regarding PAGE_MASK are still inverted ...

Yes, pfn_mask can be at least slightly better.  I can add a patch to rename
it, or we can also do it on top as cleanups.

Thanks,

-- 
Peter Xu

