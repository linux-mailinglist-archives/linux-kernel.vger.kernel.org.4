Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A96C4194
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCVE3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCVE32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:29:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2741B68;
        Tue, 21 Mar 2023 21:29:28 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M3EOga008417;
        Wed, 22 Mar 2023 04:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yaMYr9CZzNPJoDI/TubYoFVDj8RCVIIes+4I7SHib1Y=;
 b=C8KmzyEDD7etRWQA06p4Kn/2Vy9C8KTTqSt1FspKjlJ0rA5RCc+YdneK0XSYGKjGGZPF
 +NTHuIyS4nfVgNS9eFCvri3FEFLElC4g+YqrdYx0lPGu4kPPUDLZ0kW2vP7VBJLwnwM6
 FiMkd7Q62i1DuADCwdli6G1wzdktl36vrrZqw3l4auD4EY31QRTr+pUbllUo1f9yLohX
 q5tLxkm778FeMVw/GV9UuH+GMnQ6cQBAKmVbOkovHzTJMYiGaxOad+u4QBqU3XMvwbZl
 cXiZVryRIaNo2Q+B1+1zMhQZcSnDLIgqwNG2ysRizxY+wUVgHp3vwOJov9VZhR5GHEcy 5Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfskk141e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 04:29:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEHNGm000634;
        Wed, 22 Mar 2023 04:29:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6ch9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 04:29:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32M4TMZ728115582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 04:29:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE88120043;
        Wed, 22 Mar 2023 04:29:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EC8520040;
        Wed, 22 Mar 2023 04:29:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 04:29:22 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1DE0E600F5;
        Wed, 22 Mar 2023 15:29:17 +1100 (AEDT)
Message-ID: <5d909e0b1a9155112feb72b1f99c9fc4fc2d4263.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] initramfs: Check negative timestamp to prevent
 broken cpio archive
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Benjamin Gray <bgray@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Date:   Wed, 22 Mar 2023 15:29:07 +1100
In-Reply-To: <20230320040839.660475-1-bgray@linux.ibm.com>
References: <20230320040839.660475-1-bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QQWuBq8uQZawbEpKAInzyBSiWpzeUQIR
X-Proofpoint-ORIG-GUID: QQWuBq8uQZawbEpKAInzyBSiWpzeUQIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220028
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 15:08 +1100, Benjamin Gray wrote:
> Similar to commit 4c9d410f32b3 ("initramfs: Check timestamp to
> prevent
> broken cpio archive"), except asserts that the timestamp is
> non-negative. This can happen when the KBUILD_BUILD_TIMESTAMP is a
> value
> before UNIX epoch, which may be set when making reproducible builds
> that
> don't want to look like they use a valid date.
>=20
> While support for dates before 1970 might not be supported, this is
> more
> about preventing undetected CPIO corruption. The printf's use a
> minimum
> length format specifier, and will happily make the field longer than
> 8
> characters if they need to.
>=20
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Tested-by: Andrew Donnellan <ajd@linux.ibm.com>


--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
