Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A377627703
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiKNIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:03:40 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D555BE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668413016; x=1699949016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DbjC3H2Ku7yQenUDNoHIk16VbS/maGkqEh/pBXxGFcI=;
  b=cOxJF/j52vIeEFtrCFag7HKSvLQU4OxK9Gtl1kuLAAAjq7azKs/DjVgb
   7bL8XU2j3VipUGscUhrcTR1e9QrhAqlJWDQuf2Srx1+/JC3mZleTpCRR1
   +D0ssoQf+1fv6FmHowN9zexeuqkSu2AiOlY5oFhkOPiwVvweYv6zfHb12
   Ap7YDmF1n5XWXFej4/ELnMYofM36+M8uqImGPDq5y6Qq5Dag8s8pN/T4a
   eGBKcjqToisn20v47iE5/zIkQm6TIbxoEzTd9SvxiL6CG0La4AC3L14yr
   TDNfuXmQEXefjSHVZ8XseuFAIaVWudZtqpEkewEmIQHQWD5ZXNG3QWbF+
   A==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="216204315"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 16:03:34 +0800
IronPort-SDR: Uhbz89qHebksfg9JRAng7zOehFIPaBBFmOsYmeG+rnoe1/rocFYsMfqSkDHb+zRwNXybuW3p0B
 7kv28H6pH/hrTYP60/xlaZ5/IBQrTdwst7dPYQK+koqLCEu1NhJjhprskr2z3XCI00CHRQqmsp
 FNwPaL5tTtVY0SBPw3F0mT6NB0R7FFbYbxz6Ot7GjFVCMbOELqi9zu9C7DgNpCm1CZEId/lj0g
 ZEFlUxFQWBeTUyWDOnrianZ4zgH7FCcpbG4AmUnEyC6UZEOV+Tuls87ZZS90GiHotFJ/Hpj1KA
 F5s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 23:22:33 -0800
IronPort-SDR: L8HviyV2fiDVfu6ixatKiortOjaUDFwyiEY9EAXD1JtO5mjLRnrXUV0ePaxEua5zzFHm/0sQEz
 IMhP5TdgixuY05SsE4awRdLMPmXHB66BM7nj6xPaucFy1XEox37bI3/GjpanYtoxQ/nq2/+yW0
 YGkLa2Gd5Cltr0Ye2RiFAoJAFlgGTNE1YV8zmmTtSPlSRbh4K7/nDafXzmo6KF9EIEa46JacyK
 iqgsOD8SmsYWarNtrFtpl0FFAYIScCZZlOagr+5zQ2+5tcsWvnIUNJcDqks/EgnFBy82amTgXr
 6h8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 00:03:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9hdf2rDfz1RwqL
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:03:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668413011; x=1671005012; bh=DbjC3H2Ku7yQenUDNoHIk16VbS/maGkqEh/
        pBXxGFcI=; b=LHXGp+axE2AoT0lFqqFp+/8OuzyFLF3IhIuQLFvCSK3RFKgQjzZ
        uTuAjGohCtnfJGlMFMakpbKV2fYkFiRg38RgJ8nLvZj9D3QWyO5co/n/Vl9e1vZI
        p6+kb4Z1Mjz3Ox++pH8j3TNwDh5TgwxyiQykjMtEF6KeXhPPwUE6NiFMnS7qA+DT
        8s+SHqHFrFJOd/bGxfeH5Xbn1nVQ0UxGCVhbRQQe/H40M7S4wP8MBetoNq0wNE3p
        lYY7j5Gt6q8269gqQ73/EVfmK7CUjNeOnoWQzC6jopdoE+BQfEEPaxqbbXDwG6PE
        79inucPi1EfKFhvXJUQzu6kF6kBi5qHEROQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NWHddo-KKP1V for <linux-kernel@vger.kernel.org>;
        Mon, 14 Nov 2022 00:03:31 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9hdY5JXSz1RvLy;
        Mon, 14 Nov 2022 00:03:29 -0800 (PST)
Message-ID: <f8ce8ecd-cadd-d9ca-d2fa-1251804344f0@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 17:03:28 +0900
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
 <202211121217.03948.linux@zary.sk>
 <51bb45e2-6de5-3608-0ccf-7ee78071fa05@opensource.wdc.com>
 <202211140853.11115.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202211140853.11115.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 16:53, Ondrej Zary wrote:
> On Monday 14 November 2022, Damien Le Moal wrote:
>> On 11/12/22 20:17, Ondrej Zary wrote:
>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
>>>> It's been a while - did you get a chance to make some progress on
>>>> this?  Do you need any help to unblock you?
>>>>
>>>
>>> Sorry again, I'm back now. Trying to fix locking problems.
>>> Added this to each function for analysis how the functions are called wrt.
>>> locking:
>>>
>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
>>
>> Do you have your code somewhere that we can look at ?
> 
> This is the current version with debug printks. I've also added dump_stack()
> to find out the code path but haven't analyzed the output yet.

Can you send a proper patch ? Or a link to a git tree ? That is easier to
handle than pasted code in an email...

> 
> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * Copyright 2022 Ondrej Zary
>  * based on paride.c by Grant R. Guenther <grant@torque.net>
>  */
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/parport.h>
> #include <linux/pata_parport.h>
> 
> #define DRV_NAME "pata_parport"
> 
> static DEFINE_IDR(parport_list);
> static DEFINE_IDR(protocols);
> static DEFINE_IDA(pata_parport_bus_dev_ids);
> static DEFINE_MUTEX(pi_mutex);
> 
> static bool probe = true;
> module_param(probe, bool, 0644);
> MODULE_PARM_DESC(probe, "Enable automatic device probing (0=off, 1=on [default])");
> 
> static bool verbose;
> module_param(verbose, bool, 0644);
> MODULE_PARM_DESC(verbose, "Enable verbose messages (0=off [default], 1=on)");
> 
> #define DISCONNECT_TIMEOUT	(HZ / 10)
> 
> static void pi_connect(struct ata_port *ap)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	if (spin_is_locked(ap->lock))
> 		dump_stack();
> 
> 	del_timer_sync(&pi->timer);
> 	if (!pi->claimed) {
> 		pi->claimed = true;
> 		parport_claim_or_block(pi->pardev);
> 		pi->proto->connect(pi);
> 	}
> }
> 
> static void pi_disconnect(struct pi_adapter *pi)
> {
> 	if (pi->claimed) {
> 		pi->proto->disconnect(pi);
> 		parport_release(pi->pardev);
> 		pi->claimed = false;
> 	}
> }
> 
> static void pi_disconnect_timer(struct timer_list *t)
> {
> 	struct pi_adapter *pi = from_timer(pi, t, timer);
> 
> 	pi_disconnect(pi);
> }
> 
> /* functions taken from libata-sff.c and converted from direct port I/O */
> static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	u8 tmp;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 
> 	if (device == 0)
> 		tmp = ATA_DEVICE_OBS;
> 	else
> 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
> 
> 	pi_connect(ap);
> 	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 	ata_sff_pause(ap);
> }
> 
> static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	u8 nsect, lbal;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pata_parport_dev_select(ap, device);
> 
> 	pi_connect(ap);
> 	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
> 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
> 
> 	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
> 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
> 
> 	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
> 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
> 
> 	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> 	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 
> 	if ((nsect == 0x55) && (lbal == 0xaa))
> 		return true;	/* we found a device */
> 
> 	return false;		/* nothing found */
> }
> 
> static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
> 				      unsigned long deadline)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	/* software reset.  causes dev0 to be selected */
> 	pi->proto->write_regr(pi, 1, 6, ap->ctl);
> 	udelay(20);
> 	pi->proto->write_regr(pi, 1, 6, ap->ctl | ATA_SRST);
> 	udelay(20);
> 	pi->proto->write_regr(pi, 1, 6, ap->ctl);
> 	ap->last_ctl = ap->ctl;
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 
> 	/* wait the port to become ready */
> 	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
> }
> 
> static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
> 				  unsigned long deadline)
> {
> 	struct ata_port *ap = link->ap;
> 	unsigned int devmask = 0;
> 	int rc;
> 	u8 err;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	/* determine if device 0/1 are present */
> 	if (pata_parport_devchk(ap, 0))
> 		devmask |= (1 << 0);
> 	if (pata_parport_devchk(ap, 1))
> 		devmask |= (1 << 1);
> 
> 	/* select device 0 again */
> 	pata_parport_dev_select(ap, 0);
> 
> 	/* issue bus reset */
> 	rc = pata_parport_bus_softreset(ap, devmask, deadline);
> 	if (rc && rc != -ENODEV) {
> 		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
> 		return rc;
> 	}
> 
> 	/* determine by signature whether we have ATA or ATAPI devices */
> 	classes[0] = ata_sff_dev_classify(&link->device[0],
> 					  devmask & (1 << 0), &err);
> 	if (err != 0x81)
> 		classes[1] = ata_sff_dev_classify(&link->device[1],
> 						  devmask & (1 << 1), &err);
> 
> 	return 0;
> }
> 
> static u8 pata_parport_check_status(struct ata_port *ap)
> {
> 	u8 status;
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 
> 	return status;
> }
> 
> static u8 pata_parport_check_altstatus(struct ata_port *ap)
> {
> 	u8 altstatus;
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	altstatus = pi->proto->read_regr(pi, 1, 6);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 
> 	return altstatus;
> }
> 
> static void pata_parport_tf_load(struct ata_port *ap,
> 				 const struct ata_taskfile *tf)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	if (tf->ctl != ap->last_ctl) {
> 		pi->proto->write_regr(pi, 1, 6, tf->ctl);
> 		ap->last_ctl = tf->ctl;
> 		ata_wait_idle(ap);
> 	}
> 
> 	if (tf->flags & ATA_TFLAG_ISADDR) {
> 		if (tf->flags & ATA_TFLAG_LBA48) {
> 			pi->proto->write_regr(pi, 0, ATA_REG_FEATURE,
> 					      tf->hob_feature);
> 			pi->proto->write_regr(pi, 0, ATA_REG_NSECT,
> 					      tf->hob_nsect);
> 			pi->proto->write_regr(pi, 0, ATA_REG_LBAL,
> 					      tf->hob_lbal);
> 			pi->proto->write_regr(pi, 0, ATA_REG_LBAM,
> 					      tf->hob_lbam);
> 			pi->proto->write_regr(pi, 0, ATA_REG_LBAH,
> 					      tf->hob_lbah);
> 		}
> 		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->feature);
> 		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->nsect);
> 		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->lbal);
> 		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->lbam);
> 		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->lbah);
> 	}
> 
> 	if (tf->flags & ATA_TFLAG_DEVICE)
> 		pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tf->device);
> 
> 	ata_wait_idle(ap);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> }
> 
> static void pata_parport_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	tf->status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
> 	tf->error = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
> 	tf->nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> 	tf->lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> 	tf->lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
> 	tf->lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
> 	tf->device = pi->proto->read_regr(pi, 0, ATA_REG_DEVICE);
> 
> 	if (tf->flags & ATA_TFLAG_LBA48) {
> 		pi->proto->write_regr(pi, 1, 6, tf->ctl | ATA_HOB);
> 		tf->hob_feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
> 		tf->hob_nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> 		tf->hob_lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> 		tf->hob_lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
> 		tf->hob_lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
> 		pi->proto->write_regr(pi, 1, 6, tf->ctl);
> 		ap->last_ctl = tf->ctl;
> 	}
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> }
> 
> static void pata_parport_exec_command(struct ata_port *ap,
> 				      const struct ata_taskfile *tf)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	pi->proto->write_regr(pi, 0, ATA_REG_CMD, tf->command);
> 	ata_sff_pause(ap);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> }
> 
> static unsigned int pata_parport_data_xfer(struct ata_queued_cmd *qc,
> 				unsigned char *buf, unsigned int buflen, int rw)
> {
> 	struct ata_port *ap = qc->dev->link->ap;
> 	struct pi_adapter *pi = ap->host->private_data;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi_connect(ap);
> 	if (rw == READ)
> 		pi->proto->read_block(pi, buf, buflen);
> 	else
> 		pi->proto->write_block(pi, buf, buflen);
> 	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 
> 	return buflen;
> }
> 
> static void pata_parport_drain_fifo(struct ata_queued_cmd *qc)
> {
> 	int count;
> 	struct ata_port *ap;
> 	struct pi_adapter *pi;
> 	char junk[2];
> 
> 	/* We only need to flush incoming data when a command was running */
> 	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
> 		return;
> 
> 	ap = qc->ap;
> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> 	pi = ap->host->private_data;
> 	/* Drain up to 64K of data before we give up this recovery method */
> 	for (count = 0; (pata_parport_check_status(ap) & ATA_DRQ)
> 						&& count < 65536; count += 2) {
> 		pi_connect(ap);
> 		pi->proto->read_block(pi, junk, 2);
> 		mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> 	}
> 
> 	if (count)
> 		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
> }
> 
> static struct ata_port_operations pata_parport_port_ops = {
> 	.inherits		= &ata_sff_port_ops,
> 
> 	.softreset		= pata_parport_softreset,
> 	.hardreset		= NULL,
> 
> 	.sff_dev_select		= pata_parport_dev_select,
> 	.sff_check_status	= pata_parport_check_status,
> 	.sff_check_altstatus	= pata_parport_check_altstatus,
> 	.sff_tf_load		= pata_parport_tf_load,
> 	.sff_tf_read		= pata_parport_tf_read,
> 	.sff_exec_command	= pata_parport_exec_command,
> 	.sff_data_xfer		= pata_parport_data_xfer,
> 	.sff_drain_fifo		= pata_parport_drain_fifo,
> };
> 
> static const struct ata_port_info pata_parport_port_info = {
> 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING,
> 	.pio_mask	= ATA_PIO0,
> 	/* No DMA */
> 	.port_ops	= &pata_parport_port_ops,
> };
> 
> static void pi_release(struct pi_adapter *pi)
> {
> 	parport_unregister_device(pi->pardev);
> 	if (pi->proto->release_proto)
> 		pi->proto->release_proto(pi);
> 	module_put(pi->proto->owner);
> }
> 
> static int default_test_proto(struct pi_adapter *pi, char *scratch)
> {
> 	int j, k;
> 	int e[2] = { 0, 0 };
> 
> 	pi->proto->connect(pi);
> 
> 	for (j = 0; j < 2; j++) {
> 		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
> 		for (k = 0; k < 256; k++) {
> 			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
> 			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
> 			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
> 				e[j]++;
> 		}
> 	}
> 	pi->proto->disconnect(pi);
> 
> 	if (verbose)
> 		dev_info(&pi->dev, "%s: port 0x%x, mode %d, test=(%d,%d)\n",
> 		       pi->proto->name, pi->port,
> 		       pi->mode, e[0], e[1]);
> 
> 	return e[0] && e[1];	/* not here if both > 0 */
> }
> 
> static int pi_test_proto(struct pi_adapter *pi, char *scratch)
> {
> 	int res;
> 
> 	parport_claim_or_block(pi->pardev);
> 	if (pi->proto->test_proto)
> 		res = pi->proto->test_proto(pi, scratch, verbose);
> 	else
> 		res = default_test_proto(pi, scratch);
> 	parport_release(pi->pardev);
> 
> 	return res;
> }
> 
> static bool pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
> {
> 	int best, range;
> 
> 	if (pi->mode != -1) {
> 		if (pi->mode >= max)
> 			return false;
> 		range = 3;
> 		if (pi->mode >= pi->proto->epp_first)
> 			range = 8;
> 		if (range == 8 && pi->port % 8)
> 			return false;
> 		return !pi_test_proto(pi, scratch);
> 	}
> 	best = -1;
> 	for (pi->mode = 0; pi->mode < max; pi->mode++) {
> 		range = 3;
> 		if (pi->mode >= pi->proto->epp_first)
> 			range = 8;
> 		if (range == 8 && pi->port % 8)
> 			break;
> 		if (!pi_test_proto(pi, scratch))
> 			best = pi->mode;
> 	}
> 	pi->mode = best;
> 	return best > -1;
> }
> 
> static bool pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)
> {
> 	int max, s, e;
> 
> 	s = unit;
> 	e = s + 1;
> 
> 	if (s == -1) {
> 		s = 0;
> 		e = pi->proto->max_units;
> 	}
> 
> 	if (pi->proto->test_port) {
> 		parport_claim_or_block(pi->pardev);
> 		max = pi->proto->test_port(pi);
> 		parport_release(pi->pardev);
> 	} else {
> 		max = pi->proto->max_mode;
> 	}
> 
> 	if (pi->proto->probe_unit) {
> 		parport_claim_or_block(pi->pardev);
> 		for (pi->unit = s; pi->unit < e; pi->unit++) {
> 			if (pi->proto->probe_unit(pi)) {
> 				parport_release(pi->pardev);
> 				return pi_probe_mode(pi, max, scratch);
> 			}
> 		}
> 		parport_release(pi->pardev);
> 		return false;
> 	}
> 
> 	return pi_probe_mode(pi, max, scratch);
> }
> 
> static void pata_parport_dev_release(struct device *dev)
> {
> 	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
> 
> 	kfree(pi);
> }
> 
> static void pata_parport_bus_release(struct device *dev)
> {
> 	/* nothing to do here but required to avoid warning on device removal */
> }
> 
> static struct bus_type pata_parport_bus_type = {
> 	.name = DRV_NAME,
> };
> 
> static struct device pata_parport_bus = {
> 	.init_name = DRV_NAME,
> 	.release = pata_parport_bus_release,
> };
> 
> /* temporary for old paride protocol modules */
> static struct scsi_host_template pata_parport_sht = {
> 	PATA_PARPORT_SHT("pata_parport")
> };
> 
> struct pi_device_match {
> 	struct parport *parport;
> 	struct pi_protocol *proto;
> };
> 
> static int pi_find_dev(struct device *dev, void *data)
> {
> 	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
> 	struct pi_device_match *match = data;
> 
> 	return pi->pardev->port == match->parport && pi->proto == match->proto;
> }
> 
> static struct pi_adapter *pi_init_one(struct parport *parport,
> 			struct pi_protocol *pr, int mode, int unit, int delay)
> {
> 	struct pardev_cb par_cb = { };
> 	char scratch[512];
> 	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
> 	struct ata_host *host;
> 	struct pi_adapter *pi;
> 	struct pi_device_match match = { .parport = parport, .proto = pr };
> 
> 	/*
> 	 * Abort if there's a device already registered on the same parport
> 	 * using the same protocol.
> 	 */
> 	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
> 		return NULL;
> 
> 	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
> 	if (!pi)
> 		return NULL;
> 
> 	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
> 	pi->dev.parent = &pata_parport_bus;
> 	pi->dev.bus = &pata_parport_bus_type;
> 	pi->dev.driver = &pr->driver;
> 	pi->dev.release = pata_parport_dev_release;
> 	pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> 	if (pi->dev.id < 0)
> 		return NULL; /* pata_parport_dev_release will do kfree(pi) */
> 	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
> 	if (device_register(&pi->dev)) {
> 		put_device(&pi->dev);
> 		goto out_ida_free;
> 	}
> 
> 	pi->proto = pr;
> 
> 	if (!try_module_get(pi->proto->owner))
> 		goto out_unreg_dev;
> 	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
> 		goto out_module_put;
> 
> 	pi->delay = (delay == -1) ? pi->proto->default_delay : delay;
> 	pi->mode = mode;
> 	pi->port = parport->base;
> 
> 	par_cb.private = pi;
> 	pi->pardev = parport_register_dev_model(parport, DRV_NAME, &par_cb,
> 						pi->dev.id);
> 	if (!pi->pardev)
> 		goto out_module_put;
> 
> 	if (!pi_probe_unit(pi, unit, scratch)) {
> 		dev_info(&pi->dev, "Adapter not found\n");
> 		goto out_unreg_parport;
> 	}
> 
> 	pi->proto->log_adapter(pi, scratch, verbose);
> 
> 	host = ata_host_alloc_pinfo(&pi->pardev->dev, ppi, 1);
> 	if (!host)
> 		goto out_unreg_parport;
> 	dev_set_drvdata(&pi->dev, host);
> 	host->private_data = pi;
> 
> 	ata_port_desc(host->ports[0], "port %s", pi->pardev->port->name);
> 	ata_port_desc(host->ports[0], "protocol %s", pi->proto->name);
> 
> 	timer_setup(&pi->timer, pi_disconnect_timer, 0);
> 
> 	if (ata_host_activate(host, 0, NULL, 0, &pata_parport_sht))
> 		goto out_unreg_parport;
> 
> 	return pi;
> 
> out_unreg_parport:
> 	parport_unregister_device(pi->pardev);
> 	if (pi->proto->release_proto)
> 		pi->proto->release_proto(pi);
> out_module_put:
> 	module_put(pi->proto->owner);
> out_unreg_dev:
> 	device_unregister(&pi->dev);
> out_ida_free:
> 	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
> 	return NULL;
> }
> 
> int pata_parport_register_driver(struct pi_protocol *pr)
> {
> 	int error;
> 	struct parport *parport;
> 	int port_num;
> 
> 	pr->driver.bus = &pata_parport_bus_type;
> 	pr->driver.name = pr->name;
> 	error = driver_register(&pr->driver);
> 	if (error)
> 		return error;
> 
> 	mutex_lock(&pi_mutex);
> 	error = idr_alloc(&protocols, pr, 0, 0, GFP_KERNEL);
> 	if (error < 0) {
> 		driver_unregister(&pr->driver);
> 		mutex_unlock(&pi_mutex);
> 		return error;
> 	}
> 
> 	pr_info("pata_parport: protocol %s registered\n", pr->name);
> 
> 	if (probe) {
> 		/* probe all parports using this protocol */
> 		idr_for_each_entry(&parport_list, parport, port_num)
> 			pi_init_one(parport, pr, -1, 0, -1);
> 	}
> 	mutex_unlock(&pi_mutex);
> 
> 	return 0;
> }
> EXPORT_SYMBOL(pata_parport_register_driver);
> 
> void pata_parport_unregister_driver(struct pi_protocol *pr)
> {
> 	struct pi_protocol *pr_iter;
> 	int id = -1;
> 
> 	mutex_lock(&pi_mutex);
> 	idr_for_each_entry(&protocols, pr_iter, id) {
> 		if (pr_iter == pr)
> 			break;
> 	}
> 	idr_remove(&protocols, id);
> 	mutex_unlock(&pi_mutex);
> 	driver_unregister(&pr->driver);
> }
> EXPORT_SYMBOL(pata_parport_unregister_driver);
> 
> static ssize_t new_device_store(struct bus_type *bus, const char *buf,
> 				size_t count)
> {
> 	char port[12] = "auto";
> 	char protocol[8] = "auto";
> 	int mode = -1, unit = -1, delay = -1;
> 	struct pi_protocol *pr, *pr_wanted;
> 	struct device_driver *drv;
> 	struct parport *parport;
> 	int port_num, port_wanted, pr_num;
> 	bool ok = false;
> 
> 	if (sscanf(buf, "%11s %7s %d %d %d",
> 			port, protocol, &mode, &unit, &delay) < 1)
> 		return -EINVAL;
> 
> 	if (sscanf(port, "parport%u", &port_wanted) < 1) {
> 		if (!strcmp(port, "auto")) {
> 			port_wanted = -1;
> 		} else {
> 			pr_err("invalid port name %s\n", port);
> 			return -EINVAL;
> 		}
> 	}
> 
> 	drv = driver_find(protocol, &pata_parport_bus_type);
> 	if (!drv) {
> 		if (!strcmp(protocol, "auto")) {
> 			pr_wanted = NULL;
> 		} else {
> 			pr_err("protocol %s not found\n", protocol);
> 			return -EINVAL;
> 		}
> 	} else {
> 		pr_wanted = container_of(drv, struct pi_protocol, driver);
> 	}
> 
> 	mutex_lock(&pi_mutex);
> 	/* walk all parports */
> 	idr_for_each_entry(&parport_list, parport, port_num) {
> 		if (port_num == port_wanted || port_wanted == -1) {
> 			parport = parport_find_number(port_num);
> 			if (!parport) {
> 				pr_err("no such port %s\n", port);
> 				mutex_unlock(&pi_mutex);
> 				return -ENODEV;
> 			}
> 			/* walk all protocols */
> 			idr_for_each_entry(&protocols, pr, pr_num) {
> 				if (pr == pr_wanted || !pr_wanted)
> 					if (pi_init_one(parport, pr, mode, unit,
> 							delay))
> 						ok = true;
> 			}
> 			parport_put_port(parport);
> 		}
> 	}
> 	mutex_unlock(&pi_mutex);
> 	if (!ok)
> 		return -ENODEV;
> 
> 	return count;
> }
> static BUS_ATTR_WO(new_device);
> 
> static void pi_remove_one(struct device *dev)
> {
> 	struct ata_host *host = dev_get_drvdata(dev);
> 	struct pi_adapter *pi = host->private_data;
> 
> 	ata_host_detach(host);
> 	del_timer_sync(&pi->timer);
> 	pi_disconnect(pi);
> 	pi_release(pi);
> 	device_unregister(dev);
> 	ida_free(&pata_parport_bus_dev_ids, dev->id);
> 	/* pata_parport_dev_release will do kfree(pi) */
> }
> 
> static ssize_t delete_device_store(struct bus_type *bus, const char *buf,
> 				   size_t count)
> {
> 	struct device *dev;
> 	char device_name[32];
> 
> 	if (sscanf(buf, "%31s", device_name) < 1)
> 		return -EINVAL;
> 
> 	mutex_lock(&pi_mutex);
> 	dev = bus_find_device_by_name(bus, NULL, device_name);
> 	if (!dev) {
> 		mutex_unlock(&pi_mutex);
> 		return -ENODEV;
> 	}
> 
> 	pi_remove_one(dev);
> 	mutex_unlock(&pi_mutex);
> 
> 	return count;
> }
> static BUS_ATTR_WO(delete_device);
> 
> static void pata_parport_attach(struct parport *port)
> {
> 	struct pi_protocol *pr;
> 	int pr_num, id;
> 
> 	mutex_lock(&pi_mutex);
> 	id = idr_alloc(&parport_list, port, port->number, port->number,
> 		       GFP_KERNEL);
> 	if (id < 0) {
> 		mutex_unlock(&pi_mutex);
> 		return;
> 	}
> 
> 	if (probe) {
> 		/* probe this port using all protocols */
> 		idr_for_each_entry(&protocols, pr, pr_num)
> 			pi_init_one(port, pr, -1, 0, -1);
> 	}
> 	mutex_unlock(&pi_mutex);
> }
> 
> static int pi_remove_port(struct device *dev, void *p)
> {
> 	struct ata_host *host = dev_get_drvdata(dev);
> 	struct pi_adapter *pi = host->private_data;
> 
> 	if (pi->pardev->port == p)
> 		pi_remove_one(dev);
> 
> 	return 0;
> }
> 
> static void pata_parport_detach(struct parport *port)
> {
> 	mutex_lock(&pi_mutex);
> 	bus_for_each_dev(&pata_parport_bus_type, NULL, port, pi_remove_port);
> 	idr_remove(&parport_list, port->number);
> 	mutex_unlock(&pi_mutex);
> }
> 
> static struct parport_driver pata_parport_driver = {
> 	.name = DRV_NAME,
> 	.match_port = pata_parport_attach,
> 	.detach = pata_parport_detach,
> 	.devmodel = true,
> };
> 
> static __init int pata_parport_init(void)
> {
> 	int error;
> 
> 	error = bus_register(&pata_parport_bus_type);
> 	if (error) {
> 		pr_err("failed to register pata_parport bus, error: %d\n", error);
> 		return error;
> 	}
> 
> 	error = device_register(&pata_parport_bus);
> 	if (error) {
> 		pr_err("failed to register pata_parport bus, error: %d\n", error);
> 		goto out_unregister_bus;
> 	}
> 
> 	error = bus_create_file(&pata_parport_bus_type, &bus_attr_new_device);
> 	if (error) {
> 		pr_err("unable to create sysfs file, error: %d\n", error);
> 		goto out_unregister_dev;
> 	}
> 
> 	error = bus_create_file(&pata_parport_bus_type, &bus_attr_delete_device);
> 	if (error) {
> 		pr_err("unable to create sysfs file, error: %d\n", error);
> 		goto out_remove_new;
> 	}
> 
> 	error = parport_register_driver(&pata_parport_driver);
> 	if (error) {
> 		pr_err("unable to register parport driver, error: %d\n", error);
> 		goto out_remove_del;
> 	}
> 
> 	return 0;
> 
> out_remove_del:
> 	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
> out_remove_new:
> 	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
> out_unregister_dev:
> 	device_unregister(&pata_parport_bus);
> out_unregister_bus:
> 	bus_unregister(&pata_parport_bus_type);
> 	return error;
> }
> 
> static __exit void pata_parport_exit(void)
> {
> 	parport_unregister_driver(&pata_parport_driver);
> 	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
> 	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
> 	device_unregister(&pata_parport_bus);
> 	bus_unregister(&pata_parport_bus_type);
> }
> 
> MODULE_AUTHOR("Ondrej Zary");
> MODULE_DESCRIPTION("driver for parallel port ATA adapters");
> MODULE_LICENSE("GPL");
> MODULE_ALIAS("paride");
> 
> module_init(pata_parport_init);
> module_exit(pata_parport_exit);
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

