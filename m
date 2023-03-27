Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F06CABFF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjC0RmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0RmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:42:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6159B10EA;
        Mon, 27 Mar 2023 10:42:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RALBNT011118;
        Mon, 27 Mar 2023 17:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=gd41agZAFBrdyQ2rYAAIcve8FqL8Ny9Ztm92PCMYCcc=;
 b=A4maCPUU3qlFoV9QJps+26IR6R0KD4LANM2F+gsNUa/MxYYvM9MpvzBnXOLx+CV25mDK
 GWkKe2LCRHwNNRmBLNeIyp6iLl6T6UVyydtADfPWJMpAaMcxJIEvGnD/7X1p7tSmrMA/
 67YTr8SeR95hWJjtzFk5+P8cE5ptaNaZtSJp7nDWIvv+9u4E2eenBOjMVRqchrg0NE/h
 7iLtgibGczsVZPKATf39luFXknaTFRoyF33u3jcwO9JHxCyUP4z2BM5RE/MLXqu+Asnx
 NByjUpxmsHgaTF/uVA3uKc2Sf8tZGI5sYdliKqz6vL5q+Zn8JlJWOsgWlHEJ1ESt5C80 pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk53yhr43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 17:41:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32RHftJN032624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 17:41:55 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 10:41:54 -0700
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
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: [PATCH v4 0/2] Validating UAPI backwards compatibility
Date:   Mon, 27 Mar 2023 10:41:38 -0700
Message-ID: <20230327174140.8169-1-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hXteiBBLw_53QzlszTJKScp2GjLA9o9y
X-Proofpoint-ORIG-GUID: hXteiBBLw_53QzlszTJKScp2GjLA9o9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270144
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel community has rigorously enforced a policy of backwards
compatibility in its UAPI headers for a long time. This has allowed user
applications to enjoy stability across kernel upgrades without
recompiling. Our goal is to add tooling and documentation to help kernel
developers maintain this stability.

We see in the kernel documentation:
"Kernel headers are backwards compatible, but not forwards compatible.
This means that a program built against a C library using older kernel
headers should run on a newer kernel (although it may not have access
to new features), but a program built against newer kernel headers may
not work on an older kernel."[1]

How does the kernel community enforce this guarantee? As we understand it,
it's enforced with thorough code review and testing. Is there any tooling
outside of this being used to help the process?

Also, could documentation on UAPI maintenance (from a developer's point
of view) be expanded? Internally, we have a set of guidelines for our
kernel developers regarding UAPI compatibility techniques. If there's
interest in supplying a document on this topic with the kernel, we'd be
happy to submit a draft detailing what we have so far as a jumping off
point.

In terms of tooling, I've attached a shell script we've been using
internally to validate backwards compatibility of our UAPI headers. The
script uses libabigail's[2] tool abidiff[3] to compare a modified
header's ABI before and after a patch is applied. If an existing UAPI is
modified, the script exits non-zero. We use this script in our
continuous integration system to block changes that fail the check.

It generates output like this when a backwards-incompatible change is made
to a UAPI header:

!!! ABI differences detected in include/uapi/linux/bpf.h from HEAD~1 -> HEAD !!!

    [C] 'struct bpf_insn' changed:
      type size hasn't changed
      1 data member change:
        type of '__s32 imm' changed:
          typedef name changed from __s32 to __u32 at int-ll64.h:27:1
          underlying type 'int' changed:
            type name changed from 'int' to 'unsigned int'
            type size hasn't changed

We wanted to share this script with the community and hopefully also
receive general feedback when it comes to tooling/policy surrounding this
issue. Our hope is that the script will help kernel UAPI authors maintain
good discipline and avoid breaking userspace.

In v4, we've updated the script to operate exclusively on the trees
generated by "make headers_install" at the two git references. This
catches several classes of false negatives brought up in earlier
revisions.

Thanks for the helpful reviews of previous revs! We're looking forward
to any additional feedback you may have on v4.

[1] Documentation/kbuild/headers_install.rst
[2] https://sourceware.org/libabigail/manual/libabigail-overview.html
[3] https://sourceware.org/libabigail/manual/abidiff.html

P.S. While at Qualcomm, Jordan Crouse <jorcrous@amazon.com> authored the
original version of the UAPI checker script. Thanks Jordan!<Paste>

John Moon (2):
  check-uapi: Introduce check-uapi.sh
  docs: dev-tools: Add UAPI checker documentation

 Documentation/dev-tools/checkuapi.rst | 479 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 scripts/check-uapi.sh                 | 490 ++++++++++++++++++++++++++
 3 files changed, 970 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst
 create mode 100755 scripts/check-uapi.sh


base-commit: e76db6e50c85cce9e68c47076f8eab06189fe4db
--
2.17.1

