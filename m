Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8E692A30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjBJWcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjBJWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:32:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16284B746;
        Fri, 10 Feb 2023 14:32:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 731DBB82607;
        Fri, 10 Feb 2023 22:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383E8C433EF;
        Fri, 10 Feb 2023 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068338;
        bh=2NQDPgACS8xj+77ibaZP4zKWlf6IXR9HA3KiWyN/oTg=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=lMS8aROoD3ffESkMofzGNmAthSTy++eZx24c9pCK/JVHbO3UWpZHKbKxgFVBDONOP
         8nahBhN0obUkvQr83CgdQqeG6rUpruk6gMHexwuMguo6wsG1V1KmxVZBALUsXsvKLD
         0XWmuS5U+tPmNZJDoRhfBzAMvcK7lg5kWeOaIR7cbO4etlNZTDu7e0tDIulAny6oz+
         RtpTYP7VoFpfuy3OYY944CEU94K3fLDoTbZPVO41NWpCj7ZSScc0OO4G0zXQCiI7s6
         CUAPRpCjRzzFy6+riLxkXBkEsvRUo15X3G1NE4vdigte0zggGBGsGpv42fS6HL1cJG
         l55AEeCq+J4rw==
Message-ID: <350b296b62a982f83e273f0f385f2b6f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bced492e-08f3-90d9-4ca0-41ab0e4cca9d@linaro.org>
References: <20230123094925.54824-1-krzysztof.kozlowski@linaro.org> <20230123094925.54824-2-krzysztof.kozlowski@linaro.org> <7ddf5c74de84c5dc291996423cb1eb46.sboyd@kernel.org> <febd59ed-ff7b-ffc4-5568-d856703c9123@linaro.org> <9367139a425dc7e4811c757b62f33a4e.sboyd@kernel.org> <bced492e-08f3-90d9-4ca0-41ab0e4cca9d@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: restrict drivers per ARM/ARM64
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 10 Feb 2023 14:32:14 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-31 23:12:53)
> On 31/01/2023 00:30, Stephen Boyd wrote:
> > Quoting Krzysztof Kozlowski (2023-01-26 01:31:55)
> >> On 25/01/2023 21:44, Stephen Boyd wrote:
> >>> Quoting Krzysztof Kozlowski (2023-01-23 01:49:25)
> >>>> There is no point to allow selecting pin-controller drivers for Qual=
comm
> >>>
> >>> pin controllers?
> >>
> >> Copy-paste, I'll fix it.
> >>
> >>>
> >>>> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> >>>> kernel configuration more difficult as many do not remember the Qual=
comm
> >>>> SoCs model names/numbers.  There won't be a single image for ARMv7 a=
nd
> >>>> ARMv8/9 SoCs, so no features/options are lost.
> >>>
> >>> Are the drivers used in arm32 emulation mode on these SoCs? I recall
> >>> there are some SoCs they run with the arm architecture.
> >>
> >> I did not add it to the few SoCs which have upstream DTS in ARM and
> >> ARM64. I added only to the ones which are in one specific folder. Also
> >> my patch does not affect defconfigs (qcom_defconfig and arm64/defconfi=
g).
> >=20
> > Cool, thanks for checking. Is it possible to take a dtb from arm64 dts
> > directory and boot it on an armv8 CPU running in 32-bit mode? Just
> > wondering if even having the dts file exist in the arm64 architecture
> > really matters here.
>=20
> If DTSI (and/or board DTS) is in arm64, you still need DTS or a link in
> arm directory. If such one is added, then the restrictions here can be
> removed. Have in mind that I did the same already for pinctrl.
>=20

I'm saying that you put the dts file in arch/arm64/boot/dts/, compile
the dts to a dtb and stick it on a board that boots the kernel in arm32
mode. If it is possible to boot the dtb on a CPU running in arm32 mode
then this restriction should be loosened to=20

	depends on ARM || ARM64 || COMPILE_TEST
