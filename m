Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAE60071D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJQG4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJQG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA257BD5;
        Sun, 16 Oct 2022 23:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A53F60F31;
        Mon, 17 Oct 2022 06:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1097C433D7;
        Mon, 17 Oct 2022 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989719;
        bh=PNnJGOyQxGlF6kxJP9vN4ecaF/KlHCOIeam3mAgZbNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3kxCqOZfArXCq6cer8xlXYc+oB2CcUQ71hSXKx4Osyc5icd+QXlsO4ZfjN7R/Zou
         yyfuY9PGYzZkuVlRYAy2PtPB+QmmxFsdRUFnaYo2XehR3DEzxddcOv1dH3DrINlz3G
         ZoRKWSEj+havq+Ohwxz/o5worCL8zUwy17vLKUY7S2ih0tcvQ5/Hn7+sDLv0i7iHhw
         sG6PgMzZy28BLPgnmDrcDZlzwLaeeFzUb9C/eMTMH+qKvsrAkBOFkBcmPRJz0VwOmF
         2nlx5b3sgXM7a4DmLlVhzZ3oIrs7PKA3vWDBaj1rJd1S9Jg3gWpyF2aps71l9ekWJh
         fMab9kAqwjTBA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okK1l-0005CX-2V; Mon, 17 Oct 2022 08:55:09 +0200
Date:   Mon, 17 Oct 2022 08:55:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/20] phy: qcom-qmp-combo: clean up status polling
Message-ID: <Y0z8TWt/AA4Oh9ww@hovoldconsulting.com>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-8-johan+linaro@kernel.org>
 <ca4eef6a-dedd-1823-9525-67d695ac3e58@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca4eef6a-dedd-1823-9525-67d695ac3e58@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 12:14:17AM +0300, Dmitry Baryshkov wrote:
> On 12/10/2022 11:49, Johan Hovold wrote:
> > Clean up the PHY status polling by dropping the configuration mask which
> > is no longer needed since the QMP driver split.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> This comes in expectation that 4.20 / 5.20 PHYs will be limited to PCIe. 
> I'd add this to the commit message.

I don't think that's needed. The commit message is correct as it stands,
and the fact that we may need to change code in case we add support for
new devices that may need it is quite natural.

Also note that the vendor drivers (5.4) only have such a provision for
PCIe PHYs and not for the combo and USB PHY drivers.

> With that fixed:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan
