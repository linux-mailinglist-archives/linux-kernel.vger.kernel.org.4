Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6D73FEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjF0OwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjF0Ovs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:51:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA04C1B;
        Tue, 27 Jun 2023 07:49:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDVfNM000853;
        Tue, 27 Jun 2023 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hFqgsytwO7YkPhtAzxumxYOYePgrq4GqYMK6wBUKkqU=;
 b=GwQacHVqAsyMaBPm0rNrGOAnrndoR4OvsstRvd51fRXGEXVv9lAEq7VmBdhhzGQs7q7U
 Rlh2aQn2gTBH0N2iJE88Z8hIi3QEJW30Vep+ODOlj6LjThQSSR2nSzIy1vtQQgBls1Mi
 istsCrrnotnMiIVEmvyHVJfYyMVmkVktLv4bgqEwR/5d3lZfAgMYLHOC+gafP0F1+g2/
 Q1WfJsDJ6VDk8OLmup3txDq4/gV7G6tpMXq0OOCoUOl0VLtBUCsLLEXnFdUETTFBPibC
 YBHO46JDDEze6RuFfdtkO1iv0dwMJjnWE74KXRQio2t2GI8Fh8KErI7v64mn99Lyyk3A Jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfc02aqqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 14:48:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35REmW27011345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 14:48:32 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 07:48:31 -0700
Message-ID: <dd87f23b-d559-f544-c9bc-69ee592c17e8@quicinc.com>
Date:   Tue, 27 Jun 2023 08:48:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 10/24] bus: mhi: host: use vmalloc_array and vcalloc
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <keescook@chromium.org>,
        <christophe.jaillet@wanadoo.fr>, <kuba@kernel.org>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
 <20230627144339.144478-11-Julia.Lawall@inria.fr>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230627144339.144478-11-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aLe5CmSgeSsnVXgSXq5v5pCSDBN7aPz5
X-Proofpoint-GUID: aLe5CmSgeSsnVXgSXq5v5pCSDBN7aPz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=746
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270137
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2023 8:43 AM, Julia Lawall wrote:
> Use vmalloc_array and vcalloc to protect against
> multiplication overflows.
> 
> The changes were done using the following Coccinelle
> semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> let rename alloc =
>    match alloc with
>      "vmalloc" -> "vmalloc_array"
>    | "vzalloc" -> "vcalloc"
>    | _ -> failwith "unknown"
> 
> @@
>      size_t e1,e2;
>      constant C1, C2;
>      expression E1, E2, COUNT, x1, x2, x3;
>      typedef u8;
>      typedef __u8;
>      type t = {u8,__u8,char,unsigned char};
>      identifier alloc = {vmalloc,vzalloc};
>      fresh identifier realloc = script:ocaml(alloc) { rename alloc };
> @@
> 
> (
>        alloc(x1*x2*x3)
> |
>        alloc(C1 * C2)
> |
>        alloc((sizeof(t)) * (COUNT), ...)
> |
> -     alloc((e1) * (e2))
> +     realloc(e1, e2)
> |
> -     alloc((e1) * (COUNT))
> +     realloc(COUNT, e1)
> |
> -     alloc((E1) * (E2))
> +     realloc(E1, E2)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

