Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218769A21B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBPXIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPXIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971BC4C6FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676588849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U1i355zZnPAPOV+7l8sV2CTmBt7VeakOe3eIo5ILPXc=;
        b=Fyz+AU23YmgWSxW+L7pwdSAh5+jWwFJGQh9Bw019v4dY4wLjr/tJqhfZzWzTYOaotkYpZY
        sbxtUVfSDTd5oIjFdJnJwqGUgh3+4g5E8xHzBNQ+IP8w8sO9WqSJWGAqg/wk2lrSWXDw3N
        q2iM2SldvlOLSNEMcFf7ldwuBrge93o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-N8GqmPcsMqOz2jE0FyYZlQ-1; Thu, 16 Feb 2023 18:07:28 -0500
X-MC-Unique: N8GqmPcsMqOz2jE0FyYZlQ-1
Received: by mail-qk1-f197.google.com with SMTP id s7-20020ae9f707000000b007294677a6e8so2131299qkg.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1i355zZnPAPOV+7l8sV2CTmBt7VeakOe3eIo5ILPXc=;
        b=kiWn5G37GRHTgW0KgMCKkTPDMxkzxfHpAIlhbN2EkOlrmrKsYsCpobtZ0tq8EYl2/Y
         tAUEQq9KoK4s9kZE/cSf/ZA/UH1HDfi4DyXk9m9/04xXepkSBi4NmUe17vMthjQZ4ZSa
         RT0sYTRsM1LWfvjUXZ6FjIqugj3f0WKtX3TYjtYzXJ6g+7lrK8fRANpIdyhe4AW1SaR0
         9OUMToxwJUPVFBRtoPQuGRCGQPXzv/7oq1zC7fLL7bOxFqPq2tAFwAe+f9iMyrjTgubN
         IRbIHVBg296eMmn1q/v7NYW/QJRXoLyB1+kUov5NLUQ1VER9WnOFXdNKApPMloAeTewP
         wVWQ==
X-Gm-Message-State: AO0yUKVsbI2QPK1RAydfZt3ngxeJvTj9E5gwNI/KKclsUh1ypLHeQvEJ
        HtYheF0F68iYlNoFlTLF4nTjOXYj6zk2mzp4gTtipN63Hn6eI94qavI5djuoJgxOdfELU11bCEz
        WuhSC9SwSglbsdoQmCiP9vbWh
X-Received: by 2002:a05:622a:110a:b0:3bd:d8f:2da9 with SMTP id e10-20020a05622a110a00b003bd0d8f2da9mr5554076qty.2.1676588847925;
        Thu, 16 Feb 2023 15:07:27 -0800 (PST)
X-Google-Smtp-Source: AK7set8TDXBD8/ctrYlut9+45E6qFFpg/9ja49qyzef3+g8lBYY5BB+I0S1SlMPM9d6OMKBy+cv3Hg==
X-Received: by 2002:a05:622a:110a:b0:3bd:d8f:2da9 with SMTP id e10-20020a05622a110a00b003bd0d8f2da9mr5554050qty.2.1676588847668;
        Thu, 16 Feb 2023 15:07:27 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 207-20020a3708d8000000b0071de2b6d439sm2142783qki.49.2023.02.16.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 15:07:27 -0800 (PST)
Date:   Thu, 16 Feb 2023 18:07:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+63LQo49CCyXRQn@x1n>
References: <20230214075710.2401855-1-stevensd@google.com>
 <20230214075710.2401855-2-stevensd@google.com>
 <Y+1hMsm4eQIUtag5@x1n>
 <CAD=HUj69L2e-Z4TB19qFt8h1cn0r1oGbWovJGMOjjyvfDcQ7NA@mail.gmail.com>
 <Y+5Akpz4CvGywt6R@x1n>
 <CAHbLzkqUF8Y759ZBVGXWdKwDS4f+ZJakUhoqf8Dqvx0Jam4c1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqUF8Y759ZBVGXWdKwDS4f+ZJakUhoqf8Dqvx0Jam4c1g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yang,

On Thu, Feb 16, 2023 at 01:58:55PM -0800, Yang Shi wrote:
> > IIUC we released it before copying the pages:
> 
> The huge page is locked until the copy is done. It should be fine
> unless the users inspect the page content without acquiring page lock.

The current patch from David has replaced "insert hpage into holes" with
"insert RETRY entries into holes", so IMHO the hpage is not visible at all
when releasing page cache lock here.

All the accessors (including RCU protected ones to access page cache; those
may not need to take the page lock) should be spinning on the RETRY entry,
which it seems fine to me.  But my question was whether it's legal to keep
them spinning even after releasing the page cache lock.

Thanks,

> 
> >
> > xa_locked:
> >         xas_unlock_irq(&xas);  <-------------------------------- here
> > xa_unlocked:
> >
> >         /*
> >          * If collapse is successful, flush must be done now before copying.
> >          * If collapse is unsuccessful, does flush actually need to be done?
> >          * Do it anyway, to clear the state.
> >          */
> >         try_to_unmap_flush();
> >
> > Before insertion of the multi-index:
> >
> >         /* Join all the small entries into a single multi-index entry. */
> >         xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> >         xas_store(&xas, hpage);
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu

