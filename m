Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D8600D56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJQLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJQLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:02:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C0631EB;
        Mon, 17 Oct 2022 04:01:16 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrYqg1GB2z688sf;
        Mon, 17 Oct 2022 18:57:51 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 17 Oct 2022 13:00:56 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 12:00:55 +0100
Message-ID: <6319a91e-43c8-e4c9-915b-29bfe1532c02@huawei.com>
Date:   Mon, 17 Oct 2022 12:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 4/8] scsi: hisi_sas: Modify v3 HW SATA disk error state
 completion processing
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangxingui@huawei.com" <yangxingui@huawei.com>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
 <1665998435-199946-5-git-send-email-john.garry@huawei.com>
 <Y00yW9PhSJWjobVC@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y00yW9PhSJWjobVC@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 11:45, Niklas Cassel wrote:
> On Mon, Oct 17, 2022 at 05:20:31PM +0800, John Garry wrote:
>> From: Xingui Yang<yangxingui@huawei.com>
>>
>> When an NCQ error occurs, the  controller will abnormally complete the I/Os
>> that are newly delivered to disk, and bit8 in CQ dw3 will be set which
>> indicates that the SATA disk is in error state. The current processing flow
>> is to set ts->stat to SAS_OPEN_REJECT and then sas_ata_task_done() will
>> set FIS stat to ATA_ERR. After analyzing the IO by ata_eh_analyze_tf(),
>> err_mask will set to AC_ERR_HSM. If media error occurs for four times
>> within 10 minutes and the chip rejects new I/Os for four times, NCQ will
>> be disabled due to excessive errors, which is undesirable.
> With patch 8/8 in this series, will it still set err_mask to AC_ERR_HSM?
> If not, is this patch still needed with patch 8/8?
> 

I spoke to colleague Xingui Yang and he does not think that it is still 
required. But I was leaving it in as it still looked like a sensible 
change. I suppose I can drop it.

Thanks,
John
