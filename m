Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BE637DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKXQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:45:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CEDE637D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:45:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f18so5299438ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=+E5du9WqGFlouc+LeqDkcx4iwdplSSdCD7snpKAbN2o=;
        b=LWcXSbmqeeGEVmYDes8L2yQAvxPx1cCS0hzTOiUADEVmGjSLDkcGvHjuIx9EkLM3VH
         Ek3t7tsuU5p020wUiT7Uu7O1VHpdR5LF35D6A6DQuI3s2Gw1ToFfGBWCs605DDOw5HtS
         xkl3QQ7pmeSoStxpIbsOJbUoK1FIaIKCdONR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E5du9WqGFlouc+LeqDkcx4iwdplSSdCD7snpKAbN2o=;
        b=itqP0JcYRs7u+mbh/dBpA2a0HNB+dAPmjpCqREVU8QNmALJ16qVB7GsgUlHq1YaONj
         cr7JAMbV/9aZ8hnFR9d5dL/WMmwLBc81NrNya68pKq5o4HezBEnGmynO4GXUMx+WHVVn
         UZi8CE7HIl3r+AvSDqjxzJibXbFz5pGZiVZiqsz03p6iJhYJf6HkJ6ntk1SaVn2vpNF2
         BeaSvz218fIRm7KRmMmG+pY52PD2Uda43Bg+sCsfV5GU/+SOjlVORBdqSyTx9kB6j5Dr
         dn6ciSvH1FAzjAoZbqNtYGE0A7S7pkkH5qrXeOGcWebXu/I5Ghnzn1MlkA5M2vXmHnYH
         RhHQ==
X-Gm-Message-State: ANoB5pmOTzJwoB03l9pWRloEUc1kFaSZM2mFCA2Rt0M8MCm0bAoW3Ap7
        kzC+RIWZev9Pcw4U0mn6Bqx5GtMuSe4cc5Kt
X-Google-Smtp-Source: AA0mqf76af1D1rQ79EuNbZaKPNs6NTzahg59vzP2wdZXOK7mNh6RbNKGS5S1X042i5BslOpjPQRGVw==
X-Received: by 2002:a17:907:8b93:b0:7b4:f258:6196 with SMTP id tb19-20020a1709078b9300b007b4f2586196mr15210154ejc.524.1669308350720;
        Thu, 24 Nov 2022 08:45:50 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:f5a0:768e:7eda:2441])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b0073ae9ba9ba8sm608555ejb.3.2022.11.24.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 08:45:50 -0800 (PST)
Subject: [PATCH v1 0/1] regulator: da9211: Fix crash when irqs are pre-enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKqff2MC/w3KQQqAIBBA0avIrBNUJshu4+iUghgotRHv3uz+gz9hcC884FQTOn9llKcJ7KYg5t
 Bu1iWJwRnnrHWoU/ASGunwBgkvph1kpjBYUw8tZtnbW+taP4mWc6JdAAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 17:45:30 +0100
Message-Id: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=qruzP/iiOqRIA8c0nhR0ef9/1fxllgdp5bBdQwylc7o=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf5+0d60R1bcUp5gcSFxhe6aTw4rhAI/cvT5tyehb
 G+04S66JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3+ftAAKCRDRN9E+zzrEiFUtD/
 9OU8mfHf8NiYGqEcohQ8XpbbsIAK73mc/80FAbDb9c4M9ZNUxCs7U148z2N995d4cIbgkghCzeetxq
 9Y5kMvlAnb1r2NErXoOUslydRy3Dx4g3wOs80hI1sv6cYb6tiEXk+ybReJ5GTA0x2CkzVlZHh8+PFy
 zANJFKsOtbaEDoRtUFIRIrNDwgL2EFIhBj30Vdg3MRRhAoZMh9NocKmvja8mITh80PW6KqKAqxX1Fe
 NQiWxTlzKmK7n7sFA1a1/fCblkPgBsiBLj9NXJ+lIkh0RK28uh0cl5zknTtDh1CqlHx9/TOQytTyiX
 m51zlTaZN3iozcIC+YUERn0XUb1oGvYc1oiVsyvAw1DWkRuyuwvRqxjmJsSgCA9LNdH7sxiDSTqCpQ
 3+nb+bQjazDAA/hAeEAY5UFsURol71NL5hWfRvDftNxp9cvCl14NWY8EoYPfZJApdh1f7tJW/8VBZV
 yFPm/RV7qel+aoqOwpDyrF4vvWcEoAcMrgDqxpYiDb1lbUDgWMeuIRJcW1tsJZuC+VRXVirmXb0Hl3
 wXxn2rRO+iU+M0S+a/SqLHTl/eniGoMfbO1lXH/56rJ/73PVMWJ9mecBBARKZDe0u6cHL+z3x1X1eK
 2MWYd9EBRmthgRn8E78wTBdfaUF7Lg5DXiuNJdFvvHsQgpDkLMVy+o1yY6Pg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system does not come from reset (like when it is kexec()), the
regulator might have an IRQ waiting for us.

If we enable the IRQ handler before its structures are ready, we crash.

To: Support Opensource <support.opensource@diasemi.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      regulator: da9211: Use irq handler when ready

 drivers/regulator/da9211-regulator.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221124-da9211-4b8904b4feb5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
