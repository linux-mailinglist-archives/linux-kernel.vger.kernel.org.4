Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7A7098E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjESOCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:02:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D69114
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:02:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2934727a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684504931; x=1687096931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCA4W0aVo+e8OjY3tSgSqtBniuKM9TjrVDSu+ILRZQc=;
        b=ZBTbewDlGG7cRnbdWnrb8ry2wdTnpMiArph4eC7ZtX3LmdWl+8+KXe6BQBwPYD1tcF
         1pl0BnVVEYLufcYz77Vm6lk/suM3vdYE7A/sfeOD38GyGTMhVxXlTAXaIECojW6XrAH3
         mJoJirMXWkCwm4jUDszIoopISZohjnhgvPDdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504931; x=1687096931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCA4W0aVo+e8OjY3tSgSqtBniuKM9TjrVDSu+ILRZQc=;
        b=jNihpACmIYS/h6vulGm1Zsxqk4dl76DjOheZLNOaXjJJpR25IlIO1i3tnXwGlNDZwX
         dmOQ6GZNbQfS76eeNITFduI0xuedD93KKMgLrZnGyWx5jCZzp2/I3BblVh/m6UHzxRZT
         XSdt+Uy8UjsH5YzNEyMzA/4fRwts/8sEKM9SX8aVJ0CoX0kKJR/3fdel6zCi64gZbN20
         9PdvqP8EbGAVQUROovk2YfFKwuyLg6OaJ1Dj4jndjpZK61mbezt7ZfOWcuwGH50sTHHY
         ZIgNTFN94Opk2f+g1kkmePOgkfjGsViazUTdFjt251ALrMLBTJwNjkVLC2+R34Y82O63
         w8LQ==
X-Gm-Message-State: AC+VfDzMA51TCaFw+FdlRTiF2rhk6P39wjT2IJFtu5TIodXZdXmvPrQ3
        dYgkonq1FhHwtdNdTHebYA1eZ363iULppUUrcYE=
X-Google-Smtp-Source: ACHHUZ71zyjc8iwDLwZ28HJ050YlFaZlgI43fpwYXV4fJkG3gdtmPpphs40DCfhsH3nNIwvcyXSqUA==
X-Received: by 2002:a17:90a:6341:b0:252:8698:d03b with SMTP id v1-20020a17090a634100b002528698d03bmr2210673pjs.14.1684504931034;
        Fri, 19 May 2023 07:02:11 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id d3-20020a63f243000000b0051b71e8f633sm3084663pgk.92.2023.05.19.07.02.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 07:02:09 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1a950b982d4so144675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:02:09 -0700 (PDT)
X-Received: by 2002:a17:902:cec6:b0:1a9:343c:76e5 with SMTP id
 d6-20020a170902cec600b001a9343c76e5mr199210plg.18.1684504928906; Fri, 19 May
 2023 07:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230519090149.4407-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230519090149.4407-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 May 2023 07:01:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
Message-ID: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: goodix: Add ili9882t timing
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, mka@chromium.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 19, 2023 at 2:02=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The ili9882t is a TDDI IC ((Touch with Display Driver)). It requires the
> panel reset gpio to be high before i2c commands. Use a longer delay in
> post_power_delay_ms to ensure the poweron sequence.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Two comments:

1. You need to submit a bindings patch to document your
"ilitek,ili9882t" compatible string.

2. I would tend to add the support to the "i2c-hid-of-elan.c" driver
instead of the goodix one. Probably the drivers need to combined again
(I'll see if I can post a patch for that before too long), but if I
were picking one I'd pick the elan one, I think.

-Doug
