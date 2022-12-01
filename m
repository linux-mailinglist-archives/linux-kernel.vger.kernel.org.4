Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52663F894
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiLATv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiLATvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:51:25 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD5B71DF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:51:24 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3b10392c064so28485577b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+cxU5tsQZIeB8MEm8lyamTViU2V0IWkgm7seDl4PV8=;
        b=bEtqLuo2hAFMWMbuZ6x+99JPoTYgfQ0an+IKqqGdbPbpfAbIR8M6UsYf8t1tLPEGc8
         QKj8hUopQ2Lt+uCBQVfegJBGoYVezN9oNx6DP19lh3nYS2pnU1zlAv2mftHYhKvXWYv8
         snHwu7ppgcfAyFzBYXJJS/fAM1lfz7HLPY6YNKDzzo9GcnjIPJPj0CbwYfg+lH3PLmA1
         2RO+Mm97uTLOYXBC6sFThq5rGTh13Ncc4o2nEWXhxw8O17rc8GK7acVWJpMzVFZF/9LF
         M41792Jl/65v7D9DiK+0OGbrUNcgrY17A07Hd6jZkT2A142Mk5BCqjqETb71uBkiUF2D
         xmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+cxU5tsQZIeB8MEm8lyamTViU2V0IWkgm7seDl4PV8=;
        b=GF42na+0M4uodBBTbntoR1V2l1LGlqGNXjLHdNTiwUs6UHLH1SYzQTWck3ONBLgYjj
         4OPMBSidN7qn8wUXJqCAmMAgKGdWS/8vZPDX169KGoD5AqiGTzZUNu0FPGhW9ZR+y3vJ
         1eUbMQhSL7SJXMaXhfm5RE2Lh6P9awYuFFX9T7zhGLW+d8RnO4XFarcbBiFpPps7gjpM
         wChJLWULrRDuhSvgeEqWMs+3JpT8sSBAPAZSLzVwiIwpiK96uD+yjrwzdJJd8Ymb9EAt
         V6N4yT17fd78aaG0TqBnwzWwftG+g8Vp56iLnjw9poeangYD6w/g25ZHtxzNCJGeURex
         CTig==
X-Gm-Message-State: ANoB5plWHK6M/U7ZxprVIgQtatHMcfyMU0DSXg/KWzQ7HfMeYTvBPr7A
        o5OQZRaURQB//NDpbS/+cnPAAe4MnQYRjArGk0syYA==
X-Google-Smtp-Source: AA0mqf6CFQG1T7aehU9tXBhngYcgvwsjV64sfIIfE74DyYk+KSdOmNl6FBcLUM1qwHBsaZm/BpdBYo5m9sWQjchAILQ=
X-Received: by 2002:a81:104f:0:b0:3d2:b057:9925 with SMTP id
 76-20020a81104f000000b003d2b0579925mr11779662ywq.455.1669924282992; Thu, 01
 Dec 2022 11:51:22 -0800 (PST)
MIME-Version: 1.0
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
 <20221130151739.a7771037aa83ff536ac2edd5@linux-foundation.org> <20221201030045.GB3980@hu-pkondeti-hyd.qualcomm.com>
In-Reply-To: <20221201030045.GB3980@hu-pkondeti-hyd.qualcomm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Dec 2022 11:51:12 -0800
Message-ID: <CAJuCfpGvKN8kY-+DPf5W4Lc1vXEgmmQ=JgbYqz6Cnvkv5QFSLA@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
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

On Wed, Nov 30, 2022 at 7:00 PM Pavan Kondeti <quic_pkondeti@quicinc.com> wrote:
>
> On Wed, Nov 30, 2022 at 03:17:39PM -0800, Andrew Morton wrote:
> >
> > On Wed, 9 Nov 2022 10:48:36 +0530 Pavankumar Kondeti <quic_pkondeti@quicinc.com> wrote:
> >
> > > When MADV_PAGEOUT is called on a private file mapping VMA region,
> > > we bail out early if the process is neither owner nor write capable
> > > of the file. However, this VMA may have both private/shared clean
> > > pages and private dirty pages. The opportunity of paging out the
> > > private dirty pages (Anon pages) is missed. Fix this by caching
> > > the file access check and use it later along with PageAnon() during
> > > page walk.
> > >
> > > We observe ~10% improvement in zram usage, thus leaving more available
> > > memory on a 4GB RAM system running Android.
> > >
> >
> > Could we please have some reviewer input on this?
> >
> > Thanks.
> >
>
> Thanks Andrew for the reminder. Fyi, this patch has been included in Android
> Generic Kernel Image (5.10 and 5.15 kernels) as we have seen good savings on
> Android. It would make a difference on a low memory android devices.
>
> Suren/Minchan,
>
> Can you please do the needful?

Yeah, I saw this patch before and it makes sense to me.
When discussing it with Minchan one concern was that if the vma has no
private dirty pages then we will be wasting cpu cycles scanning it.
However I guess it's the choice of the userspace process to call
madvise() on such mappings and risk wasting some cycles...

>
> Thanks,
> Pavan
