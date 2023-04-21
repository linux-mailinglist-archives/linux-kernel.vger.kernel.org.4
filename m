Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E06EB5CC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjDUXsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjDUXsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:48:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A731991;
        Fri, 21 Apr 2023 16:48:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f8f459b34so26630087b3.0;
        Fri, 21 Apr 2023 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682120914; x=1684712914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKo4rMQhVlKnCZ36cijs5DaB4xHEMjnKxi/jto5phPI=;
        b=fxTvlqpp0qEiW9JlFjmXr2otE7+lX5M9uEiLDuGxCjo17byJthUEPuEFrmE6rfyH2y
         U2YfQ8MtZXZIKaGITcdTGNGBkLNlBLwka/3zZaUJhPaDXLTsXoOEu8pu0CSxYalyqT1y
         EC2xTO1Zlu/1A/YnCvLEmEkCnEepVU+e4sU0u150+Y+z1N4jwQ2yc1apvKb2tgNI19Qw
         xZ1mILOHv+BrnUU4A586NdIEhvNq4YK7i2ioaaZGvDaX8Ma3r/PhRu6tA1keHfdc9iHw
         I1BuxO/MW8LuK1Wf8q84yoWF3bGZdb6UBEYir2Y+jR/WV7o7DmIWVH7Fz50Kd9lrAsVj
         P+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682120914; x=1684712914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKo4rMQhVlKnCZ36cijs5DaB4xHEMjnKxi/jto5phPI=;
        b=k6XgAyGnPWA0cFxJOlTzaWh0Ai/Eeyr5x+4ND0u5q2G+8Vzzf+4oDrWr8kjfhesIcb
         BmUwTxIN72n7e34ks4hvoZJe8ivmdUFmYwKrxqSm+0jL5/lkAI3AzQRdVWtum6tTU6bp
         M/up26lxB2qiwGZchLRYPrEVFVZw+saSU6UmQy5pon8Tfu1eceR8n7MePHTfe7VyCUXh
         O8LAfisDAOu7Ity6OiwFQTcjscCdtb6AsYPez0vKnEVNdFQTkb/T0QK1luM4s0K4BD0F
         x9ruXErHbau9Kib3IZVrEAc95xF6Izqc6i9f4R6U2/o2e2D9s9VS9kNM2xJmfIzPlhiq
         1WLg==
X-Gm-Message-State: AAQBX9e6auYfdv/DCXI3GoIxPMHN8TgasM/dEKCE4f5jweLbApN8BiZK
        9oSegoQJBfeJ2tc0Z4DlgE1m3JDtqJkSbziOSNM=
X-Google-Smtp-Source: AKy350ZR0lvdmIdc7h1xsRaMBzKAwdWO38Bwi7pi/+Qnj3XLt7M4URjdOdlO4W3Z4/q6djvzI1ylNZB90m/MM9LPRfg=
X-Received: by 2002:a0d:f283:0:b0:54f:a613:cee2 with SMTP id
 b125-20020a0df283000000b0054fa613cee2mr3517564ywf.31.1682120913478; Fri, 21
 Apr 2023 16:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com>
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Apr 2023 01:48:22 +0200
Message-ID: <CANiq72kV7qZ2MWexvF8_36rdSvTw9KooqJYsaTcNOgHHetvXrw@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] rust: sync: introduce `LockClassKey`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 7:46=E2=80=AFAM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.

Series applied to `rust-next` with the v4.1 patches applied plus the
irqsave bits removed as well as p4 since it was not Acked yet, as
discussed. Thanks!

Cheers,
Miguel
