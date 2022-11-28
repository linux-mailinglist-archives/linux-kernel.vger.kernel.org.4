Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DAB63B4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiK1WME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiK1WMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:12:00 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B930F60
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:11:59 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b2so8719068iof.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqj31xD4hPaFJyMRspnZtLV/GdibyQshhKJftkXPTVY=;
        b=LX1I5X2Tqi3H4osOssCuWhQxDxiOSlkZYdf+xSNNQ5ROewNwQQhCSV6qRABxIV2Bks
         oYRqoJPX71/O7LWeXlCZXMdXOJYPsyjuD4LOYDUmiqHaJXS34kSPYV3r0aSd22RTBcvD
         HpGsQZUSAGnCIdx7iCLmqGl1ZVN/RS78RxSwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqj31xD4hPaFJyMRspnZtLV/GdibyQshhKJftkXPTVY=;
        b=7j/h6fHsfEzXVOG9MHEk47tW3PlkBGMnZaXcpwk/lCXogWDjGmGkiyx8W5Z/u1IE+P
         0qbihT4eErESE/r6dQSARPlpqeuhk8WRIo5Gl4wqN6g1gULDqo89j13GNUo4Q2kxsIPg
         Y36MAxX9rU3x5rTuSYtUyCHspkVjlxC5KcsNHYLe5TUVDPW6q9MiUjm5ABvVy0nEmW5I
         VDWHuDvPz/fJRGnsf/ATFugKSZFHbSiz9HNUm5eGYHMyox745NacBB4zkQwYwmj3AdO1
         sSEC8xk/TME71iqutRx60FLAddBPpfDKH02r0wPgKjAFyVKdl1aCk9Cl2AtcKWb1POoS
         10sw==
X-Gm-Message-State: ANoB5pnXOGPs4WJHXwCQgu0naoG8wteEGqWvQEAFFuFBC3EB/oGj4Y3T
        IBlGAUU3mdb06IMTu6AODASS6w==
X-Google-Smtp-Source: AA0mqf77dcDF5VbAESm+8p/Wms6Z+hD0jVYwI2+aCwtztLs7FD6Hhnbu5FCGv+vyB+kuFVJq+DEo4A==
X-Received: by 2002:a05:6602:21c2:b0:6c3:168a:a25e with SMTP id c2-20020a05660221c200b006c3168aa25emr17433231ioc.174.1669673518761;
        Mon, 28 Nov 2022 14:11:58 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id a15-20020a92ce4f000000b00302bcbad239sm3827937ilr.77.2022.11.28.14.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:11:58 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org,
        Douglas Anderson <dianders@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] ASoC: qcom: lpass-sc7180: Return 0 instead of 'ret' at the end of _resume()
Date:   Mon, 28 Nov 2022 22:11:55 +0000
Message-Id: <20221128221152.2.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
References: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180_lpass_dev_resume() returns 'ret' at the end of the function,
where 'ret' is always 0. Just return 0 to make it plain obvious that
this is always the success path.

Also add an empty line between the error handling path and the
return.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 sound/soc/qcom/lpass-sc7180.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 7a81e609727c..30a28e3152cb 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -173,7 +173,8 @@ static int sc7180_lpass_dev_resume(struct device *dev)
 		dev_err(dev, "sc7180 clk prepare and enable failed\n");
 		return ret;
 	}
-	return ret;
+
+	return 0;
 }
 
 static int sc7180_lpass_dev_suspend(struct device *dev)
-- 
2.38.1.584.g0f3c55d4c2-goog

