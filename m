Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CB647728
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLHUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLHUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27ED186EA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670530919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMLxZ2vEpcan9FP4JPPeH3ALepfz4tDO6+Vi7LEQRvk=;
        b=gjAXwsfnCHE/keAGBiKhfX/Frye1MFNeB9C2/xfV89UtxU4XInvbPmJfrk48Pn1xLXv5pl
        N1PfcXOSR6NK2vrsad9hIE4WM9+JSh4s6SSjCuwjhyiHdEet1rmWtLLrULJqlsQWrle8Zc
        lVJEd635DcBJ8UUPEyyGKkaCnqe9Src=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-qRZK3BVgNPaD62PWLeBcyw-1; Thu, 08 Dec 2022 15:21:57 -0500
X-MC-Unique: qRZK3BVgNPaD62PWLeBcyw-1
Received: by mail-qv1-f72.google.com with SMTP id u15-20020a0cec8f000000b004c704e015f7so2446614qvo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMLxZ2vEpcan9FP4JPPeH3ALepfz4tDO6+Vi7LEQRvk=;
        b=myjxJxZLy+WPhJ+cUi7La3zX2sof+sUDOP3BSauRTWq1zuxazQkhEIAdHpAhueLjqb
         4C9pZUMQkBOdMcoJpsrTVxbj/IuWMhB5e9vbFXyepT0Ku9DcpaYFTu7rafwbsCU+xJag
         LoTz6PgJ7houaCS8fSVWO43rONhQa3g9OEH4KkhRtzfH6C6tcAE3/RtAURwXS3auYykJ
         d267gChbWz4mags2VRQoDmH5+jFlVrth9da7Ld1B+/8Bv4zLZZ7QuO1bhOP+xyDns0yA
         9BE5Y84wDo1LyM7ywN6WR9DIA9mehj1VvVmLfEv8b+0miDpzCOg7emUQWsJNkgudpLGR
         yJzg==
X-Gm-Message-State: ANoB5plqpbMgbHjqhPc910JdzsgjNaOV6ordE2SNtdktnwGaHlUjOi1E
        lA+yO1M+OTngRc/gcTsAgaLpveY9A9dWlOD+oKvQuKG9ACsnBoB1OM6p0VGWtW8dPKS5UuJrKE3
        mKEl16ADj+6cwHh6JKwoH8wa6
X-Received: by 2002:ac8:774d:0:b0:3a5:7ab0:e1c4 with SMTP id g13-20020ac8774d000000b003a57ab0e1c4mr4517418qtu.35.1670530917389;
        Thu, 08 Dec 2022 12:21:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7k+qy/zHCSKcSSKL+b4cS9+x4HXGI/lH5oy++Dhi9P840spOv4KDspGKt5GTP4hJO3hvBySw==
X-Received: by 2002:ac8:774d:0:b0:3a5:7ab0:e1c4 with SMTP id g13-20020ac8774d000000b003a57ab0e1c4mr4517397qtu.35.1670530917146;
        Thu, 08 Dec 2022 12:21:57 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id ga23-20020a05622a591700b003a526675c07sm16021164qtb.52.2022.12.08.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:21:56 -0800 (PST)
Date:   Thu, 8 Dec 2022 15:21:55 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ives van Hoorne <ives@codesandbox.io>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hugh@veritas.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v1] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y5JHY2zyK4k8aBtX@x1n>
References: <20221208114137.35035-1-david@redhat.com>
 <Y5IQzJkBSYwPOtiP@x1n>
 <b9162f04-7d8e-1ada-f428-85fd84327d1c@redhat.com>
 <Y5JDrkBGEyZviXz9@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5JDrkBGEyZviXz9@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 03:06:06PM -0500, Peter Xu wrote:
> On Thu, Dec 08, 2022 at 05:44:35PM +0100, David Hildenbrand wrote:
> > I'll wait for some more (+retest) before I resend tomorrow.
> 
> One more thing just to double check:
> 
> It's 6a56ccbcf6c6 ("mm/autonuma: use can_change_(pte|pmd)_writable() to
> replace savedwrite", 2022-11-30) that just started to break uffd-wp on
> numa, am I right?
> 
> With the old code, pte_modify() will persist uffd-wp bit, afaict, and we
> used to do savedwrite for numa hints.  That all look correct to me until
> the savedwrite removal patchset with/without vm_page_prot changes.
> 
> If that's the case, we'd better also mention that in the commit message and
> has another Fixes: for that one to be clear.

Nah, never mind.  I think the savedwrite will not guarantee pte write
protected just like the migration path.  The commit message is correct.

-- 
Peter Xu

