Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617F727624
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjFHEg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFHEgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166B91988;
        Wed,  7 Jun 2023 21:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 951326478D;
        Thu,  8 Jun 2023 04:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0E3C433D2;
        Thu,  8 Jun 2023 04:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686198981;
        bh=L/74qyYmuC5m/lS+AJK+0bRD2NenVahTw3pHvJavynU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CjZ2FR/NVSEAmxfxC6it73ZkPHCC0KNq7ODRXgfwkeQnYARfnvcFfnZDHEz4j7iKQ
         N43RK9KGXoYn1ZYCQL4T3jAQS1hUZKZ1+cJEjI1BO2QjXGtR5L2nQQAa3faFE7WHyp
         q6Z+wKRF0odV0nvZzqvl+OkJyHMLTmPblr6uZzBL3+XCEtfn7ara+V3ld95F2Ftyjy
         3nzVsFs72rddqA5Rsn4YQkyUzgSH69OcWbv+Z5mHBaZaildab4JBAZKr4C1JzTJK6F
         G5pPo+j7me2d+h7ODJEwq5pR6eY7hUb9ZI51KZYTyVL7EhXUsb3fZFE4GpJtWVALGJ
         8CzPRrjsZTeTw==
Date:   Wed, 7 Jun 2023 21:36:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Raymond Hackley <raymondhackley@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <20230607213620.4087b0e2@kernel.org>
In-Reply-To: <20230606072454.145106-1-raymondhackley@protonmail.com>
References: <20230606071824.144990-1-raymondhackley@protonmail.com>
        <20230606072454.145106-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 07:25:55 +0000 Raymond Hackley wrote:
> +			if (r != -EPROBE_DEFER)
> +				dev_err(dev,
> +					"Failed to get regulator pvdd: %d\n",
> +					r);
> +			return r;

dev_err_probe() ?

> +	r = devm_add_action_or_reset(dev, nxp_nci_i2c_poweroff, phy);
> +	if (r < 0) {
> +		nfc_err(dev, "Failed to install poweroff handler: %d\n",
> +			r);
> +		nxp_nci_i2c_poweroff(phy);

The _or_reset() stands for "we'll call the action for you if we can't
add it". Don't call poweroff again.
-- 
pw-bot: cr
