Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC176887F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBBUFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjBBUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC4722A22
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675368290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTHdymdXseHUyg+Ebb447lp0I2uDggYeKUHoqsLF3K4=;
        b=RK0hvvT4WIlq7M0ji2orcyIaejq/ryu7QAkOBAoPOF6INMXll+BRejF6xJVF08aPLn45zE
        oxRowc5zxaYHayQPss6VEH5crNid0Lh4UohFZek2v+qFt+pBBC+1k047zdoixRB+J+eH4a
        gqOIVtwVc9H31IIJ2M+n1IlHVPbV4LU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-Zb3xLrVKN6uWMf7811CCnA-1; Thu, 02 Feb 2023 15:04:49 -0500
X-MC-Unique: Zb3xLrVKN6uWMf7811CCnA-1
Received: by mail-yb1-f199.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso2749348ybp.20
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTHdymdXseHUyg+Ebb447lp0I2uDggYeKUHoqsLF3K4=;
        b=z+KRsmoVXZtVEC1YP9glyuQpRQ6FbSK2iwDpEji7jDiT0JLY16GR27Y2zMEfrTDqu9
         PILz+60JrSEbSbLK0qQxjiLjCbXECUxa4MlQ+PX9VEU7t2zr85AcQkuD1ChOtZENNIQR
         OB0GlSG0W7fUsys0sNVc1dvVBAHy9h+7JKlnYZxFRZ6kn05CAprM4R204RyM8hKyk3QQ
         pA/N5Toj1yittdC3od5y8Pypv1y2k1X8VxNuAw4yiynRDQck3Suu2oYpmjKROxNE2mFY
         4AI7b1rn0lNmVHJv4LnAJ/Qsdd3ZbfdH6vU2sPidLodAtLTSCjYFDNRVdlDUW4CFGYY3
         Fy6Q==
X-Gm-Message-State: AO0yUKW4uCRp+Mu0elqkKF8PUWgxtG5iWwriQvKXUmXIwrv/ye/yZUKp
        ay7IsvHmP57m4lRBRNRgnyvL35fuklAvsIgw2njZb7J7eFDwDBzvCW190cdvzrZNxTtBc232iTy
        FBs1zP4X0FdnhFOAubO5i0Vq+
X-Received: by 2002:a05:690c:1b:b0:51d:efdd:b1d with SMTP id bc27-20020a05690c001b00b0051defdd0b1dmr7235284ywb.0.1675368288438;
        Thu, 02 Feb 2023 12:04:48 -0800 (PST)
X-Google-Smtp-Source: AK7set+K6sx4quQN5ghvY74ba3Y9dYzcyRzTFaEw9AXmqSMs//jZGTpZAalF5pjDQRAtQo8peVpekw==
X-Received: by 2002:a05:690c:1b:b0:51d:efdd:b1d with SMTP id bc27-20020a05690c001b00b0051defdd0b1dmr7235259ywb.0.1675368288168;
        Thu, 02 Feb 2023 12:04:48 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a056d00b007208dd55183sm359687qkp.40.2023.02.02.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:04:47 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:04:46 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Stevens <stevensd@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
Message-ID: <Y9wXXoSY+QqoKMMx@x1n>
References: <20230201034137.2463113-1-stevensd@google.com>
 <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n>
 <CAHbLzkqyhS5thdVKa-jcS5iNUNxe95hagBncWaG=CQTh=LU70w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqyhS5thdVKa-jcS5iNUNxe95hagBncWaG=CQTh=LU70w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:57:33PM -0800, Yang Shi wrote:
> > There's another problem where the current vma may not have uffd armed,
> > khugepaged may think it has nothing to do with uffd and moved on with
> > collapsing, but actually it's armed in another vma of either the current mm
> > or just another mm's.
> 
> Out of curiosity, could you please elaborate how another vma armed
> with userfaultfd could have an impact on the vmas that are not armed?

It's e.g. when >1 vmas mapped to the same shmem file on the same range, one
registered with uffd missing, others not.  Then others can cause page cache
populated without generating message to the vma that got uffd missing mode
registered, so there'll be the same issue as when khugepaged accidentally
does thp collapsings.  Thanks,

-- 
Peter Xu

