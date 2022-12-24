Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877576558B9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 07:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLXGsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 01:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLXGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 01:48:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E894A185;
        Fri, 23 Dec 2022 22:48:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A72D4B8219A;
        Sat, 24 Dec 2022 06:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C32BC433D2;
        Sat, 24 Dec 2022 06:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671864485;
        bh=cHfFHGYVOkCPbYTiLNY3UlB2WhZQ8+IgSDnIYQQYy/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkirL3mc1MlPIOEQj5li9Hu+bfviYBV8N+V2TdQB1+x57LROXcFYoNisgkItvzfKW
         r23AmF75j2zuCebeKDCtX0MsP+H/JGWtdm9Z7jUC7QzjTY6wRT7sAoFtUugWqjc3NE
         GiADDFS/mL0Tps1dSLfhCyKdzafBQ0/Gmr4WNgPc=
Date:   Sat, 24 Dec 2022 07:48:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 01/14] ASoC: Add SOC USB APIs for adding an USB
 backend
Message-ID: <Y6agoe9fFMy3PQz4@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-2-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-2-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:47PM -0800, Wesley Cheng wrote:
> diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
> new file mode 100644
> index 000000000000..c6c376960e4d
> --- /dev/null
> +++ b/sound/soc/soc-usb.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#include <linux/usb.h>
> +#include <sound/soc.h>
> +#include <sound/soc-usb.h>
> +#include "../usb/card.h"
> +
> +struct snd_soc_usb *ctx;

Note, this will not work.  You can not only have "one" state for a
system like this.  That just broke any system with more than one
controller, of which we have millions.

This has to be dynamic for any number of controllers in the system, like
the sound and USB core can handle.  Any requirement of "there can be
only one!" will obviously never be acceptable as that is not how Linux
works.

thanks,

greg k-h
