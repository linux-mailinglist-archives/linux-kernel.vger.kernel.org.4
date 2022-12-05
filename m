Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82A6439A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiLEXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiLEXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:38:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EF81FF9D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:38:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so13128884pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNLoUhiYobmP9bOtj7/XkDyvOhLAhDsxAU1nXkGHdyM=;
        b=fOuWe2ZA5NZUMq4NUtvsO/z6eY5hOMUUUzgZkRNwMH1XjOT7Hivq9r+UV19vma2M6b
         F5GjAtwRFsODWgNItqjyucOrnJuh0441y58c96fLfPKwl6iR8efOj/OWoQZzv4NO5rT0
         HGGAaZbd+sy+YjZBQV5/CdZIVQOyLhIPmgsJbuhGvn8ZIwD9WIJ0uGYcf/kvPnBwnzG3
         HZ59T/MYwza2dFAIe+epjUUyCjKTdIVjnqUE7aH0hwtvE7DrMuH6BpFlJ3YITDlsrGMg
         9VLLLhKSelBOsrbMhCUOsVG4kXWaThyNPse2oaY0JoH99et7gAJBPWA7yRepAHyFcGT/
         tFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNLoUhiYobmP9bOtj7/XkDyvOhLAhDsxAU1nXkGHdyM=;
        b=AV3uHMRd5IU3OfP8Z/+okcbg58GYfzU9oh8JLow0G3w89yapzzr2d8FByThYAUZlhq
         JgFSO0ShxRZD1R07Km2cPq+eAb4Y2/ekVz7790AH47zfrsLgwpurYPM2dScQ4JfC1U6f
         v1YHnx5+mJ2EiR067x20vABhQ/Q2S54JPe2s/idFc0xqNBMyAkUNZ8Qhf65RXHYNuHxr
         3IahPCE1bg5MVn6owRtA4g+vK9qVz0tmDBwoQL5ibzVTv9slaH7bmq6ZpQ8dy2tG7unb
         nWUepNbROxD3JRlNV8/peqbFy9xCRFsENlUsDpm2N87Zi28EItvb/FncQBq8ZLVu7TlA
         BOKg==
X-Gm-Message-State: ANoB5pmU+YeeM7+RDrjdKVXnj6Tpi9i1HiUvUzVkP2Ha6TBcdIIZ4W3v
        V0qWY0i6UHVIGs/z6FalowrpuLWpBbemHL6qVvs=
X-Google-Smtp-Source: AA0mqf4/T85GnagMf8xKs0oq6Ky1c0Quf5SrKMRVY4uZVBTBFEVHFzGTks3vgUpgKZHnWNzVsgv9lHqGLVkCBEBHfe4=
X-Received: by 2002:a17:90a:4889:b0:20d:d531:97cc with SMTP id
 b9-20020a17090a488900b0020dd53197ccmr93180378pjh.164.1670283484324; Mon, 05
 Dec 2022 15:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20221201233317.1394958-1-almasrymina@google.com>
In-Reply-To: <20221201233317.1394958-1-almasrymina@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 5 Dec 2022 15:37:52 -0800
Message-ID: <CAHbLzkpuJAx4LGpHMSfLUscsFR5Z5BRXdce2tPGdf=uHxfhCLQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: disable top-tier fallback to reclaim on proactive reclaim
To:     Mina Almasry <almasrymina@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 3:33 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Reclaiming directly from top tier nodes breaks the aging pipeline of
> memory tiers.  If we have a RAM -> CXL -> storage hierarchy, we
> should demote from RAM to CXL and from CXL to storage. If we reclaim
> a page from RAM, it means we 'demote' it directly from RAM to storage,
> bypassing potentially a huge amount of pages colder than it in CXL.
>
> However disabling reclaim from top tier nodes entirely would cause ooms
> in edge scenarios where lower tier memory is unreclaimable for whatever
> reason, e.g. memory being mlocked() or too hot to reclaim.  In these
> cases we would rather the job run with a performance regression rather
> than it oom altogether.
>
> However, we can disable reclaim from top tier nodes for proactive reclaim.
> That reclaim is not real memory pressure, and we don't have any cause to
> be breaking the aging pipeline.

Makes sense to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  mm/vmscan.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 23fc5b523764..6eb130e57920 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2088,10 +2088,31 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>         nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
>         /* Folios that could not be demoted are still in @demote_folios */
>         if (!list_empty(&demote_folios)) {
> -               /* Folios which weren't demoted go back on @folio_list for retry: */
> +               /*
> +                * Folios which weren't demoted go back on @folio_list.
> +                */
>                 list_splice_init(&demote_folios, folio_list);
> -               do_demote_pass = false;
> -               goto retry;
> +
> +               /*
> +                * goto retry to reclaim the undemoted folios in folio_list if
> +                * desired.
> +                *
> +                * Reclaiming directly from top tier nodes is not often desired
> +                * due to it breaking the LRU ordering: in general memory
> +                * should be reclaimed from lower tier nodes and demoted from
> +                * top tier nodes.
> +                *
> +                * However, disabling reclaim from top tier nodes entirely
> +                * would cause ooms in edge scenarios where lower tier memory
> +                * is unreclaimable for whatever reason, eg memory being
> +                * mlocked or too hot to reclaim. We can disable reclaim
> +                * from top tier nodes in proactive reclaim though as that is
> +                * not real memory pressure.
> +                */
> +               if (!sc->proactive) {
> +                       do_demote_pass = false;
> +                       goto retry;
> +               }
>         }
>
>         pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>
