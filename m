Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64369C96A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBTLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjBTLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:14:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9D1ABE7;
        Mon, 20 Feb 2023 03:14:09 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K9xH5L015352;
        Mon, 20 Feb 2023 11:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=xR7MhnROeM1r0/Sm02pu8nKl+srHSuBfn9ADf82CgeY=;
 b=g4ZF9puM0rx4fyEMPtasQlBLZS250ZRvUu58Xv7LHRm6IuuZNShKzsD9lHWwC62+FXJF
 w6qOTWlqnHU/KL9/Dt8fl1CPuVhE3Q8wCQSpPtDvQOHwuFSFlYgpJVQ5ejaqC+UtAnXA
 Phsp1wqMizo+vyUlfA552h7VdXbVxwLjqrIGPXfraSz+RgoE90VYKanOtDORZ1puY8Sr
 ZQZMV0LLXkzGj+wWU0YJh2vb67yrd0YGgj1aT6Tpd4JVWRi2/GGjSZgFj53jzs26vRdn
 7yshGtPbJ8wZBUQN/WF+PqhDBG3uEQ4Xf85kG3Pkycb+mYdePCb9IyLj5SCFbLuMRxZt ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6qbhr5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:14:02 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KAkpaX032615;
        Mon, 20 Feb 2023 11:14:02 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6qbhr4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:14:02 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31K7sJQe030599;
        Mon, 20 Feb 2023 11:14:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ntpa69xug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:14:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KBDwph30015762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 11:13:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8CB320043;
        Mon, 20 Feb 2023 11:13:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5078320040;
        Mon, 20 Feb 2023 11:13:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 20 Feb 2023 11:13:56 +0000 (GMT)
Date:   Mon, 20 Feb 2023 16:43:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Lee Duncan <leeman.duncan@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Message-ID: <20230220111355.GA805552@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220928181350.9948-1-leeman.duncan@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0eSVwE3sxnfqcUe2PAOOmKubdcJCQFzD
X-Proofpoint-ORIG-GUID: XL0Tm_2lZtxMKzosClRqRAQV5kX6u70r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302200100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Duncan <leeman.duncan@gmail.com> [2022-09-28 11:13:50]:

> From: Lee Duncan <lduncan@suse.com>
> 
> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
> (front end) do not like the recent commit:
> 
> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> 
> That commit changed getting SCSI VPD pages so that we now read
> just enough of the page to get the actual page size, then read
> the whole page in a second read. The problem is that the above
> mentioned hardware returns zero for the page size, because of
> a firmware error. In such cases, until the firmware is fixed,
> this new black flag says to revert to the original method of
> reading the VPD pages, i.e. try to read as a whole buffer's
> worth on the first try.
> 
> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> Reported-by: Martin Wilck <mwilck@suse.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Duncan <lduncan@suse.com>

Facing similar problem on latest upstream kernel and this fixes it in my
testing.

Incase this helps:

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


Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>


-- 
Thanks and Regards
Srikar Dronamraju
