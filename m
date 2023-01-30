Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1968177C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbjA3RVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjA3RVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:21:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55142BE2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:21:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso3711739wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSfhN/NQZOIItlwojG0mAkCuXdrYw27j66qhC9GXU0o=;
        b=dnSC9l/Qp7X43K3yBcAlLZrYOY9wqLGfqKQZ//dxhTLjaF9wKAJieVr/Emam+FADKx
         m+rzXLRUOL+iyb3oeXgHNRqcsO2eHu3/FSTbiUWSrJcHfx0pWz7tB90HjKMvIwP6pfw9
         BgmxbRuZQ3v4tn9fmNrLyEFN69UPnOrGz4OkvMFrZLX1TP8k6PkvXcrZYVi12emR595C
         tW95vsGKEBhzd/PVNble1uuOnReFuZwioybK4vaWmZIBuVojZBDs2j/1Sn+U2bp6w0gl
         6+UmKI2TRY9Uh7KXC48xupGsPUXjuE05byEgluhJOubvIjRb9w25SqVnX+rJbDvQpbU6
         hI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSfhN/NQZOIItlwojG0mAkCuXdrYw27j66qhC9GXU0o=;
        b=IJR/Hq8r8JtDVcw+ox2/SGWYH9bqSlCIOo2E/8VE23uWfqfnVTK472VvQmO8uBAL/N
         DEuHRbXMVH9fHH2rYvRht7AT96bso9PojM+TeYPM52QRq31lIaAjgVpLo7A+0LrI6S8o
         6agtLK14Y79YpRzscQxQdVXUufMZNOb+w88zKp2xHSOMIFB1UOIVj561Gv+DBuRMGoMs
         UPrbA16zcjF6K1FlFYEOCop1hEboeeR0eX7KGkyu6s72iFRI9CKesTq8KYAHtNwzXCy/
         ODOQhwrwZu4fG9+7JJrOEuz/VOqmvogkVlW+aLgdmaQVJu8cFSjcMHaSPByJPvAbHz3u
         8/Zw==
X-Gm-Message-State: AO0yUKV3ftIIgzYQmsJNK1J7BMDw5/p1RY/yCPNqgInh6QQW03i9cdtn
        OMTI6ih5gTsgrAvZ1IrjxjUteg==
X-Google-Smtp-Source: AK7set/9PtVdbnS3IC9Awh/BF1nXIhRzk5Hcus1GHJxdPdx1wyGbJl8Mq9hyXZzi8y6s3Hhx7MfQSw==
X-Received: by 2002:a05:600c:3508:b0:3dc:5bdc:a9e9 with SMTP id h8-20020a05600c350800b003dc5bdca9e9mr3047681wmq.33.1675099267802;
        Mon, 30 Jan 2023 09:21:07 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003dc36981727sm11189875wma.14.2023.01.30.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:21:06 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-input@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: Re: mtk-pmic-keys: Ignore power button if pressed before driver loads
In-Reply-To: <883798d8-f7d9-eadc-1343-7d241741ff67@arinc9.com>
References: <883798d8-f7d9-eadc-1343-7d241741ff67@arinc9.com>
Date:   Mon, 30 Jan 2023 18:21:04 +0100
Message-ID: <87r0vcc51b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ar=C4=B1n=C3=A7,

On lun., janv. 30, 2023 at 16:36, Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@ari=
nc9.com> wrote:

> Hi all,
>
> The power button on my Bananapi BPI-R2 (MT7623NI SoC, mt6323-keys) is=20
> shorted, so the device automatically boots when there's power. This=20
> causes the device to reboot when KEYBOARD_MTK_PMIC is loaded because the=
=20
> driver sees the power button being pressed.

What evidence do you have that there is actually a "press" event being
received by userspace? Did you tested this with evtest or something
similar?

If a "power button press" is generated, than I imagine that a userspace
process must receive it and halt the system, right?

The PMIC also has a feature to shutdown in case detect a long key-press,
which is controlled by the mediatek,long-press-mode device-tree
property.
So is it the pmic that shutdown your board (probably no evidence in
logs, just a "power cut" behaviour) or is it userspace?

>
> I was wondering if it's possible to change the driver in a way that=20
> doesn't break in this situation. Maybe don't do anything if the first=20
> state of the the power button the driver sees is being pressed, and if=20
> the state doesn't change.

If the driver is an issue, can't we blacklist it from being probed
instead? or do you want to use the home key feature that that same
driver provides?

Hope that helps,

Mattijs

>
> To address an edge case, if the power button was being pressed before=20
> the driver loads, look for if it's ever released. Only after then start=20
> working as usual.
>
> Looking forward to hearing your thoughts.
> Ar=C4=B1n=C3=A7
