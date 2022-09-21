Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA95BF8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiIUIKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIUIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:09:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3E1EEC9;
        Wed, 21 Sep 2022 01:09:51 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MXWHm2MXrz687YJ;
        Wed, 21 Sep 2022 16:08:04 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:09:47 +0200
Received: from [10.195.245.235] (10.195.245.235) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:09:47 +0100
Message-ID: <4d257e48-f7e3-4de3-fea1-ca6b0d21ea04@huawei.com>
Date:   Wed, 21 Sep 2022 09:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/6] libsas and drivers: NCQ error handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>, <hare@suse.de>
References: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
 <d2ff0ebf-e22f-85ac-6964-27bafadaf8f3@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <d2ff0ebf-e22f-85ac-6964-27bafadaf8f3@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.235]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 04:59, Damien Le Moal wrote:
> I tested this series on top of the current Linus tree. All look good. As 
> ususal, I hammered an SMR drive connected to a pm80xx adapter and 
> generated lots of invalid commands to check EH. No issues that I can see.
> E.g., an unaligned write error look like this:
> 
> [ 5384.194853] pm80xx0:: mpi_sata_event 2685: SATA EVENT 0x23
> [ 5384.238720] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [ 5384.246171] sas: sas_scsi_find_task: aborting task 0x0000000050be2a4b
> [ 5384.254654] pm80xx0:: mpi_sata_completion 2292: task null, freeing 
> CCB tag 2
> [ 5384.254676] sas: sas_scsi_find_task: task 0x0000000050be2a4b is aborted
> [ 5384.294659] sas: sas_eh_handle_sas_errors: task 0x0000000050be2a4b is 
> aborted
> [ 5384.318691] ata22.00: exception Emask 0x0 SAct 0x200000 SErr 0x0 
> action 0x0
> [ 5384.328425] ata22.00: failed command: WRITE FPDMA QUEUED
> [ 5384.336277] ata22.00: cmd 61/01:00:01:00:ea/00:00:02:00:00/40 tag 21 
> ncq dma 4096 out
> [ 5384.336277]          res 43/04:01:01:00:ea/00:00:02:00:00/00 Emask 
> 0x400 (NCQ error) <F>
> [ 5384.357299] ata22.00: status: { DRDY SENSE ERR }
> [ 5384.364459] ata22.00: error: { ABRT }
> [ 5384.553177] ata22.00: configured for UDMA/133
> [ 5384.560343] sd 19:0:3:0: [sdl] tag#80 FAILED Result: hostbyte=DID_OK 
> driverbyte=DRIVER_OK cmd_age=0s
> [ 5384.572175] sd 19:0:3:0: [sdl] tag#80 Sense Key : Illegal Request 
> [current]
> [ 5384.581765] sd 19:0:3:0: [sdl] tag#80 Add. Sense: Unaligned write 
> command
> [ 5384.591126] sd 19:0:3:0: [sdl] tag#80 CDB: Write(16) 8a 00 00 00 00 
> 00 02 ea 00 01 00 00 00 01 00 00
> [ 5384.602938] I/O error, dev sdl, sector 391118856 op 0x1:(WRITE) flags 
> 0x8800 phys_seg 1 prio class 2
> [ 5384.613854] ata22: EH complete
> [ 5384.618570] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 
> tries: 1
> 
> So looks good to me.
> 
> Feel free to add:
> 
> Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Great, thanks very much. I'll send an updated version based on mkp-scsi 
6.1 queue today.

John
