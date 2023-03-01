Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244426A7486
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCATwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCATwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:52:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29099497FB;
        Wed,  1 Mar 2023 11:52:19 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321J6jrn002151;
        Wed, 1 Mar 2023 19:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=bN+eSv473stxdX6f/2RM/Yu9WCP/4a7goXSYB44BrrU=;
 b=m67HIef2cbFx9wyTpc1VyZNDppH59dZUUe3Xl5m9jM0hYAHdv/jQlC9UdWEjgoTe2KuL
 MaxaS0CUMut6j/ufJ38vk8XnyHlI3l0f+g3n6FbicoBh5gemsaTSpMPVY17SDFl6U/Lh
 xmCRRgyiiCw0ZEG7iTjEGsD1AuhLQzECtBm1RGN7+kqXCGmT2PeADoXPAZvM/T4DsuND
 fO7kpmlB7IlW7cf20erJS2RzEAriEv/URrIx79Nw5J7+MD5sXtxhRtoSC92HmdDMdeY6
 FNUGVJTApehjif05CI4RWCf+Gol4viucontgoPl6LH4AqY6s5UJrmX/QUdgTSOI46jgg YA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2cjs92ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:52:02 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 321JECDV024469;
        Wed, 1 Mar 2023 19:52:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nybe9rrsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:52:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 321Jq0x046006672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 19:52:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C7E65805D;
        Wed,  1 Mar 2023 19:52:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 462D758058;
        Wed,  1 Mar 2023 19:51:59 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.163.79.233])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Mar 2023 19:51:59 +0000 (GMT)
Message-ID: <afba754afa2bd1fe7e0e72400b202db5b51ecdd8.camel@linux.ibm.com>
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     zhongjinghua <zhongjinghua@huaweicloud.com>,
        zhongjinghua <zhongjinghua@huawei.com>,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
Date:   Wed, 01 Mar 2023 14:51:58 -0500
In-Reply-To: <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
         <4585779e-f919-0439-2062-b1f30b04f176@huawei.com>
         <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HI5Yc6kzjOcknZ1dUiIpIQ-mFU8Nx7Py
X-Proofpoint-GUID: HI5Yc6kzjOcknZ1dUiIpIQ-mFU8Nx7Py
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-01 at 11:40 +0800, zhongjinghua wrote:
> ping...
> 
> Hello，
> 
> Anyone looking this？
> 
> 在 2023/3/1 11:37, zhongjinghua 写道:
> > ping...
> > 
> > Hello，
> > 
> > Anyone looking this？
> > 
> > 在 2023/2/13 11:43, Zhong Jinghua 写道:
> > > From: Zhong Jinghua <zhongjinghua@huawei.com>
> > > 
> > > A use-after-free problem like below:
> > > 
> > > BUG: KASAN: use-after-free in scsi_target_reap+0x6c/0x70
> > > 
> > > Workqueue: scsi_wq_1 __iscsi_unbind_session
> > > [scsi_transport_iscsi]
> > > Call trace:
> > >   dump_backtrace+0x0/0x320
> > >   show_stack+0x24/0x30
> > >   dump_stack+0xdc/0x128
> > >   print_address_description+0x68/0x278
> > >   kasan_report+0x1e4/0x308
> > >   __asan_report_load4_noabort+0x30/0x40
> > >   scsi_target_reap+0x6c/0x70
> > >   scsi_remove_target+0x430/0x640
> > >   __iscsi_unbind_session+0x164/0x268 [scsi_transport_iscsi]
> > >   process_one_work+0x67c/0x1350
> > >   worker_thread+0x370/0xf90
> > >   kthread+0x2a4/0x320
> > >   ret_from_fork+0x10/0x18
> > > 
> > > The problem is caused by a concurrency scenario:
> > > 
> > > T0: delete target
> > > // echo 1 > 
> > > /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
> > > T1: logout
> > > // iscsiadm -m node --logout
> > > 
> > > T0                            T1
> > >   sdev_store_delete
> > >    scsi_remove_device
> > >     device_remove_file
> > >      __scsi_remove_device
> > >                              __iscsi_unbind_session
> > >                               scsi_remove_target
> > >                           spin_lock_irqsave
> > >                                list_for_each_entry
> > >       scsi_target_reap // starget->reaf 1 -> 0
> > > kref_get(&starget->reap_ref);
> > >                           // warn use-after-free.
> > >                           spin_unlock_irqrestore
> > >        scsi_target_reap_ref_release
> > >     scsi_target_destroy
> > >     ... // delete starget
> > >                           scsi_target_reap
> > >                           // UAF
> > > 
> > > When T0 reduces the reference count to 0, but has not been
> > > released,
> > > T1 can still enter list_for_each_entry, and then kref_get reports
> > > UAF.
> > > 
> > > Fix it by using kref_get_unless_zero() to check for a reference
> > > count of
> > > 0.
> > > 
> > > Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> > > ---
> > >   drivers/scsi/scsi_sysfs.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/scsi/scsi_sysfs.c
> > > b/drivers/scsi/scsi_sysfs.c
> > > index e7893835b99a..0ad357ff4c59 100644
> > > --- a/drivers/scsi/scsi_sysfs.c
> > > +++ b/drivers/scsi/scsi_sysfs.c
> > > @@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device
> > > *dev)
> > >               starget->state == STARGET_CREATED_REMOVE)
> > >               continue;
> > >           if (starget->dev.parent == dev || &starget->dev == dev)
> > > {
> > > -            kref_get(&starget->reap_ref);
> > > +
> > > +            /*
> > > +             * If starget->reap_ref is reduced to 0, it means
> > > +             * that other processes are releasing it and
> > > +             * there is no need to delete it again
> > > +             */
> > > +            if (!kref_get_unless_zero(&starget->reap_ref)) {
> > > +                spin_unlock_irqrestore(shost->host_lock, flags);
> > > +                goto restart;

This doesn't seem to be a good idea: you're asking for a live lock
where the thread that's already reduced the refcount to 0 and will
eventually remove the target from the list doesn't progress before you
take the lock again in the restart and then you find the same result
and go round again (and again ...).

Since there should only be one match in the target list and you found
it and know it's going away, what about break instead of unlock and
goto restart?

James

