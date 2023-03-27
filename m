Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62AB6C9E62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjC0ImI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjC0Iki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:40:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D86A7B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:37:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m2so7788764wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679906241;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAGQSh525G5QsNivU8boPxjITx0FQ4aR6d82jdyyf+Q=;
        b=p3IoE5Q99hRqPzz3xpo9aJoDkl1Oq+spG67+pjb7gTlsT6HcxQockEEzpsEQn/ZWwS
         cjq5T7SK2468KIV6K0Fde5kMg31eVKeu2A+CWVdPTrisVZ02DM2GHS1GasvHm362DVm/
         ew+uX+IzoV7H/ZhO0GFhJ0Nh+r7DSJnHQHz9tdja1yaaetaXFtbLGgMX8qbPiHtz3qxe
         l9UtTZNo/Q6LGUG7/+pHXJcIyPSC0BAcBBp8Ae0lveHCve67HLIPPZ4Dq1OU/9TlbqQu
         ligvPdptIW7xVgyrhPlkQvlgtK8HBrIM/5mdtS9yXEaKfj7JGC9DXjjxuYjnBMu3m+WP
         MVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679906241;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAGQSh525G5QsNivU8boPxjITx0FQ4aR6d82jdyyf+Q=;
        b=GHq5bH7EebqlX5WVb8Lb90I1Sn4AcN1K0e6fud0G84prVa6vmivgj3U+qplyHZC+fg
         8XfZDrKgHGXtHmD/Gh60EbSc0M9tFk8A6xnio59bDKC9+P2d6yj5bwDVgwkLZBIPGcij
         4y6Ga9k8PpJA4gjyss6yf+1AHLJ37AVKi8iI8v9FawWDBBA/IPAlkNaU7690YyeIgpXa
         /VEzSoxFRUfhl58oS1PUixP2s8zUygcuybX81DUkBjG70NiD3VFRk7SQkJTUEWAB4EP/
         pepkLlt1+0g+bIUJ/U1Vr34yBxCl+WJOmXYxrmLBlQODJ/WJwI3K5CC2KvanqS6OpNLl
         0c8w==
X-Gm-Message-State: AAQBX9diF7m+tURH0T087n4PKjuYEiCHL9iUIgYnLjZAnLcFVC7P40L/
        X9P6CoQugootU/yeX7e//kydB4LLXhBWI01TKE0=
X-Google-Smtp-Source: AKy350ZiWynu63zWZTjihRtHZa5diapakFf34xk8Kw84gZt8VcyHIjhXIq/m0lGrMLR2M+1+9w8TuQ==
X-Received: by 2002:adf:f582:0:b0:2cf:ebaa:31a0 with SMTP id f2-20020adff582000000b002cfebaa31a0mr9023916wro.54.1679905686704;
        Mon, 27 Mar 2023 01:28:06 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm19192398wrn.111.2023.03.27.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:28:06 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v5 0/2] Add MediaTek MT8365 I2C support
Date:   Mon, 27 Mar 2023 10:27:56 +0200
Message-Id: <20221122-mt8365-i2c-support-v5-0-6e4f3b54937f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxTIWQC/4XNQWrDMBAF0KsErauiGUmW2lXvUboYSZNa4NhBc
 gwh+O4duiyhXg3/w3/zUJ1b5a7eTw/VeKu9LrME/3JSeaT5m3UtkhUaRABEfVmjHbyumHW/Xa9
 LW/U5GxcL4QBMSoaJOuvUaM6jTOfbNEk51r4u7f77aAM5n/+aG2ijHXEK2bs8hPSR6D7V1Pg1L
 xf1JeKGxwqKwi4LAo5DhCeKPVasKFTeUgIThhLOTxR3rDhRYvRUrDVQPP1R9n3/AYK7/rqOAQA
 A
To:     Qii Wang <qii.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=nSXv0el9Q8eoEvhrwybYSeDmgS2My2V0mCaELMNPWdg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkIVOVGTG8xJzvYqFA8imHTuPGZ8rE/HDlHms8uoEl
 3j7NhP2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCFTlQAKCRArRkmdfjHURczaD/
 sEi6Ep1k07eUJsUradvYUXA1V9p1fPlrqwqj6K0ndkmHBaBoMybGY2w5BkIHbU1eOpifrH2TeXjrqf
 WC6jhSGEW+P6OEtROWTGnL3PBdtT7UeF2BBeFtKyl44vw9MLhaks69GfuBsCvqVXgUMBnZxUKksu/6
 KX0LAlE1Mjy38sX0T7m9H46UN4fMvSyjn3FLiKdFD8pdsB94JZx/oLgZBJecIpIZJwj0ai1NdDhGa8
 jNMaqbAzwg/33Dv8w/YVWfDxyGHYT1FnXRuTsnrFRbqEbMZQGs32V+JzoEy28tHvr9QFuuPge6oszP
 ZIr660+hZHEqNDRWH4AD/iBJzdFx2YcPcthZ3Wl6k7LxZj6GzbXBF4oVHxaucnY7fDHPpUP9zeLjqY
 4h34++BNsS5YciBHvHZHXSFCPrPkftwhD5LVYBg9ffuq+4/BtN6nVZoySkEOhGwUdbfoPPCYsqZ0Tk
 8S9Ueae2dX3Nqw7S8NQY7zddsqkKdBOYRZ3Y3hpwlghfouSz4wGDetrG16/t5OoQnVY1JXhzdwSPLy
 +H1MeB5Xu2gOmjhtuedevEy60yDzda3+SqCD23wxT75Dz0KI6RMAY/NkcBtF4zfzVVB1L+7z5y8n0T
 3PFrZXO2tF2FaxTl0vyeJCAOC4z7gIs1qyssJDKmJUaBKjlub77LG/+DoXkQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch series adds I2C support for MT8365-EVK board.
The I2C-0 is enabled, it can be used through the board pin header,
as described directly on the PCB.

This series depends to another one which add support for
MT8365 SoC and EVK board. Link [1]
This dependancy has been applied by Matthias Brugger [3]

One patch has been cherry-picked from [2], so I've addressed the comment
and kept the trailer.

Regards,
Alex

[1]: https://lore.kernel.org/linux-mediatek/20230101220149.3035048-1-bero@baylibre.com/
[2]: https://lore.kernel.org/all/20220531135026.238475-2-fparent@baylibre.com/
[3]: https://lore.kernel.org/all/ed1f9faf-cb4f-9ff1-ab6b-813035a051bd@gmail.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v5:
- Remove mediatek,drive-strength-adv which is a deprecated pin-control property.
- Link to v4: https://lore.kernel.org/r/20221122-mt8365-i2c-support-v4-0-885ad3301d5a@baylibre.com

Changes in v4:
- Fix some properties order.
- Remove the useless properties.
- Link to v3: https://lore.kernel.org/r/20221122-mt8365-i2c-support-v3-0-ad9bb1076d7f@baylibre.com

Changes in v3:
- Rebased to v6.3-rc1.
- Move i2c3 node to be consistent with the SoC address order.
- Link to v2: https://lore.kernel.org/r/20221122-mt8365-i2c-support-v2-0-e4c7c514e781@baylibre.com

Changes in v2:
- Drop the patch which do useless change in i2c-mt65xx.c driver.
- Change 2 lines compatible/reg in oneline.
- Link to v1: https://lore.kernel.org/r/20221122-mt8365-i2c-support-v1-0-4aeb7c54c67b@baylibre.com

---
Alexandre Mergnat (2):
      arm64: dts: mediatek: add i2c support for mt8365 SoC
      arm64: dts: mediatek: enable i2c0 for mt8365-evk board

 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 16 ++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 48 +++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
---
base-commit: 5c6b974d24c21a6aa5d8b524067d7d9bc7fcc4f2
change-id: 20221122-mt8365-i2c-support-fc048da261ea

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

