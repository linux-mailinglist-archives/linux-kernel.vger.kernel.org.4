Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69B374CFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjGJIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjGJISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E2FB;
        Mon, 10 Jul 2023 01:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2149B60B38;
        Mon, 10 Jul 2023 08:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B392C433C8;
        Mon, 10 Jul 2023 08:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688977033;
        bh=o21HF+UQcS0l3yAQUuKG4zuD/R+bPXKc2OVpaRoiVgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n40nmwMw1E+wUBhSn66EV2a1HkmIgPT+NPilR6uVX5pfjZPL2n4/pipwhgcYytccu
         LbRUzBWO8+JndLw3pQw/UEkD0zuG9HVplY4imqP+0pFG1EKcJVLEGMIw5t423kXXzW
         uSBl7lbDma9jbUlCIv8gsO5tAle78cBiCVl07CeDfTJgjnG5DO+No2rc00ZhO9UxZc
         TxiHU605qD7qjhd/B3olEmSDQwRoy8RizVGyrVIE+oybl8N/eUpBc6x56DkH1sTT2m
         4bmotqdAEBfXx9pMdTmAXu020eottw9EV3NZqP+LLCJnVjfrl7NXezK5OqdlF1uUQc
         vh5IDhxWOUIDg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qIm5T-0007yi-0p;
        Mon, 10 Jul 2023 10:17:39 +0200
Date:   Mon, 10 Jul 2023 10:17:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     andersson@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soundwire: qcom: update status correctly with mask
Message-ID: <ZKu-o0GQgh84cxZ0@hovoldconsulting.com>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
 <20230525133812.30841-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525133812.30841-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:38:09PM +0100, Srinivas Kandagatla wrote:
> SoundWire device status can be incorrectly updated without
> proper mask, fix this by adding a mask before updating the status.
> 
> Fixes: c7d49c76d1d5 ("soundwire: qcom: add support to new interrupts")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

When rebasing on 6.5-rc1, I noticed that this one was apparently never
merged along with the rest of the series.

Any idea how this could have happened?

And can we get this one into 6.5 as well?

>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index aad5942e5980..9440787e924b 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -515,7 +515,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
>  		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
>  
>  		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
> -			ctrl->status[dev_num] = status;
> +			ctrl->status[dev_num] = status & SWRM_MCP_SLV_STATUS_MASK;
>  			return dev_num;
>  		}
>  	}

Johan
