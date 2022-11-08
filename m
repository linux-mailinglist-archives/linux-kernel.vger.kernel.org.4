Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360F621A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiKHRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiKHRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:11:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71259D4D;
        Tue,  8 Nov 2022 09:11:20 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8GvbdR000527;
        Tue, 8 Nov 2022 17:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0hpNoEBdpTfPWxrWghYS1K060jz/jhsWiCJsRukbfgg=;
 b=aLVcqJcK30u4BxaDy81KEqLbIkatgH86srQNs2zuIp9AJm3X4qpJ6TfnEauQHs41EX1E
 4RF0kRn8e/1mX3Ip+JpikvhZcyfuoqwpAfIuZyPc/5J2RDxlqCFMJzW6xvmO2X4Uy7WQ
 oET6RCWtf1ue6HMeJHGHStuP+0AB+4+YPBo0EuI2hxa9wlwKRJW9pSyYHw95XWGBMKxp
 DN3XDYkrqx/1C5RpH4IGOP1ZwowG9EfOAuAmRcjWjCYLrQBdkRwEs2+MQy0rxebTUD0u
 T8ZMIPkRau05R1A2qp+G/2PCGmw03RdrejW2LyWNtEbWvc/Ntu/4YCsfARIXPgXYh0sH aQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqsruv146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 17:11:06 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A8H5b4a015832;
        Tue, 8 Nov 2022 17:11:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3kngs4k8mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 17:11:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A8H5IgY44892480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Nov 2022 17:05:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDFE64C046;
        Tue,  8 Nov 2022 17:11:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA6CF4C040;
        Tue,  8 Nov 2022 17:11:01 +0000 (GMT)
Received: from dyn-9-152-224-237.boeblingen.de.ibm.com (unknown [9.152.224.237])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Nov 2022 17:11:01 +0000 (GMT)
Message-ID: <5a883e670b6f38fc7c3edde7343a205fbc56474b.camel@linux.ibm.com>
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-nvme@lists.infradead.org
Date:   Tue, 08 Nov 2022 18:11:01 +0100
In-Reply-To: <20221108074846.GA22674@lst.de>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
         <20221108074846.GA22674@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kCX14IO2WQLb_sL4RnBDEx__4PKmnlOM
X-Proofpoint-GUID: kCX14IO2WQLb_sL4RnBDEx__4PKmnlOM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

with your minimal fix

On Tue, 2022-11-08 at 08:48 +0100, Christoph Hellwig wrote:
> Below is the minimal fix.  I'll see if I sort out the mess that is
> probe/reset failure vs ->remove a bit better, though.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f94b05c585cbc..577bacdcfee08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>  
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
> +	if (!ctrl->tagset)
> +		return;
>  	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>  		blk_mq_quiesce_tagset(ctrl->tagset);
>  	else
> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>  
>  void nvme_start_queues(struct nvme_ctrl *ctrl)
>  {
> +	if (!ctrl->tagset)
> +		return;
>  	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>  		blk_mq_unquiesce_tagset(ctrl->tagset);
>  }

on next-20221108 the kernel does not crash any
more when I run the short test-script.

dmesg shows:
Nov 08 17:38:51 a46lp24.lnxne.boe kernel: nvme nvme0: pci function 0004:00:00.0
Nov 08 17:38:51 a46lp24.lnxne.boe kernel:
nvme nvme0: failed to mark controller CONNECTING
Nov 08 17:38:51 a46lp24.lnxne.boe kernel: nvme nvme0: Removing after
probe failure status: -16
Nov 08 17:38:52 a46lp24.lnxne.boe kernel: pci 0004:00:00.0: Removing from iommu group 0

while kernel remains up.
I can even do 
- rescan on the pci bus (to bring back the nvme drive), and
- run the test script
multiple times.

So from my point of view this band-aid is valuable to be incorporated while the larger 
overhaul in

https://lore.kernel.org/linux-nvme/20221108150252.2123727-1-hch@lst.de/
is out for review and test.

Feel free to add my
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>

Thank you,
Gerd Bayer

