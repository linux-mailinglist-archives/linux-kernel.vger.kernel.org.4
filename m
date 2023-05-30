Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC2715DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjE3LqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjE3Lpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:45:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5EE5A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:45:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-566586b180fso27572837b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685447117; x=1688039117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXwxmYeftYzF4jtqCiLrlUMOqQIXZv6xuhc1OQJvYiE=;
        b=HJgN16ooshsHiGI4V9zZekl8WfBy0TCwlt4G4xj0wTN4T0V5SPWaECI89YjxMfYqZ7
         5J0+lobIDDpFs8nyZLHxt5X02ikL160kPbWvnId/jSEED27yjhRfOJnfa3AQgIHRQ36s
         8fptYF6EhjEtpUyBtKluUOw8En7dFNPlpOS0gCy6+CeFbSEhk+9gPlxPMEkU+HCFNXIq
         XUxlKnb0y0HRT2MknggVsoTrvukOAXFXoMV3sEJhWwBC7bApfAcCwwi1SrGcvdZ13Db0
         Ys3OVcirp6azO7+heXcstqN7opBBGbNqbBg6GpzgkjWWaz7U/pcK6K4XfId0vSM6UbBx
         DB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685447117; x=1688039117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXwxmYeftYzF4jtqCiLrlUMOqQIXZv6xuhc1OQJvYiE=;
        b=iS3eP+W1rK+DV+fZLhvcX0Rg/UsENWERAwL/YVGolUTn45N4+LWLMLqq2gAQT6/a7U
         xG1X8CryEqI/gD3nTLw4H/5Wf0qOniqhc+RjnP2oJGbBpUniT11c5q+XIP1VHcp88Rwq
         eihmEoBZw+V8h3LXBhW5osOjXIJvm54DeBszF8qylnu9Jzd8Ls9Edce4gC22BaTOSIbz
         1TkS7yyIfTfglu6JX1ieuxkZkopa5J6kVfy95iSTxP6bLVDsbwVDxr2yFSjGngy/EBC+
         68QWkJbuOTkHnLfahR9077mzJl8rACrgYOCy2fiWHfqyDoL0gUzq6SEnKXSDOLYZYo+t
         c3ew==
X-Gm-Message-State: AC+VfDw9+dxTDrZT9EyAenDVZYLnkU2kSSvb0vWbRx9aVpvwKPKnbD5Z
        qn9XVOakNXJ3xQAOa7VEeXWqzCkXl7y0UKacCy5wIQ==
X-Google-Smtp-Source: ACHHUZ54QNO/+6fZku62PNi90U4Qj5ZC1Ba0zmVJNFZwpokSvXDXq1LvXMXcoGLGYfuyN0jRafVEeT9V0RJEt/njhSg=
X-Received: by 2002:a81:5cc3:0:b0:562:7f3:bee6 with SMTP id
 q186-20020a815cc3000000b0056207f3bee6mr1880035ywb.45.1685447116862; Tue, 30
 May 2023 04:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230527114057.36091-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230527114057.36091-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 13:45:05 +0200
Message-ID: <CACRpkdZadKSnRQXVaWTWKEhYJ+19XM2eQzqNmoGDZSMJq+csag@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Consolidate the allocated mask freeing APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Sat, May 27, 2023 at 1:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is a common API to allocate a mask, but more than one duplicative
> counterparts. Consolidate the latter into a single common API beneath.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Microoptimization, but I'm game for this one because it has a good
descriptive name making the code more readable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
