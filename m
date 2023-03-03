Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD46A9AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCCPgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCCPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA391A49C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677857756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0kL2F3roXwPeTO3C+PURsaXpvpP++lBa+L0HVed97U=;
        b=bAp6Cx/XVTUc6VAu8JYTa1cd7xAOMDwjvVApA5fQCsXUwnSJKiH/3rSAOI+PAmouIipdO5
        73zF/qy47D0pYQkQ3KKsjfFmcjKA9YdEc9bmGft404W7zBjtiv/WcURNXexJXjonqi/lj+
        wwpGUHTdy1jRytVnTBcC7KvbArLPxjo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-YKqUTPVVNpGk0X-_fIAscQ-1; Fri, 03 Mar 2023 10:35:55 -0500
X-MC-Unique: YKqUTPVVNpGk0X-_fIAscQ-1
Received: by mail-qv1-f70.google.com with SMTP id s18-20020a0cf792000000b00572c04240f1so1593192qvn.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677857755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0kL2F3roXwPeTO3C+PURsaXpvpP++lBa+L0HVed97U=;
        b=mW1l7Iw7A8dlDVeVnP/o3A4MYufVEVvWLBsk1/fRiCqdbqACM+ksvWbuz0bPh2fMJ+
         5v4eCZlTKrnX02MjB30hi+i/7dAjvwwY9KERVrX+V3S5Iui4EgSeRqOSDGwGL5UCvCCc
         AQfL759D+3+orPpcrSqN+nFIMjcbXEoE/e5Yjt+cclgglSUY67H1W4hV31JrzEgk64nr
         /EQfAhxL8V6dvAq2JInIPOJvVrODhteslNu36pyZW1XKk/8TSEg6uIioDsWO9PytlnLz
         XWanNWsE/cYBACakceU92hOWIb6cSJaJHv1h91d4TDwbaIg4Vcqos2aChq1784RlllS+
         PPag==
X-Gm-Message-State: AO0yUKWEdEfVZDZCBO0FN+lwHNJh83dIjPxFWD/Z34vj4XTu43682/jg
        rzuZovVrG5xxseR6LspFGKmc9IhRgTmYM3T6J09pcQCpjlhaj6o+x6+dhI1FSI/mrOYnlQ5Yapa
        tE91+mvVY/JUHK5F1r8Sd19bO
X-Received: by 2002:a05:622a:28a:b0:3bf:a60d:43b9 with SMTP id z10-20020a05622a028a00b003bfa60d43b9mr3596855qtw.4.1677857755045;
        Fri, 03 Mar 2023 07:35:55 -0800 (PST)
X-Google-Smtp-Source: AK7set+3mcqZLv5O6pE/bMB+WazZAA7+g7AIZGHurGdscVxsG3ogM/CcqyrobKFw1jTrlB7s1oWSsw==
X-Received: by 2002:a05:622a:28a:b0:3bf:a60d:43b9 with SMTP id z10-20020a05622a028a00b003bfa60d43b9mr3596813qtw.4.1677857754759;
        Fri, 03 Mar 2023 07:35:54 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id r13-20020a05622a034d00b0039cc0fbdb61sm2052593qtw.53.2023.03.03.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:35:54 -0800 (PST)
Date:   Fri, 3 Mar 2023 10:35:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
Message-ID: <ZAIT2YI4WrzZK5NK@x1n>
References: <20230217085439.2826375-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217085439.2826375-1-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:54:36PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Fix two races in khugepaged+shmem that cause issues with userfaultfd and
> lseek, respectively.
> 
> v3 -> v4:
>  - Base changes on mm-everything (fba720cb4dc0)
>  - Add patch to refactor error handling control flow in collapse_file
>  - Rebase userfaultfd patch with no significant logic changes
>  - Different approach for fixing lseek race

I just noticed this one hasn't landed unstable, so I guess I just posted a
trivial cleanup that can conflict with this so it won't apply cleanly..

https://lore.kernel.org/r/20230303151218.311015-1-peterx@redhat.com

The resolution will be fairly straightforward though, and I'm happy to
rebase that one to this since this targets a real bug so should have higher
priority.

I guess it's possible Andrew thought the series has unsettled comment so
Andrew could just have ignored that whole set in the mark ups.  A repost
could possibly clarify that.

Again, it'll always great to get another eye on this slightly involved
series. Matthew / Yang were already on the list, also copying Zach for his
recent works on khugepaged just in case he spots anything wrong.

Thanks,

-- 
Peter Xu

