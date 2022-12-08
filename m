Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA9646C70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLHKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:09:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0450FD19;
        Thu,  8 Dec 2022 02:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BAF461E5A;
        Thu,  8 Dec 2022 10:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB6C433D6;
        Thu,  8 Dec 2022 10:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494168;
        bh=pdHuBW2vgVkBR1zSw6UMnFvXwScyE1N5Uf4fEZpGo8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXFisoLykZoKbJlVpVttqTBOuqb9Mr5OrYjDriTOzcmsFUFDS7ObXQZCWgT7LT9wP
         gy3D4d/xT08bysWegGeXGzG8eL31sQo/urFHN9BuLD/ZVRH04FzJgZW5C4yMczWWO1
         xYyILlibuakLQXKm6Nn7uFYohFPHA6rcqjXvfqxfybqvsO0usdz5MedXaC9p4hdL5s
         VdrFW4Bsk8T3AqCDhwQvZBtLCcFpYDUpTj5tuAWIzL1WuaDmiAd1SMGG2ILXw56tx/
         BTHz/ehGuSdqkOgR6gLyYVaJJz/dfu1Fgoz8reT90QIV74Jj0x+nsr2MQQzSFMpqP9
         b2//QdHMHFGcA==
Date:   Thu, 8 Dec 2022 10:09:22 +0000
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <Y5G30ttrf1RJa+sM@google.com>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <20221202000858.GA1737135-robh@kernel.org>
 <Y5Dzamz6XRZudQzq@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5Dzamz6XRZudQzq@duo.ucw.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Pavel Machek wrote:

> On Thu 2022-12-01 18:08:58, Rob Herring wrote:
> > On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
> > > Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
> > >  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
> > >  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
> > >  3 files changed, 61 insertions(+), 67 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
> > >  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Or should I apply it?
> 
> Thanks for ACK, let me take it, I guess.

Did you see Krzysztof's replies to this patch?

Sounded like he was going to re-work it, which is why I left it.

-- 
Lee Jones [李琼斯]
