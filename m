Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53E85FB3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJKNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJKNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FDE7C742;
        Tue, 11 Oct 2022 06:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2197861123;
        Tue, 11 Oct 2022 13:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBBDC433D6;
        Tue, 11 Oct 2022 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665496406;
        bh=EINtKE+ZFkOpiRcj5jShXlOH+liwnEAnMQj9W0oJVX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZedtaGSuVaOlqhcBPxFIN27eEettJmZ6fU1Z3yI5pN4IXW6UFYev7+ypWycCeg/+
         F+0EDMO+rg9HKfHuSo4l/hxHCDDi8OKkvpKJOzNT0GX5kTOVsVX06ajSXrFL65kBKm
         yLjLHFXaPK/QYJEF3bOw5wxJyzc/1E7oMwGnpZrIlBObt+zdglbYGu4DTbo13u1Cfb
         XmM+wYHxMCJpbzkyox55Fnmqg6kOqMMv3VbTM1NYlVvby2jXuMnvTB+BNFPEQsqo3m
         IeAixo9n4t5SRUy5vt7DSxkgxK8VHFxgxUYi9iut+uQVKWG47oVnbwdegyauqkDSnP
         DUc8wKuCq889A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oiFh6-0002h8-RF; Tue, 11 Oct 2022 15:53:17 +0200
Date:   Tue, 11 Oct 2022 15:53:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] phy: qcom-qmp-pcie: drop power-down delay config
Message-ID: <Y0V1TIBySTPhYqX/@hovoldconsulting.com>
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-9-johan+linaro@kernel.org>
 <66261491-530d-c368-6cc8-daeef74fcbda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66261491-530d-c368-6cc8-daeef74fcbda@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:46:53PM +0300, Dmitry Baryshkov wrote:
> On 11/10/2022 16:14, Johan Hovold wrote:
> > The power-down delay was included in the first version of the QMP driver
> > as an optional delay after powering on the PHY (using
> > POWER_DOWN_CONTROL) and just before starting it. Later changes modified
> > this sequence by powering on before initialising the PHY, but the
> > optional delay stayed where it was (i.e. before starting the PHY).
> > 
> > The vendor driver does not use a delay before starting the PHY and this
> > is likely not needed on any platform unless there is a corresponding
> > delay in the vendor kernel init sequence tables (i.e. in devicetree).
> > 
> > Let's keep the delay for now, but drop the redundant delay period
> > configuration while increasing the unnecessarily low timer slack
> > somewhat.
> 
> Actually, the vendor driver does this 995..1005 sleep. But contrary to 
> our driver it does that after programming whole PHY init sequence, which 
> includes SW_RESET / START_CTL, but before programming the pipe clocks.

Right, it does it after starting the PHY which means that you don't have
to poll for as long for the PHY status.

It's a different delay entirely.

> I think we can either drop this delay completely, or move it before 
> read_poll_timeout().

It definitely shouldn't be used for any new platforms, but I opted for
the conservative route of keeping it in case some of the older platforms
actually do need it.

My bet is that this is all copy-paste cruft that could be removed, but
I'd rather do that as a separate follow-on change. Perhaps after testing
some more SoC after removing the delay.

SC8280XP certainly doesn't need it.

Johan
