Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE056B8C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCNHqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCNHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590CA94F7A;
        Tue, 14 Mar 2023 00:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3E8F6160B;
        Tue, 14 Mar 2023 07:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31865C433D2;
        Tue, 14 Mar 2023 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678779950;
        bh=xYFxSC3248b3wowZpsQSJGM3+Hs59s0ozCkaRtr0i7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaknvJ1Dijgw4p6/pxdtTD1/eFsoePAIj+unNe0bfSPFIFVKJM19sl4Bdb7L0GjD1
         1uY9U1otjheelu+adQe9s2BBcSmO2pzFLNEUbal8juiDK2oLHIbdR3hGQEoNA4ynqn
         Dg9Qt2UdGjnageQfG9tojQRiZFCbcwRvZOCKSPDzhBSzia8OAEp1oE+ls6yf6iFpaV
         l7VHpfuBcM8dcyAb5hNPq+xaKkQ7MTple//F7R/S5Q15m91IpKl354SMvh21GK2Cv8
         fZ1uzImuYAi/bZnz8EO5vHT660FDohj0O4BCFK8tL1MXOnoyhW3KOW/+z+XD/zuQ/b
         03ZZXZKfKHgeA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pbzMz-0001ZP-6n; Tue, 14 Mar 2023 08:46:53 +0100
Date:   Tue, 14 Mar 2023 08:46:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: rpm: drop bogus pm domain attach
Message-ID: <ZBAmbYxztGTK0vHV@hovoldconsulting.com>
References: <20230313084953.24088-1-johan+linaro@kernel.org>
 <20230313084953.24088-3-johan+linaro@kernel.org>
 <eb633e38-7972-4655-63d1-80399bb3a80b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb633e38-7972-4655-63d1-80399bb3a80b@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 09:58:24PM +0200, Georgi Djakov wrote:
> Hi Johan,
> 
> On 13.03.23 10:49, Johan Hovold wrote:
> > Any power domain would already have been attached by the platform bus
> > code so drop the bogus power domain attach which always succeeds from
> > probe.
> > 
> > This effectively reverts commit 7de109c0abe9 ("interconnect: icc-rpm:
> > Add support for bus power domain").
> > 
> > Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
> > Cc: Yassine Oudjana <y.oudjana@protonmail.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> To make it a complete revert, I'll fold this in:
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 0badd2c75161..c80819557923 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -11,7 +11,6 @@
>   #include <linux/of_device.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> -#include <linux/pm_domain.h>
>   #include <linux/regmap.h>
>   #include <linux/slab.h>

Thanks for catching that!

Johan
