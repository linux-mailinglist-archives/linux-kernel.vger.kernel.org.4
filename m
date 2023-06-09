Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF27290DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbjFIHWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjFIHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:21:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1422C18D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:21:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb15165ba06so1451280276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686295304; x=1688887304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqR4+wxVQ0djZi5VqEW6OMI/6pVtmx3wzdSI7GLh/j0=;
        b=eN2o2tWJbGiu31bKSfBVTtFZJT31Bj9JGX2tD6cCYxh4Xae3C9A6kusl5zs8Hljit/
         ZZdTkyTbH7GnXwa1R7OgMALLbGo+JvZxRj0x7iBIiMbfIVOZmm776Vo6Ybm3Ai3VtnDE
         g2hz1v55bCdvjVCsYYVM/fKvSyeJ8cOacOQEpvRHbRsFFWJZT4wGQmYu8YYzvQCrhe/Y
         AssItq7D/SLGh4ZevKDHgWp3OIOGdZ7Hcy2Sw5pvv/g4L1jBUeLSFEwV0TXUd8ZJjOLv
         Viw4bePceInNJqozG6DezC+w+YngQ9hZ382d43he2IZOilXsEELG7xxMRvh2X5YTKv7y
         PiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295304; x=1688887304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqR4+wxVQ0djZi5VqEW6OMI/6pVtmx3wzdSI7GLh/j0=;
        b=YmpSAD5rksLXOl39UbT9RIcPFafkK8SPDE7orxejAiKAtv4Y885wvt51Iwgd3AynAl
         xxzvcRF1nGNPWy1oGGUtHXEN+7h1MmpvlfhT0ZcVYVr7JEf/JHZ2zyzSGKCsvCrqUwd7
         hjI4Bwld2Zk3tfmaOh7p1h7Zl7DAM4CLBnov5jizpPifkVBBvJWj1onwCM/2JewbapNC
         LcgB1eyPcB6TpGur+xdZlDlcNMPX7WMDN/ov/jigoVlhebf/g/aw9LKoZtSooIL0K+Te
         Bj5UU+lKv8szqGNTAlWeDFh6/3PRQ7JSqony3Tlj91lBpk+q1Y4KtPFWBLRV3q2eAYUd
         IY0Q==
X-Gm-Message-State: AC+VfDw3eBpOc+O9eSnLLXENz/SONTM9f02PfPzRPJZU6cdL7mp1hWfo
        zhpG625H+bCK+fbn+rpsldLo5V/BjGyJ1XXRudzPVe6qKV7KbuRh
X-Google-Smtp-Source: ACHHUZ52Aha2fvuvzRnVXr3veiHhI1IT0CwXgNUyqsNgyVxjcz0aZltwWsuPRkz8wSvW3lsTCARV+iaDygLT/SwLdmY=
X-Received: by 2002:a25:1384:0:b0:bad:822:d9d1 with SMTP id
 126-20020a251384000000b00bad0822d9d1mr360226ybt.19.1686295304362; Fri, 09 Jun
 2023 00:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230604131215.78847-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230604131215.78847-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:21:33 +0200
Message-ID: <CACRpkdZiMWhwbxL=Co3QyjXv57rKN+HdN56Y4qfMBeEu3RoiFQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: Duplicate user memory in one go in pinmux_select()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 3:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Current code is suboptimal in three ways:
> 1) it explicitly terminates the string which is not needed;
> 2) it might provoke additional faults, because asked lenght might be
>    bigger than the real one;
> 3) it consumes more than needed lines in the source.
>
> Instead of using kmalloc() + strncpy_from_user() + terminating, just
> utilize memdup_user_nul().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Excellent patch, applied!

Yours,
Linus Walleij
