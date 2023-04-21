Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CA6EA625
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjDUIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjDUInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:43:53 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F54A5E4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:43:27 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b8f599b9277so1753452276.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066601; x=1684658601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTKKOyKN4Z0lKcLKCV+aiEIsVrXu31hD3pCZldfF46M=;
        b=AC2JKMAZucbYV4YJydqiE9nhmDLQP1qu6xwVNlgUI4dG7QFnnPj1LKMyYVuWNkV+KU
         KTwJg3Vz8A+X1+VxBpTjy1kt7AdLK9RiwpWlXAZCj0sdke6K1Xz23Xd6xu8N5pPDzRNK
         hH+5Fx2qm4tKEnfmdoVQOAADXKJr5tj1ka0HQJ6xSRupEmAZ8TIF4sjsszGB4odQtRAT
         IuF4ATmROZ5uWIuNkJdfRjiHzOBSDBvGeODS/3zUznPRQQYcpk1n7Tmbf+z6LMvUgzVy
         ZYW5LzKaplXNuAcYRgbKSlyWepTl0zzM5qdoBZEGqLlug296MWXihbO2kxPQy2GdN26S
         G4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066601; x=1684658601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTKKOyKN4Z0lKcLKCV+aiEIsVrXu31hD3pCZldfF46M=;
        b=gd8zwF6TwtB3yuYz+hNg9xOlNOeBlCLsAJA5QJjjyHAGalul3HP66yBJUzBd6Rteje
         I9jgnMoGfVKyTAs5n8a1yJjhbfv+DtFU8o91+fpiHms1Z/yKiWFoYi0KEDO+oB3gXw5j
         hThZOe7BiCx5jWuyvpLEDxJUaevOEEAFjJukKC0cm8QETz1XvzrsTEkX6i3XosdneOAK
         sMj+nTGqyjT/Xlebu/tfIOfxRpPs7I3846Nk6KZrf8hUPTbvihJMG47lX5K/DEcSZ+Np
         rcVsWlxRcO1jODlwvu45o6D0XGioGaLnC2IK8nN0fwIHzq6CqiasQpdt+RevJkCWBsLm
         6ATg==
X-Gm-Message-State: AAQBX9fT522f1/v+gfGnGgiqmHKP3lduuWsH0crWcY+QYMYZ+9QetL+b
        7JTjahTdnksDFar8AJi6UQxTsBjRhoA4R1+bwLb4gw==
X-Google-Smtp-Source: AKy350aTq3k6gn2qX7lD1gS77KA3FGMddnhmjKpqI3uEOwtfJ8yAPioU+Ep320STOoH5P4ilYdei+SHs8ebFbT418w4=
X-Received: by 2002:a25:d8a:0:b0:b67:3785:823c with SMTP id
 132-20020a250d8a000000b00b673785823cmr1474283ybn.36.1682066600858; Fri, 21
 Apr 2023 01:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-5-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-5-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:43:09 +0200
Message-ID: <CACRpkdYK09BXp5isd898veY=SKniCys+24jvGpYbDJO4jXy3QQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] iio: st_sensors: Add ACPI support for lsm303d to
 the LSM9DS0 IMU driver
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> The lsm303d can be found as ACCL0001 on various Lenovo devices,
> including the Lenovo Yoga Tablet 2 1051-F, where I tested this
> patch.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
