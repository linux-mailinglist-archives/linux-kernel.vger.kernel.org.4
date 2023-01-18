Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DA76727E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjARTLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARTLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:11:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17745530C1;
        Wed, 18 Jan 2023 11:11:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70BF619C5;
        Wed, 18 Jan 2023 19:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA584C433D2;
        Wed, 18 Jan 2023 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674069063;
        bh=Nv6pusw6gTldht2J9OiYqivb3O/jn9kff9e+OmktbW4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=QAnoE0mc1tZha037fZcCzUut7YSpS9BilUeV3MFKvRJh96egg16FLHt9D3+i6jnll
         syOsfEFxjxciz+6QD5QvATeb+A+py+oHRDPYuqDnGwbb3MKoMRA6i1WmtsvpHdRcFt
         eJI8prfVRmw+bkzWNbCz6XW/Mf/bsu13HLuR55xpBuBKC2Pyr6AY+bfV07E5EB4Xku
         pZVkP7DSH9GdU+CKBbgu+voj3YlUnugTlf0gwwLxEtJuIpA49NDBTrgoVQnhnGs2x5
         hsS5AClCbp2W8Uj829mXBscL0tqb7JNYMIgmW1h0aJPNzxJGx5yBBjJG3UfMFdCVpR
         1gST9rBagNXaA==
Message-ID: <705c78c1d0da18089419b064832d5fed.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <063c5516-417d-7c21-b58f-a6552779a621@linaro.org>
References: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org> <e73ad320fafa1365e3506bbd4cc77d8d.sboyd@kernel.org> <063c5516-417d-7c21-b58f-a6552779a621@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Jan 2023 11:11:00 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-15 06:35:23)
> On 13/01/2023 21:28, Stephen Boyd wrote:
> > Quoting Krzysztof Kozlowski (2023-01-13 06:58:59)
> >> The CPU PLL clock node does not use OPP tables (neither driver).
> >=20
> > What device is qcom_a53pll_get_freq_tbl() operating on?
>=20
> On its own, internal table. While of course driver could be converted to
> operating-points-v2, no one did it within last 5 years, so why it should
> happen now?
>=20

The property was added mid 2021 by Shawn[1], that's not 5 years ago. I
guess there were plans to add an OPP table that never happened[2]? Is
Shawn still working on this? If not, we should revert the OPP code out
of the driver.

[1] https://lore.kernel.org/all/20210704024032.11559-4-shawn.guo@linaro.org/
[2] https://lore.kernel.org/all/20210709021334.GB11342@dragon/
