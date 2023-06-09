Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08072910E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbjFIH3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjFIH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:29:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E435A7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:29:12 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-392116b8f31so374206b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686295752; x=1688887752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8EsfWHpWeEAsNMtoQxkNmoUaO1QNi7pZmjCqABYF5Q=;
        b=POi9nbAV25Brikqe/W2Ymh7GlIaZA9Dxo/7rn9kYc1cvJurZUpeHM2BZAKFHYiYObo
         LJBHSru7swM0r+MXwDjjiuEStNs4CgsY3Ay3kgKF2OcP5utGRd/TVW2Dq7hPfyL00UK5
         4HF7umJ7Bpww97g8cV4JxBo/DkLYSr+Fig/+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295752; x=1688887752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8EsfWHpWeEAsNMtoQxkNmoUaO1QNi7pZmjCqABYF5Q=;
        b=Hv4gpGaLtVL3CPcxVZzdxbDcWJaIJQ/KAN6xRxBj30mY7tWGmL5b2oj4qRXA9Y4GS0
         ZJNNEXYz7IyWxJA1WbC5hGLxK2F9xDDZwHQ6rrFru0t+LohJKRf5pXtHRRzxlfvT0ppq
         u75p9lh5alfufpA9eM30TzseXlUO70K0wHWmkzK+6rlKQakKIHlRTrO2fVUhdn4UrLtt
         x/hjhQiquwhkshBG9lUfv0INIVyTprL71Fs+ytrqyPfGUtKqJhLTp5RrRzO+9GZaBumA
         aJg3iASzNxxruUZnmOqyaS23ITB4Wgy+QWYMWa2NNffH21g16jkIUFaFF2CwYUWKJMre
         FXyw==
X-Gm-Message-State: AC+VfDwRZR6iSDSmY3ZoGBsAJ9vAhFFL0PIonU4R9vNt5SRfcUHjZfVu
        eyyrUYVioYfe53ZriD8QyWYylA==
X-Google-Smtp-Source: ACHHUZ6gUAtIUXXV50rIS9fsoov6g8tykoRv2P3NMR3XnEWio1RRcO83nEpmRKXDIRmX0T5deps5XQ==
X-Received: by 2002:a05:6808:2115:b0:39a:7830:f237 with SMTP id r21-20020a056808211500b0039a7830f237mr1010340oiw.7.1686295752093;
        Fri, 09 Jun 2023 00:29:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id y9-20020a655a09000000b005287a0560c9sm2160283pgs.1.2023.06.09.00.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:29:11 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 0/4] arm64: dts: mediatek: mt8186: More DVFS nodes
Date:   Fri,  9 Jun 2023 15:29:01 +0800
Message-ID: <20230609072906.2784594-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds more of the DVFS stuff at the SoC .dtsi level. This includes
the CCI and GPU.

Changes since v1:
- Dropped opp-level property from CPU and CCI OPP tables
- Used "opp-supported-hw = <0xff>" for GPU base OPPs to denote "all
  variations"

Please have a look and merge for this cycle if possible.

On another note, I'm still cleaning up the MT6366 regulator's binding.
We shouldn't upstream the boards until the PMIC is ready.

ChenYu

Chen-Yu Tsai (4):
  arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table
  arm64: dts: mediatek: mt8186: Wire up CPU frequency/voltage scaling
  arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM cells
  arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 490 ++++++++++++++++++++++-
 1 file changed, 489 insertions(+), 1 deletion(-)

-- 
2.41.0.162.gfafddb0af9-goog

