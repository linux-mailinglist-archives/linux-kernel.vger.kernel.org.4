Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12B474CB93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGJFEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGJFE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8A612A;
        Sun,  9 Jul 2023 22:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2954F60DE5;
        Mon, 10 Jul 2023 05:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22E8C43391;
        Mon, 10 Jul 2023 05:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965464;
        bh=ni2upZI8kEppFCVo7r7vCrGM7+j/rJ5swOEAL7zFOGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbSs0uPa/EZyfZfDToS3gWqbV24BkP6Qnrv1A7zmbv7MxznqsPcbi3jFE0j9Pf5G+
         qTB5EKYIhI9+jLkeh/ZzKG3CrKkOnOgXUWtgWMGv5YZBVPk2DNYEyWnTRRjcvnGeXy
         tpU4akA4a/DBlpy+nREbs83gxMU43vGS386QlK/LSfoN1aA+ZPZUJU3Y7voB6YCjGJ
         wtGqCDDoR2QQUMGwXztU2VgHlM2j2likFMvCh/X6N+dLhqg6dBQgwxQbTeds5rNWho
         SmFaZTx0l4gqAbAhkbR98SmYP4vQ9sWxxbiAbwyW6uDwlD4r/JyrREuS4HPm8yC3dS
         0u/Qu3ESaDV3A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-serranove: Add RT5033 PMIC with charger
Date:   Sun,  9 Jul 2023 22:07:08 -0700
Message-ID: <168896565963.1376307.362293397029491245.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619203743.8136-1-jahau@rocketmail.com>
References: <20230619203743.8136-1-jahau.ref@rocketmail.com> <20230619203743.8136-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2023 22:37:43 +0200, Jakob Hauser wrote:
> For the regulators, apply the same settings as in the downstream
> devicetree [1], including the "regulator-always-on" for the SAFE_LDO.
> For the voltage of SAFE_LDO, however, there is only one voltage of 4.9 V
> available in the mainline driver [2][3].
> 
> The values of the battery data evolve from following sources:
> - precharge current: 450 mA corresponds to the default value of the chip. It
>   doesn't get changed by the downstream Android driver. Therefore let's stick
>   to this value.
> - constant charge current: The 1000 mA are taken from the downstream devicetree
>   of the serranove battery. It's not easy to spot. The value is in the line
>   "input_current_limit" [4]. The rows are according to the power supply type,
>   the 4th value stands for "main supply" [5]. That's the value used by the
>   Android driver when a charging cable is plugged into the device.
> - charge termination current: In the downstream devicetree of the battery
>   that's the line "full_check_current_1st", which contains the 150 mA [6].
> - precharge voltage: This one doesn't get set in the downstream Android driver.
>   The chip's default is 2.8 V. That seemed too low to have a notable effect of
>   handling the battery gentle. The chosen value of 3.5 V is a bit arbitrary
>   and possibly rather high. As the device is already several years old and
>   therefore most batteries too, a value on the safe side seems reasonable.
> - constant charge voltage: The value of 4.35 V is set in the line
>   "chg_float_voltage" of the downstream battery devicetree [7].
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-serranove: Add RT5033 PMIC with charger
      commit: 404d7f65767dde3a0eb3d6127b458b61ed7d7118

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
