Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E572B760
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjFLFfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjFLFeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:34:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F59B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:34:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-970028cfb6cso731424466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686548087; x=1689140087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABer1Qpbiiz2YP6yXC9CjLyORxYGpFS/k9rP6ZJ+dM8=;
        b=UrWKpQm/HNULGfsOm+ZCPIz3WEbdKKudcxeTlp7bebNUGCSRQGkGcEjgGAkrQfbiWq
         7ITVfQD1mEA8zlXWT4Bjk2E010tPCVedKm6HPtXGBF7VH2KzbcSDOI+OSvK3dlU4DJtL
         930b90GZgWWpQuBc2TR6F7VDon5JDxDWr0Lr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548087; x=1689140087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABer1Qpbiiz2YP6yXC9CjLyORxYGpFS/k9rP6ZJ+dM8=;
        b=XBkEuQkhZgnXWUnA2eS72BEDo/o4dKiLDERuQ2puId6sh8yrflRgbDkUnZcgHmnoJi
         5gcSF0hsAJKFXUGNJMfsepSF6yT9xmHuiAVB2/AMtWEmHiD/xbCv75gmXcRG1GHJK8B8
         owUyXiC8Ly60Cak8223VOWk7ugE6o/hQ/ikQ7CCvKve8T3QwulMD3sEYdISiGUcbv3l8
         8j1M5fbTRGZUj1gUt9gvF5m4glh2YbzO2Oxv4N/EU9Sg3+hTA0eIyHlKo+hdzH1qgDyL
         nbiZLYXRwnLKQOhbANNTRJqIFDYhDDXR1ih6xbNUMl0OHQY36aSXO8mYxC+9JMegCEjZ
         Fz9w==
X-Gm-Message-State: AC+VfDxwSzkssykISEUfhGti+13YJivbu0iPirbhSWgHm9gTOdlcWffV
        0prLlZ/GYY1efLJmzwR9Ao9RIoCTKQ+66ompuJlA9g==
X-Google-Smtp-Source: ACHHUZ6GCDo2sWwi3EYE6rdWzCCR59CXKlMWxL6GNyxqm/yTmWxUzVtTUgcZd87gqO3VyafAIQGD7Q==
X-Received: by 2002:a17:907:7e9a:b0:94f:3521:394 with SMTP id qb26-20020a1709077e9a00b0094f35210394mr8601352ejc.51.1686548087447;
        Sun, 11 Jun 2023 22:34:47 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709064acd00b009787ad3157bsm4714234ejt.39.2023.06.11.22.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 22:34:46 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso7078078a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:34:46 -0700 (PDT)
X-Received: by 2002:a17:906:7951:b0:94e:e97b:c65 with SMTP id
 l17-20020a170906795100b0094ee97b0c65mr10173252ejo.60.1686548086273; Sun, 11
 Jun 2023 22:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <ZIaqMpGISWKgHLK6@dread.disaster.area>
In-Reply-To: <ZIaqMpGISWKgHLK6@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Jun 2023 22:34:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
Message-ID: <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 10:16=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> > +             /* vhost workers don't participate in core dups */
> > +             if ((current->flags & (PF_IO_WORKER | PF_USER_WORKER)) !=
=3D PF_USER_WORKER)
> > +                     goto out;
> > +
>
> That would appear to make things worse. mkfs.xfs hung in Z state on
> exit and never returned to the shell.

Well, duh, that's because I'm a complete nincompoop who just copied
the condition from the other cases, but those other cases were for
testing the "this is *not* a vhost worker".

Here the logic - as per the comment I added - was supposed to be "is
this a vhost worker".

So that "!=3D" should obviously have been a "=3D=3D".

Not that I'm at all convinced that that will fix the problem you are
seeing, but at least it shouldn't have made things worse like the
getting the condition completely wrong did.

                    Linus
