Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4A68A0FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBCR4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:56:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C381CF79;
        Fri,  3 Feb 2023 09:56:40 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313HHJMs007086;
        Fri, 3 Feb 2023 17:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=02KT45rBrJ4pSEsR3ymDPFQ/Q7yUORWGKR/1Ihcy3i4=;
 b=e4cO3uJrTp5d/ejqFs1JvXhj4LKJmY5O0vG00Tgm6+2Vw1xawi8YCt7wlmsTP8CI2wpj
 upnDtkJ/ej5lKhAwPiuaMqXUYCX3k4Ityo2wucgdOFg+cB+gkvHrmSL1T2DiYHToEZyu
 31mw4pkbzTpOZSnGGl7qzjYKRWKuP4MluYxGqXJvQAFDaYlvzfeCK7jRCv8bidiXP46d
 iyz47O5VsXP/TFzFKFgCmRL7VKh4nsHOFpEJj7tn4uA7WI0J+ZJ6y5zH0guxlzZJbQCN
 Dhgln3gVP8zMBSn5w9k8JhCXBr7caZekN5HfD0EknVah06WKyJeLnf1xOGQXvSAGb9Vl Kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns2j7f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 17:56:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313HuQta025792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 17:56:26 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 09:56:19 -0800
Date:   Fri, 3 Feb 2023 23:26:16 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 21/27] gunyah: vm_mgr: Add framework to add VM
 Functions
Message-ID: <20230203175616.GD332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-22-quic_eberman@quicinc.com>
 <20230203093704.GC332@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230203093704.GC332@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YpG8-ONnZ_wPj4MJJBKvgU-vb4mH8Op8
X-Proofpoint-ORIG-GUID: YpG8-ONnZ_wPj4MJJBKvgU-vb4mH8Op8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_17,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=881 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> [2023-02-03 15:07:14]:

> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:20]:
> 
> > +static struct gunyah_vm_function_driver *__find_function(const char name[GUNYAH_FUNCTION_NAME_SIZE])
> > +	__must_hold(functions_lock)
> > +{
> > +	struct gunyah_vm_function_driver *iter, *drv = NULL;
> > +
> > +	list_for_each_entry(iter, &functions, list) {
> > +		if (!strncmp(iter->name, name, GUNYAH_FUNCTION_NAME_SIZE)) {
> > +			drv = iter;
> > +			break;
> > +		}
> > +	}
> 
> Not sure how much of a hot path this is going to sit in. I can imagine VM boot
> to be in fast path for some cases (VMs spawned on usecase boundaries - I think
> some VMs like in Amazon firecracker boot in fraction of a second). This
> indirection could cost that a bit (linear search + strcmp for the right
> function). IMHO a direct interface (ex: ADD_IOEVENTFD) will be more efficient.

At the minimum, I think you can make iter->name an enum, which will make the
search faster.

-vatsa

