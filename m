Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113806C422F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCVF32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCVF3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:29:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0755505;
        Tue, 21 Mar 2023 22:29:21 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M3ERmu008519;
        Wed, 22 Mar 2023 05:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oLRmgruzrs3e57le87DNnVBdMXRtRa3gF7Yf0IKZ+1k=;
 b=OfATGuV1bQlmzTfC9N/NlzriGtZx4erQ/Mm/mwFR61qbWg7+u7EyBjHmYEzGW5ySSbvl
 Z5DGI+/zGbD9ztrTOH+mInELrim5v9S8SpB8/4Rt/b1rvmZKJap5f4vvxKo0SoxPyy3t
 0nlmRrHy/uKxtmp4W5Aoz3nloqdrai9cLXGX+SB7Ox5lu776YAcDdtUCovIXglY6vfOM
 /eibxpKavFi726kd0Fn3zEa3KiI7XSDo3d+j/WX++lO1dvOgVXBojmIIDQgxrFe2csI4
 UYmmENjn5pHFUcHKDJf0ywDBv/NGP86rEA4Kdlwg7PUoWNaOcdSsivT0EmXYjUN8M6Se oQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfskk22sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 05:29:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32M2OCcx018610;
        Wed, 22 Mar 2023 05:29:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6defb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 05:29:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32M5TFUb29295322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 05:29:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A900C2004B;
        Wed, 22 Mar 2023 05:29:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 299CA20040;
        Wed, 22 Mar 2023 05:29:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 05:29:15 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6D4286010A;
        Wed, 22 Mar 2023 16:29:13 +1100 (AEDT)
Message-ID: <7582f7bcd123f88d267a26bcd15a94aeeb238474.camel@linux.ibm.com>
Subject: Re: [PATCH] init/initramfs: Fix argument forwarding to panic() in
 panic_show_mem()
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Benjamin Gray <bgray@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Date:   Wed, 22 Mar 2023 16:29:13 +1100
In-Reply-To: <20230320230534.50174-1-bgray@linux.ibm.com>
References: <20230320230534.50174-1-bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0wDMZCZVER0AUUpLCJ1mgSDBUGWFeTrz
X-Proofpoint-ORIG-GUID: 0wDMZCZVER0AUUpLCJ1mgSDBUGWFeTrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220036
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-21 at 10:05 +1100, Benjamin Gray wrote:
> Forwarding variadic argument lists can't be done by passing a va_list
> to a function with signature foo(...) (as panic() has). It ends up
> interpreting the va_list itself as a single argument instead of
> iterating it. printf() happily accepts it of course, leading to
> corrupt
> output.
>=20
> Convert panic_show_mem() to a macro to allow forwarding the
> arguments.
> The function is trivial enough that it's easier than trying to
> introduce
> a vpanic() variant.
>=20
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
