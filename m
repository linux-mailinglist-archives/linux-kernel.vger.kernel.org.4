Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757A073A91E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjFVTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:49:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324F1FE8;
        Thu, 22 Jun 2023 12:49:01 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MJFd5R000374;
        Thu, 22 Jun 2023 19:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tmENBKFGIrm+W5xEE+TLaiJBxZpQvSPgrr9e7uSqw6o=;
 b=aaMWb/ztQ97ox+3GJcQ5L1iF4TeUEePjpAuwT+oWW6eVqhVuyWeJ1rCE8loGnU0Oy94n
 B4ZGsWuUvCNo3tZuRJfuCdSYoL/W2+2a+peBnSbzkt/sh6f12JmqdHeGKa+S7R+HZzo+
 x22acOUCjFkCUS2907Z27Et7sXE+u8rQowh7oNifJdL1HwA2bxf6K06gHmC6hS2y261W
 Jcq5MWHXt4iE3OwHhbV8XJkVQZTFeR3feTKBVg7P0BMN78mTfoR063lMtREUzRzFGDQh
 OUq15CsGZDCYoD/f7RkJUzrJVUIzPPSMZlBCRK5Sq9qM73kvjpkFP1On+l+37OBZHFhw GA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcva1gmqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 19:48:39 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35MJbDXX010301;
        Thu, 22 Jun 2023 19:48:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r94f726ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 19:48:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MJmaoV65339684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 19:48:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D77858051;
        Thu, 22 Jun 2023 19:48:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5994C5805C;
        Thu, 22 Jun 2023 19:48:36 +0000 (GMT)
Received: from [9.61.34.182] (unknown [9.61.34.182])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jun 2023 19:48:36 +0000 (GMT)
Message-ID: <6dff003d-c727-e4a3-b5d3-f58beb2b02cb@linux.ibm.com>
Date:   Thu, 22 Jun 2023 14:48:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] spi: Split transfers larger than max size
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        andi@etezian.org
Cc:     kernel@axis.com, alim.akhtar@samsung.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
 <20220927112117.77599-4-vincent.whitchurch@axis.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220927112117.77599-4-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UGpeUflZAMyn6SP0xeEJT2IivBDUQeK2
X-Proofpoint-ORIG-GUID: UGpeUflZAMyn6SP0xeEJT2IivBDUQeK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_14,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/22 06:21, Vincent Whitchurch wrote:
> A couple of drivers call spi_split_transfers_maxsize() from their
> ->prepare_message() callbacks to split transfers which are too big for
> them to handle.  Add support in the core to do this based on
> ->max_transfer_size() to avoid code duplication.


Hello,

I've been testing AT25 functionality in linux 6.1 and I believe this 
patch is breaking the AT25 protocol. It will split a write command up 
such that some of the data is in a different transfer than  the write 
enable and address. According to my understanding of the AT25 spec, that 
doesn't work... Someone correct me if I'm wrong though. Do we need a 
flag to enable/disable this behavior depending on the client perhaps?


Thanks,

Eddie


>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>   drivers/spi/spi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f41a8c2752b8..44e4352d948b 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1649,6 +1649,15 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
>   
>   	trace_spi_message_start(msg);
>   
> +	ret = spi_split_transfers_maxsize(ctlr, msg,
> +					  spi_max_transfer_size(msg->spi),
> +					  GFP_KERNEL | GFP_DMA);
> +	if (ret) {
> +		msg->status = ret;
> +		spi_finalize_current_message(ctlr);
> +		return ret;
> +	}
> +
>   	if (ctlr->prepare_message) {
>   		ret = ctlr->prepare_message(ctlr, msg);
>   		if (ret) {
