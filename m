Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DDF64AB21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiLLXHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiLLXHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:07:41 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723DC71
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670886459; x=1702422459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xomx44ErsYrGwGV/oMLYjJEQHpULQ8ikWOnAe1neyG8=;
  b=MSQVqKgn+RSqZt+PSpL7YaA+lGE7OPxyneLmhYGm7ep5YhGWXOhErf6J
   ak1UZADBHgoAPJWgHsQRObkNVLtzdXs+a7iNsvABff1yKngUDUREvEeAM
   gZKCydOyJQAXRHPCYWc1pvNz80tjATQNS59j2GSeVDxWeuGoXrFgB452s
   DYL7Bar7MhBUoBdRVJp4xHol0sE4x2ZW6rjJAFTSDSisDYGQVmuCWsx5P
   8h0ngDzmyIag0tRNz/HRnbiyVb/7seldv6I7h1rm7hUrdG2w3+2NedbFI
   9oKsT6Rh5btcLD+/ih/A593DbjXu8YDbgYdVsA9O9+WrGVvfNTGjx1i/w
   g==;
X-IronPort-AV: E=Sophos;i="5.96,239,1665417600"; 
   d="scan'208";a="216690802"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 07:07:36 +0800
IronPort-SDR: hQJjdZkmxhQZeWId88dLUjMLh+g/OFTlqqmFWJ7q36PVmzQFT+UwIP0FOanbVulVTYRdbYOlSc
 oNHkFsPZR9/o4sdgXu48fYou4zrlsMQvSNFXVBIUOMoooqUeizQChRwNAE1VlGEFrNqLgv8Son
 GV67Tehjgs72uOiBTX6PLzaskk+V0F1M2LYlWPJF7dasVOeCVH0UNy+Db5Zb4lJpiQllQyy0lz
 0SsM8sIlnU1/EKt2BfY549e4hZEPfcswVWDGWv8FivKqoIp2VyYqKhfzZ44aUwgP92u59Ht1qD
 bx0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 14:26:00 -0800
IronPort-SDR: 93UsCCsDb8KnP39Oo1sS+E6qaV69Gy72m+k5JVrIwF2Zj3kc0U4LcbGUG3dONMqNZS4YyIV2vH
 qRBKq+TWzswSvpVf6uJ4FetIZ0YnbWhk1PTEFaE5nriuR25yO9MRYg2duzIp1OW5H3UAPclS12
 eQ1zWWTYXpZ4avnnNKTMRVakUwxuUGymb/YEUNQdGW+RqsY/xwW7jcFNaFnvlMPAFEJdE8N1l9
 qU0DV75LCrlRTPKmpa7Y2kTivi5aUyKxs/3cIawrAZbQK8D+vmI03GNrl5B12lK3h6bH3+ERrP
 q1M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 15:07:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NWHMr0qvLz1RvTr
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:07:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670886454; x=1673478455; bh=xomx44ErsYrGwGV/oMLYjJEQHpULQ8ikWOn
        Ae1neyG8=; b=Cuj3VN+gMWPSANYbtxtxjzlkGB5c5LQWe/58o3sWfjpDGNECFLh
        xGq/TkSoXQENYxbZvh8XoIROOWsiPvCQYFI2ubO7VmElWdK+Q9jTcyQtA2XtDZvT
        9DxLY2xx14YDZ9p9cWKwSkP7AGEocv7LGfDZDnBRcPNYOWUCzV4aEHZpCgldPYxH
        8kl2SY5tPwdD+V8bP4NAtBz1GwdkTQ5A2tqvfAIeR1Dp2MtGfuWnKBsgGp7eicJC
        iqfSS4dsOCC3NTeau10VerYDEepXv46k4noo07MXgidfsN5soHUBIgaQDSRLX1h9
        Z+1KYAuet5CFn0SAEgBIfnXGP4bJooK7SjA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GjszroFp4kow for <linux-kernel@vger.kernel.org>;
        Mon, 12 Dec 2022 15:07:34 -0800 (PST)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NWHMn3tL8z1RvLy;
        Mon, 12 Dec 2022 15:07:33 -0800 (PST)
Message-ID: <dcd31bf2-5a7a-30a4-4c3c-205d5f39fcd8@opensource.wdc.com>
Date:   Tue, 13 Dec 2022 08:07:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202211151556.52895.linux@zary.sk>
 <bfc49618-dbc3-8ffb-f536-3b4486e1980e@opensource.wdc.com>
 <202212122355.30988.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202212122355.30988.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 07:55, Ondrej Zary wrote:
> On Wednesday 16 November 2022 02:30:46 Damien Le Moal wrote:
>> On 2022/11/15 23:56, Ondrej Zary wrote:
>>> On Tuesday 15 November 2022, Damien Le Moal wrote:
>>>> On 11/15/22 04:25, Ondrej Zary wrote:
>>>>> On Monday 14 November 2022 09:03:28 Damien Le Moal wrote:
>>>>>> On 11/14/22 16:53, Ondrej Zary wrote:
>>>>>>> On Monday 14 November 2022, Damien Le Moal wrote:
>>>>>>>> On 11/12/22 20:17, Ondrej Zary wrote:
>>>>>>>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
>>>>>>>>>> It's been a while - did you get a chance to make some progress on
>>>>>>>>>> this?  Do you need any help to unblock you?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Sorry again, I'm back now. Trying to fix locking problems.
>>>>>>>>> Added this to each function for analysis how the functions are called wrt.
>>>>>>>>> locking:
>>>>>>>>>
>>>>>>>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
>>>>>>>>
>>>>>>>> Do you have your code somewhere that we can look at ?
>>>>>>>
>>>>>>> This is the current version with debug printks. I've also added dump_stack()
>>>>>>> to find out the code path but haven't analyzed the output yet.
>>>>>>
>>>>>> Can you send a proper patch ? Or a link to a git tree ? That is easier to
>>>>>> handle than pasted code in an email...
>>>>>
>>>>> Patch against what? I don't have a git server.
>>>>
>>>> patch against current 6.1-rc, or against an older kernel should be OK too.
>>>> But please "git send-email" a patch, or push your dev tree to github ?
>>>>
>>>>> I've done some call trace analysis. These code paths are calling
>>>>> pata_parport functions with ap->lock locked during init.
>>>>>
>>>>> Comm: kworker, Workqueue: ata_sff ata_sff_pio_task
>>>>> ata_sff_hsm_move -> ata_pio_sectors-> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
>>>>> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
>>>>> ata_sff_pio_task -> ata_sff_busy_wait -> pata_parport_check_status
>>>>> ata_sff_hsm_move -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>>>> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>>>> ata_sff_pio_task -> ata_sff_hsm_move -> ata_pio_sectors -> ata_pio_sector -> ata_pio_xfer -> pata_parport_data_xfer
>>>>> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_data_xfer
>>>>> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_tf_read
>>>>> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_qc_complete -> fill_result_tf -> ata_sff_qc_fill_rtf -> pata_parport_tf_read
>>>>> ata_sff_hsm_move -> ata_pio_sectors -> ata_sff_altstatus -> pata_parport_check_altstatus
>>>>> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_check_altstatus
>>>>>
>>>>> Comm: modprobe
>>>>> ata_host_start -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
>>>>>
>>>>> Comm: scsi_eh_4
>>>>> ata_eh_recover -> ata_eh_reset -> ata_eh_thaw_port -> ata_sff_thaw -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>>>> ata_eh_reset -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
>>>>> ata_scsi_error -> ata_scsi_port_error_handler -> ata_port_freeze -> ata_sff_freeze -> pata_parport_check_status
>>>>> ata_sff_error_handler -> pata_parport_drain_fifo -> pata_parport_check_status
>>>>
>>>> What exactly are the issues you are having with ap->lock ? It looks like
>>>> you have done a lot of analysis of the code, but without any context about
>>>> the problem, I do not understand what I am looking at.
>>>>
>>>
>>> The problem is that pi_connect() can sleep because it calls
>>> parport_claim_or_block(). And any access (even reading ATA status register)
>>> requires pi_connect.
>>
>> OK. Let me have a look.
>>
> 
> The locking problems seem not to be easily solvable. Maybe a hack that grabs
> the parport before registering ata interface (and keeps it until the
> interface is disabled) will help? That will prevent multiple chained devices
> on one parport from working but can get pata_parport moving.

I have been very busy and had no time to look at this. Sorry about that. I
will have a look before year-end break.

-- 
Damien Le Moal
Western Digital Research

