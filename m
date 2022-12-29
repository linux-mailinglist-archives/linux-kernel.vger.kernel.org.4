Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8765920D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiL2VPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiL2VPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:15:47 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACB33C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:15:45 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r205so18068483oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fP9vW+f4HJx2PMQOsthzDPalvVom8q67NEFiBnQA94Y=;
        b=sHcj50okRU6B4RqAXfb6NJ+nmRgPRo/rlHkaapygujJhm1hEjkTFWgRfejemKXgTbN
         BIqAT2liXTV+lmID/h1yAu9xeRvogJ3ToeQCkStzggAYdta6pHdiigYmDhoS1Ku9Rwxb
         kkgiHxE/b9ZtPeOrX3CnSkvqlTXj5i2C4x8o84yZQM92dQMuyEqJqnfYXBF51kN3dMjQ
         4bJ9eNncYoz/n0Z3/OVYXzrRbBj1SzyKcoVpQaRy/lPbF32N+L6cbrn+UEw/hDjljuGD
         aJ2mPsiKFPw6kC0ZUophFVuftwPj7J/isUk8/MzyQouffzPw/BiFE1El5WU5EtysTzcg
         z49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fP9vW+f4HJx2PMQOsthzDPalvVom8q67NEFiBnQA94Y=;
        b=K4Gzf7V+empEOPTz06ipLy6ntoO/vBUOtXxw0+dw9X44X19FmWE1Abip1VEo0cwyFX
         +iOe70+Xr+9VIb5OQVRlEIBNIEpITBQfOhvA4tzp4U8ni+FyDmnEfqWnobQLbnAnO7yF
         nOwY0IzEluiUzuhyIAOZTwI0NBQCmZ6mHl2b6CzFvioSXnrod/xf8EC3BH4033ibdnYJ
         i0vR/MbFgdpxcb7BjfYVUlH7TlovwAWxHYCkgVCdvTfOhqq+cxQLiLURkDyEhq6a9aMz
         zsoCK/HLBhl/pBCCmS/hunXMtp5AexYONqGWnFH9rEvIT3OXyj5kzrsen7weEKQsDN7e
         lbpA==
X-Gm-Message-State: AFqh2kp2jmo641V3ANBqGklot4P4mEDMoSGbEjVdxkS0ZbCUVoRil13i
        u4YARyU+rUF4N2kbrxtOF+V5T9F6mYOrJl2WcybSYQ==
X-Google-Smtp-Source: AMrXdXvN6Orftn3hmgTYONNYA8qEr00HxkF5nIDdY0voe6NhcGplTvdTO4P6MhjOsMrSDZf5MiLAE+bleRvSudQXAPY=
X-Received: by 2002:aca:3dd7:0:b0:35b:8358:aed4 with SMTP id
 k206-20020aca3dd7000000b0035b8358aed4mr1553371oia.291.1672348544838; Thu, 29
 Dec 2022 13:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 22:17:37 +0100
Message-ID: <CACRpkdbDevAJSjEKHdi+kovzuhuxJ2cbyUYNb9w8qimYMa__Jw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] pinctrl: Introduce struct pinfunction and
 PINCTRL_PINFUNCTION() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 1:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There are many pin control drivers define their own data type for
> pin function representation which is the same or embed the same data
> as newly introduced one. Provide the data type and convenient macro
> for all pin control drivers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Very nice and helpful!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
