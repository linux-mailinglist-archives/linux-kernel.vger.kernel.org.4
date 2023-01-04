Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B665DCEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjADTiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbjADTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:38:03 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B74321A2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:38:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e129so10004005iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op+CSODDgA7gYctUurMTZjWcainGafNK+wkXHM2pWJE=;
        b=xoO0owRnugC4wYhTySKnrSg4YL1odqmcABTU4VGByBNKTWnR1PYs76Pg7A+oh44Bvy
         cG4amKkT+TdOOCF5S9pMhFTytunXodyc8oAAmEW6HqCcP07BHZLX2QJANW4sc1ULRy+S
         KM7yuV4GWbom/8FCfxPwrqFwhLYKScseZixzscLVSKJ6KI0jR91ig4qfIye0UWwY1nrT
         oPhE1NrB7Z5QrViZ6gn+CYnIr5EzMSuB4hcZ2bZfBkohSSRy3cj+59bdsipoeYItWW0j
         n2TiAt/lVnd24pZMXqLApTAFrPwtbcaOOs/HBrAISxKJhadm9HzUbBxB0/RjjoLn0/em
         Tx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op+CSODDgA7gYctUurMTZjWcainGafNK+wkXHM2pWJE=;
        b=owHUR7K3Y+EcNajBbYsMLAgaSQ9+q9SDARNe/VWmpXzyPMtkdmAJX35kKnzqqPDuNi
         aGLQAPlbiDWsWzYZAqFvF+izKKdgwU9xLTkzXsxInxuFjal9Uh5FHfAtjBAUKM9Wwq4y
         +UEqyXdoxdYsRcBnEbZ9LSDd9ckQ3Vo4X8NLSH0cNVS4SRaN6R3/NlyY8AQjyPrqMz0S
         Lpy6LmTpZtFtwpoOWjon9x19a9Pz+v2T0Btt2DlTm+owMif+d1AjjqzRudbfnsNu9jF/
         JPqAI/gkoYiRktuf/cjcFHhgZaZCGqYSNOS49/PeVBCcClC3aB7cCvwKDsvhL7NHIMW4
         TMog==
X-Gm-Message-State: AFqh2kpmAy2c1sq9fkhCpFzblOsK4egA9TlEsKM11PxA8pwQmPemBzcG
        fUdC+9GiphqVUu6tmDZd/n35Fg==
X-Google-Smtp-Source: AMrXdXvXOYePefoLcfACXniOLtUOi34WPdbQg+J4EpRP05K1W/t13OGOVmV/CAqEw9TlyHQq7QcwTw==
X-Received: by 2002:a5e:8808:0:b0:6e2:af6e:3b58 with SMTP id l8-20020a5e8808000000b006e2af6e3b58mr30964640ioj.12.1672861081717;
        Wed, 04 Jan 2023 11:38:01 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id h13-20020a056602130d00b006cab79c4214sm6972498iov.46.2023.01.04.11.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:38:01 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     luca.weiss@fairphone.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: qcom: sm6350: enable IPA
Date:   Wed,  4 Jan 2023 13:37:57 -0600
Message-Id: <20230104193759.3286014-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IPA for the SM6350 SoC, which implements IPA v4.7.  Enable it
on the Fairphone 4, which incorporates IPA definitions used for the
SM6350.

Version 2 of this series uses the new "qcom,gsi-loader" property to
specify that the AP should load firmware on this platform.

					-Alex

Luca Weiss (2):
  arm64: dts: qcom: sm6350: add IPA node
  arm64: dts: qcom: sm7225-fairphone-fp4: enable IPA

 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 47 +++++++++++++++++++
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  7 +++
 2 files changed, 54 insertions(+)

-- 
2.34.1

