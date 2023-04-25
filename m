Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC76EE625
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjDYQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjDYQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:55:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB1D32E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:55:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f109b1808so1133607166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682441733; x=1685033733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIA68ceP7iZzPJ+vVNyRxj8lFQGUcY9/Iscq0YFStw0=;
        b=JBtbztkcps2kOPRu30Nzuby5yiTXJ4Hwp/2aazsJy+o54UMC6X4x79gFfP8J8XLMbZ
         DELmwWnhUBNeyq6UxF+tGdo1KiBE4CA4ij+3mf7B7UEhwa3gveY2iEZcx4qmoSOOf23Y
         9u5og7jn9WY/mZoWImmDBCiUdzBjPw/qK7ZHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441733; x=1685033733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIA68ceP7iZzPJ+vVNyRxj8lFQGUcY9/Iscq0YFStw0=;
        b=FEPY3bgC72sLIK/lfdU+jTHt6B17K6WXlxUeVYmMXS8RevxkfD3T72bxtMDrXmoDM7
         ElIv7GdVBUWaJ9o5aUT31igPYP4RROLg0qHdasNV3IEUEjv6WPHy1FzE5LhETUTwwAts
         VmIwzJiWzKYWn37AZJ03utgC7UdGpMdkoj1WNKV4Aal0u+vVHaNDdMBtaP7QOecQXFk/
         d9VWbbxAUmdwhXcX3etpp8czXImbJy4630VsmRVgPZZcKn5eCqrm4HFfDxBzmVVmTwhA
         1nc5vrLM3JvU0bi7ZOBcrZI8Hz2wbvUfvZTMu32dqihJRLS7xq5A9ePWV2Hrque8Spqf
         FUew==
X-Gm-Message-State: AAQBX9dY3qU8Z0VTqdnJD5jjsj7NMLqJ00Vp+647BOmhExlVtBSPdTq0
        e1DAs3gTnIgdE9DcrYi0d/XJGxjQthh6dp1SoFfjBSyo
X-Google-Smtp-Source: AKy350Y51+bJ5e793K11s95sw/bYzPlFbY7tc4okcwnTAGIzv/uhfd9K/NdVuMPGVOukdsOFVHF/BA==
X-Received: by 2002:a17:906:2095:b0:953:9024:1b50 with SMTP id 21-20020a170906209500b0095390241b50mr12312325ejq.74.1682441732842;
        Tue, 25 Apr 2023 09:55:32 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id me9-20020a170906aec900b0094a962da55dsm6904666ejb.195.2023.04.25.09.55.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:55:32 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bc07so10159358a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:55:31 -0700 (PDT)
X-Received: by 2002:a50:fb8e:0:b0:506:843f:2f27 with SMTP id
 e14-20020a50fb8e000000b00506843f2f27mr14643641edq.11.1682441731504; Tue, 25
 Apr 2023 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
In-Reply-To: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 09:55:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com>
Message-ID: <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.4
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

On Mon, Apr 24, 2023 at 12:28=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> For some stupid reason (juggling gazillion things at the same time,
> probably) I have based the edac-amd64 branch *not* ontop of plain
> v6.3-rc3 but there are a couple more of your merges ontop.

It's fine. Mistakes happen, and honestly, the "base your work on top
of a stable point" is - like almost everything else in life - a
recommendation for everybody's sanity, rather than any kind of
black-and-white rule.

And it comes mainly from people actively mis-using git, and merging
random upstream state without thought, and trying to set that kind of
behavior right, and have people _think_ about it.

IOW, it's not some "this gets enforced" thing - it's more of a "you
did something else horribly wrong, so let's clarify what the 'good
thoughtful git behavior' should be".

Sometimes starting at a random point can even be a feature - random
cleanups that depend on some helper that was added last release, and
it's just much more convenient to start at point X ratherr than wait
for the next -rc.

Now, the thing I do hope that people actively try to avoid is picking
a "kernel of the day" during the merge window to start on, but even
that is less about "well-defined starting point" and more about just
the fact that the merge window kernel *can* be really unstable and is
a really bad base.

But some "rc3+" kernel is certainly not that kind of _horribly_ bad
kernel to start at. It's probably better than starting at a rc1
release in practice.

So the "try to use a reasonably stable starting point" really is a
general recommendation, and mostly a reaction against people who tend
to do more of a mindless "rebase/merge to today's kernels without any
thought" kind of workflow.

So I'm not asking for surgical precision. I'm asking for "reasonable
workflow", where people avoid doing pointlessly silly things.

                 Linus
