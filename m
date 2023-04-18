Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1DF6E67DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDRPPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEFAF17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681830881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEbLiIoDuJvtlF8aE44HZGzs1BH3gYE48UCaK8yzhWk=;
        b=XpQQxR9J9MM1BrrOxyHgk2Kh5rliwoG9NNURxMOrVCdnagSCBb8JNk/eDd1itXyjGkDcKr
        CnLYcGuQGRYUW5+51sZR0qfFxIcCue1D1/E+Fx9ORr6GKIc7zxSK1sc+I6mzy67ZQgnupo
        syXJKWDphzYoqyw+6ypzpp9TEO+0Rus=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-FVzIqMigP-eBeHQuQImJLg-1; Tue, 18 Apr 2023 11:14:40 -0400
X-MC-Unique: FVzIqMigP-eBeHQuQImJLg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74d96c33de9so59662185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830879; x=1684422879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEbLiIoDuJvtlF8aE44HZGzs1BH3gYE48UCaK8yzhWk=;
        b=N6vZTzW5P5x5Q9FMMPxNd+JkS7h103XGp5EMgtsvjQ3NoutpKXSvw+BiD7tASbA6L9
         4gj3Fjn38iESJiZUfH5NjvGK+UnRPuwvbuuqaONt28CshAddFXjuSTsZn20YZFE58LF+
         yh5xDANdAFFzRJ2azvpP3dR+n7meLWes7oW5TqUoOQZcUHMQUWx0a8Rt4t/26nlV7FH6
         JWf4lyyLsRAHomp/IikRiB4riol/kpeFLFrwNzCp0rLezuiGRv9yoJbzjzv8KegiAYIv
         q+FbOAdrZLVXRgFteKXrDnvqINNkGxXpsT7mEvdU8m5F0MjZnBHeCb4ZW/KKdFADg+1N
         66vA==
X-Gm-Message-State: AAQBX9dI/Zd7yCANu9y5FWSFHdo78HGo5+Xz1DM6fjTY6FwoTI/T2G1I
        +zu6MGbCu0uCAtWC8kOxs5CzeawGjO2uhy77ki8GVsRDUvl8JfE3sA8KlsQLkDuylt24sen+dfu
        TQu9N7v12iguu3NhJaW3ZRPsw
X-Received: by 2002:a05:6214:5083:b0:5df:4d41:9560 with SMTP id kk3-20020a056214508300b005df4d419560mr22254099qvb.0.1681830879175;
        Tue, 18 Apr 2023 08:14:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YD3hvqu4HP1QYUapVVZAP70gpGlHotyWRVct/+loHGkFxeWCZKiFOvGtf3pTAp4HTKgbicLw==
X-Received: by 2002:a05:6214:5083:b0:5df:4d41:9560 with SMTP id kk3-20020a056214508300b005df4d419560mr22254071qvb.0.1681830878851;
        Tue, 18 Apr 2023 08:14:38 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mf10-20020a0562145d8a00b005dd8b9345d2sm3730109qvb.106.2023.04.18.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:14:37 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:14:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] mm/hugetlb: Fix uffd-wp bit lost when unsharing
 happens
Message-ID: <ZD6z3Af9LKO7pvN+@x1n>
References: <20230417195317.898696-1-peterx@redhat.com>
 <20230417195317.898696-3-peterx@redhat.com>
 <20230417164822.d1f5d162115c53aab4c85e85@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417164822.d1f5d162115c53aab4c85e85@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

On Mon, Apr 17, 2023 at 04:48:22PM -0700, Andrew Morton wrote:
> On Mon, 17 Apr 2023 15:53:13 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > When we try to unshare a pinned page for a private hugetlb, uffd-wp bit can
> > get lost during unsharing.  Fix it by carrying it over.
> > 
> > This should be very rare, only if an unsharing happened on a private
> > hugetlb page with uffd-wp protected (e.g. in a child which shares the same
> > page with parent with UFFD_FEATURE_EVENT_FORK enabled).
> 
> What are the user-visible consequences of the bug?

When above condition met, one can lose uffd-wp bit on the privately mapped
hugetlb page.  It allows the page to be writable even if it should still be
wr-protected.  I assume it can mean data loss.

However it's very hard to trigger. When I wrote the reproducer (provided in
the last patch) I needed to use the newest gup_test cmd introduced by David
to trigger it because I don't even know another way to do a proper RO
longerm pin.

Besides that, it needs a bunch of other conditions all met:

        (1) hugetlb being mapped privately,
        (2) userfaultfd registered with WP and EVENT_FORK,
        (3) the user app fork()s, then,
        (4) RO longterm pin onto a wr-protected anonymous page.

If it's not impossible to hit in production I'd say extremely rare.

> 
> > Cc: linux-stable <stable@vger.kernel.org>
> 
> When proposing a backport, it's better to present the patch as a
> standalone thing, against current -linus.  I'll then queue it in
> mm-hotfixes and shall send it upstream during this -rc cycle.
> 
> As presented, this patch won't go upstream until after 6.3 is released,
> and as it comes later in time, more backporting effort might be needed.
> 
> I can rework things if this fix is reasonably urgent (the "user-visible
> consequences" info is the guide).  If not urgent, we can leave things
> as they are.

IMHO it's not urgent so suitable for mm-unstable (current base of this set;
sorry if I forgot to mention it explicitly).  I'll post (and remember to
post) patches on top of mm-stable if they're urgent, or e.g. bugs
introduced in current release.

I copied stable for the pure logic of fixing a bug in old kernels.  The
consequence of hitting the bug is very bad but chance to hit is very low.

Thanks,

-- 
Peter Xu

