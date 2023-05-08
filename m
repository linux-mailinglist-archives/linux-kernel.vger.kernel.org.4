Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035E46FB462
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjEHPvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjEHPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:51:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4537AD1C;
        Mon,  8 May 2023 08:51:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348ETuMH014109;
        Mon, 8 May 2023 15:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=vDt2BEopWdrLVpdUsagAxhdZHq6YP8MKjw07AtfcvH0=;
 b=aGstWzzBCJJstO4BFRffpwDi305+/qByh+mhIc4jOd2excN/BqmcSCeHjVT7OOuXuMgT
 V6MRaGaaWFAAhMo5r97jHubbo4QKmdpWQk6Qtd1Pjq/Nx22cdTv8Go/7Dr+0BO5rZmzB
 yVGrRP5neP6yy7cTaiEHMU8gxc0mpkzKZLl/lYk8BHWAQRNGcORZsNHfcsMWo/rIaCXn
 NTSJ4t6ALBcKgyqWsdXBnK5h4ROChISxjvszfaiBwVL2w7JgsSLNP1pl9qzG1B4S9A03
 S4AlMwU+yWdlOpl8AtUX0n2GYktz+eiDz7pAZqWYgKS3FZqct03GWyaCtAqHdUbW26fm EA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qexf1gte2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:51:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348FpCok017726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 15:51:12 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 08:51:08 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <keescook@chromium.org>, <gregkh@linuxfoundation.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <johannes@sipsolutions.net>, <rafael@kernel.org>
CC:     <quic_mojha@quicinc.com>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_shashim@quicinc.com>,
        <quic_pkondeti@quicinc.com>
Subject: RFC design of device coredump collection on panic in Pstore
Date:   Mon, 8 May 2023 21:21:00 +0530
Message-ID: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Xp700i_CMCDeRK-27co6w6eQvGO0PXm
X-Proofpoint-GUID: 1Xp700i_CMCDeRK-27co6w6eQvGO0PXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=530 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are exploring a way where device driver(registered/interested and optional could be
callback) can dump their data(consist of list of buffers or hardware registers) for post
mortam debugging of a crash via dumping the content to pstore region. Some of the example
data could be like clock dump/regulators/ etc.

These stuff should be already part of entire RAM dump but in some cases it's however not
feasible to capture the entire content of RAM, so was thinking if pstore region can be
used to capture above information either in the form of elf or binary and how pstore
can get this in human readable format can be discussed further.

Also, existing devcoredump driver does not cover panic usecases so we thought of something
like below RFC design where,

1. Device_coredump allocates some configurable contigous memory that can be controlled
   via CONFIG or bootargs and later registers for panic notifiers.
2. Notifier gets added.
3. Pstore adds device_coredump as its front-end via dumper registration similar
   to kmsg being dump today.
4. Successful registration of dumper.
5. A device driver(A-Z) can register their buffer to be dumped as part of panic.
6. buffer gets added to the dump list.
7. Panic occurs.
8. iterate over registered drivers and copy their dump list to its own memory and if
   it crosses device core dump memory log an error stop iterating.
9. Similar to devcore_dump() inline with kmsg_dump()
10.Copy the content to pstore region and this could be elf or raw binary that can be
   discussed.


Device coredump memory(1) size could be passed from pstore and should be same as size
of devcoredump frontend size given in DT or some other way.

Let me know your concern and view on this.       
                    

                    pstore               device_coredump      deviceA..Z          panic
                                                                  ┼                  │
                       │                      │       panic_notifier(1)              │
                       │                      ├───────────────────┬─────────────────►│
                       │                      │ notifier added    │ (2)              │
                       │                      │◄──────────────────┼──────────────────┤
      pstore can give  │       (3)            │                   │                  │
      its region for   │ dumper_registration  │                   │                  │
      dump             ├─────────────────────►│                   │                  │
                       │       (4)            │                   │                  │
                       │◄─────────────────────┤                   │                  │
                       │  register_dumper     │                   │                  │
                       │                      │                   │                  │
                       │                      │                   │                  │
                       │                      │                   │ init             │
                       │                      │                ───┼──                │
                       │                      │       (5)         │                  │
                       │                      │devcoredump_register(dev,buf));       │
                       │                      │◄──────────────────┐                  │
                       │                      │       (6)         │                  │
                       │                      ├──────────────────►│                  │
                       │                      │device/buf gets add│d                 │
                       │                      │ to the list       │                  │panic
                       │                      │                   │                ──┼───
                       │                      │                   │                  │
                       │                      │(7) panic_notifier │     call         │
                       │                      │◄──────────────────┼──────────────────┤
                       │                      │ prepare coredump  │for the deviceA-Z │
                       │                      ├──────────────────►├────┐             │
                       │                      │   (8)             │    │             │
                       │                      │                   │    │             │
                       │                      │                   │    │             │
                       │                      │                   │◄───┘             │
             dumper will                      │                   │            (9)   │dev_coredump()
             write all the device dump to     │◄──────────────────┼──────────────────┤
              pstore   ┌◄───┬─────────────────┤                   │                  │
              region   │    │    (10)         │                   │                  │
                       │    │                 │                   │                  │
                       │    │                 │                   │                  │
                       │◄───┘                 │                   │                  │
                       │                      │                   │                  │
                       │                      │                   



Regards,
Mukesh

-- 
2.7.4

