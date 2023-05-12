Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE37007DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbjELM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbjELM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:27:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DCDC5D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:26:25 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CCAVPi026801;
        Fri, 12 May 2023 12:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yKXxOCTYcDelzipfrqokFB+xuMUlqTOv4/tYnvIXiEQ=;
 b=hjHWxnN/6y+f98IvEZ0emffKkeJNSYkcou8s6hFfzRL4h7Xk9ud0P0pEoL+NoOf5LAXY
 xNLR4hgzhsdxs/ffM533dVOba/FBfEe7Ltth1MzjAgo54GwRfjMnaU1ke1g6kaklePNj
 QZtHj+V2kp4V5elR7fnJm4nL37xxsSmYPp5N4YPPKHcfK4wzKWoB4nLUbuQfpclSZesf
 alv3I20UjLy7dWAE71FjVXRYLGKRnP9hA+Od+uz/zYqBzd03DJ2k8/5OTo/txBEa8kzi
 P2GueB8xEOQffl25EzR1X7laUVFIxfRQ0YF1IseQu9snfsm/tm5tNvgNlvxNIBWIhts/ vA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhm3pjcgg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:25:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34CAa482015470;
        Fri, 12 May 2023 12:03:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qf896tb09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:03:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34CC3KkM26870130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 12:03:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55A0D2004B;
        Fri, 12 May 2023 12:03:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D1D20043;
        Fri, 12 May 2023 12:03:20 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 12 May 2023 12:03:19 +0000 (GMT)
Date:   Fri, 12 May 2023 14:03:18 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 0/2] statfs: Enforce statfs[64] structure intialization
Message-ID: <ZF4rBmTg8tCJwbKr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230504144021.808932-1-iii@linux.ibm.com>
 <ZFz9I5bhRh2wH14i@osiris>
 <20230511204518.eba10b4cbf9568a24d1d428b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511204518.eba10b4cbf9568a24d1d428b@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9v111isLlQvVQz_2utG7yR-BvC7V5eWy
X-Proofpoint-ORIG-GUID: 9v111isLlQvVQz_2utG7yR-BvC7V5eWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=764 clxscore=1011 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:45:18PM -0700, Andrew Morton wrote:
> On Thu, 11 May 2023 16:35:15 +0200 Heiko Carstens <hca@linux.ibm.com> wrote:
> > Al, Andrew, should this go via the s390 tree?
> 
> I'd say so.

Hi Al,

Any objections if I pull it via the s390 tree?

Thanks!
