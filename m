Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1474787A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGDSvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:51:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B3EE;
        Tue,  4 Jul 2023 11:51:50 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364Il5g5020043;
        Tue, 4 Jul 2023 18:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BEaAPQb9/hi/grRsiWwjhEKWhzwFu6dfsrx0qI9ktGs=;
 b=QWevA3yElF8hr1JHSWwlAwQ6K0rBiKJFwmEfDuF0hLGd94uWBZQO3gFGo6t480AH0zed
 Q5rEWxDGOUNX6epWkVkjGk6cJq/BOhWONSnUYcIUKEWsgkCPGRL03bRi+NEjam3vyraJ
 /QavxBSxd8+joCmekVY2yn7txb4yrbBvAE6YFRqeoMoNYUvfEkdmggcHslcDW/YOAKGH
 dqXGHFXOkUnCabFIC+FkitiA7XD2NyeDTmM4aAPmD2hqone4H8cb7EElY/MebGR34luc
 bk6dJIzjdwkFnEy37FtRTq/JOj5AWpQvHjcZtanrYNV6WWi6y+J0j0uxJFIcoi/ojjhc sA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rms0j81th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 18:51:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3642rKEK007765;
        Tue, 4 Jul 2023 18:51:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde27mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 18:51:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 364IpBre26607890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 18:51:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F3E220043;
        Tue,  4 Jul 2023 18:51:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0888920040;
        Tue,  4 Jul 2023 18:51:11 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.95])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 18:51:10 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1qGl7G-002b1X-1x;
        Tue, 04 Jul 2023 20:51:10 +0200
Date:   Tue, 4 Jul 2023 20:51:10 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Marc Hartmayer <mhartmay@linux.ibm.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, hch@lst.de, chaitanyak@nvidia.com,
        shinichiro.kawasaki@wdc.com, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, yukuai3@huawei.com,
        axboe@kernel.dk
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
Message-ID: <20230704185110.GA10217@t480-pf1aa2c2>
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
 <87lefv622n.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lefv622n.fsf@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3HeN6U--vCdwHkCcBj2iFZy9uVsSATDH
X-Proofpoint-ORIG-GUID: 3HeN6U--vCdwHkCcBj2iFZy9uVsSATDH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_12,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:04:00PM +0200, Marc Hartmayer wrote:
> On Thu, Jun 22, 2023 at 12:01 AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> > diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> > index 2433eeef042a..dcb73787c29d 100644
> > --- a/drivers/scsi/sg.c
> > +++ b/drivers/scsi/sg.c
> > @@ -1497,7 +1497,7 @@ sg_add_device(struct device *cl_dev)
> >  	int error;
> >  	unsigned long iflags;
> >  
> > -	error = scsi_device_get(scsidp);
> > +	error = blk_get_queue(scsidp->request_queue);
> >  	if (error)
> >  		return error;
> >  

Might be interesting as well. Marc showed me a `dmesg` snipped earlier
from when the bind fails:

  [   15.441817] scsi host2: scsi_eh_2: sleeping
  [   15.441899] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
  [   15.441907] scsi host2: scsi_debug: version 0191 [20210520]
                   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
  [   15.442078] scsi host2: scsi_scan_host_selected: <4294967295:4294967295:18446744073709551615>
  [   15.442267] scsi 2:0:0:0: scsi scan: INQUIRY pass 1 length 36
  [   15.442286] scsi 2:0:0:0: scsi scan: INQUIRY successful with code 0x0
  [   15.442296] scsi 2:0:0:0: scsi scan: INQUIRY pass 2 length 96
  [   15.442308] scsi 2:0:0:0: scsi scan: INQUIRY successful with code 0x0
  [   15.442317] scsi 2:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
  [   15.442554] scsi 2:0:0:0: Power-on or device reset occurred
  [   15.442560] scsi 2:0:0:0: tag#50 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
  [   15.442565] scsi 2:0:0:0: tag#50 CDB: Report supported operation codes a3 0c 01 88 00 00 00 00 00 14 00 00
  [   15.442569] scsi 2:0:0:0: tag#50 Sense Key : Unit Attention [current]
  [   15.442573] scsi 2:0:0:0: tag#50 Add. Sense: Power on occurred

The bind should happend around here somewhere I think.

  [   15.472680] sd 2:0:0:0: scsi scan: Sending REPORT LUNS to (try 0)
  [   15.472703] sd 2:0:0:0: scsi scan: REPORT LUNS successful (try 0) result 0x0
  [   15.472706] sd 2:0:0:0: scsi scan: REPORT LUN scan
  [   15.472709] sd 2:0:0:0: scsi scan: device exists on 2:0:0:0
  [   15.492874] sd 2:0:0:0: [sdi] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
  [   15.502853] sd 2:0:0:0: [sdi] Write Protect is off
  [   15.502856] sd 2:0:0:0: [sdi] Mode Sense: 73 00 10 08
  [   15.522819] sd 2:0:0:0: [sdi] Write cache: enabled, read cache: enabled, supports DPO and FUA
  [   15.552773] sd 2:0:0:0: [sdi] Preferred minimum I/O size 512 bytes
  [   15.552776] sd 2:0:0:0: [sdi] Optimal transfer size 524288 bytes
  [   15.575373] sd 2:0:0:0: [sdi] tag#62 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
  [   15.575377] sd 2:0:0:0: [sdi] tag#62 CDB: Inquiry 12 01 b9 00 04 00
  [   15.575380] sd 2:0:0:0: [sdi] tag#62 Sense Key : Illegal Request [current]
  [   15.575383] sd 2:0:0:0: [sdi] tag#62 Add. Sense: Invalid field in cdb
  [   15.645749] sd 2:0:0:0: [sdi] Attached SCSI disk

But we don't even see the `sg_alloc: dev=...` message that is logged in
`sg_alloc()`. And between the change above and the call to `sg_alloc()`,
there is only the character device allocation; and if that failed, it
would print an error. So either the bind is never even tried, or the new
`blk_get_queue()` fails to get a reference.
    Which is odd, since the only way that would happen is, if the queue
was marked dying; but we see that the stack is using it for LUN probing
in `sd`.

> This change (bisected) triggers a regression in our KVM on s390x CI. The
> symptom is that a “scsi_debug device” does not bind to the scsi_generic
> driver. On s390x you can reproduce the problem as follows (I have not
> tested on x86):
> 
> With this patch applied:
> 
> $ sudo modprobe scsi_debug

One more thing maybe worth mentioning: in the kernel configuration we
use in the CI we have `sg` built-in. I guess most have it built as
module.

> $ # Get the 'scsi_host,channel,target_number,LUN' tuple for the scsi_debug device
> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
> [0:0:0:0]
> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
> stat: cannot statx '/sys/bus/scsi/devices/0:0:0:0/scsi_generic': No such file or directory
> 
> 
> Patch reverted:
> 
> $ sudo modprobe scsi_debug
> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
> [0:0:0:0]
> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>   File: /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>   Size: 0         	Blocks: 0          IO Block: 4096   directory
> Device: 0,20	Inode: 12155       Links: 3
> …

That's all I got from looking at it earlier, so far.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
