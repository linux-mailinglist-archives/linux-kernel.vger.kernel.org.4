Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1021C6B8201
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCMUAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCMUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149074A51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m4so4202382lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpJu9aK6C1Wq/bOWJwZJEPNTv5iMsR3EtRhnCHCKB+U=;
        b=EIQFJv/vqrvhHoGChAjmk16eoqj5wuQ/JJF0AFO/tWRzp4IjBoi7Iae5HHVjP7zToz
         Upy6Icd8/A2c9zBA62rO1f1yjKJYwv5hquPHPVaEyCE7syRO9M74j3A+wlrVzc2fe/L+
         jKo62ZF0bJAZwDCpdTKaEIP+N+a9YEEcoPt6ZpwdZtvvDl9qw5TgLMNlfQCPantc5G0i
         nekbu8MXMV6QmcBIlaUK9r5hR+P0viY06x0yV+aVPbP5HZIrS0pIJ7Rlhx3r+iFDYsYc
         inALgF9Z5BUjT93ZrMJad+ShSAlPfUOkYDBMAdnqo87In019OXAPJSXCij/ivUq/wQux
         ufKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpJu9aK6C1Wq/bOWJwZJEPNTv5iMsR3EtRhnCHCKB+U=;
        b=BhbJICmtXONt1fcxR/yCDNwEVwCB+qDHWmMv1ZiOeTxH2wZAtlHLfrTzfT31zS8EcJ
         Jwr3M4rNrpcbv0pBvo2PHjXIVKGcXEHfz14I/E1H0bBLkou0oNP/+9tGMb9789mulLKk
         0ou7bK+hH55gYxsdW9hl7meRQ/pSwjGDqm3bJrp/76IumWkacjiWjAdilOGMaySP0lfD
         NLGIcFUy9ukOf5KmPnmjcPEjhfEeGAITtOH3uFmZtcTi6e37LlC9B2ShksR0iS2x4aRF
         Jb2ojCFHgqQmHi6JAatXuZ6L8eZUDeLs96W0ozYbRmFXBFp38122szduKB5Ut5gAzGua
         eiPw==
X-Gm-Message-State: AO0yUKVS/RPfnCVrTH06At3C9crD22WdXEMy7t1HFz+Kc2KRPkHI0jzv
        k+xHCU0aNKUBJgX5uNk9W5z9UA==
X-Google-Smtp-Source: AK7set9FP1LYJMWK4avFTLxE+L6Xp6sr0jFyJkf5sCieT/lchM15aYTFPUFR/7knfU4xKSMPzwNh2w==
X-Received: by 2002:ac2:5106:0:b0:4df:c2bd:58e0 with SMTP id q6-20020ac25106000000b004dfc2bd58e0mr9878773lfb.59.1678737608786;
        Mon, 13 Mar 2023 13:00:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 21:00:01 +0100
Subject: [PATCH v3 03/10] soc: qcom: rpmpd: Unify Low Power Island
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-3-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=1353;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mKejTkicxehr99wJklnHdnLAyKORPeX6SnazDDhGxh4=;
 b=NKvWACzeiN94Hug06gNAvVTWhDpa83B//+OWpPPb+xsE4nqQtVWc9V04UlrF7dFuz/0uJbzhemQV
 ZDnyea5DBHnFyFEB5lu4B0qez21ldJPc5Hpu1p55amBFey2Fjjg6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, we had 2 separate entries for VDD_LPI[CM]X and
VDD_LPI_[CM]X which both pointed to the same RPM resource. Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 7d9e762232ea..8ba025c4eca3 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -149,11 +149,9 @@ DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
 DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
 
 DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
 DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
 
 DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
-DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
 DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
 
 DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
@@ -324,9 +322,9 @@ static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] = &RWMX0_LEVEL_vddmx,
 	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
 	[QCS404_VDDMX_VFL] = &RWMX0_vddmx_vfl,
-	[QCS404_LPICX] = &RWLC0_vdd_lpicx_lvl,
+	[QCS404_LPICX] = &RWLC0_vdd_lpi_cx_lvl,
 	[QCS404_LPICX_VFL] = &RWLC0_vdd_lpicx_vfl,
-	[QCS404_LPIMX] = &RWLM0_vdd_lpimx_lvl,
+	[QCS404_LPIMX] = &RWLM0_vdd_lpi_mx_lvl,
 	[QCS404_LPIMX_VFL] = &RWLM0_vdd_lpimx_vfl,
 };
 

-- 
2.39.2

