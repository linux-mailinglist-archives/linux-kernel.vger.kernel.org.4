Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2672BCFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjFLJsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFLJrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:47:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05293A5EB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9786fc23505so610433366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686562410; x=1689154410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn1KmoSk4w+76jXteo+X6vERxlyroWl5Pa1iBI+YhcU=;
        b=aKH7YgYs7NdNLNjRM9saAyjtg6C3B3PKNqk8EubOZ6PjsYpJobwp71ACl+zvOE1iZb
         9thz1H5IUgtL/SCUeJXGYRkmj5KgbZpHFsQDcZbwv/2q/YRrc+fPbfiSYYV9O/sw6+Rr
         L3y8KeFvzqgT+g6J29ILMtchcRVu9zG1HOLeELMUENtL5YmqiXb79aLY8GRTERxHEko8
         sbyoJuu7t5BHvloNCYKfQ0NwIPWoiZ4YwurXL6XjL2RNPfxGoaq57IOBZbKqyDFR4Vuk
         175cfzC//CjQ3tTQubUK9eP2vVSP+DgR1Dn2lbHf5v6MSaq8WkFSEnm0R6jW1Pl6st8z
         VClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562410; x=1689154410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn1KmoSk4w+76jXteo+X6vERxlyroWl5Pa1iBI+YhcU=;
        b=EWl/Re0Y/ysHyvWzJ11z+3SbHHibkPD8StriEHY/J5dsp7uMw7EAjqBrYK6thVUzvt
         AiWdop8ziJvRnICIadV7n8gEt3DNUzhCPzWDbXNErKuL+ZUsCBMz4vQz4hGNCrlK+ENy
         lNzT1/GIeGwLfbVS/Xm1QKJ7uA5xVrPeIBIRDZGqKL9XGeWo6/f1foHZCaGia3/BzKcl
         +2z8y1qNNL1wPEuZvektveQ0U32V+ke+61sCSc/J4Mo84Js6UNDLsg2FXrOWc+cB9pXb
         cTTdvkx0w89h0Gj7XaAAbqTCQ/Vof3sEDhKmkVPGPHAMEJQk+CFEOuWym6ablwNjDznZ
         3VUQ==
X-Gm-Message-State: AC+VfDw9FPGFF0VptvLrpS8nEjyhhjXbuYGF3+rzr3EOVqJ1W/22rS7C
        W349bX5PYZgZVb55Li5KXz7K7A==
X-Google-Smtp-Source: ACHHUZ4+8vTsEZaxwOtLPHygS9TYUr1UyDbsg0bBA37CkuzbfQ3tHT6uZY4O9wlvwavwYKWxUWhGsg==
X-Received: by 2002:a17:906:ef07:b0:96f:7b4a:2904 with SMTP id f7-20020a170906ef0700b0096f7b4a2904mr9276446ejs.3.1686562409808;
        Mon, 12 Jun 2023 02:33:29 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id gj13-20020a170906e10d00b00965a56f82absm4908151ejb.212.2023.06.12.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:33:29 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Zhanhao Hu <zero12113@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe
Date:   Mon, 12 Jun 2023 12:32:40 +0300
Message-Id: <168656228140.662397.4112940711975875013.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601033825.336558-1-zero12113@hust.edu.cn>
References: <20230601033825.336558-1-zero12113@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Jun 2023 03:38:25 +0000, Zhanhao Hu wrote:
> In function probe(), it returns directly without unregistered hws
> when error occurs.
> 
> Fix this by adding 'goto unregister_hws;' on line 295 and
> line 310.
> 
> Use devm_kzalloc() instead of kzalloc() to automatically
> free the memory using devm_kfree() when error occurs.
> 
> [...]

Applied, thanks!

[1/1] clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe
      commit: e02ba11b457647050cb16e7cad16cec3c252fade

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
