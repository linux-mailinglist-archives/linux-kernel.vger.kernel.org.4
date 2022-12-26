Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A86562E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLZNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:41:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6A2726;
        Mon, 26 Dec 2022 05:41:45 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQDbdKr020011;
        Mon, 26 Dec 2022 13:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=+pg1t18HnFboBWRaHnKx1274JxUaiw2mejfdOM/OO8o=;
 b=lyZxgAI2M8z719BKcT6VsoIfHtc5cLPyKNwY2WxH6QCputLnJHjaWUwQDfRAvRKhAO8i
 MK5buk1aEOYOX8mhZPfAwzp28K9MO7qT4PmikmJW3InlZN4fFmGsdSatogSCdl1F/A5w
 WzQlN08DxEpWfOXMVRjZ/ofV6P3WK27xuG3/EbAcJ+R76CRvJSzo0Dvj4CpOjlosHYJw
 uBMvESJyF3RUhNGQ1NX7G7km7R1uJIwzV9kfcZMcobPazijws1QAmJsVjrLH+6gaHNDQ
 pwmV8SbjYpxrONTa4i4qHsP4OxMAWvJhvrjfCMj3kOVPgfNUuAqftBX50hgXUYekERYZ fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mqb01b4kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 13:41:20 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BQDbqpN023134;
        Mon, 26 Dec 2022 13:41:19 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mqb01b4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 13:41:19 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQDc5Le022488;
        Mon, 26 Dec 2022 13:41:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mnrpfhqcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 13:41:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BQDfEF846793156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Dec 2022 13:41:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD24B20043;
        Mon, 26 Dec 2022 13:41:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1835B20040;
        Mon, 26 Dec 2022 13:41:14 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.43.88])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Dec 2022 13:41:14 +0000 (GMT)
Date:   Mon, 26 Dec 2022 14:41:09 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        dzickus@redhat.com, ihuguet@redhat.com, ivecera@redhat.com,
        jtornosm@redhat.com, kheib@redhat.com,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH next v2] kbuild: add ability to make source rpm buildable
 using koji
Message-ID: <Y6mkdYQYmjUz7bqV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FS0Jf90b8LcwRI5ayI1DcEOFzobAgp1a
X-Proofpoint-GUID: dmGEJh88DkRXRMfMCEi33pggv9UbOibU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_10,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxlogscore=796 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:48:45AM -0500, Jonathan Toppins wrote:

Hi Jonathan, Ivan et al,

This patch causes a regression on 6.2-rc1 when rpm-pkg target
is specified on non-rpm system (i.e s390 running Ubuntu). The
offending chunk is:

> @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>  	URL: https://www.kernel.org
>  $S	Source: kernel-$__KERNELRELEASE.tar.gz
>  	Provides: $PROVIDES
> +$S	BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
> +$S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
> +
>  	# $UTS_MACHINE as a fallback of _arch in case
>  	# /usr/lib/rpm/platform/*/macros was not included.
>  	%define _arch %{?_arch:$UTS_MACHINE}
