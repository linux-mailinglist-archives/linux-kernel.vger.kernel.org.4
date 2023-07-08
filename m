Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599D74BF01
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGHTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGHTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:42:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455EA4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:42:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bff27026cb0so3652646276.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688845332; x=1691437332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4+Mach9lmHdREdY4lG7rnRYsyltEKjNy1tDSuyLngc=;
        b=WyDa+IEtTiffPeWHVWO2qzdkJXMbVkoixl5g2Oiio+Xc5RgmDl/+4NKv/Bms/JvY91
         Ea8FYlatqHWfN5yu11/zHTAxAEQMS3yy7iahdbV0GCIcaVA+gf9LiAKAeQJl3OcMd51r
         1sHYJ4js0rfpGcBpvE6TbF95yVUDE8B12gn2nYBCV3LxO1bZ5B6bFVYJ9LIRwvn2YVGL
         qJ5siqqNwKalWAOQEK/TzkYgb3k43V9HP4rK/RUwcPd6haOjOhjEl3ldtEF618o53U4p
         ZfrcJ/K1SLyM1hT/NDjfeoetYv67/RaGtibykxFbZwYrF+eQODkqklj9XH+mU6xkPTeU
         tAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688845332; x=1691437332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4+Mach9lmHdREdY4lG7rnRYsyltEKjNy1tDSuyLngc=;
        b=IUp9wE4XSCQravffmXPxNU8uhXswtyfy+nykyNc6Fpe8cQTXzZSNFRIdFajTHqYiT5
         4D7FvLePkzU8CwUtfKaw8T2Nvif80Vx13RP0JE7D45sjthjlGQuoLgA1b/gZmr2l88hm
         K+SRM3k4lLPTGSI8gdLN87QkafMn1J9LhZ7DKeoQN/mmQGIZo9v7y5nsmVqnjc73cNMe
         6w2t8dYRBNsXTrU40NENDJm1Jw6hFwtmTEHmE5RzjcUHj/IhGACTxmex/XPN4D4i3vhD
         pVXkvLNAY82QR5cYcfsja3rNOuvsd6bCxq2uMsHDXpOplynnp8oFYocX8IvyZgC/EVMx
         1uOg==
X-Gm-Message-State: ABy/qLYjz7pEF0QtrySbaJayTsiHH+YZq4COth6MaL+ausP56zH63jpO
        r5TJ9uWosKQdUgvsm7bo4iEMGV2DhpqqpydTJvuTPg==
X-Google-Smtp-Source: APBJJlEHZ+EH0adEDxcnlKd156qF4LQIYNxL5d/up1So8zPv6Qcmz7Vx+oucSWoCMFYT5ihbobbETD/Hx0H9XJC2ppM=
X-Received: by 2002:a25:7086:0:b0:b8f:5639:cb8a with SMTP id
 l128-20020a257086000000b00b8f5639cb8amr8776346ybc.9.1688845332211; Sat, 08
 Jul 2023 12:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh> <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
 <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info> <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
 <20230708103936.4f6655cd0d8e8a0478509e25@linux-foundation.org>
 <CAHk-=wh498i3s+BgOF=pUOF=Qe_A0A16-mFcH2YGy+iZXvNChQ@mail.gmail.com>
 <CAJuCfpFLc1yoZm9uqRcmcwtFNGHYKyjxrc71tzXennpGB7QbYQ@mail.gmail.com>
 <CAHk-=wi-99-DyMOGywTbjRnRRC+XfpPm=r=pei4A=MEL0QDBXA@mail.gmail.com>
 <CAJuCfpHszCAc5hDdsxry+1xh3kz+=jsYdBCXKQez-Th9LESSZA@mail.gmail.com> <CAHk-=wi=+qS+5v_7mVxKWUSOKaxzC2V8N7hyFVt1qTWGM_pmAQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi=+qS+5v_7mVxKWUSOKaxzC2V8N7hyFVt1qTWGM_pmAQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Jul 2023 12:41:58 -0700
Message-ID: <CAJuCfpF_J+wXzjFRSO_HrzyMft2j32enWKCX0iFGmH6DM7a-rw@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 12:23=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 8 Jul 2023 at 12:17, Suren Baghdasaryan <surenb@google.com> wrote=
:
> >
> > Do you want me to disable per-VMA locks by default as well?
>
> No. I seriously believe that if the per-vma locking is so broken that
> it needs to be disabled in a development kernel, we should just admit
> failure, and revert it all.
>
> And not in a "revert it for a later attempt" kind of way.
>
> So it would be a "revert it because it added insurmountable problems
> that we couldn't figure out" thing that implies *not* trying it again
> in that form at all, and much soul-searching before somebody decides
> that they have a more maintainable model for it all.

Got it. I hope that's not the case and so far we haven't received an
indication that the fixes were insufficient.

>
> If stable decides that the fixes are not back-portable, and the whole
> thing needs to be disabled for stable, that's one thing. But if we
> decide that in mainline, it's a "this was a failure" thing.

The patches applied cleanly to 6.4.y stable branch the last time I
checked, so should not be a problem.
Thanks,
Suren.

>
>            Linus
