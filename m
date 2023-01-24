Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30987679AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjAXNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjAXNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:55:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F735474EF;
        Tue, 24 Jan 2023 05:53:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 207so11224458pfv.5;
        Tue, 24 Jan 2023 05:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHeBHZ50aQkfqgUvQ7p7me+CLGT8bHN0BKeFRvf3X84=;
        b=eb88FkCt5apejh9PRzjRKde6RcCSR2ELTPTTJsmyxVC8ay6sycImlrxn26zaOvXPm2
         31opciIxOVcGQlgbghzqJMxXWbBamKQaZqO/k9bJbvZjUpTTTCjUi4nWroJ8KsQEK2fv
         x/DNoB18yRT3UldFZPD0bNtyHeerdXJEWmSR3Ea2NqfbxQrixYzfc9alph+p3BzrfK74
         olfh9w/f4IhaZHeeCLc8h9bTq1z0DY5ewmIxlBpMRvOcMNhAWAXUNbj7yaUvL/w1eKuF
         rHfFtETrkAD8aVtMD7aenYEsD3w0enmJxMiewva+MvJZhgD1Yd0N2gu+2WugBe9pAUfW
         UtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHeBHZ50aQkfqgUvQ7p7me+CLGT8bHN0BKeFRvf3X84=;
        b=qb/FkNk7Ioo5tYG1sPF4ugX+diuTB/7x49dpJfZmQFld5A9j2k2Zn8OEjgiVpXJ0Ks
         /iqeYNQw0o3w/y20yXZTD2BCSwC1zNaMdHWLPtSmHyQ/VJQw9JSm0KBB4F8LoG5xkwV9
         06x9nfSXNs/v8BeqZHHu7+dOQnyi3QI2DHCZQ/faKENtF8zCvAHsVyAOClJNzqN0AfQ9
         n2p9Jv6TVyQz+rXa+ukcWN52QF58GkT9IAzxMVdZZ4no3ba0MtuwmAwzR0HQYo+xa7Qj
         VYS+Fvoa8kY6LDJeVqkGhQYj6WyfuXK5AKDs6lKk3rcVr7Lig0NPPLSKKA7TSx7zEkqA
         2Pvw==
X-Gm-Message-State: AFqh2kpSazvEjF9H4+wgLv7gUWMbHkJjmtCJNKCLwJ8iKH0f4LBQTykR
        sveYL2XH1yLfItfW9BsGAVvgKcb0EqM=
X-Google-Smtp-Source: AMrXdXvVxedDObY8XFDjccTKR8eBjd2TqtODl6Tfz9ilcNtZ/lXtUL4AI8aY/w8AvnqFdtrVD1cPJw==
X-Received: by 2002:aa7:9116:0:b0:577:272f:fdb with SMTP id 22-20020aa79116000000b00577272f0fdbmr26607497pfh.29.1674568410046;
        Tue, 24 Jan 2023 05:53:30 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id d1-20020a056a0010c100b00589605fb0a1sm1653225pfu.96.2023.01.24.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:53:29 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro (xiaomi-elish)
Date:   Tue, 24 Jan 2023 21:53:17 +0800
Message-Id: <20230124135318.10023-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Xiaomi Mi Pad 5 Pro.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 22553637c519..c5fe81fba5b1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -873,6 +873,7 @@ properties:
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
+              - xiaomi,elish
               - sony,pdx203-generic
               - sony,pdx206-generic
           - const: qcom,sm8250
-- 
2.39.1

