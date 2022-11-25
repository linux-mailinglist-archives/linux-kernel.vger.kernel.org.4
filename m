Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D4638287
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKYCot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYCoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:44:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEE2B1A9;
        Thu, 24 Nov 2022 18:44:45 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AP2CS8r029121;
        Fri, 25 Nov 2022 02:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=z6JUryT4jk/yyFthRu8NYLvWjq32BhBoElWTlmNoT6s=;
 b=goLLCv4Yk/0ea8hDii/RHxFEZRCQjoSdWyPUtAcsKp3Bjz1MNh33/lcM6p45mCDohi4S
 e6lAjhKMhBBPhqi6ZeprtoTdIlm2fNPCDVAJD3uxhxCWTavyjYPF6p9t4/rZzgxrNv0X
 nmX3eLoLW9Cvrk4unUPe8csJ3ZTqt3z1AhmAm3jjRV1ypo/VoUp4PnSvOkKQuxCZqsvV
 iuvca7df2Am3qaz4Mg1eTAv0p0h54iLi4t7iqpRA41Z80umQuORvvfwCpV+2sHwWF+zF
 XzoiWjQ95r44srYtOoFIybYQaGlC3Z+9RDA3BcMk9JZZWk2RytYhRnj4Vtv8Bpav8lFB Bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m29349h28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 02:44:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AP2iaRj025216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 02:44:36 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 18:44:34 -0800
Message-ID: <062fb756-e84a-68ba-1347-7a6e66d5ac0d@quicinc.com>
Date:   Fri, 25 Nov 2022 10:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] usb: gadget: f_fs: use io_data->status consistently
To:     John Keeping <john@metanate.com>, <linux-usb@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dan Carpenter <error27@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20221124170430.3998755-1-john@metanate.com>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20221124170430.3998755-1-john@metanate.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a-6S_1FLDM1z4UxTuepDEb35gLSjLXK2
X-Proofpoint-GUID: a-6S_1FLDM1z4UxTuepDEb35gLSjLXK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_14,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=858 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Linyu Yuan <quic_linyyuan@quicinc.com>


On 11/25/2022 1:04 AM, John Keeping wrote:
> Commit fb1f16d74e26 ("usb: gadget: f_fs: change ep->status safe in
> ffs_epfile_io()") added a new ffs_io_data::status field to fix lifetime
> issues in synchronous requests.
>
> While there are no similar lifetime issues for asynchronous requests
> (the separate ep member in ffs_io_data avoids them) using the status
> field means the USB request can be freed earlier and that there is more
> consistency between the synchronous and asynchronous I/O paths.
>
> Cc: Linyu Yuan <quic_linyyuan@quicinc.com>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>   drivers/usb/gadget/function/f_fs.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 73dc10a77cde..1221f0d1b1a9 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -825,8 +825,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
>   {
>   	struct ffs_io_data *io_data = container_of(work, struct ffs_io_data,
>   						   work);
> -	int ret = io_data->req->status ? io_data->req->status :
> -					 io_data->req->actual;
> +	int ret = io_data->status;
>   	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
>   
>   	if (io_data->read && ret > 0) {
> @@ -840,8 +839,6 @@ static void ffs_user_copy_worker(struct work_struct *work)
>   	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
>   		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
>   
> -	usb_ep_free_request(io_data->ep, io_data->req);
> -
>   	if (io_data->read)
>   		kfree(io_data->to_free);
>   	ffs_free_buffer(io_data);
> @@ -856,6 +853,9 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
>   
>   	ENTER();
>   
> +	io_data->status = req->status ? req->status : req->actual;
> +	usb_ep_free_request(_ep, req);
> +
>   	INIT_WORK(&io_data->work, ffs_user_copy_worker);
>   	queue_work(ffs->io_completion_wq, &io_data->work);
>   }
