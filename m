Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8565A9A8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 12:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjAALEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAALEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 06:04:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA372BF2;
        Sun,  1 Jan 2023 03:04:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so4573773wmo.1;
        Sun, 01 Jan 2023 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HnHmdEP5HhRZd+BTvJL8Yr2jrcg2A44jfbRtO0xZR+0=;
        b=AYCw5+Ma83Vasd8Mc7zAYm/L3o+CTwQhKKdq42eYEi+oQ/IpemjRFdM6CkvYLH9BZ4
         ltRljrPDmLE4B0xd9bN9qM+hQ5pxjKgprfXzJITOWSs6RiZr49TeZD8TxRE/FVRgG6Xi
         MuzjdUFzqf+kizGWBNiEh5/SM+duAwn/HDUsUmCgCiJx9nzuE/iDOQoSB1qxydHC6eG3
         TEFx1ZA0mUpPJcqm5v1CE77mVtTZlpBFQnnLjNmqUMNid3EGaYp1FJpId0a3p+4KZ+Nn
         onGGyyOmNBASvZ4Zhg8Biurx6DQId9RjzzkKCIx8ZswmsXNYaXgtEviG+uD2baqf84w1
         UJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnHmdEP5HhRZd+BTvJL8Yr2jrcg2A44jfbRtO0xZR+0=;
        b=rCKlYmpSvFKmJTbkQr2I15hGTxu3fYCChEjBW/AtOxCLjO3vM9/MSYCk1ybXmDlPVg
         uWYux2zBDQJmPxX0vlmqQnq2lj86jHgE5OPj2R8OeyzD18uC9RdgW+L/jk4ZYdUn3yJj
         P3d1uCN6Ab/9U05Z1BOZpqlyTToyXb7Fs6pvX30yjasf3yagarrycDTnP+iQdLhGeNz9
         ZITIYtIjN/4WT/oC9iwju4cB7W0YZIVrdIyNbrUZFY/XTUsGPUwTgcjxsUQIFyPheGRQ
         CjhO3kLjREziYnndI4gM0jUfdP04ePBaBjp8i6A6edeNXHNj2hneD4JbvZ8vpzx+f29d
         /Jdw==
X-Gm-Message-State: AFqh2krHRA/ROz5g9MtNtZfAgH1qrf4c7RKj4mVVqIDp88CkSCvfcte7
        jcZR54YPl1J1g9dhG/zVgnChIs9ceZY=
X-Google-Smtp-Source: AMrXdXtFw0Einvi/VBREuXzcLb1FIFlTBpHmVA+LcHh2JkyEAQf5fsptZzdHj9MMcLfK5RFodLQbgg==
X-Received: by 2002:a05:600c:6020:b0:3d1:f0b4:8827 with SMTP id az32-20020a05600c602000b003d1f0b48827mr26495268wmb.25.1672571081960;
        Sun, 01 Jan 2023 03:04:41 -0800 (PST)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c080500b003d208eb17ecsm32727701wmp.26.2023.01.01.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 03:04:41 -0800 (PST)
Message-ID: <e13c4e3962923994c853b115a5606633387991db.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Add enumeration to handle
 chip variants
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Jan 2023 12:04:40 +0100
In-Reply-To: <Y6tlpP2SgsgoVBrK@smile.fi.intel.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
         <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
         <Y6tlpP2SgsgoVBrK@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-27 at 23:37 +0200, Andy Shevchenko wrote:
> On Mon, Dec 26, 2022 at 03:29:20PM +0100, Angel Iglesias wrote:
> > Adds enumeration to improve handling the different supported sensors
> > on driver initialization. This avoid collisions if different variants
> > share the same device idetifier on ID register.
>=20
> As per v1, use pointers in the ID tables.
>=20

Taking your suggestion and Jonathan's remarks into account seems to me like=
 the
best approach here is using chip_info pointer for each driver as the pointe=
r set
on the id tables. As in the i2c and spi drivers, the enum is used to fetch =
the
correct regmap configuration, and later in the shared probe, the chip_info.=
 The
logical follow-up would be adding the regmap configuration to the chip_info=
,
right?
Or is there a better solution I'm not seeing right now?

Thanks for your time,
Angel
