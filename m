Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0372CBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjFLQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjFLQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:42:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058AAE7E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:42:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977d55ac17bso829246366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686588153; x=1689180153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHlw26Nr3iiAXr4x4uSWEbvlq1xJxnXY00baLa5A/xY=;
        b=TpDE9u2f5G2kHCBrXcxJQ4ESNSxbzwsM68eafuFVBuGCAm6khd+lN0LB+3yE8JnKIR
         rc4zhn3Q2vg6s0+/NyQGb1K3q4OwiC5kbhxg12p/Z8CaYkbNbRYclhKoIDS9ItTeYtrc
         /lHeDy3wipdVjb1RFa/GVEHwGKKhudUPrKHaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588153; x=1689180153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHlw26Nr3iiAXr4x4uSWEbvlq1xJxnXY00baLa5A/xY=;
        b=YEjCUbCi8y0B4f5boh7vEBNRqykGVKb07U1Pud0SUxEwDO4Jli887LL5ZWnmZj7uDR
         LPRc4O+3wtO6IIy2O4sZ9ErAzNwGRmD5M7MW1qLI+LjqemMTygKN8qujcPOx1KuNDpVn
         TRDb82BzpU4KFvgZ81Kuzy5+lATFVJjIdtMOssogd0o2GnWGHhXs1dLSlF7m62ojTBLs
         V3cGS4qxUV6g4ZfHHOX1Muw/Mk4o723JaRgNdDcqsxIgyODEX6ahtVcEzDbF7WgFNHMW
         xkkSCBVf/is7mllNq2ZjBw+k15mFVjgXUrKYb2+wF574pX2Ur0YMhyDu8NeRGoZoxTqn
         GeAg==
X-Gm-Message-State: AC+VfDxWShyFw83U+o/uJeeMNsscKPj0C2FUobj4yS7jlnhdpZfB9+7z
        4Xp/jZyaJmi64jGTf1cmcxnvkGO8EKv8d+4oILIkrXaf
X-Google-Smtp-Source: ACHHUZ6DJxyIF6Ax8D0eXPfhOEG00eEw43ptqJqfIMj7w2AlasopV+o1BBeMhdfi3KdouhS04lKttA==
X-Received: by 2002:a17:907:a0d:b0:96f:4db5:df69 with SMTP id bb13-20020a1709070a0d00b0096f4db5df69mr11497669ejc.23.1686588153271;
        Mon, 12 Jun 2023 09:42:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906840300b0097456b4085fsm5411971ejx.190.2023.06.12.09.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:42:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so7993388a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:42:32 -0700 (PDT)
X-Received: by 2002:a05:6402:78b:b0:518:5f8e:4d2c with SMTP id
 d11-20020a056402078b00b005185f8e4d2cmr793438edy.27.1686588152188; Mon, 12 Jun
 2023 09:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs> <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk> <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
In-Reply-To: <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
Message-ID: <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 9:38=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Quick peek would suggest that it's because io-wq clears PF_IO_WORKER on
> exit, and now we fail the check in coredump_task_exit() that was added.

Oh, that makes sense.

Well, it makes sense for the bug, but that whole

        preempt_disable();
        current->flags &=3D ~PF_IO_WORKER;
        preempt_enable();

thin in io_worker_exit() does *not* make sense to me.

Does removing those three lines make things "JustWork(tm)"?

               Linus
