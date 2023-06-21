Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4327380D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFUJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjFUJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:31:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683510F8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46a06c553so63823711fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339869; x=1689931869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUVZalfP6V27NAYz5kQTxrxcxQh7F8OqnR+1IuXKgno=;
        b=1NSCmre2p7CtkNBkBJvdszJkRwwGaioXWZdO9EoPmJnoKNEGXXEu6EFvU6OgprI5xc
         tNLkv1dB9ERCHrEUpnTmLZDBzjMzhSVv4UdIs49WCyTKl8Kh/tuD9bFDYntp0pq77pkh
         rAo12jFi/yvwkjV6rGqstr6iqTzJgJ65dZl8q2XnC53Duoonqw3IhHvngOffXYqqEG3N
         Xm0SbOk8kbFQCK3y7GZwC8TlYnRblyaNUE2ptaLDzkOoXlopaD4qC8VTiVYh/iUbrdSJ
         Fp3M3vuvPtPIWQV/Hz+KWNLxB8jMJSZf0+6FxPzEv16pO8LfN7RRV2bpfV9JQl2eBTws
         2q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339869; x=1689931869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUVZalfP6V27NAYz5kQTxrxcxQh7F8OqnR+1IuXKgno=;
        b=DaTOMGSk6WaKMnfmflxs0OmR1c7H04jqJjJjpeY/VYam+lqLfHCPLa7+o+pzps0rei
         CheiUZc4PlqTOoPj0Iju+p4lcnogPy0FHJ6f7vPHjojMyyCMj98hWRdaLWr8dyxd1Xqv
         gtXFzQ1FqPa9aCgmRAqBp6o6YInNClb03CgKiXN1lufgYrRJ9Z8Dj+4PQfC2ClKktkzr
         ZWu6paJuHSArmdpfB3tMjBc0ZUPCsaqhidgmAwNzQM+IIqZ+vgaURI985BQ6MQcDUJye
         2FHgsoDiBVORW+Jj/OGIva7V9nIQAR0v5tTMiDnyTPSG/0YIzPeTNpCc/wleN8R89njY
         cSwA==
X-Gm-Message-State: AC+VfDxekIfQirWz3bIlbrFh8FdOnybe09OnJBtaByvxZAyBsziY+zBt
        rbSldhdej1pV8CwLNq3M9OsevA==
X-Google-Smtp-Source: ACHHUZ5niONPbfuy2pOl3UdRueK/q4eJCqkzPPKmPZ8iuLpRxdjpzGVdHt5BRKAlNXSVVVJQYSq+HQ==
X-Received: by 2002:a19:5053:0:b0:4f9:5519:78b8 with SMTP id z19-20020a195053000000b004f9551978b8mr2520136lfj.63.1687339869403;
        Wed, 21 Jun 2023 02:31:09 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:08 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
Date:   Wed, 21 Jun 2023 11:30:58 +0200
Message-Id: <20230621093103.3134655-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two new chips do not have state or wake pins.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index e3501bfa22e9..170e23f0610d 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
 This file provides device node information for the TCAN4x5x interface contains.
 
 Required properties:
-	- compatible: "ti,tcan4x5x"
+	- compatible:
+		"ti,tcan4552", "ti,tcan4x5x"
+		"ti,tcan4553", "ti,tcan4x5x" or
+		"ti,tcan4x5x"
 	- reg: 0
 	- #address-cells: 1
 	- #size-cells: 0
@@ -21,8 +24,10 @@ Optional properties:
 	- reset-gpios: Hardwired output GPIO. If not defined then software
 		       reset.
 	- device-state-gpios: Input GPIO that indicates if the device is in
-			      a sleep state or if the device is active.
-	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
+			      a sleep state or if the device is active. Not
+			      available with tcan4552/4553.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device. Not
+			     available with tcan4552/4553.
 
 Example:
 tcan4x5x: tcan4x5x@0 {
-- 
2.40.1

