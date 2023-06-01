Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7871F168
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjFASLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjFASLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:11:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C91123;
        Thu,  1 Jun 2023 11:11:31 -0700 (PDT)
Received: from arisu.localnet (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E6716606ED0;
        Thu,  1 Jun 2023 19:11:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685643090;
        bh=/1UK6RJyERSL17sN+JVrhQMGuFCZnyl/wmrhoctEEII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULWjjXJmbpkeISxN30WBA+kbSwotG3y7xIVx0GiEsYCmWZh15YDzICoB6EksT+VT3
         w8idCG16fqul6WxKbdRyNN1wGfyYV94rKJhNhuUyMbW+RDH/9kujdBEpW2KYOPJlL2
         dBZ4ETK/cU0nhPgzgf+BJVwMA7G5p5hAqgfQNY2pxvEXgxZrSqBGF+klCku897npdd
         Uh7tIfqVi95tLdqWmp0e2BVNEs5TsJYahiB8t+KE0kxnmMAjIMqIjNEPmpdWHamAky
         I8SyfJ4nq+uRSNNOP92X5CCR+PLSYBxlak6mf7D4vE/pNTxHlyHLsV03xa3eFN2Baa
         rQtik76BhF+ew==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: phy: Support external PHY xtal
Date:   Thu, 01 Jun 2023 14:11:31 -0400
Message-ID: <2686795.mvXUDI8C0e@arisu>
In-Reply-To: <5f5f6412-f466-9a3f-3ec7-aa45ab0049c6@linaro.org>
References: <20230531150340.522994-1-detlev.casanova@collabora.com>
 <6646604.lOV4Wx5bFT@arisu> <5f5f6412-f466-9a3f-3ec7-aa45ab0049c6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 1, 2023 12:52:18 P.M. EDT Krzysztof Kozlowski wrote:
> On 31/05/2023 20:00, Detlev Casanova wrote:
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: xtal
> >> 
> >> I don't think xtal is the best of names here. It generally is used as
> >> an abbreviation for crystal. And the commit message is about there not
> >> being a crystal, but an actual clock.
> >> 
> >> How is this clock named on the datasheet?
> > 
> > In the case of the PHY I used (RTL8211F), it is EXT_CLK. But this must be
> > generic to any (ethernet) PHY, so using ext_clk to match it would not be
> > good either.
> > 
> > Now this is about having an external clock, so the ext_clk name makes
> > sense in this case.
> > 
> > I'm not pushing one name or another, let's use what you feel is more
> > natural.
> Just drop the name.

So I can just use devm_clk_get_optional_enabled(dev, NULL) and I'll get the 
first clock defines in the device tree ?

Detlev.



