Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EF5F1866
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiJABZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiJABZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D121B5EE7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVbTStlwC6pTMq+P37M/ALkgq/u7RMkS0BdQLCeN6Hg=;
        b=O9DlKuaq9166RaGROy4pj/Dx6tigCbWcN8ITaG/rRWt/izNqK1L5TAx1bw2hhV7KFdC/Kh
        0pFgLodcJIBYMC5THONJf07Lt/tYrU1mNNBYaRRlO9+0b1b2NU3VGsM4nBeKGt5pF2Jm2H
        TNzxZdW+hUZ/6vuxi+2ODZ7X6DCjJHk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-oTbOKWjaPXid_8_0dMeVfA-1; Fri, 30 Sep 2022 21:23:09 -0400
X-MC-Unique: oTbOKWjaPXid_8_0dMeVfA-1
Received: by mail-qk1-f199.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so4973538qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DVbTStlwC6pTMq+P37M/ALkgq/u7RMkS0BdQLCeN6Hg=;
        b=DVWuME6uKq6PZzbNetlF92PrRAL8pkJ6Uy4paS1u/1myXcZ7z4phlIR4DTQ8saC/Kn
         JqozZSmW7CbeFBxgij5TJIaB9fQEa902Fk1QmHgfvyOy4cW4njhf2DSA1N9IyeDhm8QZ
         Zt7Q2SoPKI+GqOhlFDchwx+wwC3JXhy2GN7BG5B3HRvvQ2Ejg6V3dtUxAB4NvcGSQEk9
         TfkqHZ/GLW9x29WwkNGL4/TwpxztsXOR+eRhsv9CdJscBXjK6zzSVW35RefvN5r2IGN8
         Oa09dXCtjbt4wUUR2QsBXDGExEs6r4kjNIkboz9nhSHSjzOuZTnaHhrckWjsNBTV1La0
         gkSw==
X-Gm-Message-State: ACrzQf1UOsAj8ysbVpoNB4xFo+YmkwoqUJyIDUwEgHecHynuKAmxSEJ7
        42SClgMSRGK4orGQEyx2f0edFvuDWwV9RW2y6OYxSXN8ogLYNKuvGeNd3Jchqfyo44kv8tkNpUs
        OQH0vog6vIHUQ0NfFNzrqa52k
X-Received: by 2002:ac8:7f48:0:b0:35b:bac4:c472 with SMTP id g8-20020ac87f48000000b0035bbac4c472mr8985699qtk.442.1664587389514;
        Fri, 30 Sep 2022 18:23:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VuQVKY5fLsLbzl4g/Glj+K38DAyT8Qy+Xx4IhK30VygSWMCJjiuLCyKLN3eoRqM7sSs2w/Q==
X-Received: by 2002:ac8:7f48:0:b0:35b:bac4:c472 with SMTP id g8-20020ac87f48000000b0035bbac4c472mr8985687qtk.442.1664587389189;
        Fri, 30 Sep 2022 18:23:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id r24-20020ae9d618000000b006ced196a73fsm4009510qkk.135.2022.09.30.18.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:23:08 -0700 (PDT)
Date:   Fri, 30 Sep 2022 21:23:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Edward Liaw <edliaw@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [syzbot] WARNING in change_protection
Message-ID: <YzeWe/1D6L8uuP/o@x1n>
References: <00000000000046580505e9dea8e4@google.com>
 <20220930164211.b8215770d44e1a3803f1e660@linux-foundation.org>
 <YzeR+R6b4bwBlBHh@x1n>
 <20220930181415.31c2ee66166d4e1c6c0eac64@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930181415.31c2ee66166d4e1c6c0eac64@linux-foundation.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 06:14:15PM -0700, Andrew Morton wrote:
> On Fri, 30 Sep 2022 21:03:53 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > When PTE_MARKER_UFFD_WP not configured, it's still possible to reach pte
> > marker code and trigger an warning. Add a few CONFIG_PTE_MARKER_UFFD_WP
> > ifdefs to make sure the code won't be reached when not compiled in.
> 
> Thanks.
> 
> Is 679d10331910180 ("mm: introduce PTE_MARKER swap entry") the
> appropriate Fixes: target?

I forgot the stable notations, sorry.  Probably better use the one that
enables the whole thing, because the diff will touch a few patches later
than 679d10331910180 too, which means the suitable tag could be:

Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")

> 
> Should we backport to -stable?

Yes, 5.19 may need it too (if it'll still squeeze into 6.0; or 6.0 too).

-- 
Peter Xu

