Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62E76A8B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCBWB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCBWBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EEC5A6E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677794423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpF+61RhbjBED9gh9OlDPVvD+1GeHmY73K8Lmm1HO1w=;
        b=Z95kFgtdGfyhOqfPmAxmrn79PNMq0gCems5a1QG8QMEernV/EsnzJRgaMKiHIy+Qr1+aCb
        f8h1l+d/MN8gxJg5bORvfeAfVzvwkV6L5v3f+rJ8PWKc6OyBGSiGKNoW151OIpivCH/MfK
        iWeyQz7fY87neaaEJFhujIZ9Wjw2pyc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-YRKvC3e9PgqHyB-PYBl1sw-1; Thu, 02 Mar 2023 17:00:21 -0500
X-MC-Unique: YRKvC3e9PgqHyB-PYBl1sw-1
Received: by mail-qt1-f199.google.com with SMTP id c5-20020ac85185000000b003bfae3b8051so452598qtn.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpF+61RhbjBED9gh9OlDPVvD+1GeHmY73K8Lmm1HO1w=;
        b=zF1pESBVMbulSjvI7ob07YlktAWBnBzy1V09DC4bKbLCr35ANDGnf+eP1g8a7s10jX
         3SvJWk/Rkm8H7W2nvTZAz22yU1xhiEEgs6aqkrfg/mtvhC0GgWZeWoIj46LyB1GKMs+/
         MmKDkW547IRvvfxPyLXEC7Y3hKyAHMysWD6ek+BFjqUssLC3gpiwuWlq1skGytqUf03l
         rr+4rr6T0rWSkPKsoMe1EioGTqzedc2GwzjbZeBG4Ep+0Y+gExJwcs7eQ39XbA4xv6xn
         7LMtB0tixZzgSevgMrD87jeMlEWNHD+IVHnJaGOH7/eJ0NZuHs0Gj3aePxUEpeOGzXhd
         eusg==
X-Gm-Message-State: AO0yUKXArSk3PbxqBVx3gf+GZqCOiM029AEWDMrbAk4MuzCNpUrqhCNm
        Gs3vK/hZu89BVEQ+1Re94hefHvJpFg1fjPJZWvv7x2F+BQCB7GhmHvAwPi1Dvsml2WV+9Sv19rO
        46lmKxJQgKcnxQBlY/MG8i2J3
X-Received: by 2002:ac8:580f:0:b0:3bf:daa8:cacc with SMTP id g15-20020ac8580f000000b003bfdaa8caccmr22832383qtg.3.1677794420495;
        Thu, 02 Mar 2023 14:00:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+Dd+YGqo/SioYo2gFqWFziGqP77BVBRsHhvTjzMkmzleJIrVboVo66FWVtVnDVZtABxKAS4w==
X-Received: by 2002:ac8:580f:0:b0:3bf:daa8:cacc with SMTP id g15-20020ac8580f000000b003bfdaa8caccmr22832326qtg.3.1677794420075;
        Thu, 02 Mar 2023 14:00:20 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id a191-20020ae9e8c8000000b007423843d879sm427457qkg.93.2023.03.02.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:00:19 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:00:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZAEccqZfZtw4XtSm@x1n>
References: <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n>
 <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com>
 <Y/9tA2EVglOJ0Ap1@x1n>
 <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
 <8783f47e-76ea-cd24-e373-f2156884cd05@redhat.com>
 <ZACrOWKWdVYO/EAI@x1n>
 <982c1623-ac28-2743-d6a3-4faf42f72d47@redhat.com>
 <fad40511-3909-4362-5760-bcb57c94e534@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fad40511-3909-4362-5760-bcb57c94e534@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 08:14:05PM +0500, Muhammad Usama Anjum wrote:
> I've heard about a use case where a file of size 10s of GBs can be mapped
> to the memory and then accessed off and on. We need to handle this
> correctly and efficiently.

Note again that besides any slowness it'll stop working for generic FSs.

One way is we can consider enabling uffd-wp async for all archs, but I need
to think more about it, and it will not be compatible with any other modes.

-- 
Peter Xu

