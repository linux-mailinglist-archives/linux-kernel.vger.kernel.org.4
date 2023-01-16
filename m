Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB066D070
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjAPUsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjAPUsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A52B2A3;
        Mon, 16 Jan 2023 12:47:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b5so7452925wrn.0;
        Mon, 16 Jan 2023 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WD43VrJyuOOGawH5BIgCKMkAnIQ0M+903UfjUxvZAZE=;
        b=OPlzPOaEdgT/WJboIf4FH66QtTw+k/Vn0xpl87PxwRxwpF/aIbEwbLkCdDmdAqSTRL
         eFHWqMgh/Hc6hi47G0ibpItplSCVLrdPGiROamnZNa98ipSUOiWXCNmD/fRi68UHoQpd
         D5jB9JYQlWTOS0no0fHBbW7tlpkcJVtAsBFdOzg1GwGqTkRqnWrrCt6/3IxSjMxswSHj
         MGEE4pvqCtEASrvRDDnwtm2bjsM1D3AIf6Qgf8btykP676Nvk/eQGaqLi8vN2bxhckbx
         9yQTfv3TGiwUPYIb95/p80DQELm5tAF94UvWcsWX5Nz5bv/gDdq/E0GC5/MUhg8ObTBC
         rxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD43VrJyuOOGawH5BIgCKMkAnIQ0M+903UfjUxvZAZE=;
        b=rlw/3b4ZKgLY7VeP6cgBhBkX6/TssfklcAgao2xqg4XbSzSVylFtjZgecXE3eBPPE2
         mtvx/wUbJqGwLSy05rbl4NVMEobLTlj8MfH3YQTEVNSWgBo6PKZqoB0/PNWRcXV8Otfg
         6eekv6adpeH7CrbLspC7Q7ztuqn2LcjWp2Xb96bFKU+C4N8LLtNfeeEFwu+2H8oFhsSY
         Da+TtGX2DehdkbOJnOC+NXMbA07rVRtfMmm4PBS0cH7BcXg/uJJ/CHTs0XiKIZYFw1jh
         A5cf+H+5SQrkdRXe09nE5z0HsAkK+xD3//yiqsTGSWOSCOCpfhF01q5LKvLuh98itvy/
         1MZQ==
X-Gm-Message-State: AFqh2koIbVwXDQAxmIWUnBoK4G+3lhXCgIMjsJ3Zx0dj9qT9dRVrh6H7
        nfFA4e8B4b+/yImGJTLkvHk=
X-Google-Smtp-Source: AMrXdXtl2dm2gShSxprNzc7SgywcC6D01VmVe29e5x3UYg4d9JT4+BJUCDUmvCN0YK4F0Ez2PN26CQ==
X-Received: by 2002:a5d:6b07:0:b0:236:695b:82d4 with SMTP id v7-20020a5d6b07000000b00236695b82d4mr673570wrw.30.1673902078030;
        Mon, 16 Jan 2023 12:47:58 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:47:57 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7 0/7] Krait Documentation conversion
Date:   Mon, 16 Jan 2023 21:47:44 +0100
Message-Id: <20230116204751.23045-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert the krait-cc and the kpps-acc/gcc Documentation to
yaml.

This series comes form a split of a bigger series that got too big and
now hard to review.

While they are still more or less wrong and doesn't really reflect real
driver implementation, they are converted to prepare for a fixup later
when dts and driver are finally fixed.

Minor changes are done to the kpss-gcc driver and minor fixes are done to
the various affected dts to fix dtbs_check warning with the new introduced
schema.

Also fix kpss-acc dtbs_check warning.

v7:
- Split dt patches to compatible and missing clock
- Add Review tag by Rob
- Rename from power-controller to power-manager and drop extra binding
- Add Review tag by Dmitry
- Rework some patch to better commit title and description
v6:
- Split kpss-acc to separate v1 and v2 schema (thing changed from
  simple clock controller to a power domain in later SoCs)
- Fix whitespace error (extra new line at the end of the file)
- rebase on top of linux-next/master
v5:
- rebase on top of linux-next/master
v4:
- Fix error from kpss-acc schema
- Fix dtbs_check warning from kpss-acc
- Improve kpss-gcc for apq8064
v3:
- Update all Sob
- Rework kpss-gcc Documentation with the new finding
- Fix dtbs_check warning
v2:
- Fix bot error by adding missing #clock-cells

Changelog for previous series "Modernize rest of the krait drivers"
that was split to smaller series (only Documentation changes):
v7:
- Rework kpss-gcc Documentation (split patch for pure conversion and
  tweaks)
v6:
- Address comments from Rob
- Fix warning from make dtbs_check
v5:
- Address comments from Krzysztof
v4:
- Fix more dt-bindings bug errors
v3:
- Split Documentation files for kpss and krait-cc
v2:
- fix missing new line on patch 16 (krait-cc patch)

Christian Marangi (7):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert and split kpss-acc driver Documentation
    to yaml
  dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
  ARM: dts: qcom: add per SoC compatible for qcom,kpss-gcc nodes
  ARM: dts: qcom: add and fix clock configuration for kpss-gcc nodes
  ARM: dts: qcom: add missing clock configuration for kpss-acc-v1
  ARM: dts: qcom: rename kpss-acc-v2 nodes to power-manager nodes

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -----------
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ----------
 .../bindings/clock/qcom,kpss-acc-v1.yaml      | 72 +++++++++++++++
 .../bindings/clock/qcom,kpss-gcc.yaml         | 88 +++++++++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++
 .../bindings/power/qcom,kpss-acc-v2.yaml      | 42 +++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 21 ++++-
 arch/arm/boot/dts/qcom-apq8084.dtsi           |  8 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  8 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           | 12 ++-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi           | 13 ++-
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  8 +-
 15 files changed, 317 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml

-- 
2.37.2

