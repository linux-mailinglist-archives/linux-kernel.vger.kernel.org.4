Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDF6AAFCF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCENA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCENAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:00:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51113D65
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:00:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so27964422eda.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678021204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqMJ0ZIasfgRepLCIMM64pYFVwBBzY2kG8SlS9WNlTg=;
        b=ypSIDavzk/FoaSlWMzIn2JUpoYz5n8toDVcGUayZNymIaSULZKkijTC3xJS3oNGMFO
         IKcDtp90gxbufSG07DqkS6jlWsw8yfeTRbPkqJqcsWim6BJPd7JTPISSE1acgi0HGbmZ
         tMb/wkHEuccj3zX3qz85k33QbuFTV4UD5d48yjI96vuvYLaia5GBid8R7ThZ/V9xr2I/
         ws1SS7/IM0xkH8ULf44tgG3CHvgGnY68y4lr3VSwrYbHDU4ShbQw79KF7Iu15lfIwOK9
         uvbYbFkta+YXf0LtnmPFXWHpFSJWnzu9CUlYGFC5/KFZ9nV09aLe85517n6JF7njCtHC
         zXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqMJ0ZIasfgRepLCIMM64pYFVwBBzY2kG8SlS9WNlTg=;
        b=wabmD5vb8kwNZsTdt4f1ADIEkcopACWLggbPaI5ZxoMBQZLQhw6WUpvyGhSPRsv/a+
         USIBpEH8P42Nd2LyD5zwU+j3WXFbYC6IVZxajfi4wCKXUNaRTankmxoBkdC924FyG5Or
         xcgSj5B7yHZ/TGnr8eVNKdRA0JH3YmiXjJbsiZa6Ah7xWrj2VfcCZWcKpWLl4BOvh9zv
         cEJftRr71RT9oAzBf812P3Q44838rDQ/U6NtTUNOVurlfyoVf3xxq+FtJKmNifuREH+j
         MNr8T9B99Kb6ZkSO43I/27SlH6/Kr5O15XM/FIZXiLP4qMbEguzmh+t2HoLsW5FG6vqu
         NwYg==
X-Gm-Message-State: AO0yUKW2VW6gjNy5Z14vMkdXMGsWoCHB9LY+4zQQa3uFYhTe9MMqrkf7
        J8nhg3vh5fd0xxCYD5KA7FsgoA==
X-Google-Smtp-Source: AK7set/3mkGchxjK6g4piT/cMZHYdLesI3I3C498NnDBJE+DTOLBrlFye+FbdOvdfuP7vZ3060a5lw==
X-Received: by 2002:aa7:d153:0:b0:4ad:f811:e267 with SMTP id r19-20020aa7d153000000b004adf811e267mr11696605edo.12.1678021203878;
        Sun, 05 Mar 2023 05:00:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906078f00b008ea8effe947sm3193158ejc.225.2023.03.05.05.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:00:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/11] arm64: dts: qcom: msm8953: drop clocks from RPMPD
Date:   Sun,  5 Mar 2023 13:59:51 +0100
Message-Id: <20230305125954.209559-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
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

The RPM power domain controller does not take XO clock as input
(according to bindings and Linux driver):

  msm8953-xiaomi-vince.dtb: rpm-requests: power-controller: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 4e362b9012bd..da00c2f04cda 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -281,9 +281,6 @@ rpmpd: power-controller {
 					#power-domain-cells = <1>;
 					operating-points-v2 = <&rpmpd_opp_table>;
 
-					clocks = <&xo_board>;
-					clock-names = "ref";
-
 					rpmpd_opp_table: opp-table {
 						compatible = "operating-points-v2";
 
-- 
2.34.1

