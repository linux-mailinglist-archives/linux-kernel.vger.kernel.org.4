Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5322C72BD07
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjFLJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjFLJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:48:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC876A5FA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977cc662f62so604340066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686562407; x=1689154407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7/I1ayBoe2EChOWGV7usCqZR+8SIH1+fvVOuYaCd8o=;
        b=hQsfbC1hfvX/VkT1eqZm5DfS/WywUBfNcsJPDDu4FvXouSS4uGmSjMvie8Y7o22L8n
         4PeVe/c0F18vWgnIz3raM4AR0kPeDO2Qbzjnc1UYuuoSoPBynADm400FuJz48W8fVwd2
         tdA9yjlFwpO4H3g31t64F5OnsJCLzyI2ShbywFIZ6GW4XehMltmLEuPVXgXOEwikgqTz
         Yi4/9ru4IUNjZxeg/FnBRwIC0dPNc+DMHIcX94ibRBIilBcsF8bfng+S8BTlHWyzd3ld
         fNsS9lBggk3nKcLokp4hFOQ2JRXiMwhu8JCn4B7AkRJwMH2lmBf5Sex6BnCNmJ1H++Yp
         y3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562407; x=1689154407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7/I1ayBoe2EChOWGV7usCqZR+8SIH1+fvVOuYaCd8o=;
        b=TABrIZDrK44goFkGF5c0dbERN/fD6BKggkKh9EPFayB5+CcAhB4Sr5KgitLv7kkbrb
         4rZe4NGRVyQu/tDqMAnoXRQGLdydpi1LKHrP0D+fEoo++BMJL5xzxl88iqpL5nKLI4uv
         L+aOwNQWTLBIuWGrmdREi7vrkB8DB7uT1sts7G5iXY1twCq3rKhxirpTI05O2Q0SSHSD
         w7/iiLFl+5toa/o0sO+/HtALOGZSFi1OIOADb2GZIuQgGA6kFY6u2GmsIRxXQaJfeJtE
         43NppJ+x/pIk7YFNm+5dw1sLaHlsZ25rrGNUY/N+h/T8f2QAmjIAI73TCoViJBiYB8ho
         wqtg==
X-Gm-Message-State: AC+VfDzBZBnH3XSu3teWb8BUA3x4WK45tlSrF4X09HnFEVGNN+Ev3IvD
        /oFlBOOrzd3wzDjCE0QTMjwFzg==
X-Google-Smtp-Source: ACHHUZ7FiFwL8BPjh91CWEs26xmFRAo3yhdyy99t1MUNpBm1Q2o8g2tcPkZuAmMS/QfaGcOjlVTsVw==
X-Received: by 2002:a17:907:2688:b0:967:a127:7e79 with SMTP id bn8-20020a170907268800b00967a1277e79mr8819298ejc.28.1686562407624;
        Mon, 12 Jun 2023 02:33:27 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id gj13-20020a170906e10d00b00965a56f82absm4908151ejb.212.2023.06.12.02.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:33:27 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Hao Luo <m202171776@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe
Date:   Mon, 12 Jun 2023 12:32:39 +0300
Message-Id: <168656228139.662397.489177987320185162.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411015107.2645-1-m202171776@hust.edu.cn>
References: <20230411015107.2645-1-m202171776@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2023 09:51:07 +0800, Hao Luo wrote:
> Use devm_of_iomap() instead of of_iomap() to automatically handle
> the unused ioremap region.
> 
> If any error occurs, regions allocated by kzalloc() will leak,
> but using devm_kzalloc() instead will automatically free the memory
> using devm_kfree().
> 
> [...]

Applied, thanks!

[1/1] clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe
      commit: 188d070de9132667956f5aadd98d2bd87d3eac89

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
