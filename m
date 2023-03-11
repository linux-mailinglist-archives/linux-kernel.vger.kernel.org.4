Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3F6B5754
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCKBVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCKBVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:21:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7F12EAE2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:43 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bi9so8950024lfb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497702;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztXjjbd60BFQ9adlzKKMOkVzBvcLHCXoH/i70TyV+Ec=;
        b=q3WAVHm/AWREWNKGKDVHoh5g6T69Rh1ARhMh1X5XnJw8mfKwtmKHouNbpSaPtQvaIl
         1NRejU3M+iSFtroCCO2SZX0QpOIiDjGYtTmvYn6TCn1o0gMFidOTFavEw/49Mh4jgORD
         euBD4QbyU/i22X6YuTcYm0oYVjhjid6epJMyKBnPqcZ9kaNZSJd+pXL9x0iKbeFYR+7I
         AlsYoMxWEFRRO0S4twgVVT4KeoljXxKbx8REPOcFl5VqYl0lhk5BHEZR1P18Mh5rL+2G
         iImnNjNVylZwx2rqA0X2U7+FB5ZwV5VlbL+5zi2gA7/YxKaVvmbr16aM2UOuSveN1tQq
         jlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497702;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztXjjbd60BFQ9adlzKKMOkVzBvcLHCXoH/i70TyV+Ec=;
        b=PFlDCfx/I/OmBL7PiQ5Zn9ipBv30X1qdnJblPe+nmuNzvTfqskprklEKI6sm6ByYla
         hYe85H9vexem1ADH8M0vU+qwLWbAYFYVWnaot9W/YZjtujk5gftVe8MPXyFXixECjnzd
         IVum9Gbah2s++qnaL0FUbhwkXlSDzYG/xhjOdukbtGuE4j4XzdlTOXXDWsj0qqOEBjTP
         /542kDBcOtmkbvHb4wyBYm81+hmeJq9OIvk218+MV28hMx6IkHZxkDj9kw56vB/Ttaf1
         vJHqIAs+TGoPGkA99emzT5hHEXFqj/X0cquikryrd/p85nbdHIMYRPvWXTDBu+caMDe/
         C3MQ==
X-Gm-Message-State: AO0yUKUVUGdBPQPogT6ETBYEk7W/3S+Bd5o6EGTNmJgpbryiEehyzgGi
        qkOxVnf94QsoA25CXcXPtOvZrQ==
X-Google-Smtp-Source: AK7set+kjIujOB59hkOZ2XREZRD/YuX0C6q2jBdyoCGaw+W/5jFjPUh95DisAyV0tPeSFB7BFxP9Yg==
X-Received: by 2002:ac2:5332:0:b0:4dd:a7ab:b148 with SMTP id f18-20020ac25332000000b004dda7abb148mr7933914lfh.49.1678497702108;
        Fri, 10 Mar 2023 17:21:42 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RFC 00/15] Convert Qualcomm RPM message RAM to a simple-mfd
Date:   Sat, 11 Mar 2023 02:21:30 +0100
Message-Id: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJrXC2QC/x2NQQrCQAwAv1JyNtDdBSleBR/gVYpkY2wD7bZkV
 YTSvxs8zsAwG1QxlQqnZgOTj1ZdikM4NMAjlUFQH84Q25jaFAK+llUZ5zrcjWY85i4xdSGyMHi
 TqQpmo8KjV+U9TS5Xk6d+/5MbXC9n6Pf9B75+E8J5AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=3004;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Uq6nFpabusoC58q8pSGW5x4YCbTHeNtUHKsbt6Eq17E=;
 b=BvVDj6jzdTLhxkxpn2Qw6SXaLcpuQC36eScnwOAh1u/tAjXrFl2KZPXQ+iUkD72ChfuTPos9+b6P
 LTjZRDtLD4JnnS0Imb5BKWm3nPB8UKtT0PYysBlSs1GY/RcWLVcP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm RPM message RAM is a part of the RPM low-power processor's
actual RAM that's exposed to the Application Processors as a MMIO-mapped
region. It contains a couple of things, most notably the RPM master stats,
detailing per-master (read: per-subsystem) sleep/wake statistics and an
interrupt controller that's crucial to achieving full SoC clock and/or
power collapse states (the MPM). This series tries to prepare the MSG
RAM node to be a host for such devices.

Depends on https://lore.kernel.org/linux-arm-msm/20230308011705.291337-1-konrad.dybcio@linaro.org/

to solve a warning in the example.

The DTS commits don't add -cells or -ranges, as without children they're
not of very much use. They'll be introduced along with subnodes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (15):
      dt-bindings: mfd: Split out Qcom RPM MSG RAM
      arm64: dts: qcom: msm8916: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: msm8953: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: msm8976: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: msm8994: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: msm8996: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: msm8998: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: qcs404: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: sdm630: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: sm6115: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: sm6125: Add simple-mfd to rpm_msg_ram
      arm64: dts: qcom: sm6375: Add simple-mfd to rpm_msg_ram
      ARM: dts: qcom-apq8084: Add simple-mfd to rpm_msg_ram
      ARM: dts: qcom-msm8226: Add simple-mfd to rpm_msg_ram
      ARM: dts: qcom-msm8974: Add simple-mfd to rpm_msg_ram

 .../devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml  | 82 ++++++++++++++++++++++
 Documentation/devicetree/bindings/sram/sram.yaml   |  2 -
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  2 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi                |  2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |  2 +-
 16 files changed, 96 insertions(+), 16 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230311-topic-msg_ram-6b83ca812cec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

