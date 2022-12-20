Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6965276F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLTTzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiLTTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:54:11 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846E1EAC9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:53:36 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c140so14139792ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwnFJcsPqbI2VW6I+d19akHrm08uYcpLxkV9m2vTx7w=;
        b=N3VO6fanbQzcFw59rJk0rVdplAN7v/iHLbeJj+WFonDxzSeTtb0ll+pVmlMqhBYsl4
         SJ3CxZ0uhpHf7rNAKLG8lei3eumcjLyNQrqGRCiqT7hq7GwYWrSfWeouZaBZB7VIHQTq
         JC5OAOzb2isd15RQvajiIZOtGFHt1Bks++0AQdaLrIQR62gzFD7KJ8oot/Ipp773F9SN
         GULsheIgURn7bGYRfPlPtkgOJJczRme9Oz9FT0+AAmgw/da/hLFxyLdipTc46iWG90kJ
         Pt1QnGTQiaOKEL98hdGcqlDwXQwOzHToZA1GGEwc3qujLTZCso5E6yq6V2yYmAuYZIiL
         7QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwnFJcsPqbI2VW6I+d19akHrm08uYcpLxkV9m2vTx7w=;
        b=tiryZC9xhIStEf3bkeRdolZludIshs5yJW5owA7nppQzE0bny0fcrrl8/MEVMlTFdZ
         bPRG1J712Dl67r6PI+t5x5ooE/SJgAPDTV0ORT6hEt/2937n6xvhkOdIYBl68HTstZxe
         /3ezCCAJV50O2JLmt4G/de8TYiNvViY7pzhXlZaVVbtdbbI5w3l9nOpusXE3kcNTxYUl
         DsdezABWkorct7Gqe636zQ3k8DY/Pfp3YG8eJndTcQvLYQboztsrVEVaKqY6VW3/mFXX
         /N1ou7A0JnsUPg82BbfnaXDZ4uwDIr9tvlWUrabzGd+PDV2bvnRXbS2vRZIfGLctsB00
         Ddaw==
X-Gm-Message-State: AFqh2kq+q7idkcQvHcov21VtT4zT1nj7MnZ82zIT4ZDVN3PkRwaDYrle
        z7rrVNM+WXzDL1m49ExkSfR7hssZmMbGj7yUvKpVCw==
X-Google-Smtp-Source: AMrXdXten50mZXwWCtKExqPt0K7Es831NSWlVxmiQDT2EWU7O5xHDwK71SO8HCl1Op7eIvZmf0R5iZOgwen/jai4Qgs=
X-Received: by 2002:a25:9847:0:b0:733:af24:fe57 with SMTP id
 k7-20020a259847000000b00733af24fe57mr1508197ybo.228.1671566016054; Tue, 20
 Dec 2022 11:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
In-Reply-To: <20221220184813.1908318-1-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Dec 2022 11:53:25 -0800
Message-ID: <CALvZod7WNxj0vdfiEad_xfBACsJu3iA0nF25m4VN3M=yLF4igg@mail.gmail.com>
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Vlastimil

On Tue, Dec 20, 2022 at 10:48 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Sven Luther reported a regression in the posix message queues
> performance caused by switching to the per-object tracking of
> slab objects introduced by patch series ending with the
> commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> allocations").
>
> To mitigate the regression cache allocated mqueue messages on a small
> percpu cache instead of releasing and re-allocating them every time.
>

Seems fine with me but I am wondering what is stopping us to do this
caching in the slab layer for all accounted allocations? Does this
only make sense for specific scenarios/use-cases?
