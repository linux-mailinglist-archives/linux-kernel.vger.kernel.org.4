Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B656A6580
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCAC3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCAC3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:29:49 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC7DCA3A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:29:47 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536bbef1c5eso328203737b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677637787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMJ2Tq1fuRUGSjCJCJX0DWtN6w++BBp18/2BWNM6D90=;
        b=bInq0v2Y4/y/0Rjw5Q6E3rov3W3jVIr0ScG5Fu5DmLsZWiJ7q33/88572jeg3EptTf
         TgdD6heFE48s8GFeWYY9M9QxvC6nVx8eYbMf2rF7tKJPb0iQT1pJYO8jD1wLmpr4xnK0
         8mv1FH4Ui/8kK1atTX1YahmKtMTNPeK0ebn8zdgDlaar2mPww6PiD4d1j2QctFdycmOg
         SFcAiCZpXsTlpiWgzYIbewTgCdafIRvTYtl0f5+h1YEywzqb5LposqwBkVNqwP7Rb0oW
         x4eihLA+phOpITtjacPYM9DdnInHbVrrsWWvrAi/3jsFXihRU5yt5MD2hk9JPQFnfk4Q
         s5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677637787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMJ2Tq1fuRUGSjCJCJX0DWtN6w++BBp18/2BWNM6D90=;
        b=rAxsKtoA0eOPHmfPD4fGWJaE1KVSVIySRy0r1vP2h8i5XWmMfaLrNEtOvv0MQg+dNb
         P6xqsRWIyG7+dH4Z4RS8QQAHY4RsBRwCO08RrhgGTuUf9GeBfty33iL66dSeK0d42SnK
         q4e42OsyBv4tSnLAJcfJ5olsK/yiWBJdaKUBWLvefjAJc3DzYw1zFHj2A1mOoG2oNxJq
         dd2y+Yy1ewtPQVAUe7GEv3MqyVex5LeGM4w9K1bPSbuaQrk0MuI8vq6KueqmaAye8/eX
         MnkSAzo5NENQlE0IDHK8wclKbZYCp7fViFB5VzMmDnkDF5QRFUfEWdFVlq6U5eUAlC6Q
         Io1Q==
X-Gm-Message-State: AO0yUKUUIFT7P9jT6wKgE1HiS5zSOxlZpHayB8Ioi5DF1t0MjbyMlylG
        5YekGfvVOAjSEuccMN3KHEA8Gt2Ry94PX2HPrNNDxQ==
X-Google-Smtp-Source: AK7set+IAjWsrqtty1xefxKKriWeUHUlOIrdee3MUgA6h9VfimQU5IVvB9qJbj1bpgsXA3YPUeutSM6UWIkAfdbdb7A=
X-Received: by 2002:a5b:650:0:b0:997:bdfe:78c5 with SMTP id
 o16-20020a5b0650000000b00997bdfe78c5mr2540081ybq.6.1677637787035; Tue, 28 Feb
 2023 18:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20230301113648.7c279865@canb.auug.org.au> <CAJuCfpE8QwBDxRSY_dCNhias3s7K4bNoyUV6e4Ye6SU_qyYbCw@mail.gmail.com>
In-Reply-To: <CAJuCfpE8QwBDxRSY_dCNhias3s7K4bNoyUV6e4Ye6SU_qyYbCw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 28 Feb 2023 18:29:36 -0800
Message-ID: <CAJuCfpGGCzCTyLJwSjkHhEiSed-N=5SGpscq4E=eODSQ4tMo=g@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 4:47=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Feb 28, 2023 at 4:37=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Hi all,
> >
> > After merging the mm tree, today's linux-next build (htmldocs) produced
> > this warning:
> >
> > include/linux/mm_types.h:1105: warning: Enum value 'FAULT_FLAG_VMA_LOCK=
' not described in enum 'fault_flag'
> >
> > Introduced by commit
> >
> >   5827f16cffd6 ("mm: add FAULT_FLAG_VMA_LOCK flag")
>
> Thanks for the notification, Stephen! I'll post a fix for this later toda=
y.

Fix is posted at:
https://lore.kernel.org/all/20230301022720.1380780-2-surenb@google.com/

>
> >
> > --
> > Cheers,
> > Stephen Rothwell
