Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F565744E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiL1Itc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiL1Is5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:48:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D921FCD4;
        Wed, 28 Dec 2022 00:47:00 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NhlTx3DyRzmWts;
        Wed, 28 Dec 2022 16:45:41 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 16:46:52 +0800
Message-ID: <2002bec1-27af-5b4f-7bea-fca62506ca59@huawei.com>
Date:   Wed, 28 Dec 2022 16:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] scsi:core:Add sysfs interface to control if skip lun
 with PQ=1
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <20221214070846.1808300-2-haowenchao@huawei.com>
 <536981a8-76a3-54b9-a70c-a86994c027dd@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <536981a8-76a3-54b9-a70c-a86994c027dd@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500013.china.huawei.com (7.185.36.41) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/19 5:37, Mike Christie wrote:
> On 12/14/22 1:08 AM, Wenchao Hao wrote:
>>
>> When iSCSI initiator logged in target, the target attached none valid
>> lun but lun0. lun0 is not an valid disk, while it would response
>> inquiry command with PQ=1 and other general scsi commands like probe lun.
>> The others luns of target is added/removed dynamicly.
>>
>> We want the lun0 to be mapped to an sg device in initiator, so we can
>> probe luns of target based on lun0.
> 
> What do you want to do exactly? Is the idea with your patch we would create
> an sg device, then in userpsace you would do some scan related commands. If
> you find devices then you use sysfs to have scsi-ml scan/add a specific device
> like
> 
> echo 5 0 0 8 > host5/scan
> 
> ?
> 
> It's not really clear to me why you need the sg device, and can't just do?
> 
> echo - - - > .../hostN/scan
>
We do not directly echo - - - > .../hostN/scan. Instead, we use rescan-scsi-bus.sh
defined in sg3_utils to scan luns. If no sg device mapped to this host, the default
scan operations could not recognize luns.

We can simulate this with scsi_debug by following steps:

1. build scsi debug with following changes;

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 8553277effb3..36dcdd2c3fe4 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -836,6 +836,7 @@ static int dif_errors;
 static bool sdeb_zbc_in_use;   /* true for host-aware and host-managed disks */
 static int sdeb_zbc_zone_cap_mb;
 static int sdeb_zbc_zone_size_mb;
+static int sdeb_pq_type;
 static int sdeb_zbc_max_open = DEF_ZBC_MAX_OPEN_ZONES;
 static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 
@@ -1583,6 +1584,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
        u32 alloc_len, n;
        int ret;
        bool have_wlun, is_disk, is_zbc, is_disk_zbc;
+       struct scsi_device *sdev = scp->device;
 
        alloc_len = get_unaligned_be16(cmd + 3);
        arr = kzalloc(SDEBUG_MAX_INQ_ARR_SZ, GFP_ATOMIC);
@@ -1598,7 +1600,11 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
                pq_pdt = 0x7f;  /* not present, PQ=3, PDT=0x1f */
        else
                pq_pdt = (sdebug_ptype & 0x1f);
-       arr[0] = pq_pdt;
+       if (sdev->lun == 0) {
+               arr[0] = pq_pdt | (sdeb_pq_type << 5);
+       } else {
+               arr[0] = pq_pdt;
+       }
        if (0x2 & cmd[1]) {  /* CMDDT bit set */
                mk_sense_invalid_fld(scp, SDEB_IN_CDB, 1, 1);
                kfree(arr);
@@ -5883,6 +5889,7 @@ module_param_named(zone_cap_mb, sdeb_zbc_zone_cap_mb, int, S_IRUGO);
 module_param_named(zone_max_open, sdeb_zbc_max_open, int, S_IRUGO);
 module_param_named(zone_nr_conv, sdeb_zbc_nr_conv, int, S_IRUGO);
 module_param_named(zone_size_mb, sdeb_zbc_zone_size_mb, int, S_IRUGO);
+module_param_named(pq_type, sdeb_pq_type, int, S_IRUGO);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -7825,6 +7832,7 @@ static int sdebug_driver_probe(struct device *dev)
                error = -ENODEV;
                return error;
        }
+       //hpnt->no_skip_pq1 = 1;
        if (submit_queues > nr_cpu_ids) {
                pr_warn("%s: trim submit_queues (was %d) to nr_cpu_ids=%u\n",
                        my_name, submit_queues, nr_cpu_ids);

2. insmod scsi_debug with modparam max_luns=4 pq_type=1, we would get following scsi devices

# lsscsi -g
[0:0:0:1]    disk    Linux    scsi_debug       0191  /dev/sda   /dev/sg0 
[0:0:0:2]    disk    Linux    scsi_debug       0191  /dev/sdb   /dev/sg1 
[0:0:0:3]    disk    Linux    scsi_debug       0191  /dev/sdc   /dev/sg2 

3. remove the scsi_debug disks

echo 1 > /sys/block/sda/device/delete
echo 1 > /sys/block/sdb/device/delete
echo 1 > /sys/block/sdc/device/delete

4. scan with rescan-scsi-bus.sh would failed to discovery luns.

# rescan-scsi-bus.sh 
Scanning SCSI subsystem for new devices
Scanning host 0 for  SCSI target IDs 0 1 2 3 4 5 6 7, all LUNs
0 new or changed device(s) found.          
0 remapped or resized device(s) found.
0 device(s) removed.

Did not add the luns. If do not comment the line hpnt->no_skip_pq1 = 1 in
scsi_debug.c, the scan operations would found these luns succeed.

> ? Do you only want to add specific devices like you are doing some sort of
> LUN masking on the initiator side?
> 
> Is the issue that you need the sg device there, so you can detect when a device
> is no longer present on the target and then you will have userspace remove the
> device via the sysfs delete file?
> .

Yes, this is one scenarios. luns on the target are removed or added dynamically,
the only fixed one is LUN0 which response PQ=1.

If luns are removed from target after been added by initiator, we could know which
one should be removed from initiator via LUN0.

We can think LUN0 with PQ=1 is a dummy lun, which is fixed and can tell luns info on
the target.

According to the SPC, PQ=1 means the addressed logical unit having the
indicated device type is not accessible, it does not mean the addressed
logical unit is invalid. So I think we still can map this lun to an sg device.
