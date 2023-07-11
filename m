Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B0B74E9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGKJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjGKJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:10:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FE10DF;
        Tue, 11 Jul 2023 02:10:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so6794159a12.3;
        Tue, 11 Jul 2023 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066629; x=1691658629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjowR5bw3wBCNWz7mfQrfHZlHNcMw4ZgHqW91f/hVJo=;
        b=la/X8t3Ga0N+dw3/AHxRaF9wH/3Z00193fZMz7EmwoxGkRe9a1HJgCO/yh31JeGROD
         jMIvdWWwkpZMdxbjHJFbjdJfP7ZIPBR7E+jdO1ucminHtLlwxOckcYwWormybHfRRcA9
         J4Vcby6Y2wpoub3fbdWZv5e1qozYb9KGCOD2qgfHsAWhtFWCreZS/tuiJpGM4nncfx3V
         o3ga0kLbBGziozashSi+nKu3jYdWtgHC9VIUBsYIRdmtn1BU53E18Ib9cw0eU4DSXxl/
         dqGkSQG46GCHnOo6jGQgyeLIW2SGVLBS9wsvZ4h8cvuVbgAGN4HhsSkWioccFbR1aQGb
         DPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066629; x=1691658629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjowR5bw3wBCNWz7mfQrfHZlHNcMw4ZgHqW91f/hVJo=;
        b=jWHVRa/+10PwlFaxap5OkNjqiMPFvWRqsRLlyY7sRRWn4mdMbyN/jL7hvGlhcuezpz
         9e03VRId1Gv5UB93ZyBsiK1fcOGaUdgG+49q24mOx0p4Qt7h+MelE4lGY65Q83uEXQ25
         E4LAgs2+H6fKGnP3yfxrqN4x8EU1KRy9twN0nVWSjD7eg5Za0d+0SWcqG519FLZz30Nn
         Roed+x8QTRrRQhDs9PXg1YgpPfxpxGqTsLvkoPyu4s9I21vqHLe9uV8+dCL3RhxKfN6+
         nuIzocQZgqiQvo++CYNHY72kSozZxSlwrDgg30IALK1iZeCPgORws2+ZSePkiV2qx1j6
         UrPg==
X-Gm-Message-State: ABy/qLZcC3Wknn0SEQNcD9tUbqYrDgAnEy66Tq7AgD0AUjiLY3VtMHl8
        RE6RgZpx3Me1jDxa43gEXQi7yrBDe001hSaIttg=
X-Google-Smtp-Source: APBJJlFSt3r+dAHjt8X5SfVSlZsx5J38NW0SSgu3FulttGOsfcK2j0TPu/vSGbnFuTMT6jOK47ZfvAZHEekVQhoddWs=
X-Received: by 2002:a17:906:b84c:b0:98e:933:28fe with SMTP id
 ga12-20020a170906b84c00b0098e093328femr13071523ejb.66.1689066628717; Tue, 11
 Jul 2023 02:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230711083055.1274409-1-fshao@chromium.org>
In-Reply-To: <20230711083055.1274409-1-fshao@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 12:09:52 +0300
Message-ID: <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
Subject: Re: [PATCH] leds: pwm: Fix an error code
To:     Fei Shao <fshao@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
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

On Tue, Jul 11, 2023 at 11:31=E2=80=AFAM Fei Shao <fshao@chromium.org> wrot=
e:
>
> Use the negated -EINVAL as the error code.

Thank you, it seems Dan had been the first one.

Message ID <a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain>

--=20
With Best Regards,
Andy Shevchenko
