Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA486EA60C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDUIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjDUIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:41:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915768A4B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:41:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f8d59a8a9so16687357b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066472; x=1684658472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqPKWSvbX4VNO0qn/jU+y/bKk/xVC6QNeAEqYppXymg=;
        b=yWVLZI/+cDslc4+RgLuEeGboDbU2kE1QKtLaMx4vCT9ftlVfidtaLtYUZy1o44M2DA
         PIKJKf+hldVToUeGMor464O/I30mqqSbRS0IV8bgGW+9JeyjISL8SsBvcQRgi68g/m80
         DRu7PieARBWVMG8Et3V2xYBSG9x7z5TsebBmcHUuBKqtWgNbXBa+l00hIWsirEY3G0Db
         hWAhfd+jalAg9LjEzblCzpfg9IUA5zZ1qgHe0fien37hQaYfdA3GyrWZ1Cc48YbqVmX6
         FOhB0XkISqY+jHljzxXSta+vLgyy9vGSXOUzbZnZ5vzuamccqCywRe47v6mKKGwxAkSF
         BlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066472; x=1684658472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqPKWSvbX4VNO0qn/jU+y/bKk/xVC6QNeAEqYppXymg=;
        b=U9PL4QmAkagC/ckdZ7beiIp9kqNijsxf9wz9Pv0tAp0V35dkUiKmxsMtwnzaQnocF3
         tVuwK/cL0Do1mUooc7LPZkjK8K17cV7dAO9meTWoeyMwLKUlgMbfhncRXHtC8VCW7Wfu
         c7DCb2elbuUn+FzGugYyJ0r9ykxqsmFGzSGGz1svRlhVYG1V5mXij8/UkYBrHZa0wRbd
         //j3+dV3cmwfYhgTPDRR2c3LCUEnC2tOcOTJZn2VAAebQavOvxry1s4olcWv7PXyzQ/2
         +pPd4tXKGGkZCnIb31u43hXlR+AJWDji6KpK/3Fx1IZCXreakhmRDHLccolSCbJzP/aq
         44NA==
X-Gm-Message-State: AAQBX9ddFNWI4Ttz2j3Em24W0RZjxU608/NgS2ZYFEKkPRDIZBWeJEuw
        RcO67Q2vkOqvgYV2vsG/FO2djqAzZ0P7qkvQnAfU+R/HvkzZpOSs
X-Google-Smtp-Source: AKy350YQfPFjSrCEHnJpmEbkfsp5dzuUEon9/XSrk3k8KQQtjMNb8M2/fv0IHb9dV6OXSvsRXSzVnaA1wTfKME0QdDQ=
X-Received: by 2002:a0d:e2d2:0:b0:536:cb21:7223 with SMTP id
 l201-20020a0de2d2000000b00536cb217223mr1291346ywe.6.1682066471854; Fri, 21
 Apr 2023 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-2-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-2-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:41:00 +0200
Message-ID: <CACRpkdZ_f4gad-AS+HhePE-Z_vUromuDJgXB_WNw47Yr8Po+Uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] iio: accel: st_accel: Add LSM303D
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
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

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> The lsm303d has the same register mapping as the lsm9ds0,
> thus we can just re-use that.
>
> Tested on a Lenovo Yoga Tablet 2 1051-F.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
