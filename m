Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079676E80C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjDSSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDSSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:00:24 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F85254
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:00:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c12009c30so9726427b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681927222; x=1684519222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF8zWEECq6y59xFQqCF9TSLTw1U808D+I6SwxrtHJ08=;
        b=dkoGLjEMM8NAdDtKNRiFkIDW8qDzerjNU2waWt6rcJddnac2GNHA+bzRz/bvxEmDbt
         2SV9wmtJSv1LIwzAVA5w5TbZtsVnWHYoUSW+OrkF/2RCPO9rLYcgj16w6kQfNORvjhhL
         JWTm1TUZE+Qjbq9Vqd6DhhbAEqurbe6r9lUdcCHItrCZkD1SU19URrg3FzKSUclt9/m+
         AJbUY9ugnpi2pQ0/1vo9nZl3Qw7FhF0DaB/5+iIOVZ0u3PAwCDHnWhWrsUQlaqWEvPwY
         xQaH40v6JCG81ixJ/v1So0kGQx+rVBU3+nxIHk0o6way+d32sHv+WWYEiZUQVXqQfMGd
         GAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927222; x=1684519222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF8zWEECq6y59xFQqCF9TSLTw1U808D+I6SwxrtHJ08=;
        b=Og4k3r7T+jje/cJ9ccdPBfC/Pn+y1AV8xM5g2tl+SprxubRw3MNkcuF/BEie+vtPvJ
         aJQ8spIZn6QjR6ze8gOMH7muCrWdBshDS9QVc5l1G3o9h03AYfVXg4V06fTQ/kscqr7r
         qR2XXpcg5LCu0bHsFOUAR2FG+2QbbGC77OBw+aWvn+Usc+sqB+wYzvlDwxtztK+Lr5w2
         DXRjTMo0GpDyMf8knvO6Z78mVgOZm8GcEzDwEsCBaGXm6KSdqwz/mgdx1BaGs0Hr3Tha
         Ac6UuWiBHWlj9GYsRwKayoJz4espc3nL6hmr4E2Hvv/Akswl9+ZXIbw7inSZzYYKuStR
         QuIQ==
X-Gm-Message-State: AAQBX9cvnWKa3Jnu3zVQFCxuz4z2mxhLZ+1DbDYoabvUD616+EhrlUsl
        zrqoRO1BYeCq0auOPg2tmlN7TischKmUCgJWxdWlBA==
X-Google-Smtp-Source: AKy350Yb7cLtNx5IEZ4I9bEcR3hs2rytKzneRqInyFgN4hI0lZmftku7jfGdSl9+//WSuaHuuu5nTeRtZYakkjrmKZ0=
X-Received: by 2002:a0d:ca08:0:b0:54f:d538:cdde with SMTP id
 m8-20020a0dca08000000b0054fd538cddemr3909763ywd.39.1681927221873; Wed, 19 Apr
 2023 11:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZD3Nk0u+nxOT4snZ@casper.infradead.org> <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org> <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org> <ZD6/805XpvfZde0Y@x1n>
 <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
 <CAJuCfpFFsKkdnHLSojSo0pP-=nQFiY408tpVDHVy6TpGSv1B9g@mail.gmail.com>
 <ZD8dj3Tk2b1TWVK5@x1n> <CAJuCfpFyetOXEMB2+b3LRO9-ESdDTdEyOyfUGsr0FbsWJi1-kA@mail.gmail.com>
 <ZD8p3+XyvCiq9RJW@x1n>
In-Reply-To: <ZD8p3+XyvCiq9RJW@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 19 Apr 2023 11:00:10 -0700
Message-ID: <CAJuCfpG8+99WpKfZ0skd50P3PUrQ80KuNyJoyCy4dkWybYLR9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Apr 18, 2023 at 4:38=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 18, 2023 at 03:58:26PM -0700, Suren Baghdasaryan wrote:
> > Sure. How about replacing my prior "Register both successful and
> > failed faults in PGFAULT counters." comment with "To preserve the
> > behavior of older kernels, PGFAULT counters record both successful and
> > failed faults, as opposed to perf counters which ignore failed cases"
>
> Looks good here, thanks!

v3 is posted at:
https://lore.kernel.org/all/20230419175836.3857458-1-surenb@google.com/
Thanks!

>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
