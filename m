Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E726629CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKOO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKOO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:57:01 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BDD5F00E;
        Tue, 15 Nov 2022 06:56:58 -0800 (PST)
Received: from [192.168.1.3] (gsystem.sk [85.248.217.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 6F3107A0426;
        Tue, 15 Nov 2022 15:56:56 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Date:   Tue, 15 Nov 2022 15:56:52 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk> <202211142025.46723.linux@zary.sk> <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
In-Reply-To: <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202211151556.52895.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2022, Damien Le Moal wrote:
> On 11/15/22 04:25, Ondrej Zary wrote:
> > On Monday 14 November 2022 09:03:28 Damien Le Moal wrote:
> >> On 11/14/22 16:53, Ondrej Zary wrote:
> >>> On Monday 14 November 2022, Damien Le Moal wrote:
> >>>> On 11/12/22 20:17, Ondrej Zary wrote:
> >>>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
> >>>>>> It's been a while - did you get a chance to make some progress on
> >>>>>> this?  Do you need any help to unblock you?
> >>>>>>
> >>>>>
> >>>>> Sorry again, I'm back now. Trying to fix locking problems.
> >>>>> Added this to each function for analysis how the functions are called wrt.
> >>>>> locking:
> >>>>>
> >>>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
> >>>>
> >>>> Do you have your code somewhere that we can look at ?
> >>>
> >>> This is the current version with debug printks. I've also added dump_stack()
> >>> to find out the code path but haven't analyzed the output yet.
> >>
> >> Can you send a proper patch ? Or a link to a git tree ? That is easier to
> >> handle than pasted code in an email...
> > 
> > Patch against what? I don't have a git server.
> 
> patch against current 6.1-rc, or against an older kernel should be OK too.
> But please "git send-email" a patch, or push your dev tree to github ?
> 
> > I've done some call trace analysis. These code paths are calling
> > pata_parport functions with ap->lock locked during init.
> > 
> > Comm: kworker, Workqueue: ata_sff ata_sff_pio_task
> > ata_sff_hsm_move -> ata_pio_sectors-> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
> > ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
> > ata_sff_pio_task -> ata_sff_busy_wait -> pata_parport_check_status
> > ata_sff_hsm_move -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
> > ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
> > ata_sff_pio_task -> ata_sff_hsm_move -> ata_pio_sectors -> ata_pio_sector -> ata_pio_xfer -> pata_parport_data_xfer
> > ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_data_xfer
> > ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_tf_read
> > ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_qc_complete -> fill_result_tf -> ata_sff_qc_fill_rtf -> pata_parport_tf_read
> > ata_sff_hsm_move -> ata_pio_sectors -> ata_sff_altstatus -> pata_parport_check_altstatus
> > ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_check_altstatus
> > 
> > Comm: modprobe
> > ata_host_start -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
> > 
> > Comm: scsi_eh_4
> > ata_eh_recover -> ata_eh_reset -> ata_eh_thaw_port -> ata_sff_thaw -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
> > ata_eh_reset -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
> > ata_scsi_error -> ata_scsi_port_error_handler -> ata_port_freeze -> ata_sff_freeze -> pata_parport_check_status
> > ata_sff_error_handler -> pata_parport_drain_fifo -> pata_parport_check_status
> 
> What exactly are the issues you are having with ap->lock ? It looks like
> you have done a lot of analysis of the code, but without any context about
> the problem, I do not understand what I am looking at.
> 

The problem is that pi_connect() can sleep because it calls
parport_claim_or_block(). And any access (even reading ATA status register)
requires pi_connect.

-- 
Ondrej Zary
