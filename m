Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5786944BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjBMLlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBMLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:40:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A614E9E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:40:49 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id t7so3369217ilq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNo1hAJNIesNvAPFE4VcY9SxxfJ87Kojc4RqWUh0cGc=;
        b=gjzq7/aqmFScogW1z3sM+ubzYuBzmPb/CIwZFAnBLdoiB/u1NdufEuhb22tHljQVtQ
         RDAu/3vsouQRLl4FGGx25O6B8RpKUHV///uMqKKN0boRauftljBnedZOlbfrqxdJwxWw
         RrBCawHWdLMG2h+ir0rVA/0Edy5D0nk0j/9BZ3GFo4H/fUDxO7K9ilS/qXGxdwvJW5pg
         BT1jROmbXmkgNduMIu9kMDkIMr7M0Zt9F/9AFa/H0apzxwYB4VFtZAYZC6+5Whyra1MP
         ivSHXywm935Ma4LuxPdUgs8S6FH2qTMJaA7DQOoGutmM06pbQUywydhfXnPvKdO7rHJ7
         LFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNo1hAJNIesNvAPFE4VcY9SxxfJ87Kojc4RqWUh0cGc=;
        b=idxtdHr5OOls0VtvgtyZL1KHybUPuVVPanH+YZyV1XY297bCSfvefnZoFP7IL/5xPS
         UHTFxQjc5Vyx3EHhj+Rqtxh9iQzhsf9YjDI2sMqS6WO6Ut0oL+quEUWU3keRODpKUTA0
         h32b7Lw8MtAJx/IEH4d4UbBBbtP0FQNFRSQW9clRzfni+3heQWD1xPXjoQuhvllwicwK
         nOHuBrqMzL1/ImMnlCMYS5zmu/2FCojwiZV9vw9IFeA7darxAVqw7UxiAck8hmTqwbh1
         2v8R9PNQL4gfZdCMhLg+vEU2DrL87CaPGDxk05q7aYN1b8et67BT9DQLxRlWlXl3Os+5
         ecOg==
X-Gm-Message-State: AO0yUKX3tLv+M3UlnKCsiAOoqMvwgtSA0PpawGr0uSwzpr7xDoTdk5Ob
        JTH2GnAQMZRaBvNwvcJPYwJRrFEDtRzk9tweXo69tA==
X-Google-Smtp-Source: AK7set8V6mp8FME9QH/RzAyHSBACV/s/IPVMAFS6yBVqeS0BoFmBk9j6XtDVeToerNuRrE3+u8HD1A2PwltwVeJFlJU=
X-Received: by 2002:a92:8e43:0:b0:30f:5797:2c71 with SMTP id
 k3-20020a928e43000000b0030f57972c71mr13112784ilh.51.1676288448825; Mon, 13
 Feb 2023 03:40:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <317123b5c05e2f82854fc55d8b285e0869d3cb77.1676063693.git.andreyknvl@google.com>
In-Reply-To: <317123b5c05e2f82854fc55d8b285e0869d3cb77.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 12:40:10 +0100
Message-ID: <CAG_fn=W+DHE557+u66qAUbo9tjL6qgcktEJPfTCzFRAE7Ckd5A@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] lib/stacktrace, kasan, kmsan: rework extra_bits interface
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

On Fri, Feb 10, 2023 at 10:18 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> The current implementation of the extra_bits interface is confusing:
> passing extra_bits to __stack_depot_save makes it seem that the extra
> bits are somehow stored in stack depot. In reality, they are only
> embedded into a stack depot handle and are not used within stack depot.
>
> Drop the extra_bits argument from __stack_depot_save and instead provide
> a new stack_depot_set_extra_bits function (similar to the exsiting
> stack_depot_get_extra_bits) that saves extra bits into a stack depot
> handle.
>
> Update the callers of __stack_depot_save to use the new interace.
>
> This change also fixes a minor issue in the old code: __stack_depot_save
> does not return NULL if saving stack trace fails and extra_bits is used.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
