Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6032A6A8635
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCBQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCBQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21A34C03
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677774054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xOfU4PlP9FaVWqoxDuTqEGSCMk6PXW1QbyGJ2/dDF0=;
        b=e2W80ARGZ9uVHXsMgQ4pR/k6/7KQr1DBFVjkceclo8Z/8kRnEcqtWLRBM8wfODQFRoRBkW
        LZWOznEgOacIezuDQnxz5WJMHUMQIEtFgHj0qxJ8IswWjPPeG6sc95qLkrkKpzU+etA7Uk
        oGCRtphT65N3PNRzpazORl4M1SkqLv0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-n6HKBBaQNVuci_S--f0DtQ-1; Thu, 02 Mar 2023 11:20:53 -0500
X-MC-Unique: n6HKBBaQNVuci_S--f0DtQ-1
Received: by mail-qt1-f197.google.com with SMTP id c11-20020ac85a8b000000b003bfdd43ac76so6682783qtc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677774051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xOfU4PlP9FaVWqoxDuTqEGSCMk6PXW1QbyGJ2/dDF0=;
        b=c32u8zx4wMrwBhYuLmu2uAMuuln8NWC9Jbs7RmuD5TBDjnXq7btMADvOxiogQ/jnQ9
         GoZVuQXm2AHNvExnoJ1bY09ZZAKAMrULzSgumChIystHv0Cn7TpcZGQFDEWiREVS/uRb
         jWplm66IUaPlbNUsNc2ejPCVOzQRUnyKYmjC1BBfZVh80W6jDg2bni/9O4ozseBVy6M9
         euDI5JDi3jwFycUTxagrMPILL9+4CZ8NsTi1NByiV2s1oZMrG3JqQbMihaljQYswRF83
         s+LFyCXnmwb9V19gb0hxC0td2bBMCZfBTfBbz2AAteloH28iYJj+wl+xaKt1aUCeFz15
         Dh2Q==
X-Gm-Message-State: AO0yUKWbzty8GXW1+YOfyepOc43fiVc7MTe5zz3CxUDNGtGaZTPK4Vhb
        THEGwrjGPGJxZNFwsR9ntmBU6xHm8KF3aKlXFn0UOmXxWz5svdhln7+t+d/mfzQwD6rqFjTE2L9
        2+c2EiO3bUgg0z7XQFVTHxmC3
X-Received: by 2002:a05:622a:34d:b0:3bf:d71e:5b08 with SMTP id r13-20020a05622a034d00b003bfd71e5b08mr20514554qtw.3.1677774051269;
        Thu, 02 Mar 2023 08:20:51 -0800 (PST)
X-Google-Smtp-Source: AK7set9qq3ZPjFIsnOOEXZugxAvUqaHVsX6sqUyPztiC+UlkHco3HAQ8ZWbJPfUT6dNx7Q2La1DP9w==
X-Received: by 2002:a05:622a:34d:b0:3bf:d71e:5b08 with SMTP id r13-20020a05622a034d00b003bfd71e5b08mr20514481qtw.3.1677774050715;
        Thu, 02 Mar 2023 08:20:50 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s184-20020a372cc1000000b0073bb00eb0besm11147177qkh.22.2023.03.02.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:20:50 -0800 (PST)
Date:   Thu, 2 Mar 2023 11:20:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] mm/vmstat: switch counter modification to
 cmpxchg
Message-ID: <ZADM4U49g+g4S5Xf@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.846239718@redhat.com>
 <3331790c-95a1-6ab9-2667-86aae3d28d7d@redhat.com>
 <ZAC3BxPIxAplvTzT@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAC3BxPIxAplvTzT@tpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:47:35AM -0300, Marcelo Tosatti wrote:
> So it will be:
> 
> #ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> mod_zone_page_state
> inc_zone_page_state
> dec_zone_page_state
> mod_node_page_state
> inc_node_page_state
> dec_node_page_state
> __mod_zone_page_state (new function, calls mod_zone_page_state).
> __mod_node_page_state (new function, calls mod_node_page_state).
> __inc_zone_page_state
> __inc_node_page_state
> __dec_zone_page_state
> __dec_node_page_state
> #else
> __mod_zone_page_state (old, shared function for both CONFIG_HAVE_CMPXCHG_LOCAL and not)
> __mod_node_page_state
> __inc_zone_page_state
> __inc_node_page_state
> __dec_zone_page_state
> __dec_node_page_state
> mod_zone_page_state
> inc_zone_page_state
> dec_zone_page_state
> mod_node_page_state
> inc_node_page_state
> dec_node_page_state
> #endif
> 
> Any suggestion on how to split this into multiple patchsets for easier
> reviewing? (can't think of anything obvious).

I figured this out before saw this, but it did take me some time to read
carefully into the code base..  maybe it'll be a good idea to mention
something like above in the commit message to ease future reviewers (and
more likelyhood to attract the experts to start chim in)?

One fundamental (but maybe another naive.. :) question on this code piece
(so not directly related to the changeset but maybe it is still..):

AFAICT CONFIG_HAVE_CMPXCHG_LOCAL only means we can do cmpxchg() without
locking memory bus, however when !CONFIG_HAVE_CMPXCHG_LOCAL here we're not
using non-local version but using preempt_disable_nested() to make sure the
read is atomic.  Does it really worth it?  What happens if we use cmpxchg()
unconditionally, but just use local (e.g. no "LOCK" prefix) version when
CONFIG_HAVE_CMPXCHG_LOCAL?

-- 
Peter Xu

