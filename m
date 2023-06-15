Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D343731417
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbjFOJgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbjFOJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9E273F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686821590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=By+qTcV00Wxy2aMxnryfOK5l7c3RlTf1drDswP2UWb8=;
        b=hByuYn2j1Yo7fIKVAav8sR4AvuvFJ1yF/azt7oW8mJoyaVBzbbqjziKeO+cO6XAOfZWlH4
        lkGkAIW3be51Frfg1BXwTyUSzUWABO5Tbwl2F0Gl40KBcKvIHJ9WZHEqpiu/MevTGYLZ1f
        BlCmIsm7VBPawCF5xBmkUKOEC3UG11E=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-pd2jSf8zOl-LhVxEOe-c2g-1; Thu, 15 Jun 2023 05:33:08 -0400
X-MC-Unique: pd2jSf8zOl-LhVxEOe-c2g-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-bc9483b506fso1724121276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686821587; x=1689413587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By+qTcV00Wxy2aMxnryfOK5l7c3RlTf1drDswP2UWb8=;
        b=WTpPDJ6WISgCBrnQyQ3DhjqWOZumKxn0K7pMl44BCqdCjMJDltennny60bw8TVx7bp
         vz21grhnu52hYDxAkeacbwuJSz4GswfzWGWFwdwy9dJWlPEC7FUcDn+f5ERu3pZA3E9V
         8Cu0hs7WRtpnBulJbJG9HBlqQsyglJiyWciG6FXIkXrAlwxnovN1eFep7xIf/UF484gQ
         BESf7Xu/kEAMMqji5UKzaIg8lTavIL2Nc9dN4l/Xn1ExNFvhy3bNCaB3P6S0ynRDrST3
         04zjnrqAztxBqYPQjUOYRS6J6YvYNUJrtVLhNiw/tFEa3qs3WlHzcX9IHoyO5O7wXpuL
         ouOA==
X-Gm-Message-State: AC+VfDy+abGqUzxJ9rMdGkTd+0yym41zzZUArxs14WynR9Y0+Szx21bA
        vaGhakopVgqZRy+RuW0KrNK1+IrDN19vYSb4nkbemL5LfxZkKliLDLE5sSckHorbPM7WHDgFTrs
        scA3L/NE9hR8a9/soVESIzLDLzTv4h0X9felHj49S
X-Received: by 2002:a25:c5d3:0:b0:bc9:1019:541 with SMTP id v202-20020a25c5d3000000b00bc910190541mr4511769ybe.8.1686821587595;
        Thu, 15 Jun 2023 02:33:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wzABWOyoHZ4UD8kzzizr6eF73JPT8TMumNPs00qj7Wnb72JdlpUql0ilmvKC4QWb9uUl3XgGitZNA39kA0zU=
X-Received: by 2002:a25:c5d3:0:b0:bc9:1019:541 with SMTP id
 v202-20020a25c5d3000000b00bc910190541mr4511761ybe.8.1686821587344; Thu, 15
 Jun 2023 02:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com> <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
In-Reply-To: <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
From:   Fabian Deutsch <fdeutsch@redhat.com>
Date:   Thu, 15 Jun 2023 11:32:50 +0200
Message-ID: <CA+PVUaQ40isbN14=gJTM7Bo_h1cRF=7AQUbE2g+PYNUMwdZLog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] zram: charge the compressed RAM to the page's memcgroup
To:     Yu Zhao <yuzhao@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:59=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jun 14, 2023 at 9:48=E2=80=AFPM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
> >
> > The compressed RAM is currently charged to kernel, not to
> > any memory cgroup, which is not satisfy our usage scenario.
> > if the memory of a task is limited by memcgroup, it will
> > swap out the memory to zram swap device when the memory
> > is insufficient. In that case, the memory limit will have
> > no effect.
> >
> > So, it should makes sense to charge the compressed RAM to
> > the page's memory cgroup.

While looking at this in the past weeks, I believe that there are two
distinct problems:
1. Direct zram usage by process within a cg ie. a process writing to a
zram device
2. Indirect zram usage by a process within a cg via swap (described above)

Both of them probably require different solutions.
In order to fix #1, accounting a zram device should be accounted
towards a cgroup. IMHO this is something that should be fixed.

Yu Zhao and Yosry are probably much more familiar with the solution to #2.
WRT per-cgrou-swapfile, to me this is addressing #2, but I agree with
Yu Zhao, that there are probably better solutions to this.

Lastly, this patchset, while it will possibly not address the swap
issue (#2) completely, is it satisfying the needs of #1?

- fabian

> We used to do this a long time ago, but we had per-memcg swapfiles [1[
> to prevent compressed pages from different memcgs from sharing the
> same zspage.
>
> Does this patchset alone suffer from the same problem, i.e., memcgs
> sharing zspages?
>
> [1] https://lwn.net/Articles/592923/
>

