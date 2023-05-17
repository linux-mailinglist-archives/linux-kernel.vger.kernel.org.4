Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789D70724F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEQThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjEQThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:37:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B9CAD0A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:36:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965a68abfd4so209367466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684352214; x=1686944214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DJujWcgKFUPe2mSgSbivOepwby+XZ0SdDGpw6KOt6U=;
        b=JI8P++Ejpwah/9ujZLGzlcbeX6IiN9KXWwGGtrkllxq2cwtPfXM/Lg1gSDrOQCtSRF
         ItsLIL8wBg/HFszijwE0LNEONV6N8NHHqFOsEpfMKtc9ejev02a2B80w94ZQZABPUnJR
         T2qDnFjDZPfvcBMFLZ2So/CyHnCFxeyh4zMJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352214; x=1686944214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DJujWcgKFUPe2mSgSbivOepwby+XZ0SdDGpw6KOt6U=;
        b=PVkfDjPG0n+4CDji4CnphSrW8CMt1OG5g+HU63n8Ubh0XYFP5Q62N4ltrMQ/0bJhLB
         N4pkVLVLVCuK1DTVD748QDqEMFwkiyhgjaHDuS4NGcD1rwT0Z+pSuCjROr2WuMHS2yGQ
         dlntuZv2JNesRkJnhLrHUOrHXVPd6qA2Pcouxtd85ZXKHr49PdXBOHFHaic/hmoE3uek
         EKOJIxcGLm84V7BX3UEmR5DvD9a30N0XcBbuITTp2rpmrvVLUGJqUvSz9Qr2Sdy2TCJA
         5MITa7DHXSNa3ioWVBRoJsQcvKlewZxFUBoR71Eh+wtBiHcO6u2XKMXhJ+ORKVX9zgEi
         u+iQ==
X-Gm-Message-State: AC+VfDyQWNd/y00N2UGrCYZ/WQskDSdUn18/GaAWYiSNshV/u3DU9lid
        SGVCHyKr8rKM94Ly2c4S0+6by3OLIZNVHbpe3FYf5Fxd
X-Google-Smtp-Source: ACHHUZ7CDjGOfwpY6pR3bJaZa+/+Eknb8vRyvlxmNJKFHm0hhTiWuAVwZFi6Eng9QV+/a7K60dNzkw==
X-Received: by 2002:a17:907:9304:b0:94a:7716:e649 with SMTP id bu4-20020a170907930400b0094a7716e649mr37421436ejc.13.1684352213878;
        Wed, 17 May 2023 12:36:53 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b0096a68648329sm9392621ejb.214.2023.05.17.12.36.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:36:53 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96b0235c10bso209173166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:36:53 -0700 (PDT)
X-Received: by 2002:a17:907:628c:b0:94f:2a13:4e01 with SMTP id
 nd12-20020a170907628c00b0094f2a134e01mr38924382ejc.74.1684352212926; Wed, 17
 May 2023 12:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
In-Reply-To: <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 12:36:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
Message-ID: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
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

On Wed, May 17, 2023 at 12:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Also note that this does NOT fix the incorrect RCU walks.

.. this is the patch that I think should go on top of it to fix the
misleading "safe" and the incorrect RCU walk.

NOTE! This adds that

        lockdep_assert_held(&event_mutex);

to user_event_enabler_update() too. It's already there in
user_event_enabler_write(), but I'm not actually convinced this has
gotten enough coverage checking, so I also did it in that caller.

Some callers obviously hold that mutex. Others are much less obvious,
eg that user_event_reg() -> update_enable_bit_for() chain. I *assume*
all the 'class->reg()' callers get the event mutex, but I did not in
any way check that it is true.

So that lockdep annotation should be actually *tested* with lockdep
enabled and somebody doing all these operations.

Final note: I do not know this code *AT*ALL*. I'm literally just going
by "this is the only correct coding pattern to use", not by some
deeper understanding of what the code actually wants to do.

                   Linus
