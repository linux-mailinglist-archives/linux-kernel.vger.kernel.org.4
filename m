Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5BC6C3402
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCUOX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:23:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106E5072A;
        Tue, 21 Mar 2023 07:22:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LELMFx034262;
        Tue, 21 Mar 2023 14:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E4/hcGhIwKILSk4TaiplmGQpCnV33KGRDstB6/1AMjU=;
 b=p74ZCJr2prkDbPojlaRwFdJHepSgbmVBVRVLmCxTK2imUkE1+X/JP0syFsBAottl7WZJ
 FK7OgFpusjJ83TIjI8d0j0BqgP2FWKxVKSUpUneZid5mjJi4cJzA84Q4h6BCKMtadOo8
 Xm1wep1dioyHdMfelCmB1AcDURPh/YDY0FHCfVP32pUuvcwYNHdzfckIlesBZ0aBjCW6
 d57J4QE5s3csMQgIM/diWrkOxqRWBm+lo7yQiBp5S522xkmicdl/SgKYhxn5LxGsC867
 ZExo0Du3oD6tJOqouFGFpsdYBPvn3CQSzNTr0xZgMDIAqpgBp3GdmLA4LyUhmmQnjAkW NA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfbpmckx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 14:22:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8prDf022328;
        Tue, 21 Mar 2023 14:22:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6crvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 14:22:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LEMcY644237400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:22:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 437412004D;
        Tue, 21 Mar 2023 14:22:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D30C2004B;
        Tue, 21 Mar 2023 14:22:38 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.179.3.208])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 14:22:38 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1pecsn-002N2T-1t;
        Tue, 21 Mar 2023 15:22:37 +0100
Date:   Tue, 21 Mar 2023 14:22:37 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] scsi: fix hung_task when change host from recovery to
 running via sysfs
Message-ID: <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
References: <20230321084204.1860900-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230321084204.1860900-1-yebin@huaweicloud.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KsxfCXHDwgXQoQjYry9vKwkkxdYXqVKP
X-Proofpoint-GUID: KsxfCXHDwgXQoQjYry9vKwkkxdYXqVKP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:42:04PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> When do follow test:
> Step1: echo  "recovery" > /sys/class/scsi_host/host0/state

Hmm, that make me wonder, what potential use-case this is for? Just
testing?

For SDEVs we explicitly filter what states can be set from user-space.
Only `SDEV_RUNNING` and `SDEV_OFFLINE` can be set in
`store_state_field()`.
    There is probably quite a few other bad things you can do with this
interface by using any of the other states used for device destruction
or EH, and then trigger I/O or said destruction/EH otherwise.
    Not sure handling this one special case of `SHOST_RECOVERY` is quite
enough.


> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index ee28f73af4d4..ae6b1476b869 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -216,6 +216,9 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
>
>       if (scsi_host_set_state(shost, state))
>               return -EINVAL;
> +     else
> +             wake_up(&shost->host_wait);
> +
>       return count;
>  }
>
> --
> 2.31.1
>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
