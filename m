Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14E66DE36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjAQM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbjAQM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:56:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D11D929
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:56:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l8so5030717wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqhws25vCfr+KtN44sNbAes05bM1bGpfEYSXw7WryfE=;
        b=KATTs6l9/8eFALrmE/PARmJXB+OJhINK1bpVy5E0K94Kqngab/bmHcfgbkw/gpPGTw
         3gz2xCCkVhsaQi962ml2qo5pkgSoYrxausxWk5QRUSoZsyC4PhrApdGgZDR8x6C7lbd6
         abxD2/W1DsjM+DU3FwShLfS3je/WvRhrCIA1TqlqqLHzAYoSBjmlHSaXXYLHPKESYYvh
         aGdUMDV/tAZ4NKYh6u39Grq6aYK1fUl00jqfWXwe2Kq4f8gOxWjEfZZd22DsdCWkDFMJ
         Ie42H1XSnXlvFS6XLmkQXNhYLT8WHzGIfBE8Ujdy1PKxDDZeUZaaAvsHfXmWUEfT7+HB
         IBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kqhws25vCfr+KtN44sNbAes05bM1bGpfEYSXw7WryfE=;
        b=cH1FRxxY0lXDfmMfP9Jte+zRm3qj4taqnxb4z3kMjMDxemP6aghGys+/9Ijieympnw
         yqkjscfpMWNOwU45BqgN4nejtXtatZluifuAb5eeUnL0QHeBZ4nc7NbcyHF0bT5zATv9
         oS0aGfNeDzQatYU8UGI1ntAwnvSioUTjl+2ekjmLlUBIdy412rTygMy27m5ivOgh+mfK
         2VqQaDJqyJsBFHdKPiPI+4Uy0r80+cf/zzM9XQI1uD7p1oFyiWYGZHy1ofo66MesFeWg
         rOK27VBJipiJiiXNVkzS29ZeUX47lFPVpDsXQroM29F2wwoXTObmWkcEFkQdxrh6RYRM
         hszg==
X-Gm-Message-State: AFqh2krxAODIkxCD/0hQFEA/Vuj/5pYK3ROePLMqZblMGBybGRhtv015
        dbbT41zMgUtCWGKriZaTPLAS2Q==
X-Google-Smtp-Source: AMrXdXvqtGtRoLFDkn2W9oAJUq+uFk2SZmQkZJFMhbCCc178PKwlPxcU5GY21cpxJ19dpuBfLPSbrw==
X-Received: by 2002:a05:600c:1695:b0:3da:1c49:d632 with SMTP id k21-20020a05600c169500b003da1c49d632mr2998500wmn.1.1673960161411;
        Tue, 17 Jan 2023 04:56:01 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm45069778wmo.39.2023.01.17.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 04:56:00 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 0/6] phy: qualcomm: Add UFS support for SM8550
Date:   Tue, 17 Jan 2023 14:55:49 +0200
Message-Id: <20230117125555.163087-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v2 of this patchset is:
https://lore.kernel.org/all/20230112130542.1399921-1-abel.vesa@linaro.org/

Changes since v2:
 * rebased on linux-phy/next
 * dropped sm8550_ufs_phy_clk_l, used sdm845_ufs_phy_clk_l instead
 * zero padded pcs value in qmp_ufs_offsets_v6 to 4 digits
 * replaced LF copyright with Linaro's in all header files
 * moved the UFS specific includes in the UFS specific driver file
 * added Krzysztof's A-b tag to the bindings patch

Abel Vesa (6):
  dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
  phy: qcom-qmp: qserdes-com: Add v6 register offsets
  phy: qcom-qmp: qserdes-txrx: Add v6 register offsets
  phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register offsets
  phy: qcom-qmp: pcs-ufs: Add v6 register offsets
  phy: qcom-qmp-ufs: Add SM8550 support

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  1 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    | 31 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    | 82 +++++++++++++++
 .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        | 30 ++++++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h   | 77 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 99 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  3 +
 7 files changed, 323 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h

-- 
2.34.1

