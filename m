Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A86E9DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjDTVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjDTVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:17:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F984C1A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:17:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso861776e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682025463; x=1684617463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0Pj+AVFybiuMWHWYcZm+EIAYi+KrTLHdnCxLp8NU1c=;
        b=lwDHnyU+dTm6lkohZg4kDlrRTFntofvIVqppVB0b8ucL+8Bkd0y+5fTwzeeCMWAog4
         5m1Ce4x1U2iMx+TYJe1f2Qrs7zgncuB9KhPxTd2tkHBLVWtuCiel/yKNpdGKgsPB2K8c
         5lFlffzW3BQcWuNYGXU/RnyvnwE631oc5wmeL422sc1wIjaKY5wRNYktRg5ugcTO1WO0
         waFvCCq3/yGJopu2KoZmGwfSbjKm9h0QX67Txe6IF0RnWGVGlJFWGwm43MRA+/RAtPRZ
         VsHgGoO27dxBBfPAsUY57oRAycpi1ww6Doj5RIsz0NpdihTGwtRC02mUWPamZsNXUqOm
         m6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682025463; x=1684617463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0Pj+AVFybiuMWHWYcZm+EIAYi+KrTLHdnCxLp8NU1c=;
        b=Ul/hbDqDLpGcGIqse9hP0rTxjHt4iTp5Cn/Q63FwNpt4CFNgaau5e2SialU6LESUB/
         z+bo8YQ81WQbrY1PpKo1ByMVcd/0ROlTJegxg3nVCyD4gQUVAJR85FBCWYXxonJ6CDMN
         9PYAT42TuUvYqbVCaiVKiSB62tpCe8CHkLdBANZBfSQsbORr4OQlhQoFtB/TH9TA6P/v
         m+XY2at7HO8jtQmBs+yEhxPTRlUDq02wwLFiq2+XwILoPo7GX0jdT4C0IXhtXNf/uT/U
         k4ejX68YVeCd9bELOy65HR4pmOD4GwgWVAc5b8X7Fji/m6LT7xfx+w5XxEu6mvgdNFi3
         v5Mg==
X-Gm-Message-State: AAQBX9ehocexvjpnKYhWdC0lJQ9B5ckc/xUiMFc/yn2gOxvEk5QcuOWM
        11O+gEd1hzW2zT6ajnEIj3vxrg==
X-Google-Smtp-Source: AKy350YKP7KAS+NiQMgCENIJ3hf+Ib7qZphujaW1ycfkKv2FOIu6urQ2cjlpVvGzEXZBBq+pqh1u0A==
X-Received: by 2002:ac2:46cb:0:b0:4eb:4002:a5ca with SMTP id p11-20020ac246cb000000b004eb4002a5camr671480lfo.66.1682025463586;
        Thu, 20 Apr 2023 14:17:43 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ee0c000000b004edd3f011cfsm332985lfb.43.2023.04.20.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:17:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] SRAM dt binding and fix
Date:   Thu, 20 Apr 2023 23:17:33 +0200
Message-Id: <20230417-ux500-sram-v2-0-6e62ad551faa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2rQWQC/22Nyw7CIBBFf8XM2jFAn7jyP0wX0GI7iYIZtKlp+
 u9C3bo895GzQnRMLsL5sAK7mSIFn0AdD9BPxo8OaUgMSqhClLLB91IJgZHNA3UtG103qh5sCel
 gTXRo2fh+ypff0uVpbp/sbrTsqmuXeKL4CvzZzbPM6V/JLFFgpVWp29batqgud/KGwynwCN22b
 V/uUng8wwAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DT binding for the U8500 SRAMs.

This patch series also fixes an issue with pool labels that I
saw on U8500.

I suppose SRAM patches will go in through the SoC tree, I kind
of feel that SRAM is a SoC concept and the driver should
actually be in drivers/soc...

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Change to just use dev_name() for naming the SRAM partition
  when no label is passed.
- Link to v1: https://lore.kernel.org/r/20230417-ux500-sram-v1-0-5924988bb835@linaro.org

---
Linus Walleij (2):
      dt-bindings: sram: Add compatible for ST-Ericsson U8500 eSRAM
      misc: sram: Generate unique names for subpools

 Documentation/devicetree/bindings/sram/sram.yaml | 1 +
 drivers/misc/sram.c                              | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230417-ux500-sram-961796726db4

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

