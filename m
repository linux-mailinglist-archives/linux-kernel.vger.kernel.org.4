Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2966F8227
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjEELjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjEELjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:39:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F951A12C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:39:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba1815e12efso1475493276.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683286739; x=1685878739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puWCJyuFf3yp6BwyAz5qUYq78oF9e+xdSzj78gCEdNE=;
        b=Y0Y/0YC+7QL81nt9H9hIuiBWkuL7s/MD2CaHmSwYjTa9/pP1nMLmCAYN5YYZLHeY+9
         QHRWhAZFPTLqMLBuQGfw3+7GQMtw8hx+rr6QOcZOEx/Q1WC8Ep7HZXRnUmuxoDm7jt71
         rgSHQqKW9BTHsYCkUySzUGBr8ro5MavFn09rFJcUazJXA1O5PIUOKhUIuM/I+cWuNTqF
         TJEGOZW422cFvc4OOlja9+727aErAFw25YusDW1D5aFJoZsjbHCzcJQTKSnq7dtz6Fe+
         TAuBu9qis9CBMPOcHnexsoS/bHvgGbNhxmXURDjYr/BOhUMysnln/dG3efrq/VdfG4hN
         jsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683286739; x=1685878739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puWCJyuFf3yp6BwyAz5qUYq78oF9e+xdSzj78gCEdNE=;
        b=KrUCRo0lm+9sac07f0c8EZ13RBIEubW4LadE7C/NMAF8l1Kw/KBxR6XjfI4u+CLMyw
         1BOUPovTcepd7q6rXId3saT++r9qAw3DKEWwRghWS+XwL1JqPdf3Q56gagQmeXbyzdab
         Wf3vbsJt9ROrvm8iIi1rRpf77tlgxe8857nLJg+nsrlJbgC+tdWRTpPc3j+YW54I25mF
         vEjJ1muznNerKR6yKBVbF3bdPY+vuOQQUEZedaitpUIQ4utWACW5Zpi8ZYdNdNg4A6si
         xJLd2P7/AUQ2jqyO9TO4W/sdnBAFT0gao0UkYIsnyamxPdzcAyXmVElrSRT/9rpVX9Al
         QKEw==
X-Gm-Message-State: AC+VfDxyM3WoU3Pi8rB7QQTLyqkXEnLH1HXf+dwtRNyaW/Yqc73o0lyw
        JSr8zc8dk6IffYmtdkmQkDZJ0iTLgE8QOB6+XVobig==
X-Google-Smtp-Source: ACHHUZ7URXttrI5x/goP9FFi/xqVcIK9Vs/9Rym9CIhV8xMlCn+jPRw8C8kuiLQGeBOCQaw3GehxNG8DWIICXQgQaeU=
X-Received: by 2002:a25:c7ce:0:b0:b95:941a:86c4 with SMTP id
 w197-20020a25c7ce000000b00b95941a86c4mr1291465ybe.26.1683286739409; Fri, 05
 May 2023 04:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <98c3b5890bb72415145c9fe4e1d974711edae376.1681681402.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <98c3b5890bb72415145c9fe4e1d974711edae376.1681681402.git.christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 May 2023 13:38:48 +0200
Message-ID: <CACRpkdZYeHUkFC6U-abk=-e-3MO6DwTqE4WSc+rnHv5teQcdyA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 11:43=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> gpiochip_add_pin_range() can fail, so better return its error code than
> a hard coded '0'.
>
> Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-r=
anges")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied for the next kernel cycle (becoming v6.5)

Yours,
Linus Walleij
