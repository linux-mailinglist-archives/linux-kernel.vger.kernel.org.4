Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D1706800
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjEQMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjEQMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:23:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A23C03
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:23:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so1279042a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684326227; x=1686918227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA6gqqg7VsSOlrzSY0fplomac16MO4m/OUxGHMUrEn8=;
        b=YMBnZJIg35A1B1GTWe8LhYlzT/LOxu20MCzLFBgHhOswqLlw3uMyTSUrWvyn7zCLC8
         syvGDIEanQ5n5GHTKZ4gqiKBeUxCCHFQUahbxbla26a+nurlNNHLfAbzaGzyFGdh/rdl
         NJRAsQmQiUb1SeNGnfWxL9UETxaqhODBDnhzz3XbrDygz9xa8zbpg3eUvTAXVIH2R5Wk
         NdDe/6qfYhDbWsC2lPH1K4EobZy0TfYsixqsRF2LxFrDOVEXPdftp3repyVa2GjeLtzu
         Ww1kDUkdmAVNkNY6SbJ9gM9yId4YRrFyZBwC/S3FC6DA4JpKUF6Ub8DXyTfrwQWCbhAv
         THJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326227; x=1686918227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA6gqqg7VsSOlrzSY0fplomac16MO4m/OUxGHMUrEn8=;
        b=fLdC2QLbDuJS9TmKsTgH/cDrAy7WQy8/oRj79X/wmOHJtpfOy3U/HERzs1xC0SvrGv
         sao/fnMABSEr7DwGuUy4JIWpE+zMDiBQmvATJuD2n2YLteieF4U6xcHad9UWY2xbglpV
         JQywRHT4fDO/kHAkwOKIg5q7GyPm2r9gYD7RVk07VcxedRTjO6pNFc/xN4GAcs/vgxmM
         SlF3bB/i5QHTkPVXi7VNnvdKC0l+GNnVgWPHaWLx+6V6sYZmjzNimdRrmXBeaMdiV/Mz
         eWQxQTkxtM4JTbEZ7MeJ8Gm6NPZdpglpd77yUQtHhIrhb9pYuJ1SQS4hTyQvEbzrk0DH
         2uww==
X-Gm-Message-State: AC+VfDxtrYhb4QZvKpCMGneBdkNavr3Z8jUH14XlaNu/A9JzX9rYM6Bt
        NrzUFULTzu7xfr5/1DeqNZurUw==
X-Google-Smtp-Source: ACHHUZ7ZE8VVkUbrRdQvJOOf5Y0qLJrv9egXM2gFQmNhinP7JeNwvJyttB2ybh44E2+UNes2t7hqBg==
X-Received: by 2002:aa7:c1cd:0:b0:506:8dba:bd71 with SMTP id d13-20020aa7c1cd000000b005068dbabd71mr2345396edp.27.1684326227183;
        Wed, 17 May 2023 05:23:47 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id p3-20020aa7d303000000b0050e01a965a3sm6495480edq.5.2023.05.17.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:23:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: (subset) [PATCH v3 4/6] arm64: dts: sparx5: rename pinctrl nodes
Date:   Wed, 17 May 2023 14:23:40 +0200
Message-Id: <168432619061.440504.10986193205480323774.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220319204628.1759635-5-michael@walle.cc>
References: <20220319204628.1759635-1-michael@walle.cc> <20220319204628.1759635-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Mar 2022 21:46:26 +0100, Michael Walle wrote:
> The pinctrl device tree binding will be converted to YAML format. Rename
> the pin nodes so they end with "-pins" to match the schema.
> 
> 

Applied, thanks!

[4/6] arm64: dts: sparx5: rename pinctrl nodes
      https://git.kernel.org/krzk/linux-dt/c/d5e64404e77c19ec5bd687b34a11eec0263f1aa8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
