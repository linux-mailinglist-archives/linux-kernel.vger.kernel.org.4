Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8E63D2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiK3KQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiK3KQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:16:19 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B05FB1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:16:18 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id g26so11342253iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/NOyJxk2/Y6QVXbjn7P9cDJ9R1iTzMssSUy2u203sIM=;
        b=HpmpPUHi//OjVLtHOe3jtNn0Yc74jJH5bczpNpj9/tK420WNNVQ3mMOF6bWBLp18wg
         /a/qrs250q0JB3+cskXnuSlyl7pYUXm+xXXVwbLkhrw58C+ukZDoNwGjvcdfBS+B7dR5
         OqcvJwbatRbE7zsuNralDjU1+U1n36B9pjXgHBIPjcNbVA5gd4NMvpnaMujeHERQ4Aj/
         M0IaXmYio44KY1I1EphXZT5jFaQXz/khtGkg4ROZKBUMZD8luDUXUqEx8YG2a6BcXtId
         9pBmJr+hFR3qPW4MTHk0cjOK4IYvGrHEhCL+3P46EvFwHm+IK7C0pg2BnFugAU9PNuaq
         HMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NOyJxk2/Y6QVXbjn7P9cDJ9R1iTzMssSUy2u203sIM=;
        b=I3ydhTSMLazQqFpj7w5mgckeXjoD8fbFLYPUBIb+Xj31puiM+DwXJrF2MkygaKDpCG
         XXRSYk1JxLyFeaECrTXT+9itSxJX10nGlU7n+vWL+tZTLRyzZXuDSOcGoeffeLePuP3H
         FuM9RDv1SPPzylIE2IA0s//vYW90MsVZPJijYlNbEkdHmbYkBRuLIKEZheasK0bloYrD
         hG4g0hibs2iuFUoTCOz+weIKIKbrcFMOa0Mjy1GxrGWcL8FXhkaeQw8WLBNwKrEZFQNy
         iF2yZHRtqDKP+te10PWXkmsJ3phnLKAceTK4Fwion2Xol+iAfYAwl8YQs/zsEIjcRFKY
         RkZA==
X-Gm-Message-State: ANoB5plDr71bhYxljLDjM9zMxE3HLNrNMrO+eq072NvFxjeHZCM8kY1W
        gABVJ/pijMT+I7tj8IXKL0FDjVNtl6PTeTSUnWgu4w==
X-Google-Smtp-Source: AA0mqf7g6dndi/Ye2L9SL5a5x9mB856mHIBg0sJ7puDmqe/wSElbGHfm0gcsPXuzbXovJbbd1YhFjoCEEjrlKrZM958=
X-Received: by 2002:a02:b691:0:b0:389:af9:4860 with SMTP id
 i17-20020a02b691000000b003890af94860mr14137510jam.164.1669803377393; Wed, 30
 Nov 2022 02:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20221129191839.2471308-1-jannh@google.com>
In-Reply-To: <20221129191839.2471308-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Nov 2022 11:15:41 +0100
Message-ID: <CAG48ez1_uq6a4rq_89Ua=2P1jSsDV7u4fCh2y13X9v2JfC5MsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] time/namespace: Refactor copy-pasted helper into one copy
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
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

On Tue, Nov 29, 2022 at 8:18 PM Jann Horn <jannh@google.com> wrote:
> find_timens_vvar_page() is not arch-specific, as can be seen from how all
> five per-architecture versions of it are the same.
> (arm64, powerpc and riscv are exactly the same; x86 and s390 have two
> characters difference inside a comment, less blank lines, and mark the
> !CONFIG_TIME_NS version as inline.)
>
> Refactor the five copies into a central copy in kernel/time/namespace.c.
>
> Marked for stable backporting because it is a prerequisite for the
> following patch.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Should I resend this one without the Cc stable as a standalone cleanup patch?
