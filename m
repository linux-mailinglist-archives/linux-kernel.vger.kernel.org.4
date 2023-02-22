Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED68969F051
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjBVIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBVIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:34:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7737577
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:34:23 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M7d8pv006691;
        Wed, 22 Feb 2023 08:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4tix5s0pbD/oD7Zwax2s/3jrx8GJznKzO5Ypg1wsXDw=;
 b=HvPOSx+rdpbNBTj6usK0Q0ZQf8tIxfF078bbCuzpPE6SGfGsT0jEG5iqtu4aXNl5I1Ca
 HOHFEsS/1nddFMfcyH61aVv1VGGbi6f8kAb3vQp7M4fLmOpHBghzjHFypMLfayFHty4R
 4Ylgw/K+ZGzm6EG+qusGa4wLjwIIEyu889HE2vo5zitU/HcOeoxktjHf/lWYTjieN/Eg
 OIoHxal/h5zTASaHKBp7JKPeS3aNc1cVPwokRof3hidj3VeYngg3qiIymHMw+RfVsbuR
 tKMFt5mFXFbtw/wvf6c3b+lmsOg9vN9Q2ghmHjYGcpwjEsBFYyVlfAXOCTjCuqi1tClM JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwct6v9b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:34:14 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31M7uiDX007585;
        Wed, 22 Feb 2023 08:34:14 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwct6v9ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:34:14 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LD00m4020893;
        Wed, 22 Feb 2023 08:34:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6bu1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:34:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M8YA3g35455244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 08:34:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD9D42004D;
        Wed, 22 Feb 2023 08:34:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08D5220040;
        Wed, 22 Feb 2023 08:34:07 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.123.148])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Feb 2023 08:34:06 +0000 (GMT)
Date:   Wed, 22 Feb 2023 14:04:00 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/powerpc/include/asm/barrier.h: redefine rmb and wmb
 to lwsync
Message-ID: <Y/XTeBNq1x+ZuyjZ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230222060107.70565-1-kconsul@linux.vnet.ibm.com>
 <896436d1-04e4-8019-0f89-f4d4938f9697@csgroup.eu>
 <Y/XPZl8V4/0Bjegy@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <Y/XQdmeZ86Ivcy5x@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <65a0303b-f4cc-f20c-d66a-c5037bad6791@csgroup.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <65a0303b-f4cc-f20c-d66a-c5037bad6791@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oxvSHxvwCnGw7hxY_EvumeAVH7RAIFda
X-Proofpoint-GUID: 22Hlwyf-OV79KqNBFpdF7bS2UaXMJBfp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=792 mlxscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 08:28:19AM +0000, Christophe Leroy wrote:
> 
> 
> Le 22/02/2023 à 09:21, Kautuk Consul a écrit :
> >> On Wed, Feb 22, 2023 at 07:02:34AM +0000, Christophe Leroy wrote:
> >>>> +/* Redefine rmb() to lwsync. */
> >>>
> >>> WHat's the added value of this comment ? Isn't it obvious in the line
> >>> below that rmb() is being defined to lwsync ? Please avoid useless comments.
> >> Sure.
> > Sorry, forgot to add that I wasn't adding this useless comment.
> > Its just that checkpatch.pl complains that the memory barrier #define
> > doesn't have a comment for it.
> >>>
> 
> See https://docs.kernel.org/dev-tools/checkpatch.html, it says:
> 
> Checkpatch is not always right. Your judgement takes precedence over 
> checkpatch messages. If your code looks better with the violations, then 
> its probably best left alone.
> 
> checkpatch wants a comment for uses of memory barriers. Here I think it 
> is a false positive.
Cool. I will make the changes you mentioned.
Can you tell me which branch or git repo I should re-make this patch on ?
