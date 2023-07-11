Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE774F4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGKQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjGKQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:15:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B239B10F6;
        Tue, 11 Jul 2023 09:15:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11886910a12.0;
        Tue, 11 Jul 2023 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689092152; x=1691684152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3YNvBazbMQlNenlLt7Z8u6jmQ7PpLqo2Es7F9N7uLc=;
        b=m6wv+eZCBxEQXr8Ozexh8K+SxK/QKGuR6+iDyfzVSoR4HB0ekoJN8PAFacAcLZHTzM
         gI9bLUwRKfSr47ck4O6Cm06ExIp5FywzJPfDkKdtbCTMpMZDRTKdyINAdTAzckwIWFHv
         ne2WbmkCM7pxZQ8/WwVCvuEqAWBNIRW2s0X1HDkUyHzCYhf38/Q+uedwNWtsrOtcbOKp
         R5+4wYehC97hw1fsdl/FFoR7lPM1ta9idisqtyyezymqeaWDOKReuWkMYRmWiHryUGuF
         5lpvi1yYsqqIgBuSgIa6v1wlFs2sboFBUxIFH0SHnuWZoF00Twt0WZuj6hWzOwhgTcDi
         JGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092152; x=1691684152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3YNvBazbMQlNenlLt7Z8u6jmQ7PpLqo2Es7F9N7uLc=;
        b=Egnj+c+8ijI3mbuhGHatwPEAgEHrHzbWCzG9GZ259h6ajA2lkaAngO7PL5K7O/VL+q
         IFbzHa6nlUAXfpGTBOYdwzXmzUjemFhY2QLDypMw/BOHT5y0W5uiekikRKtzCkLBDmQ6
         VvjRQdBvGCg5PZTav4hYf3iu9PoP6VO+5TCSayl7YOLzCJvrH5WioS08Q4nuGp/85k0M
         gMb7+LcyD6SSGWKsgGjgh5iP4uX0L6x/2NUSz0jF/flfbT9V0b/yBkp0ZFFfxWTGV+a8
         nwjDgqyLbEwXPMSgo/Pa+OXuhWSV4Z9UZvL20mCo2SP4pw6FIY7I3TwXx1HY9FhqC/93
         O5Dw==
X-Gm-Message-State: ABy/qLbJ5eU3qjABt1y5H7CMjPD4oiQgae57kyM8qa5rk2Rf/OFy+4WZ
        0pQvJAsvxumKlnDloEgwa7bSYaftMh13/qqlFNbd7AMxoKI=
X-Google-Smtp-Source: APBJJlHSXqPqdNg9nnoASTSEuBu/eCf9o59OGyGq528wv1PX0B78LaXDuF8U+4qcWEHulEjmRsjBiA1XAwwxF4iGXYs=
X-Received: by 2002:a05:6402:520c:b0:51e:538c:1e19 with SMTP id
 s12-20020a056402520c00b0051e538c1e19mr14034219edd.15.1689092151844; Tue, 11
 Jul 2023 09:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230711151248.4750-1-asmaa@nvidia.com>
In-Reply-To: <20230711151248.4750-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 19:15:15 +0300
Message-ID: <CAHp75Vczih4F9G_UN7GNU8Th+OS=_GLbO51QxJJ+uFHTH_JbkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 6:13=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> bgpio_init() uses "sz" argument to populate ngpio, which is not
> accurate. Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init().
>
> If the "ngpios" property is specified, bgpio_bits is calculated
> as the round up value of ngpio. At the moment, the only requirement
> specified is that the round up value must be a multiple of 8 but
> it should also be a power of 2 because we provide accessors based
> on the bank size in bgpio_setup_accessors().
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> The following 2 patches were approved in March 2023 but didn't make
> it into the tree:
> [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
> [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
>
> They needed a rebase and were combined into a single patch since
> "gpio: mmio: fix calculation of bgpio_bits" fixes a bug in
> "gpio: mmio: handle "ngpios" properly in bgpio_init()"

And hence Linus' tag had been dropped.

LGTM now, thank you for pursuing this!
I hope Linus can review it again and Bart will be okay with the result
to be applied.

> v1->v2:
> - Added the tags
> - Updated the changelog

--=20
With Best Regards,
Andy Shevchenko
