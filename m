Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAA6893E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBCJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjBCJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:34:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F361D5A;
        Fri,  3 Feb 2023 01:34:13 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r27so261072wrr.1;
        Fri, 03 Feb 2023 01:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rK0jiumf10CNfjIHGx8FDIqbyhB3AWsgtWtXiKzKMg=;
        b=okoKz4eSrfO1XK3dfuH+cU9O6eWvt7CetR2sR4RFM14epnjCeA8rubZcW6XjzH/LKS
         7FagHPt0pC0QY1rc68eTr96qvLQBvj5xQmQCrGlegAOTVytsypCarQMv/XyPW069qODr
         3kyxzFnqTydVXAB6H3tXlVw8MRdn3Vl3L9ztAPsc/w2VWCmkT7QzOBW34gqAJ5kKstFF
         S8T0n4fqDsWjYEaB8h2mnal0b/FW4esNEXoBtuxYlRFTIPEEnBXW2SQwf2N2cQiBiRZF
         MQ7xBkY0/P+QhcCYnpuiP2Evtu/JKfLJCINmeoj2x5+vwMW9odK5kF7Bv+OQacAtydU6
         s3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rK0jiumf10CNfjIHGx8FDIqbyhB3AWsgtWtXiKzKMg=;
        b=vJe952Hf9ZKGUxTdg9HUyvxWVXF7n8vUfWyNi+eIPPOpZGw/1F2qqWmMBEY0xwyhg7
         fJbHjJp0UJLolvJr7vpzIuOoD0qGAgMfx1QlcBZm6R+Y7tlQmwJWna3UnnOsDbhti2Cm
         c7Z3gUm3Y/n7IX1nJnDnNFztg1bpQsjnbO/V3Glk291aKHMdKtaGaLiXsc3zItF6y3ph
         15bD5A9N7PIcL/qkmI7cqHEQW2Hz+12zaxQyIDkG24hVFo4qJKDW6sV/yhIfvbQ2z8jq
         IPGvdiC1R/Rdd1BNFnoQ6uD3349JzK6bwCW54oMA+AbDA1QhLX30+ppEVagyXaod/6pZ
         qy0Q==
X-Gm-Message-State: AO0yUKXT2bsgfe+r3EzKhGNeFk/jV+ES3fIT1PYI/aSPqIwmhzADHWq+
        VyBFlh153lbOLdNUXREzo+s=
X-Google-Smtp-Source: AK7set/m+PFuHSp1OJqG1dT50DmKvAznGfuTgUiormzAUBX1URHwsyaSrBoOrNrMJUn24B2Ks0AkHQ==
X-Received: by 2002:adf:e3c5:0:b0:2c3:da85:ad81 with SMTP id k5-20020adfe3c5000000b002c3da85ad81mr321035wrm.20.1675416851914;
        Fri, 03 Feb 2023 01:34:11 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020adff107000000b002c285b4d2b5sm1533259wro.101.2023.02.03.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:34:11 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: [PATCH v2 1/2] dt-bindings: media: rc: add rc-dreambox binding
Date:   Fri,  3 Feb 2023 09:34:04 +0000
Message-Id: <20230203093405.1616564-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203093405.1616564-1-christianshewitt@gmail.com>
References: <20230203093405.1616564-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the rc-dreambox remote keymap

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/media/rc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index e732b7f3a635..e7d2ae5a7eb9 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -55,6 +55,7 @@ properties:
       - rc-dm1105-nec
       - rc-dntv-live-dvb-t
       - rc-dntv-live-dvbt-pro
+      - rc-dreambox
       - rc-dtt200u
       - rc-dvbsky
       - rc-dvico-mce
-- 
2.34.1

