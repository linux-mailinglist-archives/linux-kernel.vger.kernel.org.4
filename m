Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B4960B0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiJXQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiJXQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:04:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E82DE0;
        Mon, 24 Oct 2022 07:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D4C1B81B44;
        Mon, 24 Oct 2022 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A17AC43470;
        Mon, 24 Oct 2022 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666618707;
        bh=I4FTtsDnU0ezaEay34oD3KMJKI9F4/bPpdTPGpE8do0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cV2AmzVatMWxWwoE+eVdEHmWI9NUojM5cEYwEOf+Tb0k20YLHrzOrDSPYvD25GPyM
         V6KWZu9hVeDknIZipT4kzJL3NpoF35cPB2Qs5PTKFcaTf2pMPvawsw8qUQTzLvRvQ7
         H+fHN5LLDHjHSqSR14M8dEwa3Y499ajj2WNdi1SgWU3TUJoDQhRkPWUxG1EGPPUdoQ
         vzeZR9frETE2p6kK+mt5QYwFUX148t4CdeiyGATCKZvOYVcaLmj0mXyN6n/rpCxGGc
         Vq6SWAcvbyFjyv4zNTZEaOEe+V3O1ZRETuOZLpdyDMNKt6pXqII44OlV5GdOeXoSH3
         jPPB4qYrMyaDQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1omxec-0008Ro-LS; Mon, 24 Oct 2022 15:38:10 +0200
Date:   Mon, 24 Oct 2022 15:38:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] phy: qcom-qmp-usb: add support for updated
 sc8280xp binding
Message-ID: <Y1aVQsKpBL7Dlt1j@hovoldconsulting.com>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
 <20221024100632.20549-14-johan+linaro@kernel.org>
 <2f758573-c901-25a5-c4fb-8dc2f72b42bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f758573-c901-25a5-c4fb-8dc2f72b42bf@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:35:25PM +0300, Dmitry Baryshkov wrote:
> On 24/10/2022 13:06, Johan Hovold wrote:
> > Add support for the new SC8280XP binding.
> > 
> > Note that the binding does not try to describe every register subregion
> > and instead the driver holds the corresponding offsets. This includes
> > the PCS_USB region which was initially overlooked.
> > 
> > Note that the driver will no longer accept the old binding due to the
> > fixed "phy_phy" reset name.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 82 ++++++++++++++++++++-----
> >   1 file changed, 67 insertions(+), 15 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks for reviewing, Dmitry!

Johan
