Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34A0605B17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJTJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJTJ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:28:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98D1C0712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:27:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K9AEm9016083;
        Thu, 20 Oct 2022 09:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6sPN/oZ0j7YOXdqz16h7W9EvY3CvqWvMNsBxtOthMVk=;
 b=eXMrG2i64m8sY1NakFYlKi+rtrm9zCgPEihZhNEPexQChMr0U1+AiQBeYxZFLxWijQUT
 sXZRccml4hphoyyE2GjnwRkSzYr6V2QgHllCIpw0vvh4IpnK2BghdTfG+4JFXHGTB6CN
 HMSe1J0WYo5Yg90ITJXo79mLTrJvbn03sQtfRZXjWGK3+5XnVdUUA53o7LZ14HTWt5kh
 MeWTM5KZK/kfEIzL7yn+xeXFWY5jSfZQSFsZXxkMeNr4IB/TXARL6dDU0GdTMlz/BOFh
 Per1YvdfSp4P626fRA+5/lWPUIbl+9omR6bfT/Fe+Xb3LG+hy93AmNWDJE5LtvJsc08m ew== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kavfm0ws0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 09:27:44 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29K9RiDJ023080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 09:27:44 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 02:27:42 -0700
Message-ID: <8cb1ce88-2e49-745a-dd40-29a084ce285b@quicinc.com>
Date:   Thu, 20 Oct 2022 14:57:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] f2fs: fix the assign logic of iocb
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>,
        <mhiramat@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
 <35c29f27-96c6-6d74-1efb-1588cbf430a2@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <35c29f27-96c6-6d74-1efb-1588cbf430a2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u4UO4k7MHNtSUY5Uymy_mq5zp7NpH1TL
X-Proofpoint-ORIG-GUID: u4UO4k7MHNtSUY5Uymy_mq5zp7NpH1TL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=724
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/20/2022 2:31 PM, Chao Yu wrote:
> On 2022/10/20 0:17, Mukesh Ojha wrote:
>> commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
>> introduces iocb field in 'f2fs_direct_IO_enter' trace event
>> And it only assigns the pointer and later it accesses its field
>> in trace print log.
>>
>> Fix it by correcting data type and memcpy the content of iocb.
> 
> So the implementation below is wrong, right? since it just assign 
> __entry->name
> with dentry->d_name.name rather than copyiny entirely, so that, during 
> printing

I think, yes.

About the patch, we were getting error as below on doing

echo 51200 > /d/tracing/buffer_size_kb
echo 1 > /d/tracing/events/f2fs/f2fs_direct_IO_enter/enable
echo 1 > /d/tracing/tracing_on
cat /d/tracing/trace_pipe > ftrace.log

Run something which exercise this path.

Unable to handle kernel paging request at virtual address ffffffc04cef3d30
Mem abort info:
ESR = 0x96000007
EC = 0x25: DABT (current EL), IL = 32 bits

  pc : trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
  lr : trace_raw_output_f2fs_direct_IO_enter+0x2c/0xa4
  sp : ffffffc0443cbbd0
  x29: ffffffc0443cbbf0 x28: ffffff8935b120d0 x27: ffffff8935b12108
  x26: ffffff8935b120f0 x25: ffffff8935b12100 x24: ffffff8935b110c0
  x23: ffffff8935b10000 x22: ffffff88859a936c x21: ffffff88859a936c
  x20: ffffff8935b110c0 x19: ffffff8935b10000 x18: ffffffc03b195060
  x17: ffffff8935b11e76 x16: 00000000000000cc x15: ffffffef855c4f2c
  x14: 0000000000000001 x13: 000000000000004e x12: ffff0000ffffff00
  x11: ffffffef86c350d0 x10: 00000000000010c0 x9 : 000000000fe0002c
  x8 : ffffffc04cef3d28 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000002000000
  x5 : ffffff8935b11e9a x4 : 0000000000006250 x3 : ffff0a00ffffff04
  x2 : 0000000000000002 x1 : ffffffef86a0a31f x0 : ffffff8935b10000
  Call trace:
   trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
   print_trace_fmt+0x9c/0x138
   print_trace_line+0x154/0x254
   tracing_read_pipe+0x21c/0x380
   vfs_read+0x108/0x3ac
   ksys_read+0x7c/0xec
   __arm64_sys_read+0x20/0x30
   invoke_syscall+0x60/0x150
   el0_svc_common.llvm.1237943816091755067+0xb8/0xf8
   do_el0_svc+0x28/0xa0

-Mukesh
