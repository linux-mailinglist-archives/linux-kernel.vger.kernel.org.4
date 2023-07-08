Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3890174BB55
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGHCR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGHCR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:17:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26951FD8;
        Fri,  7 Jul 2023 19:17:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3681GNLv032191;
        Sat, 8 Jul 2023 02:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=iKXrYXW+SZTvwYGgYg/iGhzofml+sd2lug8FJDB8pyI=;
 b=oEGBJeoK3/AYI5+vTDg64doIU8GdLy6azGCmJiFWxO6Nt+wOBBb/lXiEJ3p/snMSHuw6
 W2CHecp70jJRj5Ib0J4HivZniHdgGBD8bl5Pa9RSkOIz5npsYpYEIyu8fYN6RlyHi1bs
 hrl4Xr1z8gv63EwGyRFF6+zUxtwkhBMl4JsbX5L+dw00F44d2HLyFVTFJPSMtyqXeUGw
 zZ2KINLtugeHf7ieyigDBnIGHmm99irS9LIJYSjtdNQXKyWQI597Dkf4nrGKGFMQIwcV
 dJYcFq85e3NhXQpOn9+FmuanzsdPnBeV2RqaCWK00nluI2s34K9KCR3J9YjuZFbtobji 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xj1sf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 02:17:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3681XnRt006530;
        Sat, 8 Jul 2023 02:15:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx87rkw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 02:15:15 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3682FEKg002005;
        Sat, 8 Jul 2023 02:15:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rpx87rkuh-1;
        Sat, 08 Jul 2023 02:15:14 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     davem@davemloft.net
Cc:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        david@fries.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v8 0/6] Process connector bug fixes & enhancements
Date:   Fri,  7 Jul 2023 19:15:06 -0700
Message-ID: <20230708021512.3929237-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080019
X-Proofpoint-GUID: 4-Ode-hruDcqaA6dh7FaaDT8Sfvf-XOD
X-Proofpoint-ORIG-GUID: 4-Ode-hruDcqaA6dh7FaaDT8Sfvf-XOD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oracle DB is trying to solve a performance overhead problem it has been
facing for the past 10 years and using this patch series, we can fix this
issue.

Oracle DB runs on a large scale with 100000s of short lived processes,
starting up and exiting quickly. A process monitoring DB daemon which
tracks and cleans up after processes that have died without a proper exit
needs notifications only when a process died with a non-zero exit code
(which should be rare).

Due to the pmon architecture, which is distributed, each process is
independent and has minimal interaction with pmon. Hence fd based
solutions to track a process's spawning and exit cannot be used. Pmon
needs to detect the abnormal death of a process so it can cleanup after.
Currently it resorts to checking /proc every few seconds. Other methods
we tried like using system call to reduce the above overhead were not
accepted upstream.

With this change, we add event based filtering to proc connector module
so that DB can only listen to the events it is interested in. A new
event type PROC_EVENT_NONZERO_EXIT is added, which is only sent by kernel
to a listening application when any process exiting has a non-zero exit
status.

This change will give Oracle DB substantial performance savings - it takes
50ms to scan about 8K PIDs in /proc, about 500ms for 100K PIDs. DB does
this check every 3 secs, so over an hour we save 10secs for 100K PIDs.

With this, a client can register to listen for only exit or fork or a mix or
all of the events. This greatly enhances performance - currently, we
need to listen to all events, and there are 9 different types of events.
For eg. handling 3 types of events - 8K-forks + 8K-exits + 8K-execs takes
200ms, whereas handling 2 types - 8K-forks + 8K-exits takes about 150ms,
and handling just one type - 8K exits takes about 70ms.

Measuring the time using pidfds for monitoring 8K process exits took 4
times longer - 200ms, as compared to 70ms using only exit notifications
of proc connector. Hence, we cannot use pidfd for our use case.

This kind of a new event could also be useful to other applications like
Google's lmkd daemon, which needs a killed process's exit notification.

This patch series is organized as follows -

Patch 1 : Needed for patch 3 to work.
Patch 2 : Needed for patch 3 to work.
Patch 3 : Fixes some bugs in proc connector, details in the patch.
Patch 4 : Adds event based filtering for performance enhancements.
Patch 5 : Allow non-root users access to proc connector events.
Patch 6 : Selftest code for proc connector.

v7->v8 changes:
- Fixed an issue pointed by Liam & Eric Dumazet in v7.

v6->v7 changes:
- Incorporated Liam Howlett's comments on v6
- Incorporated Kalesh Anakkur Purayil's comments

v5->v6 changes:
- Incorporated Liam Howlett's comments
- Removed FILTER define from proc_filter.c and added a "-f" run-time
  option to run new filter code.
- Made proc_filter.c a selftest in tools/testing/selftests/connector

v4->v5 changes:
- Change the cover letter
- Fix a small issue in proc_filter.c

v3->v4 changes:
- Fix comments by Jakub Kicinski to incorporate root access changes
  within bind call of connector

v2->v3 changes:
- Fix comments by Jakub Kicinski to separate netlink (patch 2) (after
  layering) from connector fixes (patch 3).
- Minor fixes suggested by Jakub.
- Add new multicast group level permissions check at netlink layer.
  Split this into netlink & connector layers (patches 6 & 7)

v1->v2 changes:
- Fix comments by Jakub Kicinski to keep layering within netlink and
  update kdocs.
- Move non-root users access patch last in series so remaining patches
  can go in first.

v->v1 changes:
- Changed commit log in patch 4 as suggested by Christian Brauner
- Changed patch 4 to make more fine grained access to non-root users
- Fixed warning in cn_proc.c,
  Reported-by: kernel test robot <lkp@intel.com>
- Fixed some existing warnings in cn_proc.c

Anjali Kulkarni (6):
  netlink: Reverse the patch which removed filtering
  netlink: Add new netlink_release function
  connector/cn_proc: Add filtering to fix some bugs
  connector/cn_proc: Performance improvements
  connector/cn_proc: Allow non-root users access
  connector/cn_proc: Selftest for proc connector

 drivers/connector/cn_proc.c                   | 111 ++++++-
 drivers/connector/connector.c                 |  40 ++-
 drivers/w1/w1_netlink.c                       |   6 +-
 include/linux/connector.h                     |   8 +-
 include/linux/netlink.h                       |   6 +
 include/uapi/linux/cn_proc.h                  |  62 +++-
 net/netlink/af_netlink.c                      |  33 +-
 net/netlink/af_netlink.h                      |   4 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/connector/Makefile    |   6 +
 .../testing/selftests/connector/proc_filter.c | 310 ++++++++++++++++++
 11 files changed, 545 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/connector/Makefile
 create mode 100644 tools/testing/selftests/connector/proc_filter.c

-- 
2.41.0

