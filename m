Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFC729A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbjFIMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbjFIMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:51:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D77210A;
        Fri,  9 Jun 2023 05:51:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba841216e92so1748215276.1;
        Fri, 09 Jun 2023 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686315063; x=1688907063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGZuJbgC740YLODlkWmjW5DXUdE1JToY+I5MmfvcPe8=;
        b=mvNcCHBWzHzNrO5q//rYg4MIP+yevdSZDgHg069w9JYhCxodazO3P0y1RhJZcahL3r
         XRBlpalsVTX7DHdxNerlk7owLreS7cT55RUWTlFS2K9zWzz/nP2nGlqr5As0fjqzDmZt
         6fRFUj9vNnn4g/kCU5Oy2zaQ7uIbM2QyNevd+slCegXUirOZcn2sH6hYb9mgrKOA3l1P
         a8L416qBpaJcP858J3isZqocEckWOeMw+0Vj8VjH6ZQadugzAaalzSY9axGPO3jEOVw7
         pHdmJeroiqyI2qf63yxYzuFQ71pRKUmaCfvXo9zxCA+i/FORWSD3rR7hHOOFoVZ7+NaQ
         Qq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686315063; x=1688907063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGZuJbgC740YLODlkWmjW5DXUdE1JToY+I5MmfvcPe8=;
        b=l3R1FvtJc6aBUB2GnOEs2/wnyaKuUsJlRCNT7UXiM/11COVq3SPPU+lCIFNngmV2/v
         Wmu7604j4VPhbl3MRRdeAP6fngkyUFS08NeaCCsrDbFO+wJbVSFJ7cTtB1W0RBbnQzb2
         nHvyWkzAEFfPL73NJaq2SgbKos4eb5kEq51IWh4/M51GUJobEgx+bUEQ15gTBh+6V3Pb
         FzCu8Pc8F+VMKuVuTEKezpOIFSSK9egDLcuIAEyTq1daRv49ums7LLhuiBbnYnD8+eP7
         0ehZ1qJpRbyAxCi4ykI02hjM+zE6tKIb4Ki1sGpfc6PLYWYkSFoonoHAXvO48WWOapj9
         7oow==
X-Gm-Message-State: AC+VfDyJwmpUVcQTgiIQNeHjoVWyA31JwXEg2Hc7uXL7BvlP5Bv2Xvpx
        ftt1UafTOK2HcBshhHWipN7oghxPOiExzxWVf4c=
X-Google-Smtp-Source: ACHHUZ4aVtkFfkgl4fgQB7uOXF3tOafM5qe9D4x6OESrQ1rM9j7Aqh1/llk80MiU2+LBJmpFtsk0oN63TU9oBDk5v7M=
X-Received: by 2002:a81:a009:0:b0:56a:3b3e:bcc with SMTP id
 x9-20020a81a009000000b0056a3b3e0bccmr1023511ywg.17.1686315062773; Fri, 09 Jun
 2023 05:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230527012206.133464-1-samsagax@gmail.com> <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
 <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com>
 <820cef00-4768-46ae-c5a5-ea7c0dff71c5@roeck-us.net> <CABgtM3h0KMsOzZZvYKZLsFXn9A81V59ygSKizoF3TTkraMWr-Q@mail.gmail.com>
 <94f78001-13df-8c39-4771-7842dc94195e@roeck-us.net>
In-Reply-To: <94f78001-13df-8c39-4771-7842dc94195e@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Fri, 9 Jun 2023 09:50:51 -0300
Message-ID: <CABgtM3iOyCDgDY1gj-gJ4DXaXCY41FKzy-=miz0iiT8ywjbMHg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
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

> Why don't you just attach the attribute to the platform device as I
> had suggested earlier ?

You mean I should do something like this in probe():

static int oxp_platform_probe(struct platform_device *pdev)
{
  ...

switch (board) {
    case aok_zoe_a1:
    case oxp_mini_amd_a07:
    case oxp_mini_amd_pro:
        pdev->dev.groups =3D oxp_ec_groups;
}
    hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
        &oxp_ec_chip_info, NULL);
...
}

Would that work? Or even be correct?
--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
