Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6124572B7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 08:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjFLGL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 02:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFLGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:11:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165211B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 23:11:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso5855975a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686550308; x=1689142308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BipWuiASuB2niftXYaodHb7vCsVXt3eFLDs2b9I5S74=;
        b=a4L1fdNt4dpnKoKB4laiZkXGj7Zz7WeT2NWDgP8Il12G8bXZJFsIydwh5TCTviXxUs
         WxzGjdQr15BAxxt4PDLx6rLYYjFWV2+51YN3AVGzAhrASckf+1/PgQ7r9xR8DJwtCXUY
         TE7wAsc/23+d/jykmE6X8MgXA4HYkrihKzFEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686550308; x=1689142308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BipWuiASuB2niftXYaodHb7vCsVXt3eFLDs2b9I5S74=;
        b=DUYJkNgDDI3tzFivMzwVJeESq4Ydl+23zMYd1/zTeMfaZTcSkfddhQ7cvF3cyiXUCV
         zD0Uopc+KGSIs9HPgqegZnfS7FDgbnm7Utz3SiX1oXljwgIDvCBbi/xHAYeBUK7KZs1C
         /nnlDkPDo+IiSA1ENEXSfhdv8o8Zw485D6+akAw+c0GdP5Pf/DUstNsYKDC9J5oByedC
         jcLoceQH0mIk9mzoXgFh5zXezkt4TDT59uWtE/C1Nu0JTwXKI5YwkTSiFZDbj7+4F4JE
         U0+ikFaRclYw4hcIkxeaDcKLJXlRW7CTKlZ2AWdhObpq1/o1rX/emU/7rWxHNw4F1rzv
         xMdg==
X-Gm-Message-State: AC+VfDyuu94HjGlu5o2v9/8S141ZMZ/S2TYlm7ZK5tpWAtnFD7e+ORGi
        l6zxQoQs7ekGY+QJpSmkrirc93yQuzyZ0dYcgwTqbQ==
X-Google-Smtp-Source: ACHHUZ4tWBLOccTjEpBl7LvMrTrEMFRY4dB4sIB2vN9Fbf5AJnHSPDMpqIK+BPzf6iunyYnr6aza2Q==
X-Received: by 2002:a17:907:3da4:b0:973:e184:e0fd with SMTP id he36-20020a1709073da400b00973e184e0fdmr8869373ejc.70.1686550308221;
        Sun, 11 Jun 2023 23:11:48 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906045a00b0096fc35ca733sm4664972eja.41.2023.06.11.23.11.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 23:11:46 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so5868061a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 23:11:46 -0700 (PDT)
X-Received: by 2002:aa7:cd95:0:b0:514:95d5:3994 with SMTP id
 x21-20020aa7cd95000000b0051495d53994mr3761992edv.32.1686550305937; Sun, 11
 Jun 2023 23:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <ZIaqMpGISWKgHLK6@dread.disaster.area> <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
 <ZIax1FLfNajWk25A@dread.disaster.area>
In-Reply-To: <ZIax1FLfNajWk25A@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Jun 2023 23:11:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0NuJaRNC4o6FVAJgKAFJ5HWcBV5VJw6RGV0ZahqOOZA@mail.gmail.com>
Message-ID: <CAHk-=wj0NuJaRNC4o6FVAJgKAFJ5HWcBV5VJw6RGV0ZahqOOZA@mail.gmail.com>
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

On Sun, Jun 11, 2023 at 10:49=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Sun, Jun 11, 2023 at 10:34:29PM -0700, Linus Torvalds wrote:
> >
> > So that "!=3D" should obviously have been a "=3D=3D".
>
> Same as without the condition - all the fsstress tasks hang in
> do_coredump().

Ok, that at least makes sense. Your "it made things worse" made me go
"What?" until I noticed the stupid backwards test.

I'm not seeing anything else that looks odd in that commit
f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps
regression").

Let's see if somebody else goes "Ahh" when they wake up tomorrow...

              Linus
