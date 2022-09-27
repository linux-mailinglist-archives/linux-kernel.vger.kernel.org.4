Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CA5ECBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiI0SMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiI0SMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:12:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1BD2D6B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:12:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s18so6555326qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UA0/tgSQ2gUroOfJyqI9Qe+9Q/6Wy5CUcMkTK6avI5s=;
        b=K12nEPM8F0lgndPwXjzWtjjUHLXRkzGGm7YreNDb9cU7sRdcCGk1VZY5yLxog8SU4p
         v0KzQi9pgNmyHRcXTWic5twgnByy/uYMzKiUEhRuoz0uQkyeTkVaaXzS0/Ao2yi6Qet5
         RNLKFpT00gGfwwJuRIwCBVx5APecf0+d6pa/R/mqVWaCCPOX1BguZowGkdyQVKnIO8oM
         t2PlyL+5KvMPikt1mHIi1GJ4lwUJvqZjNS7htUUCF+Cju3c4F+imdFG3PX5jWe4ZzV6p
         ge52dg8xWZIm/OdLad+k1I/RHh8QIFn+levh0p/fePpyl773UgW/rAWUlDNDrxqWRlpN
         wGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UA0/tgSQ2gUroOfJyqI9Qe+9Q/6Wy5CUcMkTK6avI5s=;
        b=jPndUOG0TKcueBC/ENMKC/6GW2DL86tGLlqwpOxBchUGwKTKmaXuOMJdxDNahfKBsa
         GR24zF09kS6TQuUb2B7Xr8nd+UQCZZ02mlFFNZTOBQuL0FItx0MgMrdxfv48C/uzv4VW
         n0OECTgoEIjiUNxuXqkwHnm8HuorAkqTlVfPuLfLulLDLdQBnfVH9es1lvW6fHaJo4UU
         Ce8i4blYMNQRKAAWBqLMMl1XeFDtu/G3J89Bo2QmW86HDQDPgkCIsWGnG3DXl88urhwy
         wvdetIzeJ8f1la9+z2eGEvhed1Za/1k2KuGiKUcMRPadZED9sF+Yf7Yw0TL6qdminkVm
         +UMQ==
X-Gm-Message-State: ACrzQf1zwLdmIdOlqr99G+OBxa6IYV33GfbKNIZoernggzJV/cJfRtf9
        OBiaOoU47OjN1YUTmvzPHnlg5HhLw9xvSSa/Vko=
X-Google-Smtp-Source: AMsMyM5ZOeeUKMHQ0xGnJOQeu2mfzRUzLtqJy5/G9o3E7Orvg1JLirCa6XZ2k6OyesnQhKBJMms9c/KuhHHcM4HPApw=
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id
 n15-20020a05622a11cf00b0035ba3690cc3mr23563179qtk.11.1664302323892; Tue, 27
 Sep 2022 11:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <9345acdd11e953b207b0ed4724ff780e63afeb36.1664298455.git.andreyknvl@google.com>
 <CANpmjNM3EYpq_qaN8yzt6eVzK59YCPeBdoFMjLRBqoTy2p=HuQ@mail.gmail.com>
In-Reply-To: <CANpmjNM3EYpq_qaN8yzt6eVzK59YCPeBdoFMjLRBqoTy2p=HuQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 27 Sep 2022 20:11:53 +0200
Message-ID: <CA+fCnZeoaVHudERNTKFK1kNcOp9TY40kPxbCMM5zO75CDfHfuw@mail.gmail.com>
Subject: Re: [PATCH mm v2 1/3] kasan: switch kunit tests to console tracepoints
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Sep 27, 2022 at 7:12 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 27 Sept 2022 at 19:09, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Switch KUnit-compatible KASAN tests from using per-task KUnit resources
> > to console tracepoints.
> >
> > This allows for two things:
> >
> > 1. Migrating tests that trigger a KASAN report in the context of a task
> >    other than current to KUnit framework.
> >    This is implemented in the patches that follow.
> >
> > 2. Parsing and matching the contents of KASAN reports.
> >    This is not yet implemented.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks, Marco!

Andrew, could you consider picking up this series into mm? Thank you!
