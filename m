Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126365E670
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjAEIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjAEIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:06:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0544086D;
        Thu,  5 Jan 2023 00:06:00 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3057MfYq032307;
        Thu, 5 Jan 2023 08:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=fOrCrBR39K3gwlEhzZZbNnz3h0BbHtsclLCHEbf+Mq0=;
 b=itX8SP5mM+sMYFaxNKk4yq4R7Cya3DSMd0RxTo/7X0M1W8/mhdKCrlm3w59nH8xwVIQI
 gRGQjk22oQligKETm88N9QqPbASSaXD/MpWdhxvr6JCWNuNmVHkOMj0ydc7hWpK1Of0d
 F/6ocAMUhJsaBYKoSPCj+a42o7QgzNNlwzUkbd0XkvnJfvXZxD1xr/9MClQzI5Yjh8FR
 R/nmDiJyyj3p0VZ4Pk+F4KWb/Jo+LIFvwHLTkgXZ2JPnxp6vK+oUGVZ2S5tWOEkPdzbt
 uhQ5bcpJgog7HqRwmoR8PbUauhbIWYf5H7/BVrKoVVGzPMBF+FVjRZ1PZVx+zoj57z1b dg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwsxns4jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 08:05:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 305535xK001543;
        Thu, 5 Jan 2023 08:05:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfeegn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 08:05:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30585nU948628010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jan 2023 08:05:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCA3A20043;
        Thu,  5 Jan 2023 08:05:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52CE020040;
        Thu,  5 Jan 2023 08:05:49 +0000 (GMT)
Received: from osiris (unknown [9.171.68.186])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Jan 2023 08:05:49 +0000 (GMT)
Date:   Thu, 5 Jan 2023 09:05:47 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, linux-block@vger.kernel.org
Subject: Re: [PATCH rcu 07/27] block: Remove "select SRCU"
Message-ID: <Y7aE2zzdTyjNId6w@osiris>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-7-paulmck@kernel.org>
 <1a9d0cdf-d39e-7eb5-39dd-3e425016c579@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a9d0cdf-d39e-7eb5-39dd-3e425016c579@kernel.dk>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eWEV7vV7VjxkHgEDcwbCLUDx6EPtEpk7
X-Proofpoint-GUID: eWEV7vV7VjxkHgEDcwbCLUDx6EPtEpk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_02,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 mlxlogscore=597 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:43:07PM -0700, Jens Axboe wrote:
> On 1/4/23 5:37 PM, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> 
> I'm assuming something earlier made this true (only CC'ed on this patch,
> not the cover letter or interesting btis...), then:

I was wondering the same. But it is already unconditionally enabled
since commit 0cd7e350abc4 ("rcu: Make SRCU mandatory").
