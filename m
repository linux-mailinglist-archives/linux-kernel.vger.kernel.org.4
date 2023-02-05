Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C5868B1DB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 22:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBEVNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 16:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:13:22 -0500
Received: from fallback20.mail.ru (fallback20.mail.ru [185.5.136.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068114211;
        Sun,  5 Feb 2023 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jImAqmi0+rCcWwya4e++ISC8KB4BelrTGzo3W+13GLc=;
        t=1675631601;x=1675721601; 
        b=qM0x6vf5LjlKSwLcgZx3fIqEofrcYWMpld7/B34zgxN5ZjSAD//Xdmq2ZE4YXUogoIldE0fEWpQQmzklr4H4g7dWzZ9OYd3UCdupwPcIu7NG0C8tgPGvYoyPlidQVAsQ1FksaS05JhoGBNmnjEf5YfsyCkZQspkhhlpNU3VVnDA=;
Received: from [10.161.25.38] (port=40140 helo=smtp61.i.mail.ru)
        by fallback20.m.smailru.net with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pOmK5-0007Qh-Hz; Mon, 06 Feb 2023 00:13:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jImAqmi0+rCcWwya4e++ISC8KB4BelrTGzo3W+13GLc=;
        t=1675631597;x=1675721597; 
        b=ibUZSDELDTSkBfHAQqYRevR0NEhfPSpaNe8kJptXPNN9kpEXjTo3kTOS6QfIgM3BOm39Bq7Y6yb0YF7mZC9mjr5A01nLSecy+4Pc/107T1ObKDvJ8Z9gN6u0k15a/SCQrpehukQQJZ8CD8zqL64dA12Z4c/GQg8pmaAl+Gf5vZs=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pOmJo-0004eX-Bo; Mon, 06 Feb 2023 00:13:01 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v3 0/2] clk: qcom: Add GCC support for SM7150
Date:   Mon,  6 Feb 2023 00:12:55 +0300
Message-Id: <20230205211257.285997-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9100215ACCCAE6BED7294640152C00DDD2C3C9500F60304EE182A05F5380850404C228DA9ACA6FE2740AEFCAD8395FFABBCF89CBA0E5F125B3C56F885F6428426CADF818F26E279A3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE759251087BE69EEF7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063786F1F539FBE87B778638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D824699BAD20B5316CABC147901FF3588C117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC0F49EF363AAD6E82A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520902A1BE408319B29C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE7B96B19DC40933219735652A29929C6C4AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C39A2BE12F968E561CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3D10145CD839B4E3635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5BCF92E759FFD4C0211E8D3480825BEAB216597152BEC6D7B4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34C0DDD40374D350170E9EDFBFE289DAEFB0ADDDC23B6C3581FDD15858B403BBACF0081CEDD1423E7A1D7E09C32AA3244C0ADBF3EF26946BE94951523F98B8CF0EC3B3ADDA61883BB5111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhaOnjUTNV53XhwMHRU3jq3
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812B488FA72D9D26A4D3F3C10C8F6693D5DBC91E654210EB0A643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CF848BFCF0E6F430F1E17D0F5332DCF3E21FD34BD492FDF5049FFFDB7839CE9EE5C9C3F142B9F962D93CEC3002CA3796393164242F329D19539C915920B497B6
X-7FA49CB5: 0D63561A33F958A552FB9D1859FAD7AC46EAD27EBF13993FF93498156F4636ED8941B15DA834481FA18204E546F3947CAD7F9107A29F15F9F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006378EC9A23920962089389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006377263CA0F14EBD909D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C40D77AB7D53AE9AB43847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj6shc/GkzDh0lRo4WVlqlOw==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Global Clock Controller for SM7150.

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
 drivers/clk/qcom/gcc-sm7150.c                 | 3160 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm7150-gcc.h   |  194 +
 5 files changed, 3416 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm7150.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h

-- 
2.39.1

