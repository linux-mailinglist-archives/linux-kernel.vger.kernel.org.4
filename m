Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7060DB69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiJZGh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZGh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:37:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A66278BE1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:37:54 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q4QRpI012957;
        Wed, 26 Oct 2022 06:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zjqpFk3QhBLhN2OLYfCxFIG8Rs3NeBpSFf4AMt/hDyQ=;
 b=sotq9X3vOiUkyNcBx1bzRLJkNeidAWQwz3KlDyhuMq9WPcKX9U/q/oscmAepPehfjcwm
 g7eBgBNg336qjO3iRY9DTnCUshQDHknQDbf2w2UlNHvGzQyTo6rrsHUMYstxlANi9Zs3
 V8vhU5R8Fh6EE+5ZTkAzFfiymz63yxxYIxQ2bpxrKWmjabb2FjRwgsHW/pPnWpJh4zIY
 Y5EfQcPj7TeWy+GxdofLI65qq57K8EYpU4e8QmVV3OIP6s4DNTJq81bE2qxSrCb2EvOh
 G7a/HMJ+vTYasLnybjbh0GhP44RF4zn8g2W0z/WkNXJfITgClhLtvPXXIDPKyjgQI3Ws Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kecrrvg9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 06:37:13 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29Q6bD6j025332;
        Wed, 26 Oct 2022 06:37:13 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kecrrvg88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 06:37:13 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29Q6aBEo014393;
        Wed, 26 Oct 2022 06:37:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3kc859nqk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 06:37:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29Q6b7uW50856238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 06:37:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FAB75204F;
        Wed, 26 Oct 2022 06:37:07 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com (unknown [9.43.83.232])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id BF73652051;
        Wed, 26 Oct 2022 06:37:04 +0000 (GMT)
Date:   Wed, 26 Oct 2022 12:07:01 +0530
From:   Vishal Chourasia <vishalc@linux.vnet.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I2m5MahwrhQT1ZfY"
Content-Disposition: inline
In-Reply-To: <Y06ISBWhJflnV+NI@kroah.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i05jl_7bqzAhbNoG_v2njMD6cr85LGGT
X-Proofpoint-ORIG-GUID: h1h0AVWCZPZFMSJZLfCmn_frSss_BgXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_02,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I2m5MahwrhQT1ZfY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 01:04:40PM +0200, Greg Kroah-Hartman wrote:

> Why do you need to?  What tools require these debugfs files to be
> present?

We are not entirely sure what applications (if any) might be using this int=
erface.

> And if you only have 7-8 files per CPU, that does not seem like a lot of
> files overall (14000-16000)?  If you only offline 1 cpu, how is removing
> 7 or 8 files a bottleneck?  Do you really offline 1999 cpus for a 2k
> system?

It's 7-8 files per domain per cpu, so, in a system with approx 2k cpus and =
five
domains, the total file count goes above 70k-80k files. And, when we offlin=
e 1
CPU, the entire directory is rebuilt, resulting in creation of all the files
again.

Thanks

-- vishal.c=20


--I2m5MahwrhQT1ZfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyetz6oh8pzQ87ZNz8y5vG2Pik+wFAmNY1Y0ACgkQ8y5vG2Pi
k+zzpAf/VpaRfD7CirnN6qZ6dlymniwiDt7AqbDneQ2GpIwCM9zoXPjc2SanAfBS
j3JBmfZVPGDgBecigPGlDv4SPKH58k+Ws3ca5nsMXxZ2vQGmHTAEfRiAcolT6HDh
J1EFP/HgT0cZsbyedIbRUdoF1BGwNMnFKm04Ud7nHqPlxCJPHrxVI5kEafvH4bQM
kS6jv2Q/KexruSHaG32/AZpDxjiJ6zr2LN7slTzg4jxeKYDru4g7hl3H9ECbuDvV
GF/ZEdVXai1LAegTdQNK1laJMxsXHAHnjBhiuqO5L3vc8ulTcmQTw6TKeC895p56
KeYnC6XuaetZEvuNF+VajhNuv7w+dw==
=+7+s
-----END PGP SIGNATURE-----

--I2m5MahwrhQT1ZfY--

