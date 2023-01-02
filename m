Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF61F65B3BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjABPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjABPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:05:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B665D9;
        Mon,  2 Jan 2023 07:05:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F0060C3D;
        Mon,  2 Jan 2023 15:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605C4C433EF;
        Mon,  2 Jan 2023 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672671942;
        bh=3ZiIkfUIAE9Vkh9OW78BgI9MqwvdnLBCZLjlGknuWf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJzpA2ikSS1PkP2mpwYDkTA/D6IF9EzwDGUt+TYc8ThFildKKda6v/OVhTN84JWr3
         wVLajCJv6cD5RycJo1IxBgCeMrQGqWzkdnZqHdQ+lyYf0UyaOhGo+uG6dO4N1lURwi
         dBjLsALCVMFyUOYQ4mUyxj5uUUaVoxOzs3PKS++BK1qsCEoD1d3MOFtbS+ncotp5tj
         we0Yfso57mlHSLw3NQChMSk08c27kzajNKZJGqRnlwsO9YNcRmxHMdhoFTkiTks2jS
         CKvw01g3NZUKMnFz92SI4Lx3EQGdpgDPzMl9tZMBvcCcvePq+OlILCJ8SIMy911h7h
         eyD58QP2XTvXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMNz-0007l4-KK; Mon, 02 Jan 2023 16:05:59 +0100
Date:   Mon, 2 Jan 2023 16:05:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Message-ID: <Y7Ly1wlft4Y6VfIG@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
 <c2a32bd3-90cf-6d1b-1ca7-76071232c81b@linaro.org>
 <791c0e37-f825-c324-7a99-163b0566c758@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791c0e37-f825-c324-7a99-163b0566c758@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:24:34PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 13:23, Krzysztof Kozlowski wrote:
> > On 02/01/2023 11:50, Johan Hovold wrote:
> >> The wcd938x codec is not a memory-mapped device and does not belong
> >> under the soc node.
> >>
> >> Move the node to the root node to avoid DT validation failures.
> >>
> >> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
> >>  1 file changed, 25 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >> index 4de3e1f1c39c..217b2c654745 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >> @@ -17,6 +17,31 @@ aliases {
> >>  		serial0 = &uart7;
> >>  	};
> >>  
> >> +	wcd938x: codec {
> > 
> > Let's call it audio-codec and put it somewhere ordered alphabetically.
> > This avoids useless reshuffles immediately. Moving things back and forth
> > does not make sense.
> 
> Eh, on the other hand SM8250-MTP uses name codec so maybe the rename in
> SC8280xp should be dropped.

Nah, let's go with audio-codec. Your MTP change hasn't been merged yet
so we can still drop or respin that one.

Johan
