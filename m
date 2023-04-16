Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4F6E3BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDPUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDPUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:49:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DF5211E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:49:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u3so7137072ejj.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681678150; x=1684270150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZEsb5dT9JO5UxHpI/ZZDj8yyg+vAiJhotQU2y6VbC0=;
        b=PwCaTcEohrDy8WuWj5vSKPh0mg79sodSr4UTbElGXfn84ig63fde3fx2wD50ppGKE1
         rFedYVX7rrvvrl5Tu4yBMTk+bPrJ/43KqXuW1wM0z5zXduFo8NcMBrke2H/3ubjCRDXA
         T/o2/UTLGVRQJdrvRshdq5Jz2WYU0VHxVik5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681678150; x=1684270150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZEsb5dT9JO5UxHpI/ZZDj8yyg+vAiJhotQU2y6VbC0=;
        b=L+DMdeZGUqCRTMGWWJe/jSiEr09dE7JyKn9kqhnF07xPN5n7d5W/cCinKzlJaQBjg6
         Q4srQZq3auWLSRKJ9whSdZhGS7U0Uixb1PvLrHLjmN8Q8my4k5ymn2gwD4LCuSaU9O6u
         OiJKSsIMqnRuSJVPSmc01aq4N9wlGNhHfCC3f0YaAqZZG8sr36MPMJcYA3wuiFgzbMJ1
         jAUYh77U5X1VX50Kd565tOgsKRi2FpKqUgesW82LSzcf2t1Qp34uob9MDcAh5yOQX9ks
         nP/ICdAF/zQL29fbG5YxLseJ+SXZRjCocEa74kULRDOFUDgpNjUGZC98o1KS1Hi+bA3H
         /27A==
X-Gm-Message-State: AAQBX9dy/vTNtTShbkDksls5toTu5fWgieppmvA/cNoqmk988nPQVYO8
        CiKmFotByZFVD7xOAAAxExR+w6qYL9IEo3M1NSE0ZQ==
X-Google-Smtp-Source: AKy350Zzpe71rteIlXS2c/obEid+CGMkB5PYRwikQJChbFMCNRFdiMzCPwl6WPAiMuFCJ7s2ZF6+7Q==
X-Received: by 2002:a17:906:5e53:b0:94e:fe9a:f617 with SMTP id b19-20020a1709065e5300b0094efe9af617mr6330979eju.20.1681678150533;
        Sun, 16 Apr 2023 13:49:10 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id o23-20020aa7dd57000000b005047847d3e5sm4935874edw.36.2023.04.16.13.49.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 13:49:09 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94ed301bba0so189497566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:49:09 -0700 (PDT)
X-Received: by 2002:a50:8d5d:0:b0:506:833e:6129 with SMTP id
 t29-20020a508d5d000000b00506833e6129mr4215411edt.2.1681678149466; Sun, 16 Apr
 2023 13:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <168166781352.1843526.278570500979918184@leemhuis.info>
In-Reply-To: <168166781352.1843526.278570500979918184@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Apr 2023 13:48:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
Message-ID: <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-04-16]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:59=E2=80=AFAM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Wake-on-lan (WOL) apparently is broken for a huge number of users since
> 6.2 was released[1]. This is known for 8 weeks now and about 4 weeks ago
> it was bisected to commit 5c62d5aab87 ("ACPICA: Events: Support fixed
> PCIe wake event") we immediately could have reverted. The developer that
> looked into this was even willing to do the revert late March, but then
> got discouraged by a maintainer [2]. But well, a fix was apparently[3]
> finally posted for review last week (to the acpica-devel list); with a
> bit of luck your might get it next week. Still a bit sad that 6.2 is
> broken for so long now, as Greg wants to see it fixed in mainline first.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217069
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D217069#c50
> [3] https://lore.kernel.org/all/754225a2-95a9-2c36-1886-7da1a78308c2@loon=
gson.cn/

I find that bugzilla discussion very confusing, it's not clear what
the status of the patch actually is.

And the sane lkml thread just says "the patch is under review" without
actually saying *where* said patch is, or where the review is.

It sounds like it got perhaps into some internal ACPCICA queue? None
of those links are very clear on any of this.

Rafael?

> Another issue from the 6.2 days still not fixed are a huge number of
> DISCARD request on NVME devices with Btrfs caused by 63a7cb13071
> ("btrfs: auto enable discard=3Dasync when possible") [1, 2].

Yeah, automatic discard is a broken idea, and that should just be reverted.

The number of devices that have *horrible* problems with discard is
too high for any kind of "do discard by default" logic.

David, please don't do that. Just because discard happens to work well
on some disk, *you* care about, does not in any way mean that "do
discard by default" is sane.

Discard needs to be opt-in. Not out-opt.

                   Linus
