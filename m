Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5287E63C7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiK2TIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiK2TIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:08:38 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0E537F1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:08:36 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id n12so10380003qvr.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmXXccF6gcyyJcn8xYpOax7l00RlE3WtMYxosINrpmo=;
        b=1kG96GwDm4z4tl5X58tMTSiaw3DnpfdCF/rv7UlXbsY8+W8PnZuGywUo6KHIprE3/m
         C3/GaQpilxnGQceURvNXTO1ziGUJq4Vc2aq7zP10STkI1U+qpHo7fv8DPSjq5nmE6ZDr
         C650xqNqffQvPC+Elo1PQXQrtus8NaS/ki4zN58D+ZaxSNRC+Vtxehlx8iQIVmXaEnyn
         dXr1dJoOKIVqUhDcSoGHaKX3y65ZqZegji+EglMCsAv+k1m5HXwK3Hflzhq4HrxtID2A
         PruXnlCS3Ni2PLeN/PPbY1Pqv87aHsLGz+Av6nyMfMl+F8m8jTAKXsXDZ+jBt1Cs+Aaf
         UU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmXXccF6gcyyJcn8xYpOax7l00RlE3WtMYxosINrpmo=;
        b=shlAfrWa/9BuSZgD+/CRQ25OOGo8BVVrHdPQEjT9OpJuYR60aE/QAtYZHruDX9fIVa
         GKDJrQcJeSNPOeh54zpKKV5Tq9XH+jGFhkcTZEfQpYxzgbr5etEJL7KLR/zUIxPs09Nt
         yCW0cki1KQ7FvybQrxAxXS95g0JaGWY2KhhjRdTIF3cwmMt/wNQeA4uaPD3EfjakSCvT
         MYya/ThYU+mQ2o24XldnZZ3mqhmwGXATdh52Zz+DRYDt7fcKy2kVSW1Kv8Na4/a8F2hO
         1cO5yGjdjIXaQy6eR3kBSqErbXVGOHDpkdhjuexE3ZgMRJJiBChYYGkcwN/VZ6PsULeu
         KZSQ==
X-Gm-Message-State: ANoB5pm2WxmY4OBrE4p/pVZICTXPNNAKLX/yl9yXvF0qoMOMTyJk3ER3
        bdu/UvHKqStOzE296WZ/DYpxDUvGZ7DKUA==
X-Google-Smtp-Source: AA0mqf7kOv2D0QHrH528Onq6INt8AdhEMV1yVr/SaOZ92ayirYrrlPL0UhZs4UZIEVoDmDOXy1GqwA==
X-Received: by 2002:a05:6214:3612:b0:4c6:e2b4:8c6c with SMTP id nv18-20020a056214361200b004c6e2b48c6cmr22819440qvb.13.1669748915997;
        Tue, 29 Nov 2022 11:08:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ea9a])
        by smtp.gmail.com with ESMTPSA id w23-20020ae9e517000000b006f9f3c0c63csm10841129qkf.32.2022.11.29.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:08:35 -0800 (PST)
Date:   Tue, 29 Nov 2022 14:08:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
Message-ID: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
 <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4TpCJ+5uCvWE6co@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:59:53AM -0500, Johannes Weiner wrote:
> On Wed, Nov 23, 2022 at 10:03:00PM -0800, Hugh Dickins wrote:
> The swapcache/pagecache bit was a brainfart. We acquire the folio lock
> in move_account(), which would lock out concurrent faults. If it's not
> mapped, I don't see how it could become mapped behind our backs. But
> we do need to be prepared for it to be unmapped.

Welp, that doesn't protect us from the inverse, where the page is
mapped elsewhere and the other ptes are going away. So this won't be
enough, unfortunately.

> > Does that mean that we just have to reinstate the folio_mapped() checks
> > in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
> > commit?  Or does it invalidate the whole project to remove
> > lock_page_memcg() from mm/rmap.c?

Short of further restricting the pages that can be moved, I don't see
how we can get rid of the cgroup locks in rmap after all. :(

We can try limiting move candidates to present ptes. But maybe it's
indeed time to deprecate the legacy charge moving altogether, and get
rid of the entire complication.

Hugh, Shakeel, Michal, what do you think?
