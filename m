Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3319564603A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLGR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLGR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:28:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D963134
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:28:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d1so29046900wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=apHINZRI82aKyVlEfjuhtBGaqHolQ8IQWN/c5e4WtmE=;
        b=lolI73W7ggYljDiRWvtJ0YSQSHeXmC01JTcvMR3TNuIWzNf3IgsQJu7nNxzbPUcR3w
         y0y8AW1ZJxP0xhssbXoK5m8SW8Do0+fbBXFlnXoY/Mk8hQPFPJEQGl2DUKnALTdctm25
         PHHjK4SuvpTgtKqH4bb0dYMQPx72nV94rrXzGmgYpSHkjiPVexDSFrWNjU5R3rKZkDHT
         knoOfqthedpbfiLCZNct9RXqcS15Y1WGJyUrN3yYahDaaGo89FZKsGQkN4dtWGpaf7hN
         YzyxJyfuOPYQEQOCt99vP3TCUe9RmJzuufA1q0Tw/PLA0eMe5OUSI5sFhwkkh/yrxgCt
         aq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apHINZRI82aKyVlEfjuhtBGaqHolQ8IQWN/c5e4WtmE=;
        b=gqAu2qxam9jPQ/Sj3sxRdPU2ByoMElmLjkpIiHDmFBYCM6mpmCRH8fxQ0B/AETyShb
         VLvyXEtl3FE1POri2ML0z2XYBkWMBZePbqekrmfAroWTrgD61G+PVLpeJjT8z0uRuDiu
         z9M3tX5MkZh1qa3/d3aR7nBu9y4y4kk+gAGeQFJ1psnNVJAkNStrMa/NpE+/0yK8WKgF
         Wql8562/hViARD4TBINK3r4g54Re0iydXzpdmeQ89OW2opM9p3z5cWs6YmoYizk8KF47
         pQ+afhii3bxnX1CATB+a7I1qrEIhe4KgyRb775fbFraZIrPI9LJeL5su5o2S9uPDDkLD
         3aPA==
X-Gm-Message-State: ANoB5pmj8VufNQJ/gAwvIflOariluH90TAwy7ue9DngcOMszTyePmIx4
        W/MEat/TaaTy9ZDl95kvgZ4m0IuuN5uz+5E6G6JvS8YhUss=
X-Google-Smtp-Source: AA0mqf6lfG8+zRqSPFF8CVq7AlapT7nk1S8+ohBzQUkyKmyN+PzmVDG0lYhFrzwjeI6K0IyfemWgq6sEeB2haGcWqXg=
X-Received: by 2002:a5d:4b45:0:b0:242:1ade:1145 with SMTP id
 w5-20020a5d4b45000000b002421ade1145mr26825231wrs.483.1670434120604; Wed, 07
 Dec 2022 09:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
 <Y49eT0JmOt97Caca@casper.infradead.org>
In-Reply-To: <Y49eT0JmOt97Caca@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 7 Dec 2022 09:28:29 -0800
Message-ID: <CAKEwX=MmiswiBwEjS_7S9++JjRb0pbD0kcvY_UhrU4zN0tTiVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] workingset: refactor LRU refault to expose refault
 recency check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 7:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 05, 2022 at 09:51:38AM -0800, Nhat Pham wrote:
> > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > +     struct pglist_data **pgdat, unsigned long *token, bool *workingset)
>
> This line needs more than one tab indent.  I tend to use two tabs,
> others try to line up the parameters with the opening '('.  But
> one tab is too visually similar to the body of the function.
>
> >       rcu_read_lock();
> >
> >       memcg = folio_memcg_rcu(folio);
> > +
> > +     if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
> > +             &workingset))
>
> Similarly here.  &workingset looks like it's part of the body of the if,
> not part of the function call.
>
> > +             goto unlock;
> > +
> >       if (memcg_id != mem_cgroup_id(memcg))
> >               goto unlock;
> >

That's fair - I'll add another tab to each of these lines! Let me
know if you have any other concerns.
