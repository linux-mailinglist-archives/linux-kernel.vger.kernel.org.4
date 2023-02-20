Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1B69C9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjBTLYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjBTLYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:24:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841AA1ABC3;
        Mon, 20 Feb 2023 03:24:09 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K9xxec009147;
        Mon, 20 Feb 2023 11:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=+bgfQQ2gRBhxSo6/YEAWQTMXET0VtHWdWTgI4vde+lg=;
 b=E3A8u/hkxOn4hXS0u6wIYdfXVWQptikq4mVQYtYOXYowikhJsnwebNNK9GGGZZDpCsaA
 kA19oRYuUfFTKmBn1K0m9M9hE+ztAIKlb6Wn/eSnQG2m50fa/F51C/ZvpCfpV7sEE4y5
 auTGKUii8T5b9gjqrNvoHWaVs+hjboYpS7cmeOOH+kXWcIR4cXa/qpVkSSjvdIXb5FFd
 ymGHKn1ySbBDDyXKXhCiVJ5LyKXN7xRJtbDjJYB38UxmesYtnq+zFjc+ogTeVIzeFVkL
 DNfPZUdHzW7WgCa+TdEoj6iqXpbzHkXYY7UvGg/ZsnX4AXJOKXZZ1elvbWOXmAm6fXq3 /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuyk6kn0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:23:38 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KAUuxR002123;
        Mon, 20 Feb 2023 11:23:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuyk6kn03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:23:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JJlwd6025443;
        Mon, 20 Feb 2023 11:23:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf2kta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:23:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KBNWhP19727082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 11:23:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67D1720043;
        Mon, 20 Feb 2023 11:23:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 701CC20040;
        Mon, 20 Feb 2023 11:23:29 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 20 Feb 2023 11:23:29 +0000 (GMT)
Date:   Mon, 20 Feb 2023 16:53:28 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, hare@suse.de, hch@lst.de, ming.lei@redhat.com,
        sumanesh.samanta@broadcom.com, michael.christie@oracle.com,
        john.garry@huawei.com, johannes.thumshirn@wdc.com, axboe@kernel.dk,
        osandov@fb.com, kashyap.desai@broadcom.com,
        gregkh@linuxfoundation.org
Subject: Re: scsi: Recent kernels drop into emergency shell
Message-ID: <20230220112328.GA803890@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230220061559.GJ159593@linux.vnet.ibm.com>
 <8489afbb-2391-c22f-41fc-21726f09e444@leemhuis.info>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8489afbb-2391-c22f-41fc-21726f09e444@leemhuis.info>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TJvYzwnMKh7QZRyGnISPEoIw0a1U0cHz
X-Proofpoint-ORIG-GUID: 7gTjYswlT1fukq3G_3tSjO6I_Ix5XiGs
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> [2023-02-20 08:40:09]:

> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> On 20.02.23 07:15, Srikar Dronamraju wrote:
> > On a freshly installed system, booting latest upstream kernels causes the
> > system to drop into emergency shell. The reason for dropping into emergency
> > shell is system is unable to mount /home partition.
> 
> What kind of storage hardware do you have? Is this maybe related to this
> fix, that afaics never was merged?

$ lsslot
# Slot                     Description       Linux Name    Device(s)
U9080.HEX.134C1E8-V9-C0    Virtual I/O Slot  30000000      vty
U9080.HEX.134C1E8-V9-C2    Virtual I/O Slot  30000002      l-lan
U9080.HEX.134C1E8-V9-C109  Virtual I/O Slot  3000006d      v-scsi

$ ls-vscsi
host0 U9080.HEX.134C1E8-V9-C109-T0

$ lsscsi
[0:0:1:0]    disk    AIX      VDASD            0001  /dev/sda
[0:0:2:0]    cd/dvd  AIX      VOPTA                  /dev/sr0

Incase you need any other details please let me know.

> https://lore.kernel.org/all/20220928181350.9948-1-leeman.duncan@gmail.com/
> 

Thanks that fixes the problem. I have added a tested-by for the same.
Thanks for pointing out.


-- 
Thanks and Regards
Srikar Dronamraju
