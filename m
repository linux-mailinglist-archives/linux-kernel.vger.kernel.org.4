Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1B6B3125
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjCIWkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjCIWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:40:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F53D509BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:38:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so13297796edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678401519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIVP+U9IXmg9igNMbR9KE+dlRtqJIh5HRgs4QRiTQQA=;
        b=ifpidnJUCwCO7tXzTto2idUUHuYawl7SNcbA1YLMw7oJweI8S0ykSH+vudNquLAV2f
         r0T4JfyTZY54X4tZHvAWag8GZTNQkcHDzfijfkkoRGVPOlZb5iC6PKVK7AkyR911Uyse
         3zXzBs+xhdCa2r7E/zroPX110xJxmWp00O5P2o/mxZ6WQ5DMNIwr7URcmr7KG/no6Qu2
         pkPcM9F05p0G5shNzx+TH8Oxeu0sosJCuqhHwoj+u7zhMhUC8C1OhsHg1pSgkbpHvBD/
         GTe6P8k5PYEq6uFqEK6rBR9/DXkGvR86aoS3XTH4et7vWLcE/DJszY7ARrtX1hDmAVxS
         4iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIVP+U9IXmg9igNMbR9KE+dlRtqJIh5HRgs4QRiTQQA=;
        b=KP2vA5BknNoCbpV+QoEv/eVPC36tY4z/rQUrYx0PQpKQy8p2D5du7Q83m8gSE8NxTr
         lLXTVg7znUQLtsh0nLNYO+LtgM50fsFPSt5X+y6BaqB7ezpq2P53zcRo2ZfbNC2jgeBc
         o5cP2hdoTw5h7vdYtyCn2dDMZgjEmJijfTCAYhhXvKodcVcB9McCaY7o+jVbmkOGvrGT
         j1ZttHyxXcXdRwbQj/TkIAh7WXGJdgUlNM4+Th2dMcWfxumdU/pAs96nPXRTMeo4uZuE
         4UjQO4qxffs0VpTRwya0OF4kQeqvPZ/Vo3UQFQuyyD3OkhrgWrUtZKEyQg6PgLPy4z3o
         vLXQ==
X-Gm-Message-State: AO0yUKUaV1vkw0kZN8NR6C53xd2m1fI7D8e0KEBv1YdZLqBlynqh7S2F
        9ooXYEG5/Q3uH7AMyYNMOqUEJu7J4Wxdl91CbAIu4Q==
X-Google-Smtp-Source: AK7set9ZCtHMECp6dFXoSY1Mc/M0yJkIFeY9zLiltN6dJ2EEYBuUWVxA6LVpRPp/SJpk68hCxQcWkM9w/3Uen4BjbbY=
X-Received: by 2002:a50:d581:0:b0:4c2:ed2:1198 with SMTP id
 v1-20020a50d581000000b004c20ed21198mr12985289edi.4.1678401518988; Thu, 09 Mar
 2023 14:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
In-Reply-To: <20230308190206.GA4005@monkey>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Mar 2023 14:38:01 -0800
Message-ID: <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
Subject: Re: THP backed thread stacks
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 8, 2023 at 11:02=E2=80=AFAM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 03/06/23 16:40, Mike Kravetz wrote:
> > On 03/06/23 19:15, Peter Xu wrote:
> > > On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > > >
> > > > Just wondering if there is anything better or more selective that c=
an be
> > > > done?  Does it make sense to have THP backed stacks by default?  If=
 not,
> > > > who would be best at disabling?  A couple thoughts:
> > > > - The kernel could disable huge pages on stacks.  libpthread/glibc =
pass
> > > >   the unused flag MAP_STACK.  We could key off this and disable hug=
e pages.
> > > >   However, I'm sure there is somebody somewhere today that is getti=
ng better
> > > >   performance because they have huge pages backing their stacks.
> > > > - We could push this to glibc/libpthreads and have them use
> > > >   MADV_NOHUGEPAGE on thread stacks.  However, this also has the pot=
ential
> > > >   of regressing performance if somebody somewhere is getting better
> > > >   performance due to huge pages.
> > >
> > > Yes it seems it's always not safe to change a default behavior to me.
> > >
> > > For stack I really can't tell why it must be different here.  I assum=
e the
> > > problem is the wasted space and it exaggerates easily with N-threads.=
  But
> > > IIUC it'll be the same as thp to normal memories iiuc, e.g., there ca=
n be a
> > > per-thread mmap() of 2MB even if only 4K is used each, then if such m=
map()
> > > is populated by THP for each thread there'll also be a huge waste.
>
> I may be alone in my thinking here, but it seems that stacks by their nat=
ure
> are not generally good candidates for huge pages.  I am just thinking abo=
ut
> the 'normal' use case where stacks contain local function data and argume=
nts.
> Am I missing something, or are huge pages really a benefit here?
>
> Of course, I can imagine some thread with a large amount of frequently
> accessed data allocated on it's stack which could benefit from huge
> pages.  But, this seems to be an exception rather than the rule.
>
> I understand the argument that THP always means always and everywhere.
> It just seems that thread stacks may be 'special enough' to consider
> disabling by default

Just my drive-by 2c, but would agree with you here (at least wrt
hugepages not being good candidates, in general). A user mmap()'ing
memory has a lot more (direct) control over how they fault / utilize
the memory: you know when you're running out of space and can map more
space as needed. For these stacks, you're setting the stack size to
2MB just as a precaution so you can avoid overflow -- AFAIU there is
no intention of using the whole mapping (and looking at some data,
it's very likely you won't come close).

That said, why bother setting stack attribute to 2MiB in size if there
isn't some intention of possibly being THP-backed? Moreover, how did
it happen that the mappings were always hugepage-aligned here?

> --
> Mike Kravetz
>
