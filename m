Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB26D4BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjDCPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:19:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B041BF;
        Mon,  3 Apr 2023 08:19:29 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333F5vq2011915;
        Mon, 3 Apr 2023 15:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=lPEXog0z2vgGnN6yQE6eRK4XnVVl6t+j0e9y0ybXBds=;
 b=HlB60iI8X7xkjl0ppdblTSCvrLqTwRxGizHRcpFslNrt66E2z53X3riEc3hQLfAeUBX4
 aWRIORfhvlVD7nFsiyv2cBcGPZ2IPn3JKZz2ev3TIjSKxFQxfXmxGAMojsQnZZJWHA0I
 sBYVNo1FEadtu5szUBpRkk5k6tXxiUIinBapid/T4zM6MSUA01PVtr8t5kis1uUWoYHy
 FkrpYX3QT9tLsdaIhuHdnHSJmi4IkGJfDU4I+Gs5aGs0PGmgbZVu/tXVyHhxtbZLHFjW
 mdsx4XKm3TwBuKEfSrA3PjiVTZxKQEjc9KXmZC69ElmtyhbRgXCDezCbNmvclHc9m/3b iA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxerjcpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 15:19:06 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 333DKQHl024917;
        Mon, 3 Apr 2023 15:19:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ppc87m059-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 15:19:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 333FJ4hi39911882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 15:19:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA3358062;
        Mon,  3 Apr 2023 15:19:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27A9A58057;
        Mon,  3 Apr 2023 15:19:03 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.71.42])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Apr 2023 15:19:03 +0000 (GMT)
Message-ID: <84d55c1032a98de8b2118715d3ec435c409ca0a2.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: megaraid: Fix null dereference
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Mon, 03 Apr 2023 11:19:00 -0400
In-Reply-To: <20230403143440.1923323-1-Igor.A.Artemiev@mcst.ru>
References: <20230403143440.1923323-1-Igor.A.Artemiev@mcst.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2gGIG2l0kQ-X62-t7P-cyHFdIXdXQYJJ
X-Proofpoint-GUID: 2gGIG2l0kQ-X62-t7P-cyHFdIXdXQYJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_12,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=678 phishscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030109
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-03 at 17:34 +0300, Igor Artemiev wrote:
> When cmdid == CMDID_INT_CMDS, the 'mbox' pointer is NULL but is
> dereferenced below.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f2bb84d2a68 ("[SCSI] megaraid: simplify internal command
> handling")
> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
> ---
>  drivers/scsi/megaraid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
> index bf491af9f0d6..4fbf92dc717e 100644
> --- a/drivers/scsi/megaraid.c
> +++ b/drivers/scsi/megaraid.c
> @@ -1441,6 +1441,7 @@ mega_cmd_done(adapter_t *adapter, u8
> completed[], int nstatus, int status)
>                  */
>                 if (cmdid == CMDID_INT_CMDS) {
>                         scb = &adapter->int_scb;
> +                       mbox = (mbox_t *)scb->raw_mbox;

Have you actually seen this and if so which firmware?  I thought
megaraid internal commands only ever returned success or fail (0 or 1)
meaning they can never get into the sense processing case that is the
only consumer of the mbox.

James

