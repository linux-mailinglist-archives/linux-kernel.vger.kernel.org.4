Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75276C8E61
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCYNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCYNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:09:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0F9C656
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:09:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so18149909edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679749758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqFjnFx5K8Nv2Fuhq+klMHKhOThHrV4yIw2s3Q8d08g=;
        b=JXSRUAnt1OWri6bUeTV+FNCCtT16Cg6s9TxLF5V9MuqXwsrrXdnKYHl/PYAzL1YZBL
         Nl7SQL22aXzSKvFNmnhtGdI1lESbZtNM03Wmkqe+5scBMGP+JpC3q3C9Y+psDHzluTHP
         PTpWgG4ARke/865E9JqE2qwwTKKTZwANNXO+R+B2U1oHdS8huD3pGQOnv6EGnhc6gHzT
         9655NRvFTJEv87eL6yLnLd3chBk+Jb80GSXGDu0UoTsQquw/0+KyuJitxX+tWH3OVUjc
         4dYmAvSI/ydqkAbHlVoNKPiXkbRCiEkSOqr/khojar3jnakguCEWWo6LkNn7I5T1+opa
         klbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679749758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqFjnFx5K8Nv2Fuhq+klMHKhOThHrV4yIw2s3Q8d08g=;
        b=6q5LBnMalNqdrSH3OrBMFcpQISmpG1KDVOSakzziDG6wB3W/Xe4nT6uVBmwT3bkuvv
         4oU8E5dyDMEvmzNG3zkhY0NHhLDIeWrybLWrdHuoW6rXYbgXR0zdx10bmaBYRTGpneDQ
         K/lpcUmzacaDH2UutNkH4E7Km9wPa6xtkcuYDWjA70Cwt25ZdKtEmvzlzuHcjWFfZQl7
         TYGjaTqvT+njO9iR1c774nvXdsOnqS9RqVIoqkzU2PMfiIlrXyGvALy1S5cyB+AImjDe
         ULCpkRtSC969B42WAdtq0bRmJkefBn2jydnRTF2VsyUS+55s6Ww4uoE1qPfw8phAV8uP
         g92g==
X-Gm-Message-State: AAQBX9d0e4PsA3EQY6U6aYFeA/UZMKhWu8rTxtOmZnK38Px0sMpnHrLH
        2DEN0uFnTsWya7BIk4IuU7UrSzuy6B7HjLDkkYM=
X-Google-Smtp-Source: AKy350Z4Tja2Mv3L7DZvT+QgRtp4V+RDFFrDnr8BDVPSnRX1CMd96wTPzzl5ZJNlA3HPIGJLkucy/FH68w064fQQTwk=
X-Received: by 2002:a17:907:a46:b0:920:3bf5:7347 with SMTP id
 be6-20020a1709070a4600b009203bf57347mr3796695ejc.0.1679749757656; Sat, 25 Mar
 2023 06:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230324074901.72506-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230324074901.72506-1-yang.lee@linux.alibaba.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Mar 2023 14:09:06 +0100
Message-ID: <CAFBinCC3d78cd7vcrzOznFLfg7HE4+2DRN_aNYZe+cnvRw6VcQ@mail.gmail.com>
Subject: Re: [PATCH -next] nvmem: meson-mx-efuse: Use devm_platform_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     srinivas.kandagatla@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 8:49=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
