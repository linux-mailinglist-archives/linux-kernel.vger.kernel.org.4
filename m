Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4E6B0C64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCHPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjCHPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C2DC4EB3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678288649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KgUrAIzQqv6buwoPW4AeFmRhe7W3Tdo1X3OW6kXpN2o=;
        b=KgzfK0yEbtIIW8WJf1tZbi1/5z5jnN6eAK8bzNlM2+GSK4ncJFgbiUIr1Fpy6vIHRy0Lh+
        u2JQINmgpAg+PuYC388Nrbr5FDdGOxz1GY7MHU6n/e/3+/EG+krfOfzZxLmCq9tzdJv+su
        GsYf9hfL9bfYIGDI1VKKDAFDmt1hz90=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-MB9ebhcuM06vl6-oHTO9nA-1; Wed, 08 Mar 2023 10:17:28 -0500
X-MC-Unique: MB9ebhcuM06vl6-oHTO9nA-1
Received: by mail-qt1-f199.google.com with SMTP id l2-20020ac87242000000b003bfecc6d046so9272055qtp.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgUrAIzQqv6buwoPW4AeFmRhe7W3Tdo1X3OW6kXpN2o=;
        b=uElQDF+TyzX4p5lbUVbVOL6l+idYcQQtDhI7dcddrg8uPRNHi4Iy9eyICrGPWq120p
         9wKRflGHUUNUc3blJnnPvGHqNnHpWxkJfRDVSKiWJOmpktRPISroBAwU03mYGy6HRzEw
         d6IOkj9xmLhdf9yC/7TANvwwBUIA6VfXkwawNoHF9IXjnbuqcWFa3iisprIV9iM5ingl
         67L2EKMzFBGJd+tR2ENMrXAqqiBlbcH1km9D0vfYBOHstXXBnBqnfh03Xpmkf7/ODJuh
         31jRyAFJjx22sKfPHr5BkZ6Y+DEJMGO5MVa7ApJaQFt1EQiHfLAfqrA6i71n9W91RRkZ
         ENdA==
X-Gm-Message-State: AO0yUKUe0sEkSBeDIqengo/BqD59loQNk1FRwZTCqQg7BQNXwxHx+5mh
        Z0EDAgBX0XYIVkWcdKsW1mJt1nDdyEUzcmb8h0IMWAsPC3HbX6/tzLz6qdnZBIwdeXGW5805qXr
        DNGN4rLiC55/RBjwmKvjdW6mC
X-Received: by 2002:ac8:5f4c:0:b0:3bf:b0c6:497b with SMTP id y12-20020ac85f4c000000b003bfb0c6497bmr35213877qta.2.1678288647707;
        Wed, 08 Mar 2023 07:17:27 -0800 (PST)
X-Google-Smtp-Source: AK7set9qVqFUrXtQwqQm1+hFwjCOU2+0udiwFOza948HghCR7OGwUXvhMQANkyFZFC65tpLGlNu89A==
X-Received: by 2002:ac8:5f4c:0:b0:3bf:b0c6:497b with SMTP id y12-20020ac85f4c000000b003bfb0c6497bmr35213849qta.2.1678288647447;
        Wed, 08 Mar 2023 07:17:27 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t197-20020a3746ce000000b007417e60f621sm11748357qka.126.2023.03.08.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:17:27 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:17:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Message-ID: <ZAinBTbXu4ZriATC@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-4-axelrasmussen@google.com>
 <ZAaMs44nspRQJmrk@x1n>
 <CAJHvVciQWctUoZtrPga-fhgBf2dtc+6ypwE3FYe8ApQWpQyL0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciQWctUoZtrPga-fhgBf2dtc+6ypwE3FYe8ApQWpQyL0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:27:17PM -0800, Axel Rasmussen wrote:
> >
> > >
> > > +#define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
> >
> > Here IIUC it should be "const_ilog2(NR_MFILL_ATOMIC_MODES) + 1", but
> > maybe..  we don't bother and define every bit explicitly?
> 
> If my reading of const_ilog2's definition is correct, then:
> 
> const_ilog2(4) = 2
> const_ilog2(3) = 1
> const_ilog2(2) = 1
> 
> For either 3 or 4 modes, we need 2 bits to represent them (0, 1, 2,
> 3), i.e. we want MFILL_ATOMIC_MODE_BITS = 2. I think this is correct
> as is, because const_ilog2(4 - 1) + 1 = 2, and const_ilog2(3 - 1) + 1
> = 2.
> 
> In other words, I think const_ilog2 is defined as floor(log2()),
> whereas what we want is ceil(log2()).

You're right.

> 
> The benefit of doing this vs. just doing defines with fixed values is,
> if we ever added a new mode, we wouldn't have to do bit twiddling and
> update the mask, flag bits, etc. - it would happen "automatically". I
> prefer it this way, but I agree it is a matter of opinion / taste. :)
> If you or others feel strongly this is overcomplicated, I can take the
> other approach.

I don't know what this will look like at last.  The thing is if you plan to
define MFILL_ATOMIC_* with __bitwise I think it'll stop working with any
calculations upon it.

I don't worry on growing modes, as I don't expect it to happen a lot.

No strong opinion here, as long as sparse won't complain.

Thanks,

-- 
Peter Xu

