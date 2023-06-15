Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3D730CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbjFOBon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbjFOBol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:44:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F42726
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:44:17 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QhQ3L1sV7zMnl1;
        Thu, 15 Jun 2023 09:40:30 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 09:43:35 +0800
Message-ID: <c8e7106c-872f-4d18-f4d8-de4c450fc587@huawei.com>
Date:   Thu, 15 Jun 2023 09:43:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <prajnoha@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230518091614.137522-1-xiafukun@huawei.com>
 <86c6040d-17ab-fb01-2b75-717d82ba9345@huawei.com>
 <2023061444-latticed-discuss-fa70@gregkh>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <2023061444-latticed-discuss-fa70@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/15 4:09, Greg KH wrote:

> 
> How did you test it?  How have you verified that the previous failures
> were caught this time?
> 

My testing method is to apply the patch, compile the kernel image,
and start the QEMU virtual machine. Then compile and execute the code
mentioned in the patch that triggers out-of-bounds issues.

In addition, the following operations will be performed to verify the
functions mentioned by Peter Rajnoha <prajnoha@redhat.com>:

# echo "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" >
/sys/block/ram0/uevent

# udevadm monitor --kernel --env
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[189.376386] add      /devices/virtual/block/ram0 (block)
ACTION=add
DEVPATH=/devices/virtual/block/ram0
SUBSYSTEM=block
SYNTH_UUID=fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed
SYNTH_ARG_A=1
SYNTH_ARG_B=abc
DEVNAME=/dev/ram0
DEVTYPE=disk
DISKSEQ=14
SEQNUM=3781
MAJOR=1
MINOR=0

> You can understand my hesitancy here, right?
> 
> thanks,
> 
> greg k-h

I am not sure which experts can help review this patch, as I can
only find a limited number of people through the git blame command.
