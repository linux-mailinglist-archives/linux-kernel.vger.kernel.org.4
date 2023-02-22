Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9D69EFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBVHxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBVHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:53:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAE2BEF3;
        Tue, 21 Feb 2023 23:53:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s26so26769408edw.11;
        Tue, 21 Feb 2023 23:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s85ej20o57EVIAZFbWgvrgnN0SkPXWj9xUiifHsTHZg=;
        b=AFb76RWl0qx095lTG9TFJYrGSOSHsEId33Ft2ZTbU4DUX7kfqyIOv+8xnezBuHPYa1
         yCDyIMnOZridhY9SjLWjr1yuNZYnjaiDKIytq7JCdL+N8e506wpoMBmPQ+Nx2YMRsLCu
         RRtl75WuqhpLkXGr0F0kndHrxQhk2RMlFm7xAokmbPGAm3S9VcVvTGXs8s0X7W6B3quc
         iBAczBLHfa2OGqN+whJaqLMPDVyvjY+Rz82MsXi7wcio17ZKeVdqIP/uP8fX/9ulnnZo
         UmNtML76sovEkZBCTsHM6GkdL1/9B01pBEx4vUno8bi3hdeCaOdoTyfq6hkTa34gmft4
         03oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s85ej20o57EVIAZFbWgvrgnN0SkPXWj9xUiifHsTHZg=;
        b=Kzl0AoT/KDL6l7nOeF5hIf9uLcqJpp982BAgCGq9CQ9nTDB4L17bbbCRwxM2v/MOo2
         Kum28dTlKfDRCNZbLUfcZr140wc931/hPDuAb6jx2WbM8O7AtdqdA5c24ttBuV5XEhC2
         OUaQkkC4ml3gIKU5UWYFDsld9ljQGNQ052uuViq7n7+PLvGQEHStdWtUpVpdlNii12tQ
         1EibAJDJhA5tAvjaQ6cqMs3Dc/IOYtyeMMGN8q9zdc0WagwoL+N2oR2mJ8hnUUV1riix
         kvDWN5Du3Eg7Z5NnqT2SXdm3/NOuhSZCvCfgP/W8pE9k0oe1jMxIc2pyPg4kpR1JwEQ6
         pXHw==
X-Gm-Message-State: AO0yUKVbrffgVicY0NAsC40ySbv/nTuZp/oGFLRrXbG/HleTxE+I05cB
        Cr7i8XspyBfhIlfWoMeSYw88sR9l/GzqotPVnKM=
X-Google-Smtp-Source: AK7set+0c5IFVbo5S3RjC5aOGFuL8Zs9WlbR6blsKJepl2XbT7Oc5hgv5WTV0x4z8gzWNJGZhNesPqm9d1b5s6s1HSQ=
X-Received: by 2002:a17:907:6025:b0:877:7480:c568 with SMTP id
 fs37-20020a170907602500b008777480c568mr6954732ejc.8.1677052419551; Tue, 21
 Feb 2023 23:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20230221183211.21964-1-clamor95@gmail.com> <20230221183211.21964-3-clamor95@gmail.com>
 <Y/VA3HK/jGVPbrqb@sirena.org.uk>
In-Reply-To: <Y/VA3HK/jGVPbrqb@sirena.org.uk>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 22 Feb 2023 09:53:28 +0200
Message-ID: <CAPVz0n2cHvKfez6=ydR8HQfAfM_bipmAzav76Gxmp6pF4wLuhw@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] sound: soc: jack: allow multiple interrupt per gpio
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 22 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 00:08 Mark Brown <=
broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 21, 2023 at 08:32:03PM +0200, Svyatoslav Ryhel wrote:
> > This feature is required for coupled hp-mic quirk used
> > by some Nvidia Tegra 3 based devices work properly.
>
> Please submit this separately, there's no meaningful dependency
> on the rest of the series.

RT5631 by machine driver commit contains a coupled hp-mic quirk which
requires this commit to work properly. In v2 RT5631 machine driver bringup
and coupled hp-mic quirk may be split into separate commits.

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
