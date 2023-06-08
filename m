Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E61A728941
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjFHUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjFHUQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC32D72
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686255321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L48RUw9YMqyOqmKmJhsjcW6o+lsA4cxkY+mrl6+2nfQ=;
        b=PuPsUIiYMLh0iTUkbQntHx8vx77kwtABSkeh4a3R0zXA6gQV4GPeZM8p5NpTMy7jPEpm+N
        ebKJPswOhf7Y4vP/d46UWMlbtC0sOMoNK/09bIUV3g054ClMhAkC6rbVAQlM5XZZ6rPOpy
        searjn7ltLz6KCt3jhP+vXxrLkIX4TU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-bMLozrTZOyG5WcjqlY-raA-1; Thu, 08 Jun 2023 16:15:21 -0400
X-MC-Unique: bMLozrTZOyG5WcjqlY-raA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-187e7e6990fso51639fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 13:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686255320; x=1688847320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L48RUw9YMqyOqmKmJhsjcW6o+lsA4cxkY+mrl6+2nfQ=;
        b=QmWGFl/3kwc7JUBfCzIbgd9aUM0fnSauLAa0Ltnag1NucE8Mwvz5MufTKBWqhoFN66
         7/zfQr1VEvir4bL2sgpmVLEY4TEjRu5EtBZKmR5Gif4w7IwKnSVtnMZnOtVGYKE1hfC5
         eJe4hd3bsXsEPRVW+LZZ+eG7w8RgbEWghly/frZCubcnHyWDsMSP7jlBxtd/FWd+Usal
         LZtyOGzHpynioU6v1Fg4XqCjaLMhSzFj20zDoQHdP/cUhqZJ3w1EDEReNwMemyYTXzPO
         +og0XZSd/wGoHyAP24Inxwg7BQv6sFjQnxtV+1JmPzRBNxM7rdJm+lI5HFo1gKE44aJY
         n7vg==
X-Gm-Message-State: AC+VfDxZ8pazpGe7pp1BGJSN0+Fx0XKfKQjooTl5kzOylnoHh/U8YQWL
        AOJjuhPj2moECLSFIf5ltx/zKEb0W5hqf6HMCY86Z3Mt5HJf3IfD6E6I10FzOl71VBxC9Pl9nmG
        Lm+Co+qYT8f0JJWDikMb5dySSoFLYKjLX2SIWiE3UbogALigiXzloc992YsdZ0UVEdObfHgPh9L
        +nY9FFdKkJ
X-Received: by 2002:a05:6870:4315:b0:19f:5c37:ab9d with SMTP id w21-20020a056870431500b0019f5c37ab9dmr6615044oah.43.1686255319816;
        Thu, 08 Jun 2023 13:15:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kmzEz2a3R2fs33iV8rCMEYImysyVNpw81buOmDc0MgwnMxyKIw9y3vKvsr4l68kGBj9qIJA==
X-Received: by 2002:a05:6870:4315:b0:19f:5c37:ab9d with SMTP id w21-20020a056870431500b0019f5c37ab9dmr6615020oah.43.1686255319392;
        Thu, 08 Jun 2023 13:15:19 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id r11-20020a4aa8cb000000b0055afc1ef866sm179976oom.15.2023.06.08.13.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:15:19 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        richardcochran@gmail.com, bmasney@redhat.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] arm64: dts: qcom: sa8540p-ride: Specify ethernet phy OUI
Date:   Thu,  8 Jun 2023 15:15:13 -0500
Message-Id: <20230608201513.882950-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With wider usage on more boards, there have been reports of the
following:

    [  315.016174] qcom-ethqos 20000.ethernet eth0: no phy at addr -1
    [  315.016179] qcom-ethqos 20000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)

which has been fairly random and isolated to specific boards.
Early reports were written off as a hardware issue, but it has been
prevalent enough on boards that theory seems unlikely.

In bring up of a newer piece of hardware, similar was seen, but this
time _consistently_. Moving the reset to the mdio bus level (which isn't
exactly a lie, it is the only device on the bus so one could model it as
such) fixed things on that platform. Analysis on sa8540p-ride shows that
the phy's reset is not being handled during the OUI scan if the reset
lives in the phy node:

    # gpio 752 is the reset, and is active low, first mdio reads are the OUI
    modprobe-420     [006] .....   154.738544: mdio_access: stmmac-0 read  phy:0x08 reg:0x02 val:0x0141
    modprobe-420     [007] .....   154.738665: mdio_access: stmmac-0 read  phy:0x08 reg:0x03 val:0x0dd4
    modprobe-420     [004] .....   154.741357: gpio_value: 752 set 1
    modprobe-420     [004] .....   154.741358: gpio_direction: 752 out (0)
    modprobe-420     [004] .....   154.741360: gpio_value: 752 set 0
    modprobe-420     [006] .....   154.762751: gpio_value: 752 set 1
    modprobe-420     [007] .....   154.846857: gpio_value: 752 set 1
    modprobe-420     [004] .....   154.937824: mdio_access: stmmac-0 write phy:0x08 reg:0x0d val:0x0003
    modprobe-420     [004] .....   154.937932: mdio_access: stmmac-0 write phy:0x08 reg:0x0e val:0x0014

Moving it to the bus level, or specifying the OUI in the phy's
compatible ensures the reset is handled before any mdio access
Here is tracing with the OUI approach (which skips scanning the OUI):

    modprobe-549     [007] .....    63.860295: gpio_value: 752 set 1
    modprobe-549     [007] .....    63.860297: gpio_direction: 752 out (0)
    modprobe-549     [007] .....    63.860299: gpio_value: 752 set 0
    modprobe-549     [004] .....    63.882599: gpio_value: 752 set 1
    modprobe-549     [005] .....    63.962132: gpio_value: 752 set 1
    modprobe-549     [006] .....    64.049379: mdio_access: stmmac-0 write phy:0x08 reg:0x0d val:0x0003
    modprobe-549     [006] .....    64.049490: mdio_access: stmmac-0 write phy:0x08 reg:0x0e val:0x0014

The OUI approach is taken given the description matches the situation
perfectly (taken from ethernet-phy.yaml):

    - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
      description:
        If the PHY reports an incorrect ID (or none at all) then the
        compatible list may contain an entry with the correct PHY ID
        in the above form.
        The first group of digits is the 16 bit Phy Identifier 1
        register, this is the chip vendor OUI bits 3:18. The
        second group of digits is the Phy Identifier 2 register,
        this is the chip vendor OUI bits 19:24, followed by 10
        bits of a vendor specific ID.

With this in place the sa8540p-ride's phy is probing consistently, so
it seems the floating reset during mdio access was the issue. In either
case, it shouldn't be floating so this improves the situation. The below
link discusses some of the relationship of mdio, its phys, and points to
this OUI compatible as a way to opt out of the OUI scan pre-reset
handling which influenced this decision.

Link: https://lore.kernel.org/all/dca54c57-a3bd-1147-63b2-4631194963f0@gmail.com/
Fixes: 57827e87be54 ("arm64: dts: qcom: sa8540p-ride: Add ethernet nodes")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 21e9eaf914dd..5a26974dcf8f 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -171,6 +171,7 @@ mdio {
 
 		/* Marvell 88EA1512 */
 		rgmii_phy: phy@8 {
+			compatible = "ethernet-phy-id0141.0dd4";
 			reg = <0x8>;
 
 			interrupts-extended = <&tlmm 127 IRQ_TYPE_EDGE_FALLING>;
-- 
2.40.1

