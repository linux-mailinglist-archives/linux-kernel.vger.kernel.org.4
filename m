Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550656C422A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCVF0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCVF0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:26:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587493B21D;
        Tue, 21 Mar 2023 22:26:01 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M4F8qN015662;
        Wed, 22 Mar 2023 05:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zEiGvYwezZ56dDQgM3ygh4rnNMQ9Lsi++K/345wA9ks=;
 b=d6RwzeWJ/b4KypxjUk6/xBas19Nv7wwGgKBPU3hZBQzbQYlRoJkvMqEuequ7XPmUk7Pv
 k7XdNnATd2Y94083Arh3xjFiGETFUGaB5lWHiP3vxHxCYWhrF8IczxLZVkGz5ITMAtyJ
 RsaHbsBQTtMqk1Y4Cn4rRCngDrYVYQqxue9Q+9pokpwD8EJPup1Vz2lh7gIvmSnJN6ci
 9YfNcOfo03j97xcQIGzMXcJmhNInHXWEP9ip2zpQ7yVN0Apn4W4S8d4VEeGHWcwbm2X6
 Ez9BEsgdM2IxfPZppfvo6uFQPc2aiNQ4I9IREK9uLXIuAOmVFJE/7ztCMiXqhlfumkGi bw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pftg113un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 05:26:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0vPug022532;
        Wed, 22 Mar 2023 05:25:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6dfba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 05:25:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32M5Ptg435127590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 05:25:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F67C20043;
        Wed, 22 Mar 2023 05:25:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FBFD20040;
        Wed, 22 Mar 2023 05:25:55 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 05:25:55 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6F5EB6010A;
        Wed, 22 Mar 2023 16:25:52 +1100 (AEDT)
Message-ID: <d173f8777668de8649f894af64dbf8798e48cf20.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] initramfs: Encode dependency on
 KBUILD_BUILD_TIMESTAMP
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Benjamin Gray <bgray@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Date:   Wed, 22 Mar 2023 16:25:52 +1100
In-Reply-To: <20230320040839.660475-2-bgray@linux.ibm.com>
References: <20230320040839.660475-1-bgray@linux.ibm.com>
         <20230320040839.660475-2-bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3fmrpsOiI6Xo7GLIM3tvH2fdAf9AZb5Z
X-Proofpoint-GUID: 3fmrpsOiI6Xo7GLIM3tvH2fdAf9AZb5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220036
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 15:08 +1100, Benjamin Gray wrote:
> gen_initramfs.sh has an internal dependency on KBUILD_BUILD_TIMESTAMP
> for generating file mtimes that is not exposed to make, so changing
> KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.
>=20
> Declare the mtime date as a new parameter to gen_initramfs.sh to
> encode
> KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make
> aware
> of the dependency.
>=20
> It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly
> set/unset.
> It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before and
> after. This should be fine for anyone who doesn't care about setting
> specific build times in the first place.
>=20
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Tested-by: Andrew Donnellan <ajd@linux.ibm.com>

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
