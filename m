Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB66B61FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCKXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCKXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:17:41 -0500
Received: from smtp46.i.mail.ru (smtp46.i.mail.ru [95.163.41.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94D62410D;
        Sat, 11 Mar 2023 15:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=yNQUQIqdylZOtWdRp07sWFsYjHmj+6XeQnwvqugYH0c=;
        t=1678576659;x=1678666659; 
        b=SO6gHFCiimGyk4q4fmISgPM+8sXnnTSimRTjPmA5CvjRJVjlktehC34Q63aVOQ+aNwak/rpWCwB7H+VPLvT/235KD4V8XAw9f6/aGU09+S8EBbb9VfccJLCqoAFvcEGAEp9cKIs6bFLMtYhDpM79P7KFCPjOIRuB27bzWYKYqus=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pb8T1-00B9aE-2V; Sun, 12 Mar 2023 02:17:35 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davidwronek@gmail.com,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 0/2] phy: qcom-qmp-ufs: Add support for SM7150
Date:   Sun, 12 Mar 2023 02:17:31 +0300
Message-Id: <20230311231733.141806-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp46.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD83570AA601AEA34798F73F5BC8FBBA927E37182A05F53808504005843A5FDE927F368E6662FEDEC6AFF756DE8276EE1B4C0B2ACA4F1D781514DA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79D9C320A40CA82D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637829D9538242026C38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D828D06B9E32C23F0D727E2F8F27C7E5D6117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC1F3D1E7C87716A07A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735204B6963042765DA4B618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE41BF15D38FB6CB3A1B780A39BCC1DD35D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE36D3A1509E11137116E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063752BC29AF30EF825DEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A575C03DA3C5642B1CB11436FC6533849E5AD0401A58EBFCA54EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D341C998A3771F0415375AE9313AD7C7CC203C7577E50A71565071A78589369CDD2ECA4D15217522D061D7E09C32AA3244C28F98ADB488FB8232E425A95669FD332F2F5F14F68F1805B0D282625F6E20647
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEg2t1XEOuWFDZPI0qXV5Vw==
X-DA7885C5: 664F9D43EADD1558BF872CFFA1755FAD3FE5FF52EF7A9FEE7787BA85C37591B2D8288D6B1992AB67EF2421ABFA55128D02E9C42E3A59EA20
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814893C669902AB60405E4978E20955CA597AF23EEB7B65FE8643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds UFS QMP support for Qualcomm SM7150 SoC.

Changes in v2:
- Switch to new bindings (qcom,sc8280xp-qmp-ufs-phy.yaml)
- Fix compilation error
- Switch to 0xff instead of 0xFF
- Add offsets
- Set no_pcs_sw_reset to true
- Add Dmitry Reviewed-by on patch 2
- Link to v1: https://lore.kernel.org/all/20230309185049.170878-1-danila@jiaxyga.com/

David Wronek (2):
  dt-bindings: phy: Add QMP UFS PHY comptible for SM7150
  phy: qcom-qmp-ufs: Add SM7150 support

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+)

-- 
2.39.2

