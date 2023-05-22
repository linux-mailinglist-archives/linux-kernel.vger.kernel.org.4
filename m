Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4370B7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjEVIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEVIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:41:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB7B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:41:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so38652755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684744892; x=1687336892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQPFzLEwac+E5AoIBX7hUXtHAL/mEVRDL3gEWHhERoM=;
        b=P7E1GPikLVt35N2MgYkkC6MJEueFa+/LwbcxXJ6JhTBmv3oTFGoIVnphyX67MGILnQ
         KcdrZVwfeaG0F/t8ms/2YSdc4i5dq1nzyD6m7IOiSc/P88Mt1SblJAUIsn5UiySv8G6h
         JVObu2ucqORbd9tjWDrfZy5mEJFS2UVrrgj2ldUWqmjHCZkf6LNrj7nTHEHFHHox/6W1
         Ex4AC7Gao7i19lwq8W0S825VwWAbuyn/rA1ZDqPaYGcuOJ4qUFx3CN/S8cWXRjTrQ6Si
         1e4ffhnivTT1fonDJa7ahEc77RkatBQW0lzGwtNT3RvE3K9JHlWEfAb3wYYdCB0F+RTb
         +BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684744892; x=1687336892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQPFzLEwac+E5AoIBX7hUXtHAL/mEVRDL3gEWHhERoM=;
        b=KgqsyjVmDBOIPZSsUG06lIYXWJUhGkukr+sU44cAQVDiH31NOJ3Y5vfoaV536prDTE
         H6MZ7eUCjfj+Lsi4o7r+6DWg9KIo043+PRqFDa+w7lbgrFtAY3ejtbdCTNanFusD2H0q
         3PwidgXp60t2vxDXxafcEZiZyvTnLp/4GaE7lu9851AOXGzKxqzEG7jJ/cyEmaCDKPM3
         /FXYJbw6HBLe19rvWoaUAVMXV7L922BBVVKbQsFLJacvtAZCZdM4Wt8IAKx2Lu7YTuAD
         maYK+v5ajq6T8cqNaKxo6z86hdLh1zTGZdXxd2qtwTwAhEY4vD2V6Md3E98r2MhScidY
         FIYA==
X-Gm-Message-State: AC+VfDwy/z5P6mVk3MpBCt+rogndzdxOniZ8STd564+fFZVzwjEdpK+8
        7yKb8WPWcYwxJVo7rABUNMWDsR7FiXfpW8zDl4L0Dg==
X-Google-Smtp-Source: ACHHUZ5Av3kRe5PCmqrWW6oRTQaSgZDrHTgmfB1+0sby4qvFXFelR7YauVzomYRbNYZBgn7ZMPzGfu6P2RAsEWOUZGY=
X-Received: by 2002:a1c:7315:0:b0:3f5:9ba:442d with SMTP id
 d21-20020a1c7315000000b003f509ba442dmr7273496wmb.33.1684744892238; Mon, 22
 May 2023 01:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230516182537.3139-1-osalvador@suse.de> <20230516182537.3139-4-osalvador@suse.de>
In-Reply-To: <20230516182537.3139-4-osalvador@suse.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 22 May 2023 10:40:55 +0200
Message-ID: <CAG_fn=UJgnLFGgpkXbMeD6axZN_ifEPHvWpy2_oiPyG1a6PXng@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mm,page_owner: Filter out stacks by a threshold counter
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 8:25=E2=80=AFPM Oscar Salvador <osalvador@suse.de> =
wrote:
>
> We want to be able to filter out the output on a threshold basis,
> in this way we can get rid of a lot of noise and focus only on those
> stacks which have an allegedly high counter.
>
> We can control the threshold value by a new file called
> 'page_owner_threshold', which is 0 by default.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Nack.
We must decouple stackdepot from page_owner as much as possible, not
add extra dependencies by sharing variables between the two.

What you need here is a pair of xxx_iter_start()/xxx_iter_next()
functions in stackdepot.c that will hold the iteration state in a
struct and return the next stack trace.
The threshold value can also be part of that struct.
