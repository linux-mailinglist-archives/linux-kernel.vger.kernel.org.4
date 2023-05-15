Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EED470257E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbjEOGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbjEOGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:55:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB033C23;
        Sun, 14 May 2023 23:54:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F6Ov5O029066;
        Mon, 15 May 2023 06:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=yyrxhm/gYREWfg21/DeSezb5WJo7IQRtABWTUQAyulY=;
 b=bGex/qZxQ+l5EbPPG6P0cKYeoOar6GbaU8xtzQDEnDJWUcU8450f+fe0WgjazyNWo0sq
 lKdkUwzYeJL+Km1Cav5GUKMEDj+2M4RC4mpGKSA83kB0EEZ5KK7NgpK9F0BvljnnbJt4
 5UiGffxvb7QRwJdhfSZqv9Y5egrJ0+7esAQviqSU+AQzQcOKEtljgd300ekfYZqUPIKC
 yMulLs6v5pDmuw7lzv4IlKCzhk2lnS2E75oEYwN8848MiyAgPiBaXsI2Aqs1vgYAWVUg
 jqF553/l1QgjvqfKH9iOqfK6+ukdD1g7/JR6j8+8n98o81IdvZqkwHTgLOIl3r+Oqmrs 6w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj3qw2uq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 06:52:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F6qjC0000933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 06:52:46 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 14 May 2023 23:52:16 -0700
Date:   Mon, 15 May 2023 12:22:12 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <keescook@chromium.org>, <gregkh@linuxfoundation.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <johannes@sipsolutions.net>, <rafael@kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_shashim@quicinc.com>, <quic_pkondeti@quicinc.com>
Subject: Re: RFC design of device coredump collection on panic in Pstore
Message-ID: <20230515065212.GA522679@hu-pkondeti-hyd.qualcomm.com>
References: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fsnMYaLkZqLkDubdd0ic2pr50xDfOEFB
X-Proofpoint-GUID: fsnMYaLkZqLkDubdd0ic2pr50xDfOEFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=562 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:21:00PM +0530, Mukesh Ojha wrote:
> Hi All,
> 
> We are exploring a way where device driver(registered/interested and optional could be
> callback) can dump their data(consist of list of buffers or hardware registers) for post
> mortam debugging of a crash via dumping the content to pstore region. Some of the example
> data could be like clock dump/regulators/ etc.
> 
> These stuff should be already part of entire RAM dump but in some cases it's however not
> feasible to capture the entire content of RAM, so was thinking if pstore region can be
> used to capture above information either in the form of elf or binary and how pstore
> can get this in human readable format can be discussed further.
> 
> Also, existing devcoredump driver does not cover panic usecases so we thought of something
> like below RFC design where,
> 
> 1. Device_coredump allocates some configurable contigous memory that can be controlled
>    via CONFIG or bootargs and later registers for panic notifiers.
> 2. Notifier gets added.
> 3. Pstore adds device_coredump as its front-end via dumper registration similar
>    to kmsg being dump today.
> 4. Successful registration of dumper.
> 5. A device driver(A-Z) can register their buffer to be dumped as part of panic.
> 6. buffer gets added to the dump list.
> 7. Panic occurs.
> 8. iterate over registered drivers and copy their dump list to its own memory and if
>    it crosses device core dump memory log an error stop iterating.
> 9. Similar to devcore_dump() inline with kmsg_dump()
> 10.Copy the content to pstore region and this could be elf or raw binary that can be
>    discussed.
> 
> 
> Device coredump memory(1) size could be passed from pstore and should be same as size
> of devcoredump frontend size given in DT or some other way.
> 
> Let me know your concern and view on this.       
>                     
> 
>                     pstore               device_coredump      deviceA..Z          panic
>                                                                   ┼                  │
>                        │                      │       panic_notifier(1)              │
>                        │                      ├───────────────────┬─────────────────►│
>                        │                      │ notifier added    │ (2)              │
>                        │                      │◄──────────────────┼──────────────────┤
>       pstore can give  │       (3)            │                   │                  │
>       its region for   │ dumper_registration  │                   │                  │
>       dump             ├─────────────────────►│                   │                  │
>                        │       (4)            │                   │                  │
>                        │◄─────────────────────┤                   │                  │
>                        │  register_dumper     │                   │                  │
>                        │                      │                   │                  │
>                        │                      │                   │                  │
>                        │                      │                   │ init             │
>                        │                      │                ───┼──                │
>                        │                      │       (5)         │                  │
>                        │                      │devcoredump_register(dev,buf));       │
>                        │                      │◄──────────────────┐                  │
>                        │                      │       (6)         │                  │
>                        │                      ├──────────────────►│                  │
>                        │                      │device/buf gets add│d                 │
>                        │                      │ to the list       │                  │panic
>                        │                      │                   │                ──┼───
>                        │                      │                   │                  │
>                        │                      │(7) panic_notifier │     call         │
>                        │                      │◄──────────────────┼──────────────────┤
>                        │                      │ prepare coredump  │for the deviceA-Z │
>                        │                      ├──────────────────►├────┐             │
>                        │                      │   (8)             │    │             │
>                        │                      │                   │    │             │
>                        │                      │                   │    │             │
>                        │                      │                   │◄───┘             │
>              dumper will                      │                   │            (9)   │dev_coredump()
>              write all the device dump to     │◄──────────────────┼──────────────────┤
>               pstore   ┌◄───┬─────────────────┤                   │                  │
>               region   │    │    (10)         │                   │                  │
>                        │    │                 │                   │                  │
>                        │    │                 │                   │                  │
>                        │◄───┘                 │                   │                  │
>                        │                      │                   │                  │
>                        │                      │                   
> 
> 

I really like the idea of providing an interface for device drivers to
dump specific data for offline use. Currently in MSM/QCOM downstream
kernel, we do register for panic notifiers and dump relavant data for
later parsing/analysis. In some cases, this message gets printed to console
so that it would also available in pstore / extracted dmesg. However
having separate record/buffer for individual drivers would help.

I believe dev_coredump() is just an analogy here as it is meant for
taking a dump of the device when the driver thinks its device/firmware
is hung/crashed etc, AFAICT. IIUC, What we are looking for here a different
interface/semantics i.e querying devices to dump any information when
the *system* is crashed/paniced. May be something like dev_panicdump()
and a separate method in device_driver.

Also, are there any use cases for this dev_panicdump() outside the
pstore()? For ex: it would still be helpful to gather all the relavant
data of a device and put it a separate buffer. The list of such buffers
can be parsed offline via standard ramdump analysis.

Thanks,
Pavan
