Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805F6D9B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjDFO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbjDFO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:58:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926B4C37
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:58:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso3036973wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680793133; x=1683385133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUz8JFX9S/A4V6+0uhPV3N5OL753V9MWdLlczHDK+Qw=;
        b=EmKEsePSa12I22VXLdcQPwIk7w+aW6135rugfnphhQwQvQgTxpPmyhDBErSGUvb6yM
         j9oDCHqtVI3oINcUxiiIlFy/VrYF8vSnCwuR2K5F9eWCloQUu2NnuCCQKCPrplUSDqc0
         3pYWZ39VtQbjSJPoPu+6UV3mUuz4Vdf1WR/ACuF00yWL1eHJxdNukznZmr91SciPfmqA
         okM0FPKQyUvboPD0s1Wt72RI8Zw0qcHFcdGnCTgkBuyIV31XQLN97sIT3qo1hcnMYaGG
         FUD43Du7AEzDI/nnwSW5E1tvqnHC9AxFst/h24+IlJKNo277RYgD9vWVcc0rS3mMm+yd
         YLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793133; x=1683385133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUz8JFX9S/A4V6+0uhPV3N5OL753V9MWdLlczHDK+Qw=;
        b=cnb+zRo0d2DI+egqpfpXWmyXusoYV20/EzTlMTvyEPrEKLEYWgokj46oBh0XlW+VfJ
         H+4r2JLiF7I0Rz6lqi3G7sfTgK50sbkgkLtxcKtj22a/ShLcXSpD0hfbOOINVD2fQKzK
         /79WMiKavIz2A5rkDqEa5PGQwWFFWVwZMp6ycxpvWIdAppSYyzp2O+pG1+mS2qLCVyiH
         KNwjayXIJRIzBQeQSbeLjxk+CeHGOd9JSpFvjgBSU8Ykbs2LkXADAWaN5MqivLsKkfE4
         o9XBJghTLlCIIYJ0KfLWZt4TiVdr6euwbksygARcWp9ShPa6phX+WyX24ovJUdhR7sSn
         cOXw==
X-Gm-Message-State: AAQBX9d+xbry4Yb+hizPrdQErE+WFJsOfZiNNCJXB5CMJ/MHnTxmRVXj
        fUUuBVSsq8B12sqckct1XGrYpw==
X-Google-Smtp-Source: AKy350boASzJJb3JPCYtYb2ebNRQ2MIT1itORqZ3f27s88CsaAxEEQ2rP5/3FJishPx54VwS8vehOA==
X-Received: by 2002:a05:600c:b54:b0:3ed:6c71:9dc8 with SMTP id k20-20020a05600c0b5400b003ed6c719dc8mr8532591wmr.22.1680793132814;
        Thu, 06 Apr 2023 07:58:52 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f0373d077csm1768160wmb.47.2023.04.06.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:58:52 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/3] drivers/thermal/qcom/tsens: Add ability to read and shift-in non-contiguous calibration data
Date:   Thu,  6 Apr 2023 15:58:47 +0100
Message-Id: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MSM8939 the last sensor has calibration data that cannot be extracted in
one big read.

Rather than have a lot of MSM8939 specific code this series makes a generic
modification to allow any other calibration data that is non-contiguous to
be extracted and recovered.

For example s9-p2 takes bits 1-5 from @4b and bit 13 from @4d. The bit from
bit13 then becomes the sixth bit in the calibration data.

tsens_s9_p2: s9-p2@4b {
    reg = <0x4b 0x1>;
    bits = <1 5>;
};

tsens_s9_p2_msb: s9-p2-msb@4d {
    reg = <0x4d 0x1>;
    bits = <13 1>;
};

A register desciptor is introduced in the driver which takes the place of
the previous unsigned int hw_ids array in struct tsens_plat_data.

This new structure contains the previous hardware id and two variables
p1_shift and p2_shift.

If p1_shift or p2_shift is non-zero then this tells
tsens_read_calibration() to search for sX-pY-msb where msb means "most
significant bits".

The value at p1_shift/p2_shift is then used to right shift the value read
from sX-pY-msb and or that value into the base value from sX-pY.

The nvmem 'bits' field provides the mask.

Bryan O'Donoghue (3):
  thermal/drivers/tsens: Add error/debug prints to calibration read
  thermal/drivers/tsens: Describe sensor registers via a structure
  thermal/drivers/tsens: Extract and shift-in optional MSB

 drivers/thermal/qcom/tsens-v0_1.c | 56 +++++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens.c      | 50 ++++++++++++++++++++++++---
 drivers/thermal/qcom/tsens.h      | 16 ++++++++-
 3 files changed, 115 insertions(+), 7 deletions(-)

-- 
2.39.2

