Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45F69F24B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBVJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjBVJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:56:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849838B59
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:55:39 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M9fULa030027;
        Wed, 22 Feb 2023 09:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5OGqgH80gHCoiKIEMEs48G9KwUl+uQ2pzTd5TIgNoa0=;
 b=tCAFhD21QqCmf2BRQOfu5WYlRveq/TWKB1eyT1hvHJnOIJI7doSxbi7EIgHAHZC0ZAuX
 WusSHHWat6PIrjsfGGHgBXOXEJPtqSLq8cyx5iV8jmtBJwbMcE+9UqI+JqwEA1MSDze0
 1F/LvSZQ+WF4sc4nImgIxsqxy1wMXuDg4PfE0AJkyoqQCSlD0eD5U9mbeYb06irGs1UM
 u8MdCxIV0Bmoo4mK9A6CPD4KiD7ubJmXlGD+peKO5tPC8JtvtO00ArhfN3G/57rO3S76
 ZfwZsurOsBNuFlcm5HFbz1iG0rf/H3PpthLj2IOiuiOQwW/83SefqCkKwJLmGqQ4JfKn Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwgmtgbeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:55:29 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31M9fiBs030573;
        Wed, 22 Feb 2023 09:55:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwgmtgbdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:55:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDGv5v001655;
        Wed, 22 Feb 2023 09:55:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ntpa63w71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:55:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M9tOtj32309688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 09:55:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0F442004D;
        Wed, 22 Feb 2023 09:55:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DD9520040;
        Wed, 22 Feb 2023 09:55:22 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.123.148])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Feb 2023 09:55:21 +0000 (GMT)
Date:   Wed, 22 Feb 2023 15:25:18 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and
 wmb to lwsync
Message-ID: <Y/XmhjbbD58wi49B@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
 <c4dcf969-0836-cc78-63d9-db83b9ebfa1d@csgroup.eu>
 <Y/XkjobvDPFErM7J@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <2cf06ae7-b3cb-8d17-afef-df1834a84dce@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf06ae7-b3cb-8d17-afef-df1834a84dce@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wJAxgxaPMl-NbaeYu--xRpk17MQ_HNmI
X-Proofpoint-ORIG-GUID: 6ZqWpA3jyRnJp-cXIQfdhfp2O2NTuThU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=878
 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> I'd have preferred with 'asm volatile' though.
> > Sorry about that! That wasn't the intent of this patch.
> > Probably another patch series should change this manner of #defining
> > assembly.
> 
> Why adding new line wrong then have to have another patch to make them 
> right ?
> 
> When you build a new house in an old village, you first build your house 
> with old materials and then you replace everything with new material ?
Sorry Christophe. I will take care next time to adhere to new
conventions.
