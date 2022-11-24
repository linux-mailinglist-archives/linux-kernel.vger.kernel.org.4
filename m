Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187BC637DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKXQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKXQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:45:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A33E6744
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:45:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z20so3199801edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAtqap4QIO0nlrENg1OAurg0EARQzORNJ8DMC3M0i24=;
        b=iAgdOOxHBeNvvz8Ms4ppLdFq48dgO2tckhJhQd0ZgLzg7bxCbTpybJ9QwNRv4Keujl
         Wx2SdAxiF0fURtXNOruJp0ohBW7DgzxbHFNjxxP3EvIVBvuZRmstOkRxE8Xr48t9KAeS
         JhyySR7X4fefDhwNZ0JDo2tYJO5I3+y9mcHk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAtqap4QIO0nlrENg1OAurg0EARQzORNJ8DMC3M0i24=;
        b=gaYG4FJqB/3/ovJpUWT8B82dhs2VNw54EXS9vdILC1DPDkQTpsHCvDZgte7FdnBKdJ
         lEitlIUNtVShBQ0hRQqbvsfo3UI2ZZZWAtLbOslCCYPYKcMZq+gfS+iptgzO1mNNglrg
         bai2ngsLsMRDqgCf9UMLQcemZkfi3ys4RrWynUpSuW9W0J91DG3Q9+zCNsSE6T60HMHY
         BvbMxbI+E6H5MM0A/7tciJjRCONzfPnEyTsfxR7EGHly+NuivCBGKrysjBCTq15QVjsT
         9NeRgGcvsON6AQIxLYp6v1PdAPSemN37DD3bnwmFjF4GpAqALyhEEHxY1AU7YqvCkj/N
         R1xg==
X-Gm-Message-State: ANoB5pmNWriDtkTtUywUnarUS0PWi38jAuJZ8CHWKdi2C/shnuX1iAsU
        RD0EW6WZdH/IVvNhUqHXq6Ajnf8dd7C5O5vg
X-Google-Smtp-Source: AA0mqf4AVSmsEu0a3BmSv97qP1OPw0nM9P4xn5+Axa6gD9xG/k6fQIsSDJSgusaUkDgroGMzPdkvdA==
X-Received: by 2002:aa7:d74c:0:b0:461:b952:8932 with SMTP id a12-20020aa7d74c000000b00461b9528932mr22642210eds.104.1669308351830;
        Thu, 24 Nov 2022 08:45:51 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:f5a0:768e:7eda:2441])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b0073ae9ba9ba8sm608555ejb.3.2022.11.24.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 08:45:51 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 17:45:31 +0100
Subject: [PATCH v1 1/1] regulator: da9211: Use irq handler when ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221124-da9211-v1-1-a54549aa6d3b@chromium.org>
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
In-Reply-To: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4070; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=zxWSRE6fLmUSDYXgM3OmaEjo17zx3iKQHxANdVTI8cc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf5+5NVCBg1nMF7lruqJRY8Qbdn4SeWaoP8+p94VN
 OkX0wqmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3+fuQAKCRDRN9E+zzrEiOEHD/
 9NBg4oiL/2ci+bzOc7KtVEe06nbdeh0ubZw3/f6bJRdxPIFOFMd2p/6ego7HVh7BFRc1784XI53ptj
 T0wpy/Mok29tCVJqpp/hlsAp9fS27IzfKNkvHhMOnhID1qDh2i//YkgB/BNH89OpG3lqbRwD6U0eTg
 TZFL09570aMAMkqEip3COM5E/kXUBoKPGJCsqPeqgUryHu5RmIXfiI5wDx926LugTKbC3J80Q5F+wK
 XxZRvX9UU94Fafm+Z+CCBTGNU7Mc2IYl1oVlgiJrj6/rgwKV4wiKM04hlc6uiWTDTKG695fG7bBnow
 Pv+63xdhv2pai5NUutpFxR7r+DMa+V/mTtn/hm+5Zgy/Gj0l6t/xWhdwtFsBC9Z62fROAEvoCvMk63
 lLlB1n3W9vWUStbxArDwG5Bqj4zEwL2F4Opmv67QMNPpe/7VyuH80Ub7xstIGN3r1sxHeLGQxWeo+g
 UJLBA4j79smoDjC2nGmPz6K3uS+S1gzjsiXr2XDo2f0rrAdg+VoQsGQXmU9fzoASTesm185CbvNLAG
 c+1RVMQUuF9FTeK5wAnnYjxXdKcS5ocd93x9eHO1rT+/cHFsXo2OICIY27MI0jNO+aQ7xcj1aOY0A1
 Y2p+gi8tnwKpq+Zc7rjhcTnGsuODwajhy/ty3sWxuqFmycaBKurB0uQjMVaw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system does not come from reset (like when it is kexec()), the
regulator might have an IRQ waiting for us.

If we enable the IRQ handler before its structures are ready, we crash.

This patch fixes:

[    1.141839] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
[    1.144475] tpm_i2c_infineon 3-0020: 1.2 TPM (device-id 0x1A)
[    1.150883] Mem abort info:
[    1.150884]   ESR = 0x96000005
[    1.150887]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.167749]   SET = 0, FnV = 0
[    1.170794]   EA = 0, S1PTW = 0
[    1.173926] Data abort info:
[    1.176798]   ISV = 0, ISS = 0x00000005
[    1.180626]   CM = 0, WnR = 0
[    1.183584] [0000000000000078] user address but active_mm is swapper
[    1.189929] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    1.195490] Modules linked in:
[    1.198537] CPU: 2 PID: 145 Comm: irq/77-da9211 Not tainted 5.10.153-20404-gdd5053d763d6
[    1.210431] Hardware name: Google Hana (DT)
[    1.214603] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[    1.220601] pc : blocking_notifier_call_chain+0x20/0xa8
[    1.225818] lr : regulator_notifier_call_chain+0x1c/0x2c
[    1.231116] sp : ffffffc010463d40
[    1.234419] x29: ffffffc010463d40 x28: ffffff9140ad2ca4
[    1.239720] x27: ffffff914205efc0 x26: ffffff9140ad2cd8
[    1.245021] x25: 0000000000000001 x24: ffffffe9bd532b28
[    1.250321] x23: ffffff9140ad2ce0 x22: ffffff9140ad2cac
[    1.255622] x21: ffffff9140cc5a00 x20: ffffff9140ad2c00
[    1.255625] x19: ffffff9142059580 x18: fffffffffffffff5
[    1.267353] x17: 0000000000000304 x16: 00000000000003b6
[    1.267356] x15: 0000000000000002
[    1.279078] x14: 000000000018bae8
[    1.279080] x13: 0000000000100000 x12: 0000000000000239
[    1.287768] x11: 0000000000000000 x10: 0000000000000001
[    1.294202] mtk-thermal 1100b000.thermal: can't find thermal sensor 5
[    1.297582] x9 : ffffffe9bc344050 x8 : 0000000000000013
[    1.297586] x7 : 0000000000000000
[    1.309308] x6 : 0000000000000013
[    1.309310] x5 : ffffff914205ec02 x4 : 0000000000000001
[    1.309313] x3 : ffffffc010463c58 x2 : 0000000000000000
[    1.316093] x1 : 0000000000000002 x0 : 0000000000000050
[    1.316096] Call trace:
[    1.316101]  blocking_notifier_call_chain+0x20/0xa8
[    1.322757] cpu cpu0: dummy supplies not allowed for exclusive requests
[    1.327823]  regulator_notifier_call_chain+0x1c/0x2c
[    1.327825]  da9211_irq_handler+0x68/0xf8
[    1.327829]  irq_thread+0x11c/0x234
[    1.327833]  kthread+0x13c/0x154
[    1.332067] cpu cpu0: EM: created perf domain
[    1.339641]  ret_from_fork+0x10/0x30
[    1.339647] Code: a9015ff8 a90257f6 a9034ff4 910003fd (f9401408)
[    1.343215] cpu cpu2: EM: created perf domain
[    1.348335] ---[ end trace 46760cc6c7f556d8 ]---
[    1.420026] Kernel panic - not syncing: Oops: Fatal exception
[    1.425761] SMP: stopping secondary CPUs
[    1.429678] Kernel Offset: 0x29ac000000 from 0xffffffc010000000
[    1.435583] PHYS_OFFSET: 0xffffffefc0000000
[    1.439754] CPU features: 0x48240022,65806005
[    1.444099] Memory Limit: none

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index e01b32d1fa17..36a0009e23de 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -496,6 +496,12 @@ static int da9211_i2c_probe(struct i2c_client *i2c)
 		return PTR_ERR(chip->pdata);
 	}
 
+	ret = da9211_regulator_init(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to initialize regulator: %d\n", ret);
+		return ret;
+	}
+
 	chip->chip_irq = i2c->irq;
 
 	if (chip->chip_irq != 0) {
@@ -512,11 +518,6 @@ static int da9211_i2c_probe(struct i2c_client *i2c)
 		dev_warn(chip->dev, "No IRQ configured\n");
 	}
 
-	ret = da9211_regulator_init(chip);
-
-	if (ret < 0)
-		dev_err(chip->dev, "Failed to initialize regulator: %d\n", ret);
-
 	return ret;
 }
 

-- 
b4 0.11.0-dev-d93f8
