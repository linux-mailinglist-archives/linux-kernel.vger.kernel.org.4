Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3647C64876B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLIRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLIRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:13:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34073F042
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:13:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso8460400pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fhG6NLEcguqmAuYDYowfad0qz2/TgWDY6TZ0P8EmmE=;
        b=DwMtscjRx2e9DHcQ3qHJBjwp3qAxJlfIMS7enPtgMEzR0WF/RbYk4r3FVE2Y5EfIzG
         WAGNKS+jVOFYh1j1/PSLbDGHWYpgFeChoeBPE+l5nrxDcJWnXc80fBL82aZsQVbLtwGK
         EUe0yfSxwRf7jVat/QqcytPkeiqkhal6zYe9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fhG6NLEcguqmAuYDYowfad0qz2/TgWDY6TZ0P8EmmE=;
        b=OcP6EetoLQN6CGlbSRKAAL+Prxn1lUNT7Pt0Pge5ebsG1Vs0xU2kZuNQ5Vi/dGuTNM
         SXjaDjx7JSQ1OdbsMKypGu/T3l4jHAsRAeRh600gyjmtdzHdpzlUasyPH51498FJ9wWv
         FK8W90TLYc9bcdFuDUSQU6f1wX7d6mnXg0rAfXNT3ERnaOpY3goRQR6A7nypzA2M3aaa
         IlFbN1Xt09jN4O+vh952YnQvgaIdiftMqK89aY9Ccb68IMZkDOn9jUY2fXD3hUys7Wxf
         zfGt5/crkl/OjBn/uwtaAbWtLmPetS8SXCoeIgWpqISHHuG2OfrKdjNNOi172AZ5MkuQ
         xD8A==
X-Gm-Message-State: ANoB5pmPBcrKg03JuGE9rmesKodNzup5gXhx4qqx+XKOJiNRrLnSjHAN
        3M9u4gTalVp/XLIszXTfopGQlw==
X-Google-Smtp-Source: AA0mqf5OyDHM0ikRuMBlseFYWLgr+l1YbcjXZ6ndqQTpvFks/CfHeWVr8qYzZCB34RzoZUjMcZEwkQ==
X-Received: by 2002:a17:902:ab54:b0:189:6bda:e98f with SMTP id ij20-20020a170902ab5400b001896bdae98fmr6187571plb.58.1670605992266;
        Fri, 09 Dec 2022 09:13:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9a82:7898:7bf4:b4f])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00189c62eac37sm1597503plx.32.2022.12.09.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:13:11 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     swboyd@chromium.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mka@chromium.org, Yunlong Jia <ecs.beijing2022@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] arm64: dts: qcom: sc7180: Make pazquel360's touchscreen work
Date:   Fri,  9 Dec 2022 09:12:36 -0800
Message-Id: <20221209171240.1614904-1-dianders@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds / fixes problems with pazquel360's
touchscreen. A few notes here:

1. Originally the touchscreen was supposed to be added as part of the
first landing of the pazquel360 device tree. ...but the fact that
Yunlong changed email addresses seems to have messed up Bjorn's
scripts. What landed was v3 [1] instead of v5 [2]. The pazquel360 part
of this series is that diff (minus the incorrect 'hid-descr-addr' property).

2. We delayed sending the fixup till now because soon after the series
landed upstream we found that some laptops were having trouble
initting the touchscreen in cases where the eDP/touchscreen regulator
was left on by the bootloader. We've been struggling to make sense of
all of this. As part of this investigation we landed a85fbd649844
("Input: elants_i2c - properly handle the reset GPIO when power is
off") but that wasn't enough. That fix, together with the fixes in
this series, is enough though.

3. In v1 and v2, this series included an elan driver patch too. That's
landed, so v3 is just device tree stuff. It turns out that with
_just_ the device tree changes things are actually working OK but
the timing is tight, so getting a little extra breathing room
from the Linux driver was nice.

4. Despite the fact that we did debugging here on pazquel360, many of
the changes here are made in general for trogdor devices. I believe
that this will make the timing more correct on those devices even if
we weren't actually seeing problems.

[1] https://lore.kernel.org/r/20220901024827.v3.2.Iea2d2918adfff2825b87d428b5732717425c196f@changeid
[2] https://lore.kernel.org/r/20220923083657.v5.3.Iea2d2918adfff2825b87d428b5732717425c196f@changeid

Changes in v3:
- Removed hid-descr-addr

Changes in v2:
- Fix typo in commit message (Matthias)

Douglas Anderson (4):
  arm64: dts: qcom: sc7180: Bump up trogdor ts_reset_l drive strength
  arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator
    off-on-time
  arm64: dts: qcom: sc7180: Start the trogdor eDP/touchscreen regulator
    on
  arm64: dts: qcom: sc7180: Add pazquel360 touschreen

 .../dts/qcom/sc7180-trogdor-homestar.dtsi     | 18 +++++++++++++++++
 .../qcom/sc7180-trogdor-parade-ps8640.dtsi    | 20 +++++++++++++++++++
 .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 19 ++++++++++++++++++
 .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi | 20 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 10 +++++++++-
 5 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.39.0.rc1.256.g54fd8350bd-goog

