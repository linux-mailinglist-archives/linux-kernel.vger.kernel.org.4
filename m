Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559A465B3B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjABPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbjABPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:03:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407669FE7;
        Mon,  2 Jan 2023 07:03:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D47B260C3D;
        Mon,  2 Jan 2023 15:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3248EC433D2;
        Mon,  2 Jan 2023 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672671792;
        bh=ixEErj1PmOp79p6hqvocUDN/0XEUzSbRiIdOFnrZi8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R453quSS5C9cujJbZQJqlYFQ5QKc3774J4n+1YYUVz3WO5lW0rgfpQcECHS03uZud
         YzHbsdh3Pb9cmFzWunC0/2DS0Ac4jSeZX59lAz1jR4YFgIr5uT3bdzzF+XDd8bBu1O
         8/xSPINePRsSPF7Gs9tQiG65seiqdsFI4GVSFQsKiS4N3B4bK+Lc31ZVoxrKT/j9tj
         2T8aUu+vUN1amgbsExlNt6ASvdWDtyGma2C9s3uwZ3eRPJPwzhNFa5kHv0k2s07KPT
         8jwZuR3sTqswBC0+3PlI69HALymgCP9Fv5SrptCcX9wzJrcW87gTPGt1ovlcw3SbXF
         I+IlVQO9br32g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMLZ-0007if-9F; Mon, 02 Jan 2023 16:03:29 +0100
Date:   Mon, 2 Jan 2023 16:03:29 +0100
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
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
Message-ID: <Y7LyQZ6FotC5Rpmg@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-6-johan+linaro@kernel.org>
 <1a8226ef-b16c-e713-94bd-807ca356ef8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8226ef-b16c-e713-94bd-807ca356ef8b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:20:03PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 11:50, Johan Hovold wrote:
> > The wcd938x codec is not a memory-mapped device and does not belong
> > under the soc node.
> > 
> > Move the node to the root node to avoid DT validation failures.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> Don't you base on some older tree? It was alreadt moved. Maybe other
> changes were also implemented...

If you've moved this node is hasn't made it into linux-next (or the qcom
tree) yet.

Johan
