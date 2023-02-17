Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DA369B3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBQUXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBQUXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:23:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A860A50;
        Fri, 17 Feb 2023 12:23:10 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HE1FHg009572;
        Fri, 17 Feb 2023 20:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OwC1YUWD4RDPqj6ij1e+DtTL840oqoIG3+VP9IMFt2g=;
 b=bopzOf1sOHwKpGmFctnCshxn/e3t7HACszkx8XXJmZidnK75m5QfFlWdsc1irOH1jO94
 Rqgl99mQ1rkNYGtvlf3skcBhcG1dMhq9LsGLR/t0M8qRfiCGKvMlbj0ThTCyp83YRbUi
 o6VLEZZrtKl7b5t6ebvoy+yccyTCgKFahXR+HSNFQhwRqLcGB8Ouihb/PPf4B4fJ5Ttm
 XxqaIz4Xz/+6cQJJL8+GaLBWCb0aar0ihUlWah3EPZz5poqPlLp33HGfsTKlpJbkuK9/
 LCBieBD+YiTcYs6qjt+MxfNArLy/fE/GEFSbQIkUEz3sxXLwQkmYfK2ofWLLV2bZPJzf Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntayfs34c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:22:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HKMuxI015818
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:22:56 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 12:22:56 -0800
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH RESEND 0/1] Validating UAPI backwards compatibility
Date:   Fri, 17 Feb 2023 12:22:33 -0800
Message-ID: <20230217202234.32260-1-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gQ__dsIXddcnFwqLNS6LKYVPkVedklXQ
X-Proofpoint-GUID: gQ__dsIXddcnFwqLNS6LKYVPkVedklXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-arm-kernel and Greg KH

Hi all,

The kernel community has rigorously enforced a policy of backwards
compatibility in its UAPI headers for a long time. This has allowed user
applications to enjoy stability across kernel upgrades without
recompiling.

In the vendor driver community (out-of-tree modules), there's been a
lack of discipline when it comes to maintaining UAPI backwards
compatibility. This has been a maintenance burden and limits our options
for long-term support of older devices.

Our goal is to add tooling for vendor driver developers because the
upstream model of expert maintainer code review can be difficult to
replicate in-house. Tools may help developers catch simple UAPI
incompatibilities that could be easily overlooked by in-house review.

We see in the kernel documentation:
"Kernel headers are backwards compatible, but not forwards compatible.
This means that a program built against a C library using older kernel
headers should run on a newer kernel (although it may not have access
to new features), but a program built against newer kernel headers may
not work on an older kernel."[1]

How does the kernel enforce this guarantee? We would be interested to
learn about any tools or methods used by kernel developers to make sure
the above statement remains true.

Could the documentation on UAPI maintenance (from a developer's point of
view) be expanded? Internally, we have a set of guidelines for our kernel
developers regarding UAPI compatibility techniques. If there's interest
in supplying a document on this topic with the kernel, we'd be happy to
submit a draft detailing what we have so far as a jumping off point.

Additionally, I've attached a shell script we've been using internally
to validate changes to our UAPI headers are backwards compatible. The
script uses libabigail's[2] tool abidiff[3] to compare a modified
header's ABI before and after a patch is applied. If an existing UAPI is
modified, the script exits non-zero. We use this script in our CI system
to block changes that fail the check.

Currently, the script works with gcc. It generates output like this when
a backwards-incompatible change is made to a UAPI header:

 !!! ABI differences detected in include/uapi/linux/acct.h (compared to
 file at HEAD^1) !!!

     [C] 'struct acct' changed:
       type size changed from 512 to 544 (in bits)
       1 data member insertion:
         '__u32 new_val', at offset 512 (in bits) at acct.h:71:1

 0/1 UAPI header file changes are backwards compatible
 UAPI header ABI check failed

However, we have not had success with clang. It seems clang is more
aggressive in optimizing dead code away (no matter which options we
pass). Therefore, no ABI differences are found.

We wanted to share with the community to receive feedback and any advice
when it comes to tooling/policy surrounding this issue. Our hope is that
the script will help all kernel UAPI authors (even those that haven't
upstreamed yet) maintain good discipline and avoid breaking userspace.

[1] Documentation/kbuild/headers_install.rst
[2] https://sourceware.org/libabigail/manual/libabigail-overview.html
[3] https://sourceware.org/libabigail/manual/abidiff.html

P.S. While at Qualcomm, Jordan Crouse <jorcrous@amazon.com> authored the
original version of the UAPI checker script. Thanks Jordan!

John Moon (1):
  check-uapi: Introduce check-uapi.sh

 scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100755 scripts/check-uapi.sh


base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
--
2.17.1

