Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEC6F484A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjEBQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEBQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D17199C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683045115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DdbmHAr/eARhTQm66JpoJt0fKm43fZTeq7P598vL5w=;
        b=cLfdG0gqZt9GbzO4MWVeYMhqW+Ba59wEMbhwLw+q+T9l2VAIr0rIuyPawCc8KpH+yn19KB
        tGMCb/eFCCRqThdaIWDyNAgjbkTiqgoNLDUQQd2i2Q0UaEfkiu3SoLU65OPqFBg3k89lCB
        OMXbaoWYKv6PSgHwAsvvZOs9TZ2gO5g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-1pud9ojXM2a-suFOGEfVQg-1; Tue, 02 May 2023 12:31:54 -0400
X-MC-Unique: 1pud9ojXM2a-suFOGEfVQg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2fa5d643cd8so1123716f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 09:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045113; x=1685637113;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DdbmHAr/eARhTQm66JpoJt0fKm43fZTeq7P598vL5w=;
        b=JlmR93y6q43D75u7kFp8kW0MLMJ7dv7emJGCHi+Z6fo3PjCv2oICAbfdGXsvEF6mjT
         COd7yMxeXdaV5sOFazlNUca5Z/Er5fdjL6/qU5+G6jC4mXu89R01GdG9liCUygpbvDRf
         3e72GFjiJssMapwkYHZ2A4Ri876Ja1gdFLyz5EtX8rUXoFKx6vJd/hxDLyI+unJb8Gf8
         ipz9cblIVr5L+w7KLtQcLKVjtubDM/EXcvE7jm7GcKqtoDIOUzP6neMQa5RhyLXzCPq3
         GmXII2HLBgkOcXaiF7A276C/xT9oYIlxmwzpojcyXk53u8tXAbgNXtGSkexPIt9F/7Rp
         L2EA==
X-Gm-Message-State: AC+VfDxJCkrN1xspqooGHYEzlsgHBkKdDFJPS1wgoz/wJe3VxRTLapTo
        K3QiO5a7YPJY4nct5N0JK8hwQANJN6iQ0xPtrtC70TDwWYrMocIuiimI/c9JKyh8Fo2K6CWezwx
        teGdy22XLHTC8COJOKxN+SUod
X-Received: by 2002:adf:e9cd:0:b0:306:2fd1:a91f with SMTP id l13-20020adfe9cd000000b003062fd1a91fmr4147025wrn.61.1683045112928;
        Tue, 02 May 2023 09:31:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EkPVTMb4YL3uV/CKjSTJe4H5ZUct+Bkd8tJ9blXCxBITCBNyVwa94yAZ3bF3D+tqITo6SDQ==
X-Received: by 2002:adf:e9cd:0:b0:306:2fd1:a91f with SMTP id l13-20020adfe9cd000000b003062fd1a91fmr4147006wrn.61.1683045112660;
        Tue, 02 May 2023 09:31:52 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id jb12-20020a05600c54ec00b003f17003e26esm39217262wmb.15.2023.05.02.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:31:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: tests - miscellaneous fixes
In-Reply-To: <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
References: <cover.1683022164.git.geert+renesas@glider.be>
 <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
Date:   Tue, 02 May 2023 18:31:51 +0200
Message-ID: <878re6y9s8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,
>
> On Tue, May 2, 2023 at 12:17=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> This patch series fixes a crash in the new input selftest, and makes the
>> test available when the KUnit framework is modular.
>>
>> Unfortunately test 3 still fails for me (tested on Koelsch (R-Car M2-W)
>> and ARAnyM):
>>
>>         KTAP version 1
>>         # Subtest: input_core
>>         1..3
>>     input: Test input device as /devices/virtual/input/input1
>>         ok 1 input_test_polling
>>     input: Test input device as /devices/virtual/input/input2
>>         ok 2 input_test_timestamp
>>     input: Test input device as /devices/virtual/input/input3
>>         # input_test_match_device_id: ASSERTION FAILED at # drivers/inpu=
t/tests/input_test.c:99
>>         Expected input_match_device_id(input_dev, &id) to be true, but i=
s false
>>         not ok 3 input_test_match_device_id
>>     # input_core: pass:2 fail:1 skip:0 total:3
>>     # Totals: pass:2 fail:1 skip:0 total:3
>>     not ok 1 input_core
>
> Adding more debug code shows that it's the test on evbit [1] in
> input_match_device_id() that fails.
> Looking at your input_test_match_device_id(), I think you expect
> the checks for the various bitmaps to be gated by
> "if (id->flags & INPUT_DEVICE_ID_MATCH_EVBIT)", like is done for the
> other checks?
>
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#=
L1021
>

That's correct. In input_test_init(), the input dev is marked as capable
of emitting EV_KEY BTN_LEFT and BTN_RIGHT. The goal of that test was to
check this.

That is, check if matches by the input dev capabilities in which case the
__set_bit(EV_KEY, ...) would make the match true and __set_bit(EV_ABS, ..)
would make the condition false.

But maybe I misunderstood how the input_set_capability() and __set_bit()
functions work ?

I'll take a look to this tomorrow, thanks a lot for your report!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

