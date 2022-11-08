Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417262176C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiKHOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiKHOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:53:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20908FFE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:53:22 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8DT0d5020165;
        Tue, 8 Nov 2022 14:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Kq+EwDS9klVR2KEyoheGgm0wHLEBe3hpZ7mOespCuYA=;
 b=qw6QeK1swq6A+IpyvnkndjGcI7qBDQs5h9NeQgUwmymEedAoGLzYfYsyIWNuG9Y02fcF
 jJrtY18OoWnx6Hq+DbQOnCkgHCvdzTqQBRtMBepepfK8lgm+o3zn7TIRkEvlVgt6j5E5
 pcH2unbOlSIkzReAFsza6VKaABhbHGlaoMSK4a1ttdbhAfkmwHH/PqmIyqBNkoq8kebY
 RttTLwsm9ZppxHzfBur6BnSLXQuWnI+gqWBlaCLieknTsIAfkL2i/W0bvnGRyQSrFFj/
 o6Bpzwdh3vCjks8JkwS6q+rVdQDDawzNd0lhkmULA8BLy5UQ1WlSaDZC5uJacOHbXB9P lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqkhm3h78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:51:09 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A8CUCrI002463;
        Tue, 8 Nov 2022 14:51:09 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqkhm3h5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:51:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A8Eo5d2013960;
        Tue, 8 Nov 2022 14:51:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgca96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:51:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A8Ep3rq25559416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Nov 2022 14:51:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 126574C046;
        Tue,  8 Nov 2022 14:51:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E66404C040;
        Tue,  8 Nov 2022 14:51:00 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  8 Nov 2022 14:51:00 +0000 (GMT)
Date:   Tue, 8 Nov 2022 20:21:00 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ritesh.list@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <20221108145100.GG145013@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
 <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
 <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y2pKh3H0Ukvmfuco@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Y2pKh3H0Ukvmfuco@kroah.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RMyJNhVWo8VVHgJd8McL9rYsOSeF2_Te
X-Proofpoint-GUID: LgwVsDUfh8tUESdaAx-ZLClqfNPU_ZDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [2022-11-08 13:24:39]:

> On Tue, Nov 08, 2022 at 03:30:46PM +0530, Vishal Chourasia wrote:

Hi Greg, 

> > 
> > Thanks Greg & Peter for your direction. 
> > 
> > While we pursue the idea of having debugfs based on kernfs, we thought about
> > having a boot time parameter which would disable creating and updating of the
> > sched_domain debugfs files and this would also be useful even when the kernfs
> > solution kicks in, as users who may not care about these debugfs files would
> > benefit from a faster CPU hotplug operation.
> 
> Ick, no, you would be adding a new user/kernel api that you will be
> required to support for the next 20+ years.  Just to get over a
> short-term issue before you solve the problem properly.
> 
> If you really do not want these debugfs files, just disable debugfs from
> your system.  That should be a better short-term solution, right?
> 
> Or better yet, disable SCHED_DEBUG, why can't you do that?

Thanks a lot for your quick inputs.

CONFIG_SCHED_DEBUG disables a lot more stuff than just updation of debugfs
files. Information like /sys/kernel/debug/sched/debug and system-wide and
per process wide information would be lost when that config is disabled.

Most users would still be using distribution kernels and most distribution
kernels that I know of seem to have CONFIG_SCHED_DEBUG enabled.

In a large system, lets say close to 2000 CPUs and we are offlining around
1750 CPUs. For example ppc64_cpu --smt=1  on a powerpc. Even if we move to a
lesser overhead kernfs based implementation, we would still be creating
files and deleting files for every CPU offline. Most users may not even be
aware of these files. However for a few users who may be using these files
once a while, we end up creating and deleting these files for all users. The
overhead increases exponentially with the number of CPUs. I would assume the
max number of CPUs are going to increase in future further.

Hence our approach was to reduce the overhead for those users who are sure
they don't depend on these files. We still keep the creating of the files as
the default approach so that others who depend on it are not going to be
impacted.

> 
> thanks,
> 
> greg k-h

-- 
Thanks and Regards
Srikar Dronamraju
