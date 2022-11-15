Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566D62A122
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKOSMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKOSMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DDB21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668535875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eer18dOX5R+bHPKMAIktRCptAEoDyYz4Wl1rWvmd9Y=;
        b=ZrG03SBCLYIuc4XKVJ/uHkkfXXiolLIwCJEsaTZmMvguBhIunGT3iY9lO89ZhK1Nh8JM50
        iEThofyJgURsBeuDeRJsSMbj5IocZ0y2559q5tsR93hpWJX7lKdgrwW9mDlyO2bqZrAEh3
        Q9qe7F/ZiPMJtjHBsonvpg6tQhlkxVc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-4okio0nQNx-eYPYGO9Cxjg-1; Tue, 15 Nov 2022 13:11:13 -0500
X-MC-Unique: 4okio0nQNx-eYPYGO9Cxjg-1
Received: by mail-qt1-f199.google.com with SMTP id g3-20020ac84b63000000b003a529c62a92so10934591qts.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eer18dOX5R+bHPKMAIktRCptAEoDyYz4Wl1rWvmd9Y=;
        b=pHN7SGhDU71n80/w4fKYpOZ7nHz6strc6TQbEvturhZ7jDbsWBvZs80rRehkDqwTno
         mH05wiljBHJO3MxyvloXFAEHS7/z0M1EZ7iSPWsKigNs4TfHsx8LvgxVh+NvrXVg864e
         TM7tz1H81aYvVPu3ibSbpkX7xIOdo/5KMEQ4J9uRrH/6OFqH+EuJkjlbSSzKUMWiVkqk
         hMiyL/xYw6hIPFFSmxo/sb+B0aNA1+P99CPNoCRucf5WKeFCIJenPfpRJI6fiixU2/Zd
         WmR2l5zYAyqix2BpCDi9aSEkehZ9rygQMnar5thuOwxbv4rK1A9eL5RqqdKv4+mih8An
         k0Ww==
X-Gm-Message-State: ANoB5plXIEJjFBODMsOsfadbthjR/pZhPxRhHtD9ivjBrpGWpotH4e9l
        tl6E9pUwRD9xA6biecN0YlNzkZk8rUHbLRChlpk+PDQB9K9tHBIRDzLiUYBi8283nD+QK2wi76Q
        rBhi5Hu7ANV+CxYbQu0gd/n3t
X-Received: by 2002:a05:620a:cca:b0:6fa:2a50:f884 with SMTP id b10-20020a05620a0cca00b006fa2a50f884mr16066922qkj.741.1668535873167;
        Tue, 15 Nov 2022 10:11:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6XBKkpt/Bs7c0cNYLkP4Cbh98dkNqTGjUQOJIIGYCpdr6clNBw82n+v7GW7OGh9k0xZvIOow==
X-Received: by 2002:a05:620a:cca:b0:6fa:2a50:f884 with SMTP id b10-20020a05620a0cca00b006fa2a50f884mr16066903qkj.741.1668535872949;
        Tue, 15 Nov 2022 10:11:12 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84b47000000b0039953dcc480sm7473363qts.88.2022.11.15.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:11:12 -0800 (PST)
Date:   Tue, 15 Nov 2022 13:11:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
Message-ID: <Y3PWP9RPjg5FObMN@x1n>
References: <20221110203132.1498183-1-peterx@redhat.com>
 <20221110203132.1498183-2-peterx@redhat.com>
 <9af36be3-313b-e39c-85bb-bf30011bccb8@redhat.com>
 <Y3KgYeMTdTM0FN5W@x1n>
 <ec8b3c86-d3b2-f898-7297-c20a58ae2ac1@redhat.com>
 <Y3O5bCXSbvKJrjRL@x1n>
 <82d7a142-8c78-4168-37e9-7b677b18987a@redhat.com>
 <2ed12722-2359-cb07-53e7-566d959d311e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ed12722-2359-cb07-53e7-566d959d311e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:54:09PM +0100, David Hildenbrand wrote:
> No it isn't natural. But sneaking such a change into your fix seems wrong.
> Touching !uffd-wp code should be separate, if we want to do this at all (as
> we discussed, maybe the better/cleaner approach is to eliminate writable
> migration entries if possible).

If you see I made the subject as mm/migrate, because I took it as a
migration change, not uffd-wp specific.  I also added the Fixes to the uffd
patch because afaict that's the only thing that it affects, but I can't
tell either.

As I said, I'm trying to follow the rule where we have read entry I want to
make sure write bit removed.

I hope we have this patch land soon, because it affects users.  I'm not
against further rework on migration entries as I replied in the other
email, but for this patch I keep the same thoughts as when I posted.

Thanks,

-- 
Peter Xu

