Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38BC6BF099
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCQSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCQSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:21:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73335F52F;
        Fri, 17 Mar 2023 11:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96271B82692;
        Fri, 17 Mar 2023 18:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4DAC433EF;
        Fri, 17 Mar 2023 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679077258;
        bh=AxXX2L5I74yqWWOgqH5b2dx2xWaIQUEl63ihhnOAsLQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nFMxkd78YIY121JTXMYkvS9+GA54+9LI1oUkpJRUyU9GZsxggVp8ayJieN7+zzTNG
         bxum8mX2qh5YALw0a0Uqbzuu/EiXwSinDVmfqt0FbJbVlUbgLOBaAaviA3eeb9jmJJ
         CuStonQBHAHekhjLgvf77TLOPg98zuhm+FpPW3ig/JZ5L4Pzymh9QauXAO4Dksg2X/
         nF1Bv0wmT+/Jdl/2OHvD4BMY1fRm5b0SVVXupI4ayHHYPjX3+lUuiBOcyo1YFJcNiZ
         8JtAiVSla+ciqSSCTNYZHOHzk32vA7Idw/HK2qrDG2CFw1n1BhAFOEy6BpTkQx1Kq8
         Rmrstysp2XlwA==
Message-ID: <5601e0edc19dc03d0fc516f9ffe4d1aa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <62533d5a-f39a-0806-b4d9-932e2af6beef@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org> <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org> <20230316225803.GA4036689-robh@kernel.org> <62533d5a-f39a-0806-b4d9-932e2af6beef@linaro.org>
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock cleanup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Date:   Fri, 17 Mar 2023 11:20:56 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-03-16 17:31:34)
>=20
> On 16.03.2023 23:58, Rob Herring wrote:
> > On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
> >> =20
> >> +  qcom,clk-disable-unused:
> >> +    type: boolean
> >> +    description:
> >> +      Indicates whether unused RPM clocks can be shut down with the c=
ommon
> >> +      unused clock cleanup. Requires a functional interconnect driver.
> >=20
> > I don't think this should be QCom specific. Come up with something=20
> > common (which will probably have some debate).=20
> Generally the opposite (ignoring unused clocks during the cleanup) is
> the thing you need to opt into.
>=20
> I can however see how (especially with the focus on not breaking things
> for older DTs) somebody else may also decide to only allow them to be
> cleaned up conditionally (by marking the clocks that were enabled earlier
> as enabled in Linux OR not addding clk.flags |=3D CLK_IGNORE_UNUSED) as we
> do here.
>=20
> Stephen, Rob, would `clk-disable-unused` be a fitting generic property
> name for that? Should we also think about `clk-ignore-unused` as a
> clock-controller-specific alternative to the CCF-wide clk_ignore_unused
> cmdline?
>=20

There are multiple threads on the list about disabling unused clks.
Moving the decision to disable unused clks to a DT property is yet
another approach. I'd rather not do that, because it really isn't
describing the hardware configuration. If anything, I'd expect the
property to be describing which clks are enabled by the firmware and
then leave the decision to disable them because they're unused up to the
software.
