Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABA9681FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjA3XaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjA3XaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4329E10;
        Mon, 30 Jan 2023 15:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA7A612C5;
        Mon, 30 Jan 2023 23:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAC6C433EF;
        Mon, 30 Jan 2023 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675121417;
        bh=Clp5BMnnUdxApbXplgRLMJC/Be26Vp2UYv/I6BzVaiU=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=dn1Ud/wbWS+IurE5VWhFcWLFMBQBK5PHvdozOL6YFBot78UqC+wrFjFE0tGku5oEf
         bGbMBlQFP2/1nD/f81Ve0SenN6TcdJZz8JPzOuWaobyYGplYatarJtTrIpXQg2Yvh7
         scWZsRx49krbXUePwoCfHTZqNcICAPOvdcMRkrzKs69JWf+YpdJiyk96ph9v/qo884
         G+g+zh8QSb3nRUK6mw48LApSSRubLdfZA9gNxN6O0k3PpHUT0tdfImw360nb9C5HAc
         VtEACfmNpZAWBioAxwEX7PVKVJB96SZQNAhdnBVVtwOJ18DDd4fg8CKbCrxcnae1Sz
         YrFeYglp/Oa9w==
Message-ID: <9367139a425dc7e4811c757b62f33a4e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <febd59ed-ff7b-ffc4-5568-d856703c9123@linaro.org>
References: <20230123094925.54824-1-krzysztof.kozlowski@linaro.org> <20230123094925.54824-2-krzysztof.kozlowski@linaro.org> <7ddf5c74de84c5dc291996423cb1eb46.sboyd@kernel.org> <febd59ed-ff7b-ffc4-5568-d856703c9123@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: restrict drivers per ARM/ARM64
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Jan 2023 15:30:15 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-26 01:31:55)
> On 25/01/2023 21:44, Stephen Boyd wrote:
> > Quoting Krzysztof Kozlowski (2023-01-23 01:49:25)
> >> There is no point to allow selecting pin-controller drivers for Qualco=
mm
> >=20
> > pin controllers?
>=20
> Copy-paste, I'll fix it.
>=20
> >=20
> >> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> >> kernel configuration more difficult as many do not remember the Qualco=
mm
> >> SoCs model names/numbers.  There won't be a single image for ARMv7 and
> >> ARMv8/9 SoCs, so no features/options are lost.
> >=20
> > Are the drivers used in arm32 emulation mode on these SoCs? I recall
> > there are some SoCs they run with the arm architecture.
>=20
> I did not add it to the few SoCs which have upstream DTS in ARM and
> ARM64. I added only to the ones which are in one specific folder. Also
> my patch does not affect defconfigs (qcom_defconfig and arm64/defconfig).

Cool, thanks for checking. Is it possible to take a dtb from arm64 dts
directory and boot it on an armv8 CPU running in 32-bit mode? Just
wondering if even having the dts file exist in the arm64 architecture
really matters here.

>=20
> Whether downstream could be affected, I do not know. Anyway, what's
> downstream it's the downstream's problem...
>=20

Agreed. I wasn't asking about downstream.
