Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE35B3792
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIIMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIIMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF313FA64;
        Fri,  9 Sep 2022 05:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D815961DF5;
        Fri,  9 Sep 2022 12:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092BDC433C1;
        Fri,  9 Sep 2022 12:16:49 +0000 (UTC)
Message-ID: <43a27419-1019-f0df-e9c5-6982bd2481c8@xs4all.nl>
Date:   Fri, 9 Sep 2022 14:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Allow S/G_PARM for stateful decoder
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com
References: <1661759670-19902-1-git-send-email-quic_dikshita@quicinc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1661759670-19902-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

First I'll comment on this patch, then at the end I have more high-level
comments.

On 29/08/2022 09:54, Dikshita Agarwal wrote:
> Some stateful decoder supports S/G_PARM similar to a

decoder -> decoders

BTW, which decoder drivers support this in mainline? Or is this
for out-of-tree drivers?

> stateful encoder. S_PARM(OUTPUT) reserves hardware decoder
> resources, and G_PARM(CAPTURE) returns the embedded
> frame interval. Allow the same with this change.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  utils/v4l2-compliance/v4l2-test-formats.cpp | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/utils/v4l2-compliance/v4l2-test-formats.cpp b/utils/v4l2-compliance/v4l2-test-formats.cpp
> index 269a383..e996558 100644
> --- a/utils/v4l2-compliance/v4l2-test-formats.cpp
> +++ b/utils/v4l2-compliance/v4l2-test-formats.cpp
> @@ -64,8 +64,6 @@ static int testEnumFrameIntervals(struct node *node, __u32 pixfmt,
>  		ret = doioctl(node, VIDIOC_ENUM_FRAMEINTERVALS, &frmival);
>  		if (ret == ENOTTY)
>  			return ret;
> -		// M2M devices don't support this, except for stateful encoders
> -		fail_on_test(node->is_m2m && !(node->codec_mask & STATEFUL_ENCODER));

M2M devices still don't support this, except for stateful codecs. So this test
should still be there, just changed to:

!(node->codec_mask & (STATEFUL_ENCODER | STATEFUL_DECODER))

>  		if (f == 0 && ret == EINVAL) {
>  			if (type == V4L2_FRMSIZE_TYPE_DISCRETE)
>  				warn("found framesize %dx%d, but no frame intervals\n", w, h);
> @@ -1367,8 +1365,6 @@ static int testParmType(struct node *node, unsigned type)
>  	}
>  	if (ret == ENOTTY)
>  		return ret;
> -	// M2M devices don't support this, except for stateful encoders
> -	fail_on_test(node->is_m2m && !is_stateful_enc);

Similar.

>  	if (ret == EINVAL)
>  		return ENOTTY;
>  	if (ret)

But modifying the utility is something you only do if the spec has first been updated.
So the stateful decoder chapter needs to be modified so it explains how G/S_PARM
shall be used. And ideally have at least one driver that supports it.

Regards,

	Hans
