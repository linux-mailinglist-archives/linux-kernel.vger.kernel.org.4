Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456872CBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbjFLQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjFLQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:58:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1571B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:58:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977e83d536fso656641966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686589089; x=1689181089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLoz7lxagH1eY4McVsEAypsnIWtE+LF5c+YFhdajR34=;
        b=LTQ3mmXY7CFskPvLfzwhsGbO1Hku7HHasdMxY0rwMTLbcY8JtsoTn8I0XjryAbAstB
         mmVXMdMrPHxbqX07dzk6qVSFdqR6WPzD68w3bKbp+rKWHQDCl2mhFPCrb8thRgkKzw2m
         nPnwyy3ZHxsgLz9mFZN4K+ktiBN0nRbrLNHMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589089; x=1689181089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLoz7lxagH1eY4McVsEAypsnIWtE+LF5c+YFhdajR34=;
        b=DuSQx034NmeZTRbl7/jmhY3Ps9BIkOSgfg40TtjPBSVwEZcse1jCDm/2JPJYDlU8jU
         +nVMulCMfziNqFIfytjsw/y9EbrLFy02hAxa3yB7Hhh34nml5EUaUU42b6LzVoocOsfN
         2JUohgBEk9LNOUUOiSj59seWJ2vzyxfKGtJiGufOOYpAV3AuOQOcuoo9E2GZRVhHzh09
         RRwJAK/OGjY0ROQM8kxHwS/QoyRemT/evEmATWOVFPD3JZ8yXXtRc4Pt94Mi2/gK+pWO
         BMQcli40731YkcGFrr/k7HRXNto/DBhHp4aDENAiMxK928iga1uVOh5WYE4OmFkiLNRV
         918g==
X-Gm-Message-State: AC+VfDwZB+FCYkS+ZmlZPDX/qEYsp+3pl4lH+1LdaQ5b5jWxr7ovCiow
        dYUURxzCobdjVdBMiO8F3BQRbeGajxbppAZlypJ3hvVh
X-Google-Smtp-Source: ACHHUZ4d5/rfNRVDIoJWsspfiOaqV2oF7yBZ5IqCI1u0w3sgjJnMrY1eDxLuK0mA11V4XNd97OTlMQ==
X-Received: by 2002:a17:907:1b1c:b0:978:70e1:f02e with SMTP id mp28-20020a1709071b1c00b0097870e1f02emr8786058ejc.22.1686589089342;
        Mon, 12 Jun 2023 09:58:09 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id gj13-20020a170906e10d00b00965a56f82absm5425124ejb.212.2023.06.12.09.58.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:58:08 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51870e2dc48so59389a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:58:08 -0700 (PDT)
X-Received: by 2002:aa7:c90a:0:b0:516:4e6b:fa46 with SMTP id
 b10-20020aa7c90a000000b005164e6bfa46mr4635225edt.31.1686589087811; Mon, 12
 Jun 2023 09:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs> <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk> <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com> <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk>
In-Reply-To: <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:57:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
Message-ID: <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
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

On Mon, Jun 12, 2023 at 9:45=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> You snipped the suspicion in my reply on why that exists, to avoid
> io_wq_worker_sleeping() triggering.

I'm not seeing why triggering io_wq_worker_sleeping() should even be a
problem in the first place.

I suspect that is entirely historical too, and has to do with how it
used to do that

        struct io_worker *worker =3D kthread_data(tsk);
        struct io_wqe *wqe =3D worker->wqe;

back in the bad old days of kthreads.

But yeah, I don't know that code.

              Linus
