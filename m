Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29972686915
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBAOzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBAOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:55:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E36600B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:55:27 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 123so22611174ybv.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f7SUNQyRKCpf4C/POu/u7L438CCRwNPoXjRFVtxsbJg=;
        b=DdkyChVD5kowrB8me9WFblmkD9Of8A4+sdQQ7ACe+WVE3iaU6kMRLGKuM5ijntpe9Z
         5+pRHFfCLNqKjEilhjxXqcf+cBf9JQ+MpE0QtQLFTvG1b+dUxYTn5w7f8X9ZTNKEdzPy
         Ks3IvSy6xFnRM5gB1B9jqLVVkiZR0i2o7cgGK3wOVD9R2SlhI0zBMLhCqOtMr7JE7cyk
         bG0sAE9fpwD6nNofbyVJ5El/tUEll4RSKQGVIQXIcnUwtNG4wwKzgRsVNR0HxwzYOuW2
         j4qZBuV602XYT4HPrplUuOETirb2NU7KeQ0iz3eKN0vBX8eSqfRd0PvCbDWIPuknWfxR
         Ppig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7SUNQyRKCpf4C/POu/u7L438CCRwNPoXjRFVtxsbJg=;
        b=CjYUqRcn0v0SzFQiSFw1bCU8Pi/c/T4OJd8W5P3fqYnxWAVgyV/mVyl8LUEQjAtC+4
         3XNbmenPvmuVg7wxa7kXKumQ2DdXkyaXOdiQkiX9vA/u2e6QMC84c1KbNgyzC6ROa38A
         57Awjn7OlwKAbzwdl32ZEoVpjXaqDL7vGG3jjINn6u8wTtg+PVZdY5C/SqA1+vIUcU8l
         ksy3IjHH/zEDZmMn2X/tYNh3HcAQGazVSUnZXRl0bDPxiGpXXVuoVptfD+9pre73/Na5
         bJIuSsa9azDxUP/JgAFJpPlMWVj71i1yJnmivAy02lnoRMdFZiTcq2TZh540x9D+DVrm
         H8Bg==
X-Gm-Message-State: AO0yUKUS2r3B9Dp51XSqdbQAqn1R8ZAekMLd4FFPkFzA++Yj1bIIjjIr
        ew/cHLEOdnJ9sAQDaZDBjo6hxTKiHYN+XVG17u2krA==
X-Google-Smtp-Source: AK7set++NAwq/dEiVCGr/I7rab+JO9iNRk16DMetBlVIATN2KzTvfMWmIfeaz5rvVlQklPDUJbUx0KBemUcAF/rmfJY=
X-Received: by 2002:a25:d341:0:b0:803:9f76:ca27 with SMTP id
 e62-20020a25d341000000b008039f76ca27mr236477ybf.145.1675263326966; Wed, 01
 Feb 2023 06:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20230201001612.515730-1-andrei.gherzan@canonical.com> <20230201001612.515730-3-andrei.gherzan@canonical.com>
In-Reply-To: <20230201001612.515730-3-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Wed, 1 Feb 2023 09:54:51 -0500
Message-ID: <CA+FuTSfDqhmP=68rQ5CmpyMcGj+cGYzvVvfjOMN0f+Bby51GuA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] selftests: net: udpgso_bench: Fix racing bug
 between the rx/tx programs
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jan 31, 2023 at 7:18 PM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> "udpgro_bench.sh" invokes udpgso_bench_rx/udpgso_bench_tx programs
> subsequently and while doing so, there is a chance that the rx one is not
> ready to accept socket connections. This racing bug could fail the test
> with at least one of the following:
>
> ./udpgso_bench_tx: connect: Connection refused
> ./udpgso_bench_tx: sendmsg: Connection refused
> ./udpgso_bench_tx: write: Connection refused
>
> This change addresses this by making udpgro_bench.sh wait for the rx
> program to be ready before firing off the tx one - up to a 10s timeout.
>
> Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
