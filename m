Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FF6DFBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjDLQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDLQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75AF4495;
        Wed, 12 Apr 2023 09:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A097B6375B;
        Wed, 12 Apr 2023 16:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B45C433D2;
        Wed, 12 Apr 2023 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681318022;
        bh=qTDTPft69sngqARhBIeJA14iYjSCz/p1w+ygzUzfdNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxhEOMUjD6PeE7AEWIEcG0FFr+I05NkdxpGo7d+vCI2w7eYaRlsSJFnr8AF/Q8kCz
         It45z8FvpfGzPr9MHRzSgQQ6flq0h9ubmFy9QzuNw+E1cQ1wx+rs5UAHbtU36Hv5BI
         o5piuZCr0RfzoIbqJ+NysBn8k8zBX/UCLb9uKKSaH6kPiSaRS1QCuiYVkE1FB9YQ1H
         LcU1hnCO2PE9jHro4a9dRZ5hCsUi+Igm3RNkZrzb1FPMrN7UFhzTMPwCPB0FOaiMlT
         oOWTHU09JWM+7ouV3uSZNmBZDfX+jsoJ2x7JsBbLLFLAvGxDpLJ0CuL6KoBag+rtHW
         IYnPtd27UV04g==
Date:   Wed, 12 Apr 2023 09:50:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Chris Lew <quic_clew@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT
Message-ID: <20230412165042.jsqhwbn3r364iinr@ripper>
References: <20230327144153.3133425-1-quic_bjorande@quicinc.com>
 <20230327144153.3133425-3-quic_bjorande@quicinc.com>
 <e01c0579-5ce2-459b-0306-7351f8aca561@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01c0579-5ce2-459b-0306-7351f8aca561@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 03:10:45PM -0700, Chris Lew wrote:
> 
> 
> On 3/27/2023 7:41 AM, Bjorn Andersson wrote:
> > Rather than duplicating most of the code for constructing the initial
> > TX_DATA and subsequent TX_DATA_CONT packets, roll them into a single
> > loop.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   drivers/rpmsg/qcom_glink_native.c | 46 +++++++++----------------------
> >   1 file changed, 13 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> > index 62634d020d13..082cf7f4888e 100644
> > --- a/drivers/rpmsg/qcom_glink_native.c
> > +++ b/drivers/rpmsg/qcom_glink_native.c
> > @@ -1309,7 +1309,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
> >   	int ret;
> >   	unsigned long flags;
> >   	int chunk_size = len;
> > -	int left_size = 0;
> > +	size_t offset = 0;
> >   	if (!glink->intentless) {
> >   		while (!intent) {
> > @@ -1343,49 +1343,29 @@ static int __qcom_glink_send(struct glink_channel *channel,
> >   		iid = intent->id;
> >   	}
> > -	if (wait && chunk_size > SZ_8K) {
> > -		chunk_size = SZ_8K;
> > -		left_size = len - chunk_size;
> > -	}
> > -	req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
> > -	req.msg.param1 = cpu_to_le16(channel->lcid);
> > -	req.msg.param2 = cpu_to_le32(iid);
> > -	req.chunk_size = cpu_to_le32(chunk_size);
> > -	req.left_size = cpu_to_le32(left_size);
> > -
> > -	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
> > -
> > -	/* Mark intent available if we failed */
> > -	if (ret) {
> > -		if (intent)
> > -			intent->in_use = false;
> > -		return ret;
> > -	}
> > -
> > -	while (left_size > 0) {
> > -		data = (void *)((char *)data + chunk_size);
> > -		chunk_size = left_size;
> > -		if (chunk_size > SZ_8K)
> > +	while (offset < len) {
> > +		chunk_size = len - offset;
> > +		if (chunk_size > SZ_8K && (wait || offset > 0))
> 
> offset > 0 seems to be a new condition compared to the previous logic.
> Are we adding this as a cached check because we know if offset is set then
> fragmented sends are allowed?
> 

You're right, I believe my intention was to retain the two inquiries of
the original code; for the first block, don't split it if we're not
waiting and for any subsequent blocks always split.

> I don't think wait would have changed during the loop, so I'm not sure if
> offset > 0 is adding any extra value to the check.
> 

But you're totally right, offset > 0 would only occur if wait is set and
wait will not have changed for subsequent blocks.

So while capturing the original conditions, it seems superfluous.

Thanks,
Bjorn

> >   			chunk_size = SZ_8K;
> > -		left_size -= chunk_size;
> > -		req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA_CONT);
> > +		req.msg.cmd = cpu_to_le16(offset == 0 ? GLINK_CMD_TX_DATA : GLINK_CMD_TX_DATA_CONT);
> >   		req.msg.param1 = cpu_to_le16(channel->lcid);
> >   		req.msg.param2 = cpu_to_le32(iid);
> >   		req.chunk_size = cpu_to_le32(chunk_size);
> > -		req.left_size = cpu_to_le32(left_size);
> > +		req.left_size = cpu_to_le32(len - offset - chunk_size);
> > -		ret = qcom_glink_tx(glink, &req, sizeof(req), data,
> > -				    chunk_size, wait);
> > -
> > -		/* Mark intent available if we failed */
> > +		ret = qcom_glink_tx(glink, &req, sizeof(req), data + offset, chunk_size, wait);
> >   		if (ret) {
> > +			/* Mark intent available if we failed */
> >   			if (intent)
> >   				intent->in_use = false;
> > -			break;
> > +			return ret;
> >   		}
> > +
> > +		offset += chunk_size;
> >   	}
> > -	return ret;
> > +
> > +	return 0;
> >   }
> >   static int qcom_glink_send(struct rpmsg_endpoint *ept, void *data, int len)
