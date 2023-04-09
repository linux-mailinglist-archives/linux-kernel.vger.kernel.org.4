Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720BB6DC01A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDINmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDINmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:42:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0035BC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:42:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id xi5so6975191ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681047757; x=1683639757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi8/kfsTn/+Uba/9WSvWrlRqaprQizpPou38595DRXM=;
        b=I+Df6fnu1Uhgtk1PT3XN5s6Kd+e0QR2hLBcCgSm/5rh6p4FIRlcL0JON+QJsNeR5Ic
         0NDAMN3AxKlyrqbdK2LKiG4IEsH6+g4dpVUcBcDG5YT7mF7kxgho7GSiObtU/YBEX9MX
         fwCGgfZK4GL/8SmuQ9QZdlBt7/L1irRct5C1CN+tgIAzUdGSrl16tyRcoDVndiqnK6XK
         O9W4axhdAkCXDMllNlO/PFrC+MZezIYXsz8n1sNEXVJOx96HawjDmzMDB42AGdvlltJU
         fpcVrbAaFW7KxYWjPeg3IztE8CIVmZf4Pb2I/tg7t/3WMgr3w8xxhFYY4dfEsHWFONM3
         1fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681047757; x=1683639757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zi8/kfsTn/+Uba/9WSvWrlRqaprQizpPou38595DRXM=;
        b=UcLJVOpBXeDlkxnSqHKGGKK0VZwaDJ9U2UfvDl5bZlYdxo6+ypIWX3bJ3BFsznoES3
         WnyA9gC+01RLqSDoYWKChILUt2jIGkwCO04VeNfVYRKb1t7GwqVMYoEfky7u8xTn89pU
         dyXBAJRK7qAx5FwmCW6PpIvY9OvWKKRh1fOo8R0t3JqLI6RtsCVdF+3Lcuc4omvoTyk+
         iw5tuzz3kvjgH80dZ84oxM441uzxFgndx2QYp2RatjAs/hXjKaGf0BP5z7Iu37hCil0y
         yLxxQVra9jySXcgvwmb16vb/DUs1RpzvmzfD5AnY16bE9MHUIkmb1Ydj1Wufc1+31evw
         jowQ==
X-Gm-Message-State: AAQBX9fc5T6lVhHVM5CoQpBN4Q28DtCvgVRjxhA1ZUWXANZd9AUjNdJS
        eBV61RzQjb9zSSn4UzXvvtc42g==
X-Google-Smtp-Source: AKy350aywhB/tiv1FR8o/tlA0hD92qcTZOlcsVIxuiFZ3p5CHzxHFWUv1Z/UQNwceuUaM7KqRlqIHQ==
X-Received: by 2002:a17:906:f2c1:b0:930:e495:b1cb with SMTP id gz1-20020a170906f2c100b00930e495b1cbmr5162251ejb.75.1681047757646;
        Sun, 09 Apr 2023 06:42:37 -0700 (PDT)
Received: from localhost.localdomain ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id wy6-20020a170906fe0600b009231714b3d4sm4140369ejb.151.2023.04.09.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:42:37 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/4] clk: imx: imx8mp: correct DISP2 pixel clock type
Date:   Sun,  9 Apr 2023 16:42:16 +0300
Message-Id: <168104762882.1272315.4894486142728322128.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
References: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 17:46:30 +0800, Peng Fan (OSS) wrote:
> The MEDIA_DISP2_CLK_ROOT use ccm_ahb_channel, it is bus type.
> 
> 

Applied, thanks!

[1/4] clk: imx: imx8mp: correct DISP2 pixel clock type
      commit: 3ea7c4c907119eb369d6b4cdec22af0434eb5304
[2/4] dt-bindings: clock: imx8mp: Add LDB clock entry
      commit: 79643567cc34ebd0743f4da3ac8f853e26202453
[3/4] clk: imx: imx8mp: Add LDB root clock
      commit: 82afc344d795cb467a646a2873573298162f01b9
[4/4] clk: imx: imx8mp: change the 'nand_usdhc_bus' clock to non-critical
      commit: 7875ee29f877dc76dae2d04648b95811f6a05b41

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
