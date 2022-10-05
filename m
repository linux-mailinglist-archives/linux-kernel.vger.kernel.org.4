Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A55F5AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJEU3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJEU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5880E8D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665001752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WhHrCKV1cwvD4EM7naK+YDuH8wkC6i7kWGC/pb6hko=;
        b=Ob8AeOD3O04JKuMfa6+gvtII2znbsV01e9fC3yVcq6RFtnNYBOiEkY6u/2tCZwGEuKntX9
        D9z96IXGsx3IchLbsYkrshA/cK4CHnJOMYw90CyYJkY15Fx0STAIl61LjL4VfUPSQgJV9N
        QBjjq61RGreqDTf7beHgo/q1yBnZ9Ow=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-80GJ1MNcP066WSaYftQ3xQ-1; Wed, 05 Oct 2022 16:29:11 -0400
X-MC-Unique: 80GJ1MNcP066WSaYftQ3xQ-1
Received: by mail-qt1-f198.google.com with SMTP id g6-20020ac84b66000000b0035cf832dec9so11837110qts.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9WhHrCKV1cwvD4EM7naK+YDuH8wkC6i7kWGC/pb6hko=;
        b=fcABtDZem51zPrSwRabLYTDNvwbHoj5PXr8cF5UDMlZCMFq9FRP86aw+Fel5RUVXqC
         eWGo2vgIIVxJ9Q1d4aRUEzeFprap8K71g4NtQRpz11FR8irHKlEY7Ldo9IAaoG/e4zZd
         O/qq0RWJa7yS4JfxkKgMKZfp5E0YY0kpB4nmbnRMzpxqKJXlCoYUiHHVrdfbGB8vDeWt
         vNlyxV9yBE5+39ZOPV1vVCNITUkNDw9a3TUrNlTAHlwcd3u7VZe6HhLnqadNhneHiXFV
         7+r612X1ktlRrBdX80UAV2D+BzyTMQoDatFPZMm7r4seb4X+gPIYD4BQIXJOkaWO79fR
         HzdQ==
X-Gm-Message-State: ACrzQf3mXi4sBFHpmpDHmbWv8MfeUlmPQ5MlwvuCyCHIr9zl08dNiKcH
        7jbkZocq6Ft6GmxpTs8SczHiY0hdkv74YskiOEngww0KF96PLCQB8kADteKVlf2rqM8n10NisJ9
        LPuortDcaPiUBoSGaG2cLPBTY
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id n15-20020a05622a11cf00b0035ba3690cc3mr1040735qtk.11.1665001750998;
        Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4X1NNPNTAB6aR9AIvBCYejjhroiFWgmpijdD0gX07m80Y4kME6G/bmuMyCb5pJutilihvZhQ==
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id n15-20020a05622a11cf00b0035ba3690cc3mr1040727qtk.11.1665001750820;
        Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a17c500b0035d0655b079sm14386325qtk.30.2022.10.05.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:29:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 2/7] mm/ksm: simplify break_ksm() to not rely on
 VM_FAULT_WRITE
Message-ID: <Yz3pFPuJrWEIHCWz@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-3-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:26PM +0200, David Hildenbrand wrote:
> I don't think that we particularly care about that performance drop when
> unmerging. If it ever turns out to be an actual performance issue, we can
> think about a better alternative for FAULT_FLAG_UNSHARE -- let's just keep
> it simple for now.

It'll be nice to hear from real ksm users for sure.  But to me this makes
sense, and the patch itself looks good to me, I think that also means:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

