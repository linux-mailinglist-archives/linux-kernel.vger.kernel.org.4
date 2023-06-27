Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2958773FD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjF0OHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjF0OHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:07:20 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA872D6A;
        Tue, 27 Jun 2023 07:07:18 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDPSLg028459;
        Tue, 27 Jun 2023 16:06:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=ua1duTEqW5T5GC/jOwW1wwLIXtNNQBIm6X1goj4Ur48=;
 b=Z6mbBX/eqCNPGEa54p9IF127hCNBgjNjrDkmb6pEuKordVcGYpas1Dxk3Ma1R7ik7h7m
 oEL2o8UGaKyrqrO9k7J7kxTXUuipLc7efEpDS9xuIxJ3nlJZZ5N5GOsZ+IC/yLTDlRv4
 d2nAfjI1oU+pLTTSd06JW6AMSqOX8sfevoeOgzxpvio2Uknihqv7LhZK9iKmZzr4rsvj
 TFO7o+Q3mIMZVuetOmd8REzPUYOP1U0PwmE5J/y8aq8Gu3Ld9Og6p6fraboq9DfIYWDB
 vzSiZZv121CP6/WsTQ/RsAfRBo8II7VNlV45K2vT6Ohqo29Izuonjl2F3iaoTGABOCyE mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rg0n188qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 16:06:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67515100057;
        Tue, 27 Jun 2023 16:06:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DB4323C6AC;
        Tue, 27 Jun 2023 16:06:50 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 27 Jun
 2023 16:06:49 +0200
Date:   Tue, 27 Jun 2023 16:06:40 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <yqsun1997@gmail.com>
CC:     <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <499671216@qq.com>
Subject: Re: [PATCH] OOB read and write in mdp_prepare_buffer
Message-ID: <20230627140640.GA3605278@gnbcxd0016.gnb.st.com>
Mail-Followup-To: yqsun1997@gmail.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com
References: <20230627082731.1769620-1-yqsun1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627082731.1769620-1-yqsun1997@gmail.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 27, 2023 at 04:27:31PM +0800, yqsun1997@gmail.com wrote:
> From: yqsun1997 <yqsun1997@gmail.com>
> 
> Because format in struct img_image_buffer max index is IMG_MAX_PLANES ==3,
> The num_planes max index is 8.so will be OOB like in mdp_prepare_buffer.

Similarly as your other patch, could you describe why you need to
increase the IMG_MAX_PLANES while I suspect your driver only needs to
deal with 3 planes.  While the maximum num_planes value that can be
given by the user is 8, this has to be first compared to the configured
format prior to reaching this function.

> 
> static void mdp_prepare_buffer(struct img_image_buffer *b,
>                                struct mdp_frame *frame, struct vb2_buffer *vb)
> {
>         struct v4l2_pix_format_mplane *pix_mp = &frame->format.fmt.pix_mp;
>         unsigned int i;
> 
>         b->format.colorformat = frame->mdp_fmt->mdp_color;
>         b->format.ycbcr_prof = frame->ycbcr_prof;
>         for (i = 0; i < pix_mp->num_planes; ++i) {
>                 u32 stride = mdp_fmt_get_stride(frame->mdp_fmt,
>                         pix_mp->plane_fmt[i].bytesperline, i);
> 
>                 b->format.plane_fmt[i].stride = stride;  //oob
>                 ......
> 
> Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
> ---
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> index ae0396806..e2e991a34 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> @@ -11,7 +11,7 @@
>  
>  #define IMG_MAX_HW_INPUTS	3
>  #define IMG_MAX_HW_OUTPUTS	4
> -#define IMG_MAX_PLANES		3
> +#define IMG_MAX_PLANES		8
>  #define IMG_MAX_COMPONENTS	20
>  
>  struct img_crop {
> -- 
> 2.39.2
> 

Regards,
Alain
