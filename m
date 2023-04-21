Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5226EA905
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjDULUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDULUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:20:21 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4F194
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:20:19 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-771d9ec5aa5so6393909241.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682076019; x=1684668019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+bvG24rbj6Mwo1aSiBvly3dKujd5OE0y4T3IN5Gcis=;
        b=ZwRBjRJ+anhiesy73RmJ21BZRFAPms930ivmq7t1dyYs9JjJgoqwAWlAU9JJTYTwLN
         i8CV8K1NV/1NHgAp8qNRPLt2ZYT8yi1+BygITDu/qi/Umh+fRiRCfnaAx496T3pVr2+g
         E+caliM9mIBhekcjkGaEwdNPVfQr7uMDRzQwz/NPmq+8Xk24oW8SyRgSrdZvMgARgXPL
         YnLbRcg2DZImn5sX921X/aSrxVYikiUQ8XoBwo3xr3ImaG75JWQ7Y1X0T13R38KjA8Tn
         sddOZUCP466Ndwu73JRcLHUSS9xDxowUo24EFajBdNjecoRB4ilSF9PIP6G9B/MxAizq
         37tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682076019; x=1684668019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+bvG24rbj6Mwo1aSiBvly3dKujd5OE0y4T3IN5Gcis=;
        b=axDWQ3/kYMp3UAzv+yatHu9CoKhISqloCJUlcVh8osbTE8I8j/O66O9JXj7YGDQG6O
         +UyPqlzoonR61qNlhWgfQsbZlAL0a9fI5VPQrQBcFRs2D10e6Ke7WIfhMCsdJuwx37pD
         k4Ox1BxB8cUVuzuXKc/nLwPiWIUlX+xPMtD6SWXL2lr/LChtseyL5qx+zDiFL14/SpNf
         QnHU3sarIOgf7FwXExkYasLeoabrjvTTJNj394vz+79K3lqW4sYId1iJfEFjeldgLIUw
         J0CT586GAke3w1hR/e+Ai4g1DzZdMkMSErmest0ZA5a2+wd2vIDSUYtPuI9owNFRUBTO
         rKuQ==
X-Gm-Message-State: AAQBX9fYtopdbi/DrysBAk+St7vxMxRuPn9XXZTx+R8YU8NMfI34RW5w
        5ECyd3VToSYeO1sRY2mikmum6MjzXzJIk/QgPU8W9g==
X-Google-Smtp-Source: AKy350bLV9lITnSRR5EoNiVQUXa7iOsSEayZDWk5yBHeDU5nljypvqoPVYejGa2kG9BLkywHOlOW+gMW1Pn5GuaM4TY=
X-Received: by 2002:a05:6122:d02:b0:440:54e1:5bf7 with SMTP id
 az2-20020a0561220d0200b0044054e15bf7mr981344vkb.4.1682076018914; Fri, 21 Apr
 2023 04:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230421101415.5734-1-osalvador@suse.de>
In-Reply-To: <20230421101415.5734-1-osalvador@suse.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 Apr 2023 13:19:42 +0200
Message-ID: <CAG_fn=UzFaHrM2X0_X=9aRPe5Wcmzj_snAbY=GJCj8__h9PxCg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] page_owner: print stacks and their counter
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
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

On Fri, Apr 21, 2023 at 12:14=E2=80=AFPM Oscar Salvador <osalvador@suse.de>=
 wrote:
>
> Changes v3 -> v4:
>      - Rebase (long time has passed)
>      - Use boolean instead of enum for action by Alexander Potapenko
>      - (I left some feedback untouched because it's been long and
>         would like to discuss it here now instead of re-vamping
>         and old thread)
>
> Changes v2 -> v3:
>      - Replace interface in favor of seq operations (suggested by Vlastim=
il)
>      - Use debugfs interface to store/read valued (suggested by Ammar)
>
> Hi,
>
> page_owner is a great debug functionality tool that gets us to know
> about all pages that have been allocated/freed and their stacktrace.
> This comes very handy when e.g: debugging leaks, as with some scripting
> we might be able to see those stacktraces that are allocating pages
> but not freeing theme.
>
> In my experience, that is one of the most useful cases, but it can get
> really tedious to screen through all pages aand try to reconstruct the
> stack <-> allocated/freed relationship. There is a lot of noise
> to cancel off.
>
> This patch aims to fix that by adding a new functionality into page_owner=
.
> What this does is to create a new read-only file "page_owner_stacks",
> which prints only the allocating stacktraces and their counting, being th=
at
> the times the stacktrace has allocated - the times it has freed.
>
> So we have a clear overview of stacks <-> allocated/freed relationship
> without the need to fiddle with pages and trying to match free stacktrace=
s
> with allocated stacktraces.
>
> This is achieved by adding a new refcount_t field in the stack_record str=
uct,
> incrementing that refcount_t everytime the same stacktrace allocates,
> and decrementing it when it frees a page. Details can be seen in the
> respective patches.

I think the implementation of these counters is too specific to
page_owner and is hard to use for any other purpose.
If we decide to have them, there should be no page_owner-specific
logic in the way we initialize/increment/decrement these counters.
The thresholds in "mm,page_owner: Filter out stacks by a threshold
counter" should also belong elsewhere.

Given that no other stackdepot user needs these counters, maybe it
should be cleaner to store an opaque struct along with the stack,
passing its size to stack_depot_save(), and letting users access it
directly using the stackdepot handler.

I am also wondering if a separate hashtable mapping handlers to
counters would solve the problem for you?
