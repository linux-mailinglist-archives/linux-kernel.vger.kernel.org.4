Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7A72CBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjFLQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFLQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:45:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD09E63
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:45:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso7727002a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686588341; x=1689180341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAwyfHdqq2XpGv1HfLFhZYNBkK1lnw38Ar7GumbG5W8=;
        b=DOV8V8WzRlbYSCaSWcJrxnzEoCDXraXQ3wJ5iUbYMP9Y/Y9VI7CzRqX1ssqq2zF0SK
         Fnck9R1mnZkJ8MspuOCrJt5zK07w/aDqQAvoxwq3LpfNtpHPec46RJgP1Rhu4Cge/q9w
         GVxNsVyax3Bso6SxBcJlniy+2rB8nRRcCkXfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588341; x=1689180341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAwyfHdqq2XpGv1HfLFhZYNBkK1lnw38Ar7GumbG5W8=;
        b=ElApWeN2FdQJijeNMLzZkox2TRpUbFHPke7MMeZNVRMN8N9h9IO3amPzygSt80Kwv6
         Fndu61I1ONa6jk27cnzxWDWWs0VaWd32WxiEFu9IJe3n69aJKUDTpUeINag468G19Smu
         YzBWwNVHc0jlR6KBWdD/wJTxllb/m0zcr3O+6PwYP22xrODCu9EzHoJ0HusICysvp4Cn
         IyWsBcwrOd7xk5RUjivYusV/p2B8k78N8+4neUxmdDQ4rpWa7RbFPVhNFl3T41atYhcF
         0mqBOOVExy4oUtz/N/Jorm3SJEj0ohqe/6nKplIPF9wupyueyPccER40eY3kEOIyqDoO
         aGDg==
X-Gm-Message-State: AC+VfDzdBiaJAyDzG5gj5fSCaYhNjtO1dhChjaLM5hHp7MKMpsz6pprk
        LY6YL1D3lomMYoZC1ZdfZNtZ5IOJKMTvs/vkQjJqFKbH
X-Google-Smtp-Source: ACHHUZ61K6yIOgvFH2rG56OJARlwPmJ0FjjreIXYdTSTZpC+3JTQU1y9ek7Cg6ZQvWS729325RWD7A==
X-Received: by 2002:aa7:c3c3:0:b0:514:9c51:ee2f with SMTP id l3-20020aa7c3c3000000b005149c51ee2fmr5432700edr.6.1686588341040;
        Mon, 12 Jun 2023 09:45:41 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id g13-20020a056402114d00b0051830f22825sm2809341edw.90.2023.06.12.09.45.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:45:40 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so7724849a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:45:39 -0700 (PDT)
X-Received: by 2002:a50:ef13:0:b0:514:80b9:793b with SMTP id
 m19-20020a50ef13000000b0051480b9793bmr5781986eds.19.1686588339613; Mon, 12
 Jun 2023 09:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs> <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk> <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:45:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3ucaR0GXt6iaAX6tKO=iHcbe6jDzf2Mgz1petZMc=rw@mail.gmail.com>
Message-ID: <CAHk-=wi3ucaR0GXt6iaAX6tKO=iHcbe6jDzf2Mgz1petZMc=rw@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 9:42=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, it makes sense for the bug, but that whole
>
>         preempt_disable();
>         current->flags &=3D ~PF_IO_WORKER;
>         preempt_enable();
>
> thin in io_worker_exit() does *not* make sense to me.

Oh, it looks like that goes back to the original io_worker
implementation, when io_worker_start() would set the PF_IO_WORKER bit,
and  io_worker_exit() would clear it, and they were otherwise created
like normal kthreads.

It *looks* all entirely historical to me, and removing those three
lines as left-over baggage smells like the right thing.

              Linus
