Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499DA6828DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAaJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAaJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:30:30 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8028D1F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:30:28 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id u3so2819221uae.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb4ZLvwVAqQMn3anowjzMX/KwREznkusXpss39hXIZs=;
        b=XRAHzGnG2Vhz2trHE2vGYlBS045uWpa6mo02OhCc+Y+yOHLRS6MglwEDJvQGrHlGMw
         atQggWzi93C4Omw16FSWlzEgyEmZT4s9pFUMWpxGg7iYKy8zDaaZ0nt5zDxLNROtJKNh
         RBaWJ1s/Q3YtGGPZTp48Y2XPd3pX88bhydwmpiaw7s4qq2ZFDkMtSdWGPOF6OPxJhMOe
         LBpDdqXP+HRyoiuxcj/9WVtf24dQhLSn8gdwQGEeYlASiLZ23/LBJNn2w3AVUqAC4dkL
         cZ2ODUcvMaI38UV6Nzz+mwQmJJDMg7B5n/+uH0XKwk4BIUivjOfJC2M7GVRCeHsBByMI
         zT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cb4ZLvwVAqQMn3anowjzMX/KwREznkusXpss39hXIZs=;
        b=idUqOUpyEouHOLFcDlLz3ix8uVefDDUyoWrJimAFOMkKz+cuuDFDG1b+2kJnKRNy64
         HceTuQSpm9pdps8Nw+o8eAf06coqp193sp3V6vjmcfznkTohOQQJXC+JUkIoPjfqjdoG
         /Agob404LIrEDLBfw1tfBPBX8lhHBSHZy+/3UQtYj8KZSO0mGvSCaYu9Dw5W0yYNO3NA
         9YdLn3kBIIT1MpoWOjltKcxqIBP5gzkpbkfAJtO0mfYW8fsOzZb/zi1fJFjQOMH8xdK9
         R+5h1DVzAN2bleWtdej9BJq4j1Wvqhc7ujANSl5IZ9DVnPGJyydOer3g9smirPOE7I3K
         JksA==
X-Gm-Message-State: AFqh2kp4RrBferIxVyS608UMqxp5kf90eCPk4iqZOoWBIp+CIaehJ2fW
        OoUg/P34RNCosYMH2MH7qwzbg7YP03sbtWwzJ0r7cQ==
X-Google-Smtp-Source: AMrXdXv2QnqPvTZoUFbskWKQJ1VxBIQtfHPHrvs+nAWPAf+wbWhb34qdxYIIVbOh+Sl0rVVEK84poHcnOzStbV3bhwY=
X-Received: by 2002:a9f:372c:0:b0:5ff:91d2:ea36 with SMTP id
 z41-20020a9f372c000000b005ff91d2ea36mr6350452uad.43.1675157427073; Tue, 31
 Jan 2023 01:30:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
In-Reply-To: <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 10:29:51 +0100
Message-ID: <CAG_fn=VO0iO4+EuwDR0bKP-4om9_Afir3fY6CExKGRNad+uPLA@mail.gmail.com>
Subject: Re: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in init_stack_slab
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, Jan 30, 2023 at 9:49 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> In commit 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in
> stack_slabs"), init_stack_slab was changed to only use preallocated
> memory for the next slab if the slab number limit is not reached.
> However, setting next_slab_inited was not moved together with updating
> stack_slabs.
>
> Set next_slab_inited only if the preallocated memory was used for the
> next slab.
>
> Fixes: 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in stack_slabs")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Wait, I think there's a problem here.

> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 79e894cf8406..0eed9bbcf23e 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -105,12 +105,13 @@ static bool init_stack_slab(void **prealloc)
>                 if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
If we get to this branch, but the condition is false, this means that:
 - next_slab_inited == 0
 - depot_index == STACK_ALLOC_MAX_SLABS+1
 - stack_slabs[depot_index] != NULL.

So stack_slabs[] is at full capacity, but upon leaving
init_stack_slab() we'll always keep next_slab_inited==0.

Now every time __stack_depot_save() is called for a known stack trace,
it will preallocate 1<<STACK_ALLOC_ORDER pages (because
next_slab_inited==0), then find the stack trace id in the hash, then
pass the preallocated pages to init_stack_slab(), which will not
change the value of next_slab_inited.
Then the preallocated pages will be freed, and next time
__stack_depot_save() is called they'll be allocated again.
