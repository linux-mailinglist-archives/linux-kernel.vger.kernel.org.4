Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECB659C21
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiL3UgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiL3Uft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:35:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B751145
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c17so31678667edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGuxAnhfIj2x3uYPeVPB/2g8dAYaMTxAZOm/4EaT1sM=;
        b=jrBQbD2ncyKY9+6Qw1UneYFTXPe9bnAJoL7gYDxrLNXLCtzTpb/kUUTbGCWUiQ9rHG
         PMvLEn5wyw2OTj6qPDygZg5/1DyGqs2vlVRqhZb/rZlebfrmGXy86cvVQu6uf0lSfKEv
         wbTan9Jt/DCzLGUgO0SVDnZsYyWtVtIsbGBARltYeTiaNnGdrxP0dNDdbgrPwhTJ4TvR
         t1q2IbHbpfI930wG3qmWgOiSlRtOjAcHGD3nmkxfX5Jq1bZplVL2LgIm4nj4MZSiYCMk
         oaoOQcAAs/gMfMW+jV9j7bUfBjN090Qb4BuynzYFTm29PdDj4dz0OAre253OtuvcPTmw
         FVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGuxAnhfIj2x3uYPeVPB/2g8dAYaMTxAZOm/4EaT1sM=;
        b=Le1YiicDSfej7VCvdzzDbkAnugwSlgev1m8vAosRr04EeaPm8olM0p91aISGoTcRM6
         94pQDp1QOLXhNddfsy5og5+Mtcsq/3MmC7PLNkZJkQHVHzCYh5MaFIMAoDFsv1so37hh
         +ltlCta4aPjGvWVQDYrDh2SdtbbWF1LNDmRv/+fPCSPTAbWZu7mmXvV62Os9bwKyDy7n
         nm1lNckBgr8gul2SgIl+4+2Ay/dK8s+L7jou6aw54tXmvaTF38Dqs39ZiYYBwzS9vVsZ
         Yw7cWpjXWVIEWLHKMi+m+/OaLxkQXQvtgP2fF167xyZv5FTI4tjdBO1/USKpQOxwZta/
         wf5A==
X-Gm-Message-State: AFqh2kq8I/KvqkRORb5urMsuKiFXhGm9vsyZ1jO+a1g+rOJS+D699yBB
        YlzgKtyku/XZfD6D+SisMreAQA==
X-Google-Smtp-Source: AMrXdXsCeCzqGEMDTH1R2aSWlkw2d+d2e8sOKhd3spzxOsnv3W/2UjG2cPl/NFmEv6DYDEsyL7ujGA==
X-Received: by 2002:aa7:d585:0:b0:48a:aaa0:5176 with SMTP id r5-20020aa7d585000000b0048aaaa05176mr4613190edq.29.1672432546162;
        Fri, 30 Dec 2022 12:35:46 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c22-cd9d-4b00-ef17-3c78-1696-7315.c22.pool.telefonica.de. [2a01:c22:cd9d:4b00:ef17:3c78:1696:7315])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402158a00b00482c1f1a039sm8350500edv.30.2022.12.30.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:35:45 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, linus.walleij@linaro.org,
        lee@kernel.org, maz@kernel.org, tglx@linutronix.de,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v6 3/7] dt-bindings: mfd: syscon: Add mt8365-syscfg
Date:   Fri, 30 Dec 2022 21:35:37 +0100
Message-Id: <20221230203541.146807-4-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230203541.146807-1-bero@baylibre.com>
References: <20221230203541.146807-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Mediatek mt8365-syscfg

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd0104316..7beeb0abc4db0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -50,6 +50,7 @@ properties:
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8365-syscfg
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-- 
2.39.0

