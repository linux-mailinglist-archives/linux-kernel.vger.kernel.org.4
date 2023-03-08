Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5B6B0F37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCHQv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E4C6E65
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678294268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yT+uvg/1uzwHRYdkyNG5W1yFDAXCvqMwEPbXMy2/b9M=;
        b=O+duIJaguNgl4TuT53JQmxiksw3zm56eWhcw8F/DoSKDu03FrQvsecgA3vJ/WSXWsfcUA0
        tYl90at93E+e9U1m16XqTIF2v5Di0zCXgcAOc7kPMh4xdBoLHate3R4CJUbIhZRrzcIIqj
        ZljRCPvIsS4RLQjE3iKXCXGq8tRxSHM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-1iOKMGRdMuq1v2decx4-Ew-1; Wed, 08 Mar 2023 11:51:07 -0500
X-MC-Unique: 1iOKMGRdMuq1v2decx4-Ew-1
Received: by mail-qv1-f69.google.com with SMTP id e9-20020a0cf749000000b00571f1377451so9655666qvo.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678294267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT+uvg/1uzwHRYdkyNG5W1yFDAXCvqMwEPbXMy2/b9M=;
        b=j/PDt4J1FWOI3FEw5fEbGFImO8atktvJNsPYrsPHtwHcaGsmitGlGD8dUTH1fADjiP
         A0jz9hPGmwY7tHp84rgWfwGYXfvBkwHFj/6+ThG/w12o2BBhPogeCtVAXOU8iokmflPo
         v02mbqeLWu+uRugR2eNQZrTyfB25OdUHMTRjywOQuaqyCAB/4xDKe2MeVwWMWeRldZjR
         mNMkhO9p9khnTftJSyUZbslmHjwTyu+2nhZYRoXzA0sHAoKk9SBE6231ZsTDikTKhnQF
         Gw8lhLnkKBZJZDv68fX1wM45UA3zRKftagxSvUoLHQ4L7//tqhXtr2nfv6BQY0yMXmos
         Zl8w==
X-Gm-Message-State: AO0yUKUQuf9L3o5cMEQaE7rRKB/+6dVj6fJoW2xongi66Ad5koZSa/R1
        T0+LzUacDhE3OHkuq68xHTB0oAY18lR9EnXF23silWYc+cgEO1/S7ySempVMLFAV30S1i1sx0G6
        GVhMvbZ5flW08OwHrFfuJB/sN
X-Received: by 2002:a05:622a:1307:b0:3c0:3d68:5411 with SMTP id v7-20020a05622a130700b003c03d685411mr10265964qtk.4.1678294266866;
        Wed, 08 Mar 2023 08:51:06 -0800 (PST)
X-Google-Smtp-Source: AK7set8jreSNkM94Fnw3qoxwWDWIjuaicOKY9mQaYLL/60bWJWLnhflCSjRVYro+sDVPVvrVDDqVdw==
X-Received: by 2002:a05:622a:1307:b0:3c0:3d68:5411 with SMTP id v7-20020a05622a130700b003c03d685411mr10265925qtk.4.1678294266578;
        Wed, 08 Mar 2023 08:51:06 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x184-20020a3763c1000000b00738e8e81dc9sm10932512qkb.75.2023.03.08.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:51:05 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:51:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZAi8+PCsIzExWPQN@x1n>
References: <20230306213925.617814-1-peterx@redhat.com>
 <20230306213925.617814-2-peterx@redhat.com>
 <94be7b9f-c33e-c6dc-4132-6cb78f7c0624@redhat.com>
 <ZAiqPU0RX3JfDFRP@x1n>
 <83b3f3ad-19a2-3737-77dd-3c3f9db82194@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83b3f3ad-19a2-3737-77dd-3c3f9db82194@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:57:55PM +0100, David Hildenbrand wrote:
> Oh, my thinking was that with markers you postpone placing the shared
> zeropage. So the next read access will require a pagefault to map the shared
> zeropage. Your v1 would have performed best in that case I guess.

Ah, so I misunderstood because the sentence being quote was in another
context I think..

Pagemap may bring overhead constantly though, not sure when vs page faults.
May relevant to num of missing pages.

It's just that we may still want pte markers to avoid losing MISSING+WP
(with WP_UNPOPULATED) use case, which you rightfully pointed out before.

-- 
Peter Xu

