Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D962907B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiKODHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiKODHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:07:04 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D16174
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668481573; x=1700017573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eAtL+g3I1NWdP7dXAC2VR2pZ+0ZdpHbdR4rh9zzzVq8=;
  b=G/JwG0L11aHoLN2kh7+4CMzyAA07XCeDSHjUsqY5hLcS50FD1nC7Hso1
   bBF0l3FFofKUNzYlIWIcHldZ4DFdFHgHCZ9LbgMqeGcPqeHEMv2L1Xyvk
   tPEQZ+aSUIsxYg+lNJrV+3YdTE/vjDqo7YC8vIYu1rBlycGBD1Kx7NOlL
   3gjWQwgSTttzhGkOeow3t0qvcY1TrrpIReGw9RVjAo4zRUF7Kpq2Ui7Vh
   BJ/3m/jvErcjMB1djVgMk+6hnE4aypOjLPQSc6XvO7shP7FoK4Tr94Syo
   vNrAMoYaO5Z/F5nhG05R2BxAP6B4sAADKYmideSj6otjNY04jFM6h7MZV
   A==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; 
   d="scan'208";a="216603054"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 11:06:10 +0800
IronPort-SDR: gbP/ext6zml+5mzPNIFnUxdm9RhjXGaN5d8MmzLT42hObogu7SfOhHMIbuB6rD8qbLVInZDSN/
 V+lPuyFNt6UosMQ7ZUblqU/cC1+MLwYiIcpIDJ84nYDm/scPZcVPfCr8v2MvwFx9MGoobRO9So
 Gef/MJmAPobhaAI1u6SP4ZVfG7TePq5hq3qoIiUWNvvgeT/lpEhaFeDLSEKTpQOUa92m6Hzimq
 sShMTelcovIFO9FZzrGA9IhBId7/lhzzj3S3U9FKksuWXddOBRTfoEFz8CFv6AL2pzlf2DhkEO
 USk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 18:25:08 -0800
IronPort-SDR: RlkxMf15PfUxIYrYgy1TGCYPJhh3iZuC2s71tqg8eemlbHwjXIz11HK94X00fU9g7pXU7CNrjo
 iSiTol7TeXYSJMG720dJWT+YsnfSPXspdgIJZ+y672JeCoVQ2ythf8En7dFyoHHcKFNeygQzhn
 Z18FqBGJT2qlZHSBkYkoWcDdGc/AyraCB4ZMsSIqvC253gQUCHl78urBLAJKpIlcn/fi8P7ytw
 5joR++Gj0F8PkbHseXqruN0tuLx+mY4SoQWg6vsSV93bUEwSmoTsODibrbJQizlAy9kahnvJkq
 7oI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 19:06:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBB022Btrz1Rwtl
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:06:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668481569; x=1671073570; bh=eAtL+g3I1NWdP7dXAC2VR2pZ+0ZdpHbdR4r
        h9zzzVq8=; b=Dnuk4bTcSh5z80wfH/3zO82WruA3D0pdRN+xP2rjQcsDIHSMn6g
        unn1v4cur/yqhI6U+esxP222RjEB77zlZRJS+0+aC+pdkwT33cRsT/3tk1K8tt1I
        0ZLMtL9JAhjBA7E2ilRfUlAUwivZcFf4zkVp+LeUAhuzArhNToDuYz1b0BwgTjRQ
        iitCCG9D2LHgLlP5Yd4dk0cSN7Zj4SjXu5BfcqlR/gkzQCs7EQR47G1DABykz61S
        z51tADd3QZTk17/by6l4KHd6erVmyCWu5zZ6sYVQ+IFPT5+ddvDqpxJo/IzVZspB
        FyL+cnvCNJrfJYHxxTLOCQN3BtFquLh6Krw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 80Oy-DFZ-jP1 for <linux-kernel@vger.kernel.org>;
        Mon, 14 Nov 2022 19:06:09 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NB9zz6fZcz1RvLy;
        Mon, 14 Nov 2022 19:06:07 -0800 (PST)
Message-ID: <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
Date:   Tue, 15 Nov 2022 12:06:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202211140853.11115.linux@zary.sk>
 <f8ce8ecd-cadd-d9ca-d2fa-1251804344f0@opensource.wdc.com>
 <202211142025.46723.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202211142025.46723.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 04:25, Ondrej Zary wrote:
> On Monday 14 November 2022 09:03:28 Damien Le Moal wrote:
>> On 11/14/22 16:53, Ondrej Zary wrote:
>>> On Monday 14 November 2022, Damien Le Moal wrote:
>>>> On 11/12/22 20:17, Ondrej Zary wrote:
>>>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
>>>>>> It's been a while - did you get a chance to make some progress on
>>>>>> this?  Do you need any help to unblock you?
>>>>>>
>>>>>
>>>>> Sorry again, I'm back now. Trying to fix locking problems.
>>>>> Added this to each function for analysis how the functions are called wrt.
>>>>> locking:
>>>>>
>>>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
>>>>
>>>> Do you have your code somewhere that we can look at ?
>>>
>>> This is the current version with debug printks. I've also added dump_stack()
>>> to find out the code path but haven't analyzed the output yet.
>>
>> Can you send a proper patch ? Or a link to a git tree ? That is easier to
>> handle than pasted code in an email...
> 
> Patch against what? I don't have a git server.

patch against current 6.1-rc, or against an older kernel should be OK too.
But please "git send-email" a patch, or push your dev tree to github ?

> I've done some call trace analysis. These code paths are calling
> pata_parport functions with ap->lock locked during init.
> 
> Comm: kworker, Workqueue: ata_sff ata_sff_pio_task
> ata_sff_hsm_move -> ata_pio_sectors-> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
> ata_sff_pio_task -> ata_sff_busy_wait -> pata_parport_check_status
> ata_sff_hsm_move -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
> ata_sff_pio_task -> ata_sff_hsm_move -> ata_pio_sectors -> ata_pio_sector -> ata_pio_xfer -> pata_parport_data_xfer
> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_data_xfer
> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_tf_read
> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_qc_complete -> fill_result_tf -> ata_sff_qc_fill_rtf -> pata_parport_tf_read
> ata_sff_hsm_move -> ata_pio_sectors -> ata_sff_altstatus -> pata_parport_check_altstatus
> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_check_altstatus
> 
> Comm: modprobe
> ata_host_start -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
> 
> Comm: scsi_eh_4
> ata_eh_recover -> ata_eh_reset -> ata_eh_thaw_port -> ata_sff_thaw -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
> ata_eh_reset -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
> ata_scsi_error -> ata_scsi_port_error_handler -> ata_port_freeze -> ata_sff_freeze -> pata_parport_check_status
> ata_sff_error_handler -> pata_parport_drain_fifo -> pata_parport_check_status

What exactly are the issues you are having with ap->lock ? It looks like
you have done a lot of analysis of the code, but without any context about
the problem, I do not understand what I am looking at.

-- 
Damien Le Moal
Western Digital Research

