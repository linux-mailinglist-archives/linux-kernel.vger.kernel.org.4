Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDE6D6E00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbjDDU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDDU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:26:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6821991;
        Tue,  4 Apr 2023 13:26:26 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334K70Pv014113;
        Tue, 4 Apr 2023 20:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=i6aB4JJNLQij09Ni0yj4yCW7jSclGoDkvC3zyJBEcYg=;
 b=N4b3z3eV+HcvvA70+NsSdUflT3GbwlNZwCCxoNrVVIZDsjr8wXLHfEjNmE3rKyQ1ZCkq
 Iebk+w4OcVMmGYTk+FW0VmIkb2BuKwr75rxiG0SbubSEDNJm89Zoi9fRSGxv1jfOfrVv
 htFlzQj55DLUnzZS9U8MbnQJqBqD9VgL2oVnFrFVbMqslAQQy1tQDM/CWzfl05qlou79
 hkWSCxIBRncNsFCSxtBYa0s1k/7Cxrm4dhqLNOfasrAmK7uV1lFiih7MYgxWKDyw9qcV
 4tjcVgZKm1fStrQdgB8igGJxt1d1EvKLinDvsObBLl1GBHVxunc98kc7I9VL7znWaMeS Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3prs3ntt3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 20:26:14 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 334KFlF9029194;
        Tue, 4 Apr 2023 20:26:14 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3prs3ntt2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 20:26:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 334IoLhQ009612;
        Tue, 4 Apr 2023 20:26:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ppc87twdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 20:26:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 334KQB3D30147188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Apr 2023 20:26:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49FA158058;
        Tue,  4 Apr 2023 20:26:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7939E58057;
        Tue,  4 Apr 2023 20:26:10 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.71.42])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Apr 2023 20:26:10 +0000 (GMT)
Message-ID: <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: ses: Handle enclosure with just a primary
 component gracefully
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jiri Kosina <jikos@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ding Hui <dinghui@sangfor.com.cn>,
        Michal Kolar <mich.k@seznam.cz>
Date:   Tue, 04 Apr 2023 16:26:08 -0400
In-Reply-To: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ya0Kq7dXkrb_NM_bMs6U_EsFjNyQFSc9
X-Proofpoint-ORIG-GUID: E5riHLf57a1bVUeAFacSct6HtTo0n0GW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_10,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=650 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040182
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-04 at 21:23 +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has
> no components") and introduces proper handling of case where there
> are no detected secondary components, but primary component
> (enumerated in num_enclosures) does exist. That fix was originally
> proposed by Ding Hui <dinghui@sangfor.com.cn>.

I think everything in here looks fine except this:

> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -509,9 +509,6 @@ static int ses_enclosure_find_by_addr(struct
> enclosure_device *edev,
>         int i;
>         struct ses_component *scomp;
>  
> -       if (!edev->component[0].scratch)
> -               return 0;
> -
>         for (i = 0; i < edev->components; i++) {
>                 scomp = edev->component[i].scratch;
>                 if (scomp->addr != efd->addr)

If you remove the check, then scomp could be NULL here and we'll oops
on scomp->addr.

Regards,

James

