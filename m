Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C26AA418
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjCCWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjCCWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:20:40 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203EEB7E;
        Fri,  3 Mar 2023 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1677881560; x=1709417560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gBGQIz/KK+1MKmUrNx1EnCdZxItixQoWNB8185256gE=;
  b=lZW/QdXXTQvSGd3vjXKIwIYlxFH9Lr33WPBU5ZMlkzuSF7q+qaZLrsqo
   tFJH/qbmrvvUKsLdjNbCyJSWxuDAeC+Tpes1duj5o1e5OKxVMTCNhcS/x
   lTAFErxaAUYIVBOvOw60NoZJR6DfiQ60rL7mG8/x7Dju8lQdN6e85VIab
   o=;
X-IronPort-AV: E=Sophos;i="5.98,231,1673913600"; 
   d="scan'208";a="189551306"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 22:09:26 +0000
Received: from EX13MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 5DCB78231C;
        Fri,  3 Mar 2023 22:09:22 +0000 (UTC)
Received: from EX19D047UWB002.ant.amazon.com (10.13.138.34) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 3 Mar 2023 22:09:21 +0000
Received: from amazon.com (10.187.170.20) by EX19D047UWB002.ant.amazon.com
 (10.13.138.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.24; Fri, 3 Mar
 2023 22:09:20 +0000
Date:   Fri, 3 Mar 2023 15:09:18 -0700
From:   Jordan Crouse <jorcrous@amazon.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sergio Lopez <slp@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH] media: venus: dec: Fix capture formats enumeration order
Message-ID: <20230303220918.qr5ydbin3nye3qtz@amazon.com>
References: <20230210081835.2054482-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210081835.2054482-1-javierm@redhat.com>
X-Originating-IP: [10.187.170.20]
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D047UWB002.ant.amazon.com (10.13.138.34)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:18:35AM +0100, Javier Martinez Canillas wrote:
> Commit 9593126dae3e ("media: venus: Add a handling of QC08C compressed
> format") and commit cef92b14e653 ("media: venus: Add a handling of QC10C
> compressed format") added support for the QC08C and QC10C compressed
> formats respectively.
> 
> But these also caused a regression, because the new formats where added
> at the beginning of the vdec_formats[] array and the vdec_inst_init()
> function sets the default format output and capture using fixed indexes
> of that array:
> 
> static void vdec_inst_init(struct venus_inst *inst)
> {
> ...
> 	inst->fmt_out = &vdec_formats[8];
> 	inst->fmt_cap = &vdec_formats[0];
> ...
> }
> 
> Since now V4L2_PIX_FMT_NV12 is not the first entry in the array anymore,
> the default capture format is not set to that as it was done before.
> 
> Both commits changed the first index to keep inst->fmt_out default format
> set to V4L2_PIX_FMT_H264, but did not update the latter to keep .fmt_out
> default format set to V4L2_PIX_FMT_NV12.
> 
> Rather than updating the index to the current V4L2_PIX_FMT_NV12 position,
> let's reorder the entries so that this format is the first entry again.
> 
> This would also make VIDIOC_ENUM_FMT report the V4L2_PIX_FMT_NV12 format
> with an index 0 as it did before the QC08C and QC10C formats were added.
> 
> Fixes: 9593126dae3e ("media: venus: Add a handling of QC08C compressed format")
> Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

I just came across this issue independently and can confirm this patch fixes
the GStreamer V4L2 decoder on QRB5165.

Tested-by: Jordan Crouse <jorcrous@amazon.com>

> ---
> 
>  drivers/media/platform/qcom/venus/vdec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4ceaba37e2e5..bb14bea9fe09 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -31,15 +31,15 @@
>   */
>  static const struct venus_format vdec_formats[] = {
>  	{
> -		.pixfmt = V4L2_PIX_FMT_QC08C,
> +		.pixfmt = V4L2_PIX_FMT_NV12,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>  	}, {
> -		.pixfmt = V4L2_PIX_FMT_QC10C,
> +		.pixfmt = V4L2_PIX_FMT_QC08C,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -	},{
> -		.pixfmt = V4L2_PIX_FMT_NV12,
> +	}, {
> +		.pixfmt = V4L2_PIX_FMT_QC10C,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>  	}, {
