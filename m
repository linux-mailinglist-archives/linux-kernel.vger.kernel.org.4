Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130C69B648
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBQXLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBQXLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87EF767
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676675413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGZu08oXDZinWgYTxC2ziQUKz+DJaWr3MxzidFt17Ys=;
        b=d/lpl+JLe15KDhoPA/BxZYUl/RdoxYBnWY12hgclCnsCH/ltgIGLQbi+dgdHSiBLVrQ+HQ
        78gm+MHwvthvNq1lqk68BBCd7UtWn9MzZIwyAFlyauNF040PA1t7jMkQMTEcR8rP+Xawl8
        5kbvaaO66l1U31bFn3gy59oHBbfe3e4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-mIHVrGV9NPeZmBrEd5ZZHg-1; Fri, 17 Feb 2023 18:10:12 -0500
X-MC-Unique: mIHVrGV9NPeZmBrEd5ZZHg-1
Received: by mail-qv1-f70.google.com with SMTP id a10-20020a0cefca000000b0053cd4737a42so1125562qvt.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676675412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGZu08oXDZinWgYTxC2ziQUKz+DJaWr3MxzidFt17Ys=;
        b=NZ/S0Dj6T/7QmLvawBgWM4x08LivBkt9faXBeQTWCYGNG+0T6XBzi6Zw48mrXkCG+G
         ayXBxhYRi8Ua9OWJx/98lQM8XUbE39Q4dKKgD5SUG5ntskN+ALaD4Xm4ewObYQZleUmt
         cvwF6Pey+0kz91uwANQ2Hw9gngohWgHPuajBUD5M+0OVUhRhpLrY6ni1a17/0FDOdyIT
         dFpBBxYb8LXzCd+JPBj7AKJLziLUNl9ySIP6Y9Szfcg6HoaY6jorOXrHOcsWsQPxb6J0
         BUImst7KZHK/GulPyb440o4R3IIng+jcEi7vJIBzqsOap73NJkGtMRAKaidfTwPMJquC
         Rzng==
X-Gm-Message-State: AO0yUKUfu4z2IIm8aSBOZc9N6lnkYYcLUa4eIixP9+4NXMhn2k6Ayy9K
        L07DCHePGpeTIyu+tk3FzDzZsM/jLwOVnJab+NDoUD1LBiV6IIuP9EjHX2snVbU7d4mXsyNLjvj
        zHWDoAL8/69bvc3bes05L2Yfy
X-Received: by 2002:ac8:7c44:0:b0:3b8:6c6e:4949 with SMTP id o4-20020ac87c44000000b003b86c6e4949mr5624131qtv.4.1676675412183;
        Fri, 17 Feb 2023 15:10:12 -0800 (PST)
X-Google-Smtp-Source: AK7set/jd0yWr5rGW+fJEsGAE+BODNIqGlr9Io2xy0/HUvUVCFax+BOqcbBuzORJHRZlS9CEMLBAAw==
X-Received: by 2002:ac8:7c44:0:b0:3b8:6c6e:4949 with SMTP id o4-20020ac87c44000000b003b86c6e4949mr5624097qtv.4.1676675411888;
        Fri, 17 Feb 2023 15:10:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d1-20020ac84e21000000b003b82489d8acsm4022408qtw.21.2023.02.17.15.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 15:10:11 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:10:10 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Message-ID: <Y/AJUi4o5hOKDkgy@x1n>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
 <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
 <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
 <Y+6NKPuty9V3nycI@x1n>
 <427298c4-0da9-059f-02ff-c5147d317c87@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <427298c4-0da9-059f-02ff-c5147d317c87@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Muhammad,

On Fri, Feb 17, 2023 at 05:31:19PM +0500, Muhammad Usama Anjum wrote:
> I've just ran my single threaded selftest [1] over an over again to get
> some numbers.
> 
> Without zeropage
> qemu has 6 cores: 26.0355

Did you count in the time of read prefault?  Or did you not prefault at
all?

> With zeropage
> qemu has 6 cores: 39.203
> 
> 33% worse performance with zero pages
> 
> Definitely, there can be better benchmark application. Please let me know
> if I should write better benchmarks on my end.
> 
> [1]
> https://lore.kernel.org/all/20230202112915.867409-7-usama.anjum@collabora.com

I'll have a closer look too next week.

Thanks,

-- 
Peter Xu

