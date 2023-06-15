Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC907321EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFOVxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFOVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:53:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C302962;
        Thu, 15 Jun 2023 14:53:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77b210292c5so917139f.1;
        Thu, 15 Jun 2023 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686866002; x=1689458002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByHw0rvddOiCXzdPhf00oxkKHXxWYbbkLr+bifjUB/o=;
        b=IqXeFclDutGbNc57s/15uuoqsJVR+xKOR1dCbsGvwPjuJbXUvtB2KRNeC1Xb/rN8hA
         5ACZwf0sCxdkje5UOKdWZnNOqX1s04yHH4+gG/WUFEZREfsulLj9wAmnjPqyfDp+fdpx
         clA0/ih3CO0WVyvs4LUotIJFV/YBkUQlGW2L/0cI9+hLe1OyZLsAyhaP8cSquF/8ZCSW
         b1AfdrkNR/QUXbqxuCjoVHQmG5IY8d4eg7cD3Y+OfmkkFsQWfC2U3tUIbGGQfHW0Q9dP
         +xwKAkCD1A5YRPqezJl+pWKied292a3qAblhp12dS6hySwJIA9uhM1gibi0A3/0LgGCV
         BYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866002; x=1689458002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByHw0rvddOiCXzdPhf00oxkKHXxWYbbkLr+bifjUB/o=;
        b=PM9L+0X+62x8x6iFBE/ZAOBldcWrEwtoojH6TZEC9K4F8P/vyBDx5pQPgJbwvqydG0
         Tb0+maPIOeaVu7fvRlX5YnH/xXv/XxxDsMPuf/mBMK8urSEqF8s6IYEBjWPSrCH+9hwK
         W2pdEMj6Gm3BefR/GHIHJ0uy8XKqp+8D1lczgnaDt3hw94io4VG8owmSoc39hNeEBRKv
         IipBYHe/kKarKgi+DMe778zvxXAXo/ozYZRjkztnocPE9hWwEsF77uCBYfEH9PzWWjZf
         QwAKbsTm/uSRp8uifAZxOGBv4YzKaMpW6VlxG35QgdS2K2MdAcU5HFeE/zBV+NABxLzW
         N7SQ==
X-Gm-Message-State: AC+VfDz/UOpbKW1rSHsSXSLXBuHxISF+HzqsN5Nqx9VeIdvx5lFCTYFD
        GmRPuMZ92M2DVMYvSGGCL08=
X-Google-Smtp-Source: ACHHUZ7ent1jZZ0S/fVhA/hHe6IWCU7pBEiTDhytMWQYaX7oheyCqqFkycAqsFCqJ+mD8C/EFcL/kg==
X-Received: by 2002:a5d:8b99:0:b0:776:bfbe:a72b with SMTP id p25-20020a5d8b99000000b00776bfbea72bmr704174iol.14.1686866002334;
        Thu, 15 Jun 2023 14:53:22 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:bba3:fc99:5334:6f55])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm6264272iol.38.2023.06.15.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:53:21 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] arm64: dts: imx8mn/imx8mm-beacon:  Add HDMI
Date:   Thu, 15 Jun 2023 16:53:10 -0500
Message-Id: <20230615215314.5402-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI updates are in the DRM tree and Linux next with some updates
that now allow the DSI to connect to an HDMI bridge and successfully
sync displays at various resolutions and refresh rates.


V3:  Alphabetize regulator names.
     Add register names for EDID and Packet
     Add I2C address change for the camera since it
     conflicted with the I2C address of the HDMI bridge.

V2:  Make 'compatible' the first thing in the new nodes.

Adam Ford (3):
  arm64: dts: imx8mn-beacon: Add HDMI video with sound
  arm64: dts: imx8mm-beacon: Change camera I2C address
  arm64: dts: imx8mm-beacon: Add HDMI video with sound

 .../freescale/imx8mm-beacon-baseboard.dtsi    |   4 +-
 .../boot/dts/freescale/imx8mm-beacon-kit.dts  | 131 +++++++++++++++++
 .../boot/dts/freescale/imx8mn-beacon-kit.dts  | 133 ++++++++++++++++++
 3 files changed, 266 insertions(+), 2 deletions(-)

-- 
2.39.2

