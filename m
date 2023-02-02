Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B866879BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjBBKEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjBBKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:04:33 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756188F1B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:04:30 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d66so1247154vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RdKAPor/0ql5fVXwvTpe95WItYbjw1iOZwcgd3aSLm4=;
        b=T7P/mMpoehcy1ri4dlxpZCVlU4M94VNqKPFWwI4rqtd0Xh2o29MTuSIDCVFhf7JBDH
         K0HO/qV31qhLSu9kD5f3VLr10gQBPUPYERsTGzVbGwxC51iElaPHsySEYLls7+ruMsYW
         xNVgeqzgSocYX7f+JvPyu9NQsly19A9ziphkmkctZ/Wny0ZEWdLU+rBSaTPKc1uwbQHB
         kaWmnJrzGWSkU0EmzOwz4mxHRDXtk3O3SifYTkbdh7eLzhJ1xHjeM72xXDhkzeQbMKdv
         M59cDk6G7jD0dRCZ9sTGcnNm/KuNePLyRH/ARU9EaUd2bC9hQsdjxre62E+bYbR39CcR
         eGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdKAPor/0ql5fVXwvTpe95WItYbjw1iOZwcgd3aSLm4=;
        b=EOMNbdEcyrStXm6Nn1qRLm5z9RjLaf90ZigyXhtARax88xY2Z3t9OhV0phBh4S/eBQ
         NIrcTUWabX5faOncOCBNm6BsB7EQNJDn0pXhOlBBrvGB1nvoEdBR5Su3dn3jRwJ+3lij
         zR92mXnkNU+dTtmFTPri5bxuDEgY6G2tXpuBU6tJGA3JJ0IHevjYmwF89Y2lCs3nvCvd
         E2JoIXFXRg4cvPofgwQae6HyNNCWUAtBm27mVoQqyHXZZ+l5YtE/FGKUfciGk6ajbF6D
         IY2F5eK4kD8jt1mx2NJOx5D1DFoUh3AXyPagJCX5MTsTwO3iyTSNjpLBJVi77fZMppyB
         3c0Q==
X-Gm-Message-State: AO0yUKX28k6o/eekQoLFV5t34ZyI1VsfBy4lXW8G1F6I/KKxYJ7S9ECk
        sVJ9xBF/iuMiERO42jlaAxOjWjn7H57+yb4aSqLYQw==
X-Google-Smtp-Source: AK7set+76DmKfMlu2D8d2hdSP1Nq8Zwz0cvhaKjmz+/RYMmVG/7RPrT6lO8OTXw72bsY6NIOKbOM/ceeo0P2tJK4YzY=
X-Received: by 2002:a67:fa01:0:b0:3d0:a896:51da with SMTP id
 i1-20020a67fa01000000b003d0a89651damr950443vsq.44.1675332269289; Thu, 02 Feb
 2023 02:04:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fbe58d38b7d93a9ef8500a72c0c4f103222418e6.1675111415.git.andreyknvl@google.com>
In-Reply-To: <fbe58d38b7d93a9ef8500a72c0c4f103222418e6.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Feb 2023 11:03:52 +0100
Message-ID: <CAG_fn=Uw6CA+N-dd6e_gp+AhogohBUU0XyNCTtjF6MZC_fgiCA@mail.gmail.com>
Subject: Re: [PATCH 15/18] lib/stacktrace, kasan, kmsan: rework extra_bits interface
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

> This change also fixes a minor issue in the old code: __stack_depot_save
> does not return NULL if saving stack trace fails and extra_bits is used.

Good catch!


> + *
> + * Stack depot handles have a few unused bits, which can be used for storing
> + * user-specific information. These bits are transparent to the stack depot.
> + */
> +depot_stack_handle_t stack_depot_set_extra_bits(depot_stack_handle_t handle,
> +                                               unsigned int extra_bits)
> +{
> +       union handle_parts parts = { .handle = handle };
> +
> +       parts.extra = extra_bits;
> +       return parts.handle;
> +}
> +EXPORT_SYMBOL(stack_depot_set_extra_bits);

You'd need to check for handle==NULL here, otherwise we're in the same
situation when __stack_depot_save returns NULL and we are happily
applying extra bits on top of it.
