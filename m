Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42166DCD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDJWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDJWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:23:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7139103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:23:12 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f64b29207so17018287b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681165392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqzijXan3tbsRD035Gip+Q2/1907zc8S6CEtVT7zJ+o=;
        b=qxQ3TGut0CDdZg7WfjGFwsLUaIvbZS/P76q6rQUaI0tTClhQ1SiVKZAQDDmid+ncqg
         PpZAePtYwUKUbZpDJhpphnnyuOE7QWtQQJAbvf7FR8pQpMzEglKpW/L80CxMiwhoVlFn
         8wNmks/g5Ay8L/jIHqDpAN0CYLYnP5nhYOxRwFWsv++1HuyD48O2/niQFjtKsiCKcvj+
         ll75Ou2hHDu7jc1LInVif44jVm7ASeLc6LwHNZK39awSjcZouVHYlhBKmLiOn/ecgt6V
         UnZisOgTJybUqdYM8wgDVFF49xcji+rymGGz8O4Rd3OBpaVGcCu/mc9l8GXJTZDjV9gn
         ckjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqzijXan3tbsRD035Gip+Q2/1907zc8S6CEtVT7zJ+o=;
        b=8JklTteK5B3qrrjgT8rPcGH3h3nX7r7Y3lsLdNUL68agENbXWkHkXysZoD7E/9jNWy
         JfCuOW0ZsHr3hP2ZbAqX3GEzjYa2rHoZJmVLRc+GB5V9P+1YlRZsYuyV3n4Ke1jdC0rh
         f6FBQNtehD/emSjS9XOTUYlho9ceY8K4P2dBhS9qPBwtgo5YMlLZmUEFgTCsu25jW/Pz
         1MerrrECRKrXMdxuiiVqI+D0ZWVSPfyDPby9rvn9PGvn1V4FH88Jo2vZbQw1TZaclb8b
         BQU33xSjjqGfA/f4WncxbEBGnuZF6Vu+16qrnaCS/f3Jnk+mQzYkE+fAJ2CXlmeYyAaE
         QnRw==
X-Gm-Message-State: AAQBX9fy+AM3RKVWn8m2TTxHudXtzGnkDPmtv9a6A9H6yJyco4P4RKC7
        V7BAz2NS/zWVvRBgcQD1W4Jm9eKQPrDECJk+ZcagsQ==
X-Google-Smtp-Source: AKy350ZlEYOLCGErRvEJNnVaXWgyMcgVUP+9FL3bH6XvLfYW6GMr55R37YmMlKd2Pw88yL58x2v6zAv5WJAAQ6eUVuA=
X-Received: by 2002:a81:c409:0:b0:545:8202:bbcf with SMTP id
 j9-20020a81c409000000b005458202bbcfmr6407198ywi.9.1681165392023; Mon, 10 Apr
 2023 15:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230407142859.1.Ia5d70e320b60d6707c6182879097708e49b8b519@changeid>
In-Reply-To: <20230407142859.1.Ia5d70e320b60d6707c6182879097708e49b8b519@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Apr 2023 00:23:00 +0200
Message-ID: <CACRpkdZH=EKoVjvDz4Er9XS6TSAGLYS=daZFb+bc2LpONz2Vgw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Add "and" to PIN_CONFIG_INPUT_ENABLE comment
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 11:29=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:

> The comment recently added talking about PIN_CONFIG_INPUT_ENABLE is
> clearly missing the word "and". Comments live forever, so let's fix
> it.
>
> Fixes: e49eabe3e13f ("pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INP=
UT_ENABLE")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/k=
ernel/+/4409769/comment/9a1d5def_e1e71db7/
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Patch applied!

Yours,
Linus Walleij
