Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4176C64B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCWKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCWKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:21:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CA412073;
        Thu, 23 Mar 2023 03:21:35 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N8CGDJ007016;
        Thu, 23 Mar 2023 10:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0ERauraqE3u5evuE0GULp57jTa/HLBK6Uf3QRaUQIVE=;
 b=D8Tp5ok6YSREwpehFrO6R0ojDsAqSYVGNm3xrmEJRRBIykSW2b9Z0FKnnkyqvo04l+kd
 1Z2OSt971FeJZkMMizHRyaYhz7eRi49i8nztEyrHJqkYxmVz8rJMcxlmQT2QZ9a7bsTI
 WAP9EoN5pj9XdV/TNDtUWvxv4kduGNXO/nxkTAJh5TbI3/4mEbRD7aCkWCp3Npw7R8gx
 smcCNebi1yFV6tAH3fzmHOui1A1I8AY4+UZsQucoDo9q3QUwp5gdl5KY+JRc8Bgsh80a
 3Aa5SGWhX4LIO8CdWfvFnydYF8totxgRPLlPJxc4hMI/8Gzj8JB56zw2REa44TAO5hSI 8Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgk22axbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:21:20 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4bnuN025421;
        Thu, 23 Mar 2023 10:21:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3pd4x661ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:21:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NALDDb64094702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 10:21:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC8F420078;
        Thu, 23 Mar 2023 10:21:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B08020077;
        Thu, 23 Mar 2023 10:21:13 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.164])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 10:21:13 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1pfI4H-0045Lj-0q;
        Thu, 23 Mar 2023 11:21:13 +0100
Date:   Thu, 23 Mar 2023 10:21:13 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fix hung_task when change host from recovery to
 running via sysfs
Message-ID: <20230323102113.GA859586@t480-pf1aa2c2>
References: <20230321084204.1860900-1-yebin@huaweicloud.com>
 <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
 <641A58D0.1020205@huawei.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <641A58D0.1020205@huawei.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O4pV-Ep14vT41oUpQBA0_T6_WQWsgRrM
X-Proofpoint-GUID: O4pV-Ep14vT41oUpQBA0_T6_WQWsgRrM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 36 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230075
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:24:32AM +0800, yebin (H) wrote:
> On 2023/3/21 22:22, Benjamin Block wrote:
> > On Tue, Mar 21, 2023 at 04:42:04PM +0800, Ye Bin wrote:
> >> From: Ye Bin <yebin10@huawei.com>
> >>
> >> When do follow test:
> >> Step1: echo  "recovery" > /sys/class/scsi_host/host0/state
> >
> > Hmm, that make me wonder, what potential use-case this is for? Just
> > testing?
>
> Thank you for your reply.
> Actually, I'm looking for a way to temporarily stop sending IO to the
> driver.
> Setting the state of the host to recovery can do this, but I changed
> the state to running and found that the process could not be woken up.
> I don't know what the purpose of designing this sysfs interface was.
> But this modification can solve the effect I want to achieve.

My first thought when seeing this was that maybe we should also limit
this interface to say `SHOST_RUNNING` and `SHOST_RECOVERY` (similar to
what is done in `store_state_field()`).
    That would limit the amount of corner cases drastically.

And in case of setting `SHOST_RUNNING` after the scsi host was set to
`SHOST_RECOVERY`, we could also make use of the already existing
function `scsi_restart_operations()` to handle the restart in the same
way as EH does.

But it's not up to me, to make that call.

> > For SDEVs we explicitly filter what states can be set from user-space.
> > Only `SDEV_RUNNING` and `SDEV_OFFLINE` can be set in
> > `store_state_field()`.
> >      There is probably quite a few other bad things you can do with this
> > interface by using any of the other states used for device destruction
> > or EH, and then trigger I/O or said destruction/EH otherwise.
> >      Not sure handling this one special case of `SHOST_RECOVERY` is quite
> > enough.
> >
> >> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> >> index ee28f73af4d4..ae6b1476b869 100644
> >> --- a/drivers/scsi/scsi_sysfs.c
> >> +++ b/drivers/scsi/scsi_sysfs.c
> >> @@ -216,6 +216,9 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
> >>
> >>        if (scsi_host_set_state(shost, state))
> >>                return -EINVAL;
> >> +     else
> >> +             wake_up(&shost->host_wait);

In the very least, this should first check whether we really just made
the transition from `SHOST_RECOVERY` to `SHOST_RUNNING` before calling
this `wake_up()`.
    And for that - first get old state, then set the new state - we
probably would also need to grab the `host_lock` to make that race free.

Just calling `wake_up()` without knowing what state transition we just
made doesn't sound right to me.

> >> +
> >>        return count;
> >>   }
> >>
> >> --
> >> 2.31.1
> >>
> 

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
