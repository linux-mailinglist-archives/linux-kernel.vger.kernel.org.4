Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D66B156C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCHWoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHWog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4186F60F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678315423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUpec8k3TuIoHkhdWuDgw2GYbAPkkhYheZa+lxQbkK0=;
        b=cmaQEjZIrCRnjXrCHu0deOC73CBs7yt24Wy6ffxgB/4ZHscLP7E265dnZAuUpERw3V1Tie
        SV/CMYT4ECovlXrcshPsp5Rv5Q2S+o4BTuENGZQNTZdS6d3UZRTm5gK7NApdhAQPi67wBC
        JJRUiL9enMssq4uMVKSlTnfObBoHkrg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-TqebD0jyMWyVbt3nJG3CjQ-1; Wed, 08 Mar 2023 17:43:42 -0500
X-MC-Unique: TqebD0jyMWyVbt3nJG3CjQ-1
Received: by mail-qt1-f197.google.com with SMTP id c11-20020ac85a8b000000b003bfdd43ac76so52568qtc.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUpec8k3TuIoHkhdWuDgw2GYbAPkkhYheZa+lxQbkK0=;
        b=VktW0tcJV5WxM+8mDuniYGFLI4Uj49htI1G5cSqngFZ5QSGD/AJYsXxtGIBHBNYmwQ
         b1YgcYZGXcyUnmrAOAXuPAhdJPGc11evMkNVOhoRuAFR5kCMp6rNeArHnUhJ64Tike4T
         wUCG/fi+Z4xkJZs8Ga4e1i6WZHvjG+SgRbtuNXm4BbjkefXR5P7kafHVy9xTvTxkIrwr
         K8DkN9tSQhhuwO5cFuKJxPECDQ2Dzi9ybQadAncELWAY2lr92qNdzwG9Hy10IJkqZrOo
         Ksh/m1MF6KRN69cK80BDOABE8AMMp5+DP6wtr/GBt3n4RIWwIMiuk9VSpkZvg2pwcWqe
         FURg==
X-Gm-Message-State: AO0yUKXR0hTJoUXo+T/HWc4n3DVf93HT/a4wQSJRkl6tDgVeL77Lg+rM
        bk5J2hD3d1y8E+/jDwbOy1WoXUj9GbVGSUIZKEXu1Bqc4gj0HLDJ7tejss1OdsDbiweWF6Qev5k
        IQIBifebpuIJq5l7N7DSqdopg
X-Received: by 2002:a05:622a:4c7:b0:3bf:be4b:8094 with SMTP id q7-20020a05622a04c700b003bfbe4b8094mr39961478qtx.0.1678315422278;
        Wed, 08 Mar 2023 14:43:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/svpcFN7oyLd26+MN7LVXbPhQYslhKV53Vi4XzGLt4t3d/JLaXvYRZ51X7BFbuHcnLETSjqQ==
X-Received: by 2002:a05:622a:4c7:b0:3bf:be4b:8094 with SMTP id q7-20020a05622a04c700b003bfbe4b8094mr39961450qtx.0.1678315422037;
        Wed, 08 Mar 2023 14:43:42 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id r25-20020ac87959000000b003bfc1f49ad1sm12255401qtt.87.2023.03.08.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:43:41 -0800 (PST)
Date:   Wed, 8 Mar 2023 17:43:39 -0500
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
Subject: Re: [PATCH v4 3/4] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Message-ID: <ZAkPmy0EqcW6Mfvn@x1n>
References: <20230308221932.1548827-1-axelrasmussen@google.com>
 <20230308221932.1548827-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308221932.1548827-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All nitpicks below.

On Wed, Mar 08, 2023 at 02:19:31PM -0800, Axel Rasmussen wrote:
> +static inline bool uffd_flags_has_mode(uffd_flags_t flags, enum mfill_atomic_mode expected)
> +{
> +	return (flags & MFILL_ATOMIC_MODE_MASK) == ((__force uffd_flags_t) expected);
> +}

I would still call it uffd_flags_get_mode() or uffd_flags_mode(), "has"
sounds a bit like there can be >1 modes set but it's not.

> +
> +static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_atomic_mode mode)
> +{
> +	return flags | ((__force uffd_flags_t) mode);
> +}

IIUC this __force mostly won't work in any way because it protects
e.g. illegal math ops upon it (to only allow bitops, iiuc) but here it's an
OR so it's always legal..

So I'd just drop it and also clear the mode mask to be very clear it sets
the mode right, rather than any chance of messing up when set twice:

    flags &= ~MFILL_ATOMIC_MODE_MASK;
    return flags | mode;

But feel free to ignore this if there's no other reason to repost, I don't
think it matters a huge deal.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

