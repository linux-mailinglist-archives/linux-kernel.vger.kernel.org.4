Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB673FA61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF0KnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjF0KnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:43:14 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342010D2;
        Tue, 27 Jun 2023 03:43:12 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RAf3ol003129;
        Tue, 27 Jun 2023 12:42:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=c/jV37qb4kjeB7WM/UZsZ8a3yqZF+ecyCOBKUdgrFBM=;
 b=fTfcymJajp2SvJqvrx6F9vtwvxT8ERfhsUnUiMqCvzLRgUqfCbGsYp/tuhPsrmJhvE/G
 uGAw43y1iD6V+A/9bMB5645mzmd5IA3JMdOI5fZ2w1kXEfQ3F8LIjJGdv1UJFs+IYRIV
 tSbUp2DaN0R80qlpP66diJEZ4yifntsHd8g/ir5zFUMOaB1+wOYghkO1aJmNVkbICbe8
 CDureOUy3pWPBgr/WvAnlkkkhJh5GVWFEnjS21U08lK/td5Toj22EyTk9MHneCPLmoUp
 XMS3nM70hGaYImUCX5AKXMCVc/PSbSB+HMa74gBmpcKiP4Xx2WfOIOPCQQdlzZz8KYw3 xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rfue61dr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 12:42:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D12AE100057;
        Tue, 27 Jun 2023 12:42:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BAB102291CD;
        Tue, 27 Jun 2023 12:42:52 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 27 Jun
 2023 12:42:52 +0200
Date:   Tue, 27 Jun 2023 12:42:37 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <yqsun1997@gmail.com>
CC:     <tiffany.lin@mediatek.com>, <andrew-ct.chen@mediatek.com>,
        <yunfei.dong@mediatek.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <499671216@qq.com>
Subject: Re: [PATCH] OOB read and write in mtk multiple places
Message-ID: <20230627104237.GA3601890@gnbcxd0016.gnb.st.com>
Mail-Followup-To: yqsun1997@gmail.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com
References: <20230627081002.1768990-1-yqsun1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627081002.1768990-1-yqsun1997@gmail.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-27_01,2023-05-22_02
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

I had a look at some places where this macro MTK_VCODEC_MAX_PLANES
is being used, such as q_data->bytesperline etc.
This patch seems to be increasing the table size from 3 to 8 but,
if my understanding is correct doesn't solve the issue that
(taking the example you give in vidioc_venc_g_fmt) the table
bytesperline is accessed taking into account a num_planes values which
is unchecked if appropriate for this driver.

What are the 8 planes you are referring to ?

While increasing the table to 8 might also be necessary, it seems to me
that the real OOB access issue should be solved by checking the num of
planes value.

Regards,
Alain

On Tue, Jun 27, 2023 at 04:10:02PM +0800, yqsun1997@gmail.com wrote:
> From: yqsun1997 <yqsun1997@gmail.com>
> 
> The num_planes max index is 8,
> but bytesperline and bytesperline in struct mtk_q_data,
> The max index is MTK_VCODEC_MAX_PLANES == 3,
> so will cause OOB read and write in multiple places.like vidioc_venc_g_fmt
> same as commit 8fbcf730
> 
> Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index 9acab54fd..c2c157675 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -22,7 +22,7 @@
>  #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
>  #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
>  
> -#define MTK_VCODEC_MAX_PLANES	3
> +#define MTK_VCODEC_MAX_PLANES	8
>  #define MTK_V4L2_BENCHMARK	0
>  #define WAIT_INTR_TIMEOUT_MS	1000
>  #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
> -- 
> 2.39.2
> 
