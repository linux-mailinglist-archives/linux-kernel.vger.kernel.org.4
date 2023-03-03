Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7DD6A9974
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCCOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCCOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6FEA27D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677853982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q66WHdU6x/5niRu8KQgKedZzzbjzv2x/XG5j8JQ+CoA=;
        b=crjPWUBwIOWkE9TQu0VPdTs7QAp8GkV2KCzdZuRskRTydHAf7mCMO63916GFKU1MGCfRsz
        VuaScBwPrEz8HxE6xpZQ/BP/p/8ZdvJlfYJFHSFstje4SifssHO6Bpny4vVN11xmK0ua2g
        PDC30eYVFHcVULw4vsGnYWZJhRkC2YA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-ByGN3uGnOTWaE2LvR2YDTQ-1; Fri, 03 Mar 2023 09:32:59 -0500
X-MC-Unique: ByGN3uGnOTWaE2LvR2YDTQ-1
Received: by mail-qv1-f69.google.com with SMTP id d27-20020a0caa1b000000b00572765a687cso1480372qvb.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q66WHdU6x/5niRu8KQgKedZzzbjzv2x/XG5j8JQ+CoA=;
        b=1+55IveNgjT6aComZ356XHcYkLtj0Q7TE+kagwAZfsc9J1dbLtuzRdmMdehmFopms/
         hXq6xZ6rBv/WpLleH/slvJJK/sa/Z5jWQntWqCJeutOk7eIERv/H8n5OdPy87U+tayQj
         eEYWH37neVj0+P8D4MJCBFZKk2XA6GUqv0PRqXjkRXbpOJdRIp4NRjMe8I7U7j0kN69j
         wxA7CI8D05zGwUsfEj0SIu92glGZXpn3mW5HBW7fqYY5Cuo8LS5sJjCrIzyap2mR4BaD
         dbh6VnuSVIL5rWuaJk2snmOp9Pc1CsrVHDx+2ceALuBmeOff2eAnYy4Og/E5zECCThi7
         wpZg==
X-Gm-Message-State: AO0yUKWm17/6UEL8MdqXaK7slKpwT8TLaM33uQtBv4vrcIn+wXkqzb7q
        dT6sl2mhGqjN7qjsIDaqlE6rKpR3hR7SuskbkhkD8zP+h895EiiAYeOr3Gx3f4hXksaA6Kb+rQO
        cTvE2lajTb9uQ9SfFaiZslXmO
X-Received: by 2002:a0c:ab08:0:b0:572:8e20:bd7 with SMTP id h8-20020a0cab08000000b005728e200bd7mr3020926qvb.4.1677853978779;
        Fri, 03 Mar 2023 06:32:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8sglo/FoEi7ArTGXrvY2lrstmRXOGbl0sDhxp1sccLW2w68eyU8sdQoQ8QrMekMlObdcXa5w==
X-Received: by 2002:a0c:ab08:0:b0:572:8e20:bd7 with SMTP id h8-20020a0cab08000000b005728e200bd7mr3020876qvb.4.1677853978434;
        Fri, 03 Mar 2023 06:32:58 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id l11-20020a37f90b000000b0073ba92629e1sm1814677qkj.23.2023.03.03.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:32:57 -0800 (PST)
Date:   Fri, 3 Mar 2023 09:32:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v1] mm/userfaultfd: propagate uffd-wp bit when
 PTE-mapping the huge zeropage
Message-ID: <ZAIFGAmNzKtTMES3@x1n>
References: <20230302175423.589164-1-david@redhat.com>
 <ZAEjXqNH+U8p9fOG@x1n>
 <95b0a3dd-b6f9-0305-759c-b715359b0cab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95b0a3dd-b6f9-0305-759c-b715359b0cab@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:12:26AM +0100, David Hildenbrand wrote:
> On 02.03.23 23:29, Peter Xu wrote:
> > On Thu, Mar 02, 2023 at 06:54:23PM +0100, David Hildenbrand wrote:
> > > Currently, we'd lose the userfaultfd-wp marker when PTE-mapping a huge
> > > zeropage, resulting in the next write faults in the PMD range
> > > not triggering uffd-wp events.
> > > 
> > > Various actions (partial MADV_DONTNEED, partial mremap, partial munmap,
> > > partial mprotect) could trigger this. However, most importantly,
> > > un-protecting a single sub-page from the userfaultfd-wp handler when
> > > processing a uffd-wp event will PTE-map the shared huge zeropage and
> > > lose the uffd-wp bit for the remainder of the PMD.
> > > 
> > > Let's properly propagate the uffd-wp bit to the PMDs.
> > 
> > Ouch.. I thought this was reported once, probably it fell through the
> > cracks.
> 
> Yes, I reported it a while ago, but our understanding back then was that
> primarily MADV_DONTNEED would trigger it (which my reproducer back then
> did), and e.g., QEMU would make sure to not have concurrent MADV_DONTNEED
> while doing background snapshots.
> 
> I realized only yesterday when retesting my patch that that a simple
> unprotect is already sufficient to mess it up.

IIRC the rational was it was fine for the original design because we didn't
plan to protect none ptes, so missing zero ptes would be the same as none,
which was not a problem.

However that'll just make apps like QEMU stops working when they want to
trap none ptes by using a round of pre-read, then the workaround will not
work either.  Copy stable will make the workaround also work for stables.

-- 
Peter Xu

