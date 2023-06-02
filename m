Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6386720A23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjFBUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBUHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:07:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DAB1AB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:07:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9745baf7c13so220098966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685736448; x=1688328448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoYDuNxotwnFxac4y25CGImQkh46PA2DrNp3JmQw+ro=;
        b=hkGDDZlvtNc6ae0GF+CCu2wL/xMkQ1kz4F0QZSkM83Jkyap3uO/m7d2qtmibwp405w
         VDKvFkedh3DvbYNbSTPCz6L5EWOKDda2IJJ97manIcnowMmZiA7SpBv5aBze0BZlBjB6
         L6HvquGwjSo+SuZWPGoJN6mNcLGDYtvhiVrX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685736448; x=1688328448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoYDuNxotwnFxac4y25CGImQkh46PA2DrNp3JmQw+ro=;
        b=TVVUeHZwhoJGd3tfZWGFkZ9C7c2Kk30piXvHwbxkq8iMjLZ+vrpE7wTMLMLJisNJb3
         UTMfAJJzZ+7WwpTPzjgwZmvWOS1ETGvSOOqJVVUndS/tWyEfAb+PSqvKelivnrJnHpYS
         ufnCtR6Tvrc9+ykjO/mLxVxugh51nlYQr5HcBjMBbDJOUhRYi+Q6E6ImUznTg9dqziC8
         nIZYUIP5KEVL+baUPpJ5e99rQJi7WtvyHqjbJSso5XSihAXOy1L5QI/4r2mnPTMiYZ8z
         CfaAOoAQ3ZXNbIfruRIZqcyW0N/RXLlqjHo4BJMqWseYTRFQUfiLea1z2wyDVxgQRFXD
         UOUQ==
X-Gm-Message-State: AC+VfDw4xCbY/MqYM0if+yelRkQbr8UMhP//TjGNnMfSFXtnUdQj9Bnm
        NZYurNYPQp8f88tf5nOyrxYD/kJ9HZx6e1Q76+D++JHn
X-Google-Smtp-Source: ACHHUZ4UX1BxNzkEowH44IQRJNKf2EDynNDAdZuN5vPfmDQGE4F6uHttNOg3sTSYrkWSgNNm3vmG1Q==
X-Received: by 2002:a17:907:a407:b0:973:9337:1aac with SMTP id sg7-20020a170907a40700b0097393371aacmr11175709ejc.60.1685736448601;
        Fri, 02 Jun 2023 13:07:28 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id gy7-20020a170906f24700b00974561a47d7sm1111544ejb.132.2023.06.02.13.07.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:07:27 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so3339348a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 13:07:27 -0700 (PDT)
X-Received: by 2002:aa7:d657:0:b0:510:487a:ca3d with SMTP id
 v23-20020aa7d657000000b00510487aca3dmr2782770edr.23.1685736447307; Fri, 02
 Jun 2023 13:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com> <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com> <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com> <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
 <20230602175846.GC555@redhat.com>
In-Reply-To: <20230602175846.GC555@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 16:07:10 -0400
X-Gmail-Original-Message-ID: <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
Message-ID: <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
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

On Fri, Jun 2, 2023 at 1:59=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> As I said from the very beginning, this code is fine on x86 because
> atomic ops are fully serialised on x86.

Yes. Other architectures require __smp_mb__{before,after}_atomic for
the bit setting ops to actually be memory barriers.

We *should* probably have acquire/release versions of the bit test/set
helpers, but we don't, so they end up being full memory barriers with
those things. Which isn't optimal, but I doubt it matters on most
architectures.

So maybe we'll some day have a "test_bit_acquire()" and a
"set_bit_release()" etc.

            Linus
