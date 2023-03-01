Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CD6A6872
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCAHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCAHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:54:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A079025;
        Tue, 28 Feb 2023 23:54:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3216cNiu006140;
        Wed, 1 Mar 2023 07:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=lOC2M2xsKQVJTnNjc3Y1KhO64GI6l7zA8Oakc8Xf4Ek=;
 b=PtMqgvNxGjTbgCEEWtjiaICcxpTiJ4BWhGfqUQWOXUmyUVtGnak5eFZIU58+uh/HPdv6
 xX3lsUCbpuoC0HLJ6+sNlGzAbY/JbuOgXyzjSdnL0RanZ8nIT+nrDcO7NMucWj/xQla0
 cNwuVKDsCeWR9lp9N0JtNc88OqXL6tM1k0rPvoNmv3VajVHybB5nmhhvfYXOEUpVf+uY
 jJM8FLwHGE+7KpdeviHvHioebQVkM6pLEc4ZJh1KxR1hy4D7IcxCDpRvPH0xqkY/yRyI
 YUvVGseOZwlnhBRePPis3qh1+2MwAPs5HzAkUohld7r9q0wpc+C5etjyyB9b4nxvHGbv yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1f7n3a30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 07:54:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3217sVwt032682
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 07:54:31 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Feb 2023 23:54:30 -0800
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v2 0/2] Validating UAPI backwards compatibility
Date:   Tue, 28 Feb 2023 23:54:00 -0800
Message-ID: <20230301075402.4578-1-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dX5y6pYg_G9A_mshnoWy4sexWdqyV5G0
X-Proofpoint-ORIG-GUID: dX5y6pYg_G9A_mshnoWy4sexWdqyV5G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303010063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

In v2, we've expanded the functionality quite a bit. We've added a
document for the tool which includes some examples and explanations of
possible false positives. We've also made it easier to examine changes
across a large range of commits (e.g. v6.0 -> v6.1). This provided a
great testbed of a wide variety of changes to examine.

It would be very helpful for the expert maintainers to look over the
tool's output and describe why or why not certain changes are being
incorrectly flagged. This could lead the way towards another document
that describes the kernel's UAPI policy more formally.

As our tooling improves, we may be able to effectively filter out the
false positives so the tool fits the kernel's UAPI policy neatly.

Thanks for the help on v1 and thanks in advance for the help on v2!

[1] Documentation/kbuild/headers_install.rst
[2] https://sourceware.org/libabigail/manual/libabigail-overview.html
[3] https://sourceware.org/libabigail/manual/abidiff.html

P.S. While at Qualcomm, Jordan Crouse <jorcrous@amazon.com> authored the
original version of the UAPI checker script. Thanks Jordan!

John Moon (2):
  check-uapi: Introduce check-uapi.sh
  docs: dev-tools: Add UAPI checker documentation

 Documentation/dev-tools/checkuapi.rst | 258 +++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 scripts/check-uapi.sh                 | 452 ++++++++++++++++++++++++++
 3 files changed, 711 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst
 create mode 100755 scripts/check-uapi.sh


base-commit: e492250d5252635b6c97d52eddf2792ec26f1ec1
--
2.17.1

