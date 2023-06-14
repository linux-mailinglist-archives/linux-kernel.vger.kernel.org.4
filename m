Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3C72FE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbjFNMSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjFNMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:18:20 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77F1FD8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:18:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so864537276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686745092; x=1689337092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xqwBeEw1hk5xn4VcXmpj3wyZNMEIN3L7jL2szWZp3c=;
        b=Kve0S08CAP3lsH0tnyAqWwbwWFQum8U37JpgmvgEvntnrZiWETPX8Nr+TTYeoiz6Zb
         DG+1Od4ppJkIHwKcLeBb3afwbqyDnxQT4dEEt8QA311SwRpIzxrzpGYvNCf0rx8XOU5G
         Hioq6YlMRz5dVcNi91gR4Hy8FkdWD51LbQk3sQNOEQEXwIN2QIR6BhtFbrkI/lS9iC5s
         00RKflUgq7ueZPdsL8WpEb7P6ym57qDxL+9DtsDV//YE4Qpc+NaSi8spkRuPo0veujWf
         G//NSe6Ij7TIFQ0s1LdxZrtHSHwuFmKEvLsOlilKxXu/AIKSHLuZltbrkmzKGWU43yOh
         yKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745092; x=1689337092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xqwBeEw1hk5xn4VcXmpj3wyZNMEIN3L7jL2szWZp3c=;
        b=YEpmLiKxug1jI+WF1lYT98mfkR5az1VY1jp6wilffCodg8eElGU0YcxS2kh+Xq6Epz
         R1fzdGhUazs+alxXbWxRv/dKRqthOJNjCU2vp+Px1pC3Ngl/sbdCv/jtTMNWEPtAojWp
         zJ9zlS5OyoK7JqJWCAOfGyPa9HliWBxUNOoDlVMUwVsjU7tUV03Cy8rDnGdq9cfcxY89
         RxDiifYv9YCxHKDeGxQanWF0YFpCeM/c//qiIL915eBEPzU3O/tQua0w7pS0GJQMLo9f
         v/ZvV+kHEFv1mk8Embr7dkThRFtUB9AULqWwoHVV15q74D2bm5ECR6E77siN48Bi9Mkx
         YIzQ==
X-Gm-Message-State: AC+VfDwKu78Ie3RWHwOv8zkolzNx3IdMRYIR7ZzVjvcT2H3z1+kM3BRr
        +a7549mih5I136pZ5SMCrLTRxsSRsmE6luIcZi3K/Q==
X-Google-Smtp-Source: ACHHUZ5+Ben8hijM5+pzz4DLNdhrmBBwVUSAPrma0St94qyK80nZeudAIWhLS7reC8/bAV8yKGXEn+PZVXTYR6RGj4U=
X-Received: by 2002:a25:404b:0:b0:bcf:d645:bd9 with SMTP id
 n72-20020a25404b000000b00bcfd6450bd9mr1963762yba.3.1686745091896; Wed, 14 Jun
 2023 05:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230612125248.1235581-1-eblanc@baylibre.com> <20230612125248.1235581-3-eblanc@baylibre.com>
In-Reply-To: <20230612125248.1235581-3-eblanc@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 14:18:00 +0200
Message-ID: <CACRpkdY91GaddouyEJPaEyfcg_0zCrOz8RO3qhC4V8Oy0rUGLQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, aseketeli@baylibre.com,
        u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 2:52=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:

> TI TPS6594 PMIC has 11 GPIOs which can be used
> for different functions.
>
> This patch adds a pinctrl and GPIO drivers in
> order to use those functions.
>
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

Looks good to me and beautiful use of regmap GPIO here:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
