Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605866A9E13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCCR7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:59:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5CE3BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:59:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ay14so9909013edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677866366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOLQICLibLd+rvjFGx9ySIGRRNRiC+4yvBdqE8iazZ8=;
        b=RnlQyBUig7NIS/KFmsMXE9ys3jz2gFuTtz6EzUzlvFHNNWYP0Jqp994hfvm43yRbR9
         /HjLnfklYeC23Fg9arx76NK09KIcY9oafpvqSa2waverk2nnD7DdsPFMCX4QFD3Ush9X
         FhahBi2miYq8OD3degnm/NwmVF2hr/2ifBqBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOLQICLibLd+rvjFGx9ySIGRRNRiC+4yvBdqE8iazZ8=;
        b=Uib3sxk1AwzqRA1Kt4cQCPFWEYtK9BJJzFcfHCCtqKy5Xs9PBzuOAnSup7TDdCd9mL
         585lZY6Klewc7p3pDX6bbNaXVjhBLIsVsH5pVWsgZSce3iypHqe9yhYh3qEw2X4t0Epj
         OJ5QV7tvpYJ/PrQkZ73VKHUAYmMxMuRsMM6CZNF445hnPG8UhmwUxgelK8eOiEo2sfpH
         nB/dbck6OTR8EkAfarGCZ4lSrSE7M1NIK1IHow9zTLWto48Xvz1nitZTT2Tmy0eIc02M
         XD6/ivNYHtY246jiSd2gnvuVqBgjopSAaIyVMBhus5bV2XVXq/ka3myo3ZlS9Zd8T7q2
         WlGA==
X-Gm-Message-State: AO0yUKXoAjKteS3Xim9/ZSe4SFtG5KlgBIckTrAF/Wndj+HeVQm6SnWf
        gq8mY9zufB8j4dnOmv/f3HwVCINlGhK2mMiJlFTmpg==
X-Google-Smtp-Source: AK7set/HcTIok1UeeMMCBMs9dPYH+Gmh4v03w4oGX6ZnR/i4soBS+AabtiaLH5UIvgwBBUT57GDr3A==
X-Received: by 2002:a17:907:c283:b0:870:b950:18d4 with SMTP id tk3-20020a170907c28300b00870b95018d4mr3122618ejc.5.1677866366389;
        Fri, 03 Mar 2023 09:59:26 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709063b5800b008cda6560404sm1169853ejf.193.2023.03.03.09.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:59:25 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id s11so13550525edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:59:25 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr1313886ejb.0.1677866365419; Fri, 03 Mar
 2023 09:59:25 -0800 (PST)
MIME-Version: 1.0
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com> <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com>
In-Reply-To: <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 09:59:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
Message-ID: <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 9:54=E2=80=AFAM Nick Terrell <terrelln@meta.com> wro=
te:
>
> I=E2=80=99m sorry, I thought this was standard practice for merging in th=
e mainline branch.

Absolutely NOT.

I have harped on "DO NOT DO BACK MERGES" for closer to two _decades_ by now=
.

When you do zstd development, you should normally have absolutely
*ZERO* reason to merge non-zstd work.

> I=E2=80=99ve been following this article [0], which recommended not rebas=
ing my public
> trees, so I merged in the mainline kernel instead.

Half right.

You should not rebase your public trees.

But you should not merge mainline either.

Exactly what relevance does <N> *thousand* driver updates have to zstd?

There are reasons to merge, but they have to be real, explicit, and
MENTIONED IN THE MERGE.

And no, "update to latest" is simply not a reason.

When close to half the commits are pointless merges that have no
explanation, I will not pull (if I notice).

                 Linus
