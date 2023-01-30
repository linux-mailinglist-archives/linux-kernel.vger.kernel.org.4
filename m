Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D94680448
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjA3DaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3DaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:30:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6EB13DC5;
        Sun, 29 Jan 2023 19:30:00 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U2kP6b028113;
        Mon, 30 Jan 2023 03:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=TNzYEuPfJYyQMycQDqLpJOdz22M2dSjrgLy3Ps16vnY=;
 b=iuBKxOGXWpoo5UgtmpqK5x8smqVyJvVUe2H50FjYtd1evzXSrHAce4A9O8PXJRH1HUDe
 K1MwxdcURdLzjPM2shHrGanGZS9yd9AdJLP+OARQLbAgt5/Hxz/qAW3BAcVAZR5zvEjQ
 HR80PVz55Enh4o8/fs763xassQjMB/u1Ez3Yz4t0/yoOg5tGKmmhW2p0RQ0+KtHu1eL5
 zLNsAEjJ6NSFPGOHNaCMyy3VLAl7FmJ5iB64PtVk/lt39JUC4ThD5fLR/Fih+2VL6DG1
 CvkECRx47nM+rYpwlTflU23H/bBdwTdt4JODmQWw+SjDqr+XCuxxJO3RtRak1FlS/ULt kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ndds8bwxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:29:38 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30U3RHTt023562;
        Mon, 30 Jan 2023 03:29:38 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ndds8bwxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:29:38 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30TNKHFR028518;
        Mon, 30 Jan 2023 03:29:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuy8pe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:29:36 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30U3TZah9962136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 03:29:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81E926E050;
        Mon, 30 Jan 2023 03:31:40 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 701F66E04E;
        Mon, 30 Jan 2023 03:31:38 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.110.248])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 03:31:38 +0000 (GMT)
Message-ID: <7c5c38f128910f89f20533b7fd51453a32ff4f5c.camel@linux.ibm.com>
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create
 block device
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        hare@suse.de, bvanassche@acm.org, emilne@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Date:   Sun, 29 Jan 2023 22:29:02 -0500
In-Reply-To: <c3e58056-942a-f829-ecf6-1342c65b6865@huaweicloud.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
         <20230128094146.205858-3-zhongjinghua@huawei.com>
         <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
         <c3e58056-942a-f829-ecf6-1342c65b6865@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qS03s2VgW1zkaU7owePzLXQBrOTW8Xkb
X-Proofpoint-GUID: _cbRM7LKurVfOY4Js-r7ZJKGgMhA_PxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=943 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 11:07 +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/01/30 1:30, James Bottomley 写道:
> > On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
> > > This error will cause a warning:
> > > kobject_add_internal failed for block (error: -2 parent:
> > > 1:0:0:1). In the lower version (such as 5.10), there is no
> > > corresponding error handling, continuing to go down will trigger
> > > a kernel panic, so cc stable.
> > 
> > Is this is important point and what you're saying is that this only
> > panics on kernels before 5.10 or so because after that it's
> > correctly failed by block device error handling so there's nothing
> > to fix in later kernels?
> > 
> > In that case, isn't the correct fix to look at backporting the
> > block device error handling:
> 
> This is the last commit that support error handling, and there are
> many relied patches, and there are lots of refactor in block layer.
> It's not a good idea to backport error handling to lower version.
> 
> Althrough error handling can prevent kernel crash in this case, I
> still think it make sense to make sure kobject is deleted in order,
> parent should not be deleted before child.

Well, look, you've created a very artificial situation where a create
closely followed by a delete of the underlying sdev races with the
create of the block gendisk devices of sd that bind asynchronously to
the created sdev.  The asynchronous nature of the bind gives the
elongated race window so the only real fix is some sort of check that
the sdev is still viable by the time the bind occurs ... probably in
sd_probe(), say a scsi_device_get of sdp at the top which would ensure
viability of the sdev for the entire bind or fail the probe if the sdev
can't be got.

James


