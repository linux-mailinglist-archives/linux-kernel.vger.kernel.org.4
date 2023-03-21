Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E56C3A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCUT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCUT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:29:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03488D32F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:28:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so17095638eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679426938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHtgR0XvPydSJ2xRHzSM20hkxNSVo2TSBRlBp9YTFyU=;
        b=G9plPQHI+8wWbGnhEvFwFA48pyG8MUzgtl+6zsHxCFMYjKS3WybFMSBOTLe+kFsBn6
         20pJitaMrUOIk7KNfUiVrABzqNRtk0AdehI3DSf9P2B+0uWPq27s/HDxupjjRK6QvLgV
         qz39Z3YNopvzM/pHPKpNL0n1qOYXzyCQBT7O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHtgR0XvPydSJ2xRHzSM20hkxNSVo2TSBRlBp9YTFyU=;
        b=HvN1k0e049Me2OyDMsvOuOt/HsjJZXBxvC0KxPuv1/e7NGHDJxi6HcoQsB59qmv3Ca
         S5MFW7VtVLf1BhF0Fs95bcVNeyVp2oeVWMSHNAiT/YPgZ/xoDoUXCWCALeSwUOktQi/5
         PGi0ENwtetffC9CBKTv6jl77/BQdD24RXZ9HyKrrR8Imhgj4OxgPU+VwgJNPuCost5/j
         1gKupYJszShMKOkc4uJyANqtXFx5vtgBsGooLwDKZyRD46fcZhZ2eLlbKpxPr3M2YSuH
         rv18LBinVD4K1kGhKLFhM/39ktPFOilfni3qLU0t97VTdsAnREUCB1uzVxcxlMWSdRAZ
         s4AQ==
X-Gm-Message-State: AO0yUKWVZ+EoAjdnOm+bvyEEnsKmI2gKRCPHKpi6xV5EKypdzob8eG9G
        lm8Qpdv6zKDRGlMU1fpJIN0ruyfHIZAl6YXXLO287f8T
X-Google-Smtp-Source: AK7set+jQlOSM/rybs9UkLsPZKLpvoB9N7BFUCHH9O4P9T71fj0EnNO0Hqd/eLDmo/2bjglWhy1xTg==
X-Received: by 2002:a17:906:f0c1:b0:931:6641:9897 with SMTP id dk1-20020a170906f0c100b0093166419897mr4205126ejb.44.1679426938278;
        Tue, 21 Mar 2023 12:28:58 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906491800b008e82cb55195sm6163429ejq.203.2023.03.21.12.28.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:28:58 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so11715599wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:28:57 -0700 (PDT)
X-Received: by 2002:a50:9e6f:0:b0:4fb:482b:f93d with SMTP id
 z102-20020a509e6f000000b004fb482bf93dmr2321260ede.2.1679426530851; Tue, 21
 Mar 2023 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <2851036.1679417029@warthog.procyon.org.uk> <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
 <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
In-Reply-To: <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 12:21:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Message-ID: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:16=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> I haven't seen the patch yet as it hasn't been pushed,

Well, it went out a couple of minutes before your email, so it's out now.

> It may make sense to add some debug check for
> PF_KTHREAD having TIF_NOTIFY_RESUME set, or task_work pending for that
> matter, as that is generally not workable without doing something to
> handle it explicitly.

Yeah, I guess we could have some generic check for that. I'm not sure
where it would be. Scheduler?

               Linus
