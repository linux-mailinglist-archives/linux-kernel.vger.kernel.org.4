Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAE6E9BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjDTSgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjDTSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3D35BF;
        Thu, 20 Apr 2023 11:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 192116156F;
        Thu, 20 Apr 2023 18:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00E7C433EF;
        Thu, 20 Apr 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682015682;
        bh=jKr+iaLUp9CiJCCDhMqaQKsER/qVVoFkcU3AC2cTRmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqMQlb/zeWZeOkw/uFCl6i1K+Ji2WSqlh1mcWVweto2DvQnPx6AJJxsemvlHFKLyv
         NotURfec3mDHO9hahzDnSSZKBVZy5+pJ6GoWI9sncfdNMm/4jdK612fHzGTLnwGVCc
         2m8S0isI7nsAftso5fBQIxSbjwS9KQtlxw3bVT/dAXqSkyTMVuNAL5FnNLiHbL00O8
         QARyg5e19sJSV2X8jrYBefuLmlF0VG2TGopWxWz2+OCB7Dop2Zc+IcwEnbKFbGEuah
         V/eMUwWAhpuesd2Qr3Lm5JQTFLxa262ATwzFTqhoR9g5Kpp5LptzaBHKIZSGQpfJE1
         WNS+JB5ZHuv1g==
Date:   Thu, 20 Apr 2023 11:38:11 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sarannya S <quic_sarannya@quicinc.com>
Cc:     quic_bjorande@quicinc.com, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V6 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Message-ID: <20230420183811.oujn5eqsnqug3u4a@ripper>
References: <1681971690-28858-1-git-send-email-quic_sarannya@quicinc.com>
 <1681971690-28858-4-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681971690-28858-4-git-send-email-quic_sarannya@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:51:29AM +0530, Sarannya S wrote:
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
[..]
> @@ -297,14 +317,31 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> +	bool set;
> +	int ret;
>  
> -	/* Don't allow to destroy a default endpoint. */
> -	if (eptdev->default_ept)
> -		return -EINVAL;
> +	switch (cmd) {
> +	case RPMSG_GET_OUTGOING_FLOWCONTROL:
> +		eptdev->remote_flow_updated = false;
> +		ret = put_user(eptdev->remote_flow, (int __user *)arg);
> +		break;
> +	case RPMSG_SET_INCOMING_FLOWCONTROL:
> +		set = !!arg;
> +		ret = rpmsg_set_flow_control(eptdev->ept, set, 0);

The last parameter should be eptdev->chinfo.dst.

Regards,
Bjorn
