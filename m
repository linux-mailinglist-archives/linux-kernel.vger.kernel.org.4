Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE760F40A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiJ0Jvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiJ0Jvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:51:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AFCD8EEA;
        Thu, 27 Oct 2022 02:51:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C154221D4;
        Thu, 27 Oct 2022 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666864297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMhDnMZsampgRMF7aSgCvQ+2ib+vll1P4/w4qqcbYrU=;
        b=o+Xnrhc+P/dGykBrUg4YiT1fyjCP23M39/0Mkg3D08oe15WqtJQcH8B0owXI+4xf4in7bW
        yHcMDCGpK/Uv0JCPqRURadQD9H1DEIczWzoGVVG2k3bS8Zcwpk38sfzDmRidQj184mUa3r
        HxZihd3l9bpRPVqyNCQ8t0i/mLyI/oE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666864297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMhDnMZsampgRMF7aSgCvQ+2ib+vll1P4/w4qqcbYrU=;
        b=AU6KYi2aeqTWCFIX/KbgPTSH1DgsFHj4gyYq6E0qtoww9FVYCY0oGZ0CW+a5z3blUfuhgq
        dQbMkALsGeuaBMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7BD613357;
        Thu, 27 Oct 2022 09:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o4zMMqdUWmM4bAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Oct 2022 09:51:35 +0000
Message-ID: <331fffd7-b5db-9b4a-42ae-940a6b54a37f@suse.de>
Date:   Thu, 27 Oct 2022 11:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC v3 16/22] ata: libata-scsi: Allocate sdev early in
 port probe
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, bvanassche@acm.org, hch@lst.de,
        ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-17-git-send-email-john.garry@huawei.com>
 <6c0a4a75-786a-c946-57f2-c511bd765bcc@opensource.wdc.com>
 <d4535f4f-d9cf-30de-ce8c-9d8ee9c0decb@suse.de>
 <5417d401-6fb3-c1d7-58df-e24e0013cfb8@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <5417d401-6fb3-c1d7-58df-e24e0013cfb8@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 11:16, Damien Le Moal wrote:
> On 10/27/22 17:11, Hannes Reinecke wrote:
>> On 10/27/22 03:34, Damien Le Moal wrote:
>>> On 10/25/22 19:18, John Garry wrote:
>>>> Currently the per-ata device sdev is allocated as part of the scsi
>>>> target
>>>> scan, which is after the ata port probe.
>>>>
>>>> However it is useful to have the sdev available in the port probe. As an
>>>> example of an advantage, if the request queue is available in the probe
>>>> (which it would be if the sdev is available), then it is possible to use
>>>> a SCSI cmnd for ATA internal commands. The benefit of this is then we
>>>> can
>>>> put the ATA qc structure in the SCSI cmnd private data. It will also be
>>>> useful if we want to send ATA internal commands as requests.
>>>>
>>>> Export scsi_target_reap() so that it can be used to put the extra
>>>> reference we get when allocating the sdev.
>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>> ---
>>>>    drivers/ata/libata-eh.c   |  1 +
>>>>    drivers/ata/libata-scsi.c | 23 +++++++++--------------
>>>>    drivers/scsi/scsi_scan.c  |  1 +
>>>>    3 files changed, 11 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>>> index 08e11bc312c2..1ed5b1b64792 100644
>>>> --- a/drivers/ata/libata-eh.c
>>>> +++ b/drivers/ata/libata-eh.c
>>>> @@ -3446,6 +3446,7 @@ static int ata_eh_schedule_probe(struct
>>>> ata_device *dev)
>>>>          ata_eh_detach_dev(dev);
>>>>        ata_dev_init(dev);
>>>> +    ata_scsi_setup_sdev(dev);
>>>>        ehc->did_probe_mask |= (1 << dev->devno);
>>>>        ehc->i.action |= ATA_EH_RESET;
>>>>        ehc->saved_xfer_mode[dev->devno] = 0;
>>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>>> index efdba852e363..476e0ef4bd29 100644
>>>> --- a/drivers/ata/libata-scsi.c
>>>> +++ b/drivers/ata/libata-scsi.c
>>>> @@ -1109,7 +1109,12 @@ int ata_scsi_dev_config(struct scsi_device
>>>> *sdev, struct ata_device *dev)
>>>>        if (dev->flags & ATA_DFLAG_TRUSTED)
>>>>            sdev->security_supported = 1;
>>>>    -    dev->sdev = sdev;
>>>> +    /*
>>>> +     * Put extra reference which we get when allocating the starget
>>>> +     * initially
>>>> +     */
>>>> +    scsi_target_reap(scsi_target(sdev));
>>>> +
>>>>        return 0;
>>>>    }
>>>>    @@ -4289,26 +4294,16 @@ void ata_scsi_scan_host(struct ata_port
>>>> *ap, int sync)
>>>>     repeat:
>>>>        ata_for_each_link(link, ap, EDGE) {
>>>>            ata_for_each_dev(dev, link, ENABLED) {
>>>> -            struct scsi_device *sdev;
>>>> +            struct Scsi_Host *shost = ap->scsi_host;
>>>>                int channel = 0, id = 0;
>>>>    -            if (dev->sdev)
>>>> -                continue;
>>>> -
>>>>                if (ata_is_host_link(link))
>>>>                    id = dev->devno;
>>>>                else
>>>>                    channel = link->pmp;
>>>>    -            sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
>>>> -                         NULL);
>>>> -            if (!IS_ERR(sdev)) {
>>>> -                dev->sdev = sdev;
>>>> -                ata_scsi_assign_ofnode(dev, ap);
>>>
>>> Is there something equivalent to what this function does inside
>>> scsi_scan_target() ? I had a quick look but did not see anything...
>>>
>> Typically, the SCSI layer has two ways of scanning.
>> One it the old-style serial scanning (originating in the old SCSI
>> parallel model):
>> The scanning code will blindly scan _all_ devices up to max_luns, and
>> attach every device for which the scanning code returns 'OK'.
>> The other one is to issue REPORT_LUNS and scan all LUNs returned there.
>>
>> Mapped to libata we would need to figure out a stable SCSI enumeration,
>> given that we have PMP and slave devices to content with.
>> To my knowledge we have ATA ports, each can have either a 'master' and
>> 'slave' device, _or_ it be a PMP port when it can support up to 16
>> devices, right?
> 
> yes
> 
>> Point being, master/slave and PMP are exclusive, right?
> 
> Never heard of pmp with ide cable :)
> 
See?

>> So we can make the master as LUN 0, and the slave as LUN 1.
> 
> Yes, but isn't that a little wrong ? That would assume that the ata port
> is the device and the ata devices the luns of that device. But beside
> the "link busy" stuff that needs to be dealt with, master and slave are
> independent devices, unlike LUNs. No ?
> Well; technically, yes.

But we already enumerate the ata ports (which is typically done by the 
hardware/PCI layer etc), and if we were try to model slave devices as 
independent ports we would either have to insert a numbering (awkward) 
or add a number at the en (even more awkward).

And the one key takeaway from the 'multiple actuators' discussion is 
that LUNs _are_ independent (cf all the hoops they had to jump through 
to define a command spanning several LUNs ...)(which, incidentally, we 
could leverage here, too ...), and the target port really only serves as 
an enumeration thingie to address the LUNs.

So we _could_ map the master device on LUN 0 and the slave device on LUN 
1 with no loss of functionality, _but_ enable a consistent SCSI enumeration.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

