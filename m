Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4715E64B572
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiLMMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiLMMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:49:12 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F61C13E9B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:49:10 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197]) by mx-outbound10-83.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Dec 2022 12:49:08 +0000
Received: by mail-pg1-f197.google.com with SMTP id g1-20020a636b01000000b00479222d9875so7075528pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLc9KUPPcfPmJRkVZ9SzdiZuUqpVIHZA1Sml1/BlenA=;
        b=XpKOWhRGTDSr5jAXwnG90EKsthoHokOx6CPQ4vtl35ZodA2iOXdTANmWpNYwm7miDe
         RuM9IQe3LuJxytqt2HaeI8F9sdsaagwSEXZVCcqN7e5a7p/JL1eja1LVUmmKt21eb+7a
         Et8YJHqJuSJ665HKlEQP9WXpglpQt8VPbMgsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLc9KUPPcfPmJRkVZ9SzdiZuUqpVIHZA1Sml1/BlenA=;
        b=b1D20X49/ITgJMaCyw3QspYx2wYb3oY2SNxolkIWn05HdJffgWWTfTzCgVDjs64v3S
         RqY55MmBbuZW5NUzoK1Rfll/woQVhl8SAF6DNcOZ+nKD572Meph/fqP8aIPeSWnITCoJ
         gL/9laz4l64rE4D05pHfKhj1nOs2Dv0iLIyzakOPWIctlzaR+IyUmsuLWsK4qPMW1Ql5
         nyYQJIZOs7mtzGe5Ad557omPWPp1aKHzoRXGLSwb3GzPQYtFop+1eklIja5EsDErUqF2
         YaAz2jXu1b//YaXEGUuR/RuRH49fNEmsi83/zr6pCaIau4XofO5KM6+/YpCa4Xvp0a4i
         b5RA==
X-Gm-Message-State: ANoB5pkOl1eVuO9WKYaVUlZEgNEJ2DX5u6lfWr0g6AqHzPz8BOYypvXz
        HbeF6lAyIbyIc0uvvN8Lz6zFzeM3lUhD/AMWeuXSQuZ47zHvRzDw+ZcVqDfVKt2lOZlBeFRhTgQ
        SZjI8c5W0I/O9MQnwWd3XKRH2ZylZBidTItc4G1LD85mIbOjeTf0TycuSGZr0
X-Received: by 2002:aa7:858a:0:b0:575:de28:b1f4 with SMTP id w10-20020aa7858a000000b00575de28b1f4mr17867561pfn.16.1670935747443;
        Tue, 13 Dec 2022 04:49:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51MQfHwJ6t4Lvah3KwdrYDJWVHA2Kmc4GYcnXbMwC/zZ+eRo+9tBgoS8nc/AgolPiROKnrIA==
X-Received: by 2002:aa7:858a:0:b0:575:de28:b1f4 with SMTP id w10-20020aa7858a000000b00575de28b1f4mr17867540pfn.16.1670935747043;
        Tue, 13 Dec 2022 04:49:07 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7942f000000b0057622e8e82csm7605485pfo.191.2022.12.13.04.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:49:06 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 0/2] phy: ti: j721e-wiz: Add support to manage type-C swap on Lane2 and lane3
Date:   Tue, 13 Dec 2022 18:18:52 +0530
Message-Id: <20221213124854.3779-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1670935747-302643-5374-5503-1
X-BESS-VER: 2019.1_20221212.2317
X-BESS-Apparent-Source-IP: 209.85.215.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244774 [from 
        cloudscan16-224.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
This series of patch add support to enable lane2 and lane3 swap by
configuring the LN23 bit. Also, it's possible that the Type-C plug orientation
on the DIR line will be implemented through hardware design. In that
situation, there won't be an external GPIO line available, but the
driver still needs to address this since the DT won't use the
typec-gpio-dir property. Update code to handle if typec-gpio-dir property
is not specified in DT.

Sinthu Raja (2):
  phy: ti: j721e-wiz: Manage TypeC lane swap if typec-gpio-dir not
    specified
  phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap

 drivers/phy/ti/phy-j721e-wiz.c | 90 ++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 25 deletions(-)

-- 
2.36.1

