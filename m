Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20854694D67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBMQxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBMQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:53:45 -0500
Received: from fallback21.mail.ru (fallback21.m.smailru.net [94.100.176.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318E72B2;
        Mon, 13 Feb 2023 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=hvba2O1FqiNAXGYucHU2OJmXctDp/jGdJ/Dvomt8LCA=;
        t=1676307220;x=1676397220; 
        b=CDMPXPOmRydQr8HsIqHypDTSPAM/tpwN3hibrl0zdjf00s4cjiTxaEyeKvTr2s4nq8PBGGUGvPh2o/k8Jr4t9HR1kDWAEZViN3pC9qAcJGbw0QwnifVvw9bf1T9+DXTKvZ45tgg4qaU07wgKBRk++x4Np2xCFqUbhoDjOPUwKW8=;
Received: from [10.161.25.38] (port=55682 helo=smtp61.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pRc5B-0000oJ-Ai; Mon, 13 Feb 2023 19:53:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=hvba2O1FqiNAXGYucHU2OJmXctDp/jGdJ/Dvomt8LCA=;
        t=1676307217;x=1676397217; 
        b=deHlVhHw73rtcyXssloSAmhu6svE7cC9L6DnRhY96rlCV6FResyie0qKpnGRNmtn7NrYCcv4doPOTOLCSspn7BBTOwRUfkVsnQJp27EY/zmPvnqHmx9YNGx764cf9AyQKprNNekWXN7xwTvvEb5cBDMaOTci6McZvPCQzMePZ4o=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pRc4v-000849-3A; Mon, 13 Feb 2023 19:53:21 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v4 0/2] clk: qcom: Add GCC support for SM7150
Date:   Mon, 13 Feb 2023 19:53:16 +0300
Message-Id: <20230213165318.127160-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D95CB639AA8C08F8F243B0CF85050B97D7A3688F4DE55FE8182A05F5380850405C421C4E737DAFA0BA29CE147DFD6826F7493D60CEDA2F188C69641083F86FDD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7196003627DEC9496EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375ABF1810CDE7D0E9EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE712211E1EC8B4FB6F984AEE62072152FCC7F00164DA146DAFE8445B8C89999728AA50765F7900637FBC651BE86AB0F05389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC87C7DAE56957A78C8F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB1E7EB37E7A723DABA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C0329BA3038C0950A5D36D5E8D9A59859A8B637A278BB1D00C32976E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B63D4080343FFB34AA089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A50C809C4011565B8D45C51A79B6683C19935D602F1671D0474EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3454548929AF40B428C806A7F8CC9ED4C932DCA9E9AF68C8586D2EAD56E901846EF9B2884AC70EDAE71D7E09C32AA3244CDEA83EC64BBC7976AE8769114F46986AA90944CA99CF22E3111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXjM8gFDnjjK8m1TqLF28xtU
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949818C37C8FDF4D04B0CD87E96EFFF79FF0F19989B863DE37BB5643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B4CD5912039A6B9827B835AAB0EF3D64C2849E8E742EC28668F3CF0E9FE49B69225E8D1F4DC7B2F59CAB8E96EE7768DE039480E8BAA5E4E9385E7BCD53582C54
X-7FA49CB5: 0D63561A33F958A55423AED370965F7272021A4C8ACD4A3AA9EF05C13F9999048941B15DA834481FA18204E546F3947CD63380FFBEB38773F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063796660B48CDE49E4B389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637EFF5ECB7E57EE405D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CD5703B978803C49E43847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojgB/I+mAIlFEip7LmYsl11w==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Global Clock Controller for SM7150.

Changes in v4:
- Keep the critical clocks always-ON
- Added Krzysztof Reviewed-by on patch 1

Changes in v3:
- Dropped entire property, it's coming from gcc.yaml
- Included original work copyrights
- Link to v2: https://lore.kernel.org/linux-clk/20230122192924.119636-1-danila@jiaxyga.com/

Changes in v2:
- Dropped redundant "binding" in subject
- Fixed yamllint and dtschema errors
- Replaced additionalProperties with unevaluatedProperties
- Added Danila and David to maintainers
- Added Konrad Reviewed-by on patch 2
- Link to v1: https://lore.kernel.org/linux-clk/20230109193030.42764-1-danila@jiaxyga.com/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: clock: Add SM7150 GCC clocks
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7150

 .../bindings/clock/qcom,sm7150-gcc.yaml       |   53 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sm7150.c                 | 3048 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm7150-gcc.h   |  186 +
 5 files changed, 3296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm7150.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h

-- 
2.39.1

