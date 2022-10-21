Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E59606F18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJUFBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUFBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:01:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6301CD69D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:01:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L4we9K000890;
        Fri, 21 Oct 2022 05:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4zR0bo5/TVeqLfecs2ICyveGAJFJeQXIbSWmGTzTSVg=;
 b=M/Sv53M3aL9f6R0vYkh4giQJTodFu7nsUfdA6kzgpMV6pWdyOqwWGohT0yGp41sJ+6Tr
 VEwOMkSYey4HvMd3PyMcraBeVVOiReLEHYiU5q85QmwjUqjcQ4d47Q7PeOg6O1/Frquy
 EOemlQ+O7Ekev/dXaD+wBEdNyHqSnHtM5hW/HKka7Nt0xUtm2ItGIaudcOvBKRef8M5c
 mLAeScgiNWyddXIB3ugXhzO2hiyDnqmnw4ylGC2xgEv4NUOrirtExlc845gsALEkz0x9
 +fXvFinWsHDBSw8HwcSw9nX6hwr1KYbWt6pPl9YeZc6w8wYuxeTgf93xPoMGZ7JLoPO2 UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kb8ckj2sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:00:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29L50qXC030997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:00:52 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 22:00:50 -0700
Date:   Fri, 21 Oct 2022 10:30:46 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <jaegeuk@kernel.org>, <chao@kernel.org>, <mhiramat@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: fix the assign logic of iocb
Message-ID: <20221021050046.GA31858@hu-pkondeti-hyd.qualcomm.com>
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: shzaNGHJGwuhp0zB50xCc0wIJ3yRTYjg
X-Proofpoint-ORIG-GUID: shzaNGHJGwuhp0zB50xCc0wIJ3yRTYjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

On Wed, Oct 19, 2022 at 09:47:57PM +0530, Mukesh Ojha wrote:
> commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> introduces iocb field in 'f2fs_direct_IO_enter' trace event
> And it only assigns the pointer and later it accesses its field
> in trace print log.
> 
> Fix it by correcting data type and memcpy the content of iocb.
> 
> Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  include/trace/events/f2fs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c6b3724..7727ec9 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -940,7 +940,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
> -		__field(struct kiocb *,	iocb)
> +		__field_struct(struct kiocb,	iocb)
>  		__field(unsigned long,	len)
>  		__field(int,	rw)
>  	),
> @@ -948,17 +948,17 @@ TRACE_EVENT(f2fs_direct_IO_enter,
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->ino	= inode->i_ino;
> -		__entry->iocb	= iocb;
> +		 memcpy(&__entry->iocb, iocb, sizeof(*iocb));
>  		__entry->len	= len;
>  		__entry->rw	= rw;
>  	),
>  

Why copy the whole structure (48 bytes)? cache the three members you
need.

Thanks,
Pavan
