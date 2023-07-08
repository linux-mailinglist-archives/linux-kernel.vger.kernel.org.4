Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B433774BA69
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjGHAGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGHAG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:06:28 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7532123;
        Fri,  7 Jul 2023 17:06:27 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b74e2d8c98so2257875a34.2;
        Fri, 07 Jul 2023 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774786; x=1691366786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxQ9ORFt2KalpWVPLln/XeJlZQtOLOl2gBwuEluzJqk=;
        b=ih/x/XN1N1IP8D9qyTD4drevI8/8TWIA770S5KgG7qcDE+qdzprHBGX1oqGrMEt8ZE
         JSzTfGSyBRGn/OstUnawSgSa1XXD72WLa+Dl9Sga4r+/JatWMLX8SXMm3kCyU7Gw+SGw
         owjWuWQFTxD8MpGyTsq0eQAgCXIqQyaes6pnO+bfKVCGci+i6xgyKrTivQVrNNepFXFZ
         UwfvnbYB+CkbjCrKUG73gZ0DiRxGen+8CRlj7E9wL8ivurWIq8Ku6yhfYPlA1aLABlRE
         ZeaO3iAdnRFmUbCQk9CMSNK86ZtoCRdeHAv1ST2Xu2croQBTb1cROTaJBEVTaYVHuwBy
         L7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774786; x=1691366786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxQ9ORFt2KalpWVPLln/XeJlZQtOLOl2gBwuEluzJqk=;
        b=F0UOQUctJ3cZcNVluwYrcYGRmxwEG9OK79h4sS2g/NaXN/61S9t+b9difaS2UBa6ri
         K8PsNr2dl+RpIHVaPVjUTAPMTKS7pq5ocZvXruMqo1RdP+i2y64vku86e04hWpVni4vq
         MKEKELF6w/jkB7S6u7hnVo/mYFMZdUy2+/ZSfVdoSVC+92LXY2oVrIzedEVHiurFEJE/
         jYqTz+Wr8dMBDCvlvI82C6JpenNZKBE63hlzhChX8VlBDWW8mQQMl7oyzBYaLg3k7Lxr
         PBxZ00V8tA+/xavkXRx8UEzT2c4zbQoemBoWH6MwPTPvHyZN/w1f1VZoVqRdOlkxuDM6
         8DdQ==
X-Gm-Message-State: ABy/qLbbaGXsVPWgz8b1MQJXcsQBDDplS/tfrei6CQGuBr2VaB7jbBGW
        d9uz2P8HWDxCGo3Y1H1SKewu1cUjRL4=
X-Google-Smtp-Source: APBJJlH+LJYi6W8fj+k19PKYvMadG7yFuvSejenF+WQtpYGeIrYZwfvXgtsbMl+ZRQ2wzQ5k5TzNUQ==
X-Received: by 2002:a05:6870:a68f:b0:1b3:e896:9bfa with SMTP id i15-20020a056870a68f00b001b3e8969bfamr8470718oam.25.1688774786484;
        Fri, 07 Jul 2023 17:06:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:38de:2bd4:8f55:60cd])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b66a71a4a0sm3805403plx.32.2023.07.07.17.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:06:26 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:06:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dt-bindings: input: touchscreen: edt-ft5x06: Add
 'threshold' property
Message-ID: <ZKiofhzbBD2hIzmv@google.com>
References: <20230621093245.78130-1-o.rempel@pengutronix.de>
 <20230621093245.78130-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621093245.78130-6-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:32:45AM +0200, Oleksij Rempel wrote:
> Add a new property 'threshold' to the edt-ft5x06 touchscreen binding.
> This property allows setting the "click"-threshold in the range from 0
> to 255. This change addresses the following dtbs_check warning:
> imx6dl-lanmcu.dtb: touchscreen@38: 'threshold' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
