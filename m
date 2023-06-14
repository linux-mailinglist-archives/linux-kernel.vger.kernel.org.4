Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6299572F67B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbjFNHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbjFNHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6E2127;
        Wed, 14 Jun 2023 00:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA7F61917;
        Wed, 14 Jun 2023 07:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0210FC433C8;
        Wed, 14 Jun 2023 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686728154;
        bh=p+2BxpWT2p5Lk9YnAikH75CUCpiETRc/GdwquTdNhw4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nyVSWI4uclpR66yEPkbimtB1cFVzdiJFuUJ+0IgHGVmrmj8e3pTuSE39/qakcOehk
         Dqq/D6u0jxFi7knOBKbnVsrcGcI59dLFbXbWESzwyQk+S0PM+xQJhiYvufID26F8Zi
         gCuCYO3g0aELEmcuIHYmrDQNJG1LLNqkJyES8NQr/7qk+dCVFZpYtVL6a31x5+tsB8
         VRv87jHcAtfpt1JrWKLlJZhlWJGYncgTwtl2Tkpzkla+Z7uDkCqSmVm0DEUZBrPm96
         Xf2YiY8kHHc6v733gFO9x8RVe2QeIoAZx1dI/BSHXniTnFMKnAryrlpZbuaUKr4inE
         XwZtQ/iMws4fQ==
Message-ID: <b0fdf454-b2f7-c273-66f5-efe42fbc2807@kernel.org>
Date:   Wed, 14 Jun 2023 16:35:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
 <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
 <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 15:57, Hannes Reinecke wrote:
> On 6/14/23 06:49, Damien Le Moal wrote:
>> On 6/11/23 18:05, Joe Breuer wrote:
>>> I'm the reporter of this issue.
>>>
>>> I just tried this patch against 6.3.4, and it completely fixes my
>>> suspend/resume issue.
>>>
>>> The optical drive stays usable after resume, even suspending/resuming
>>> during playback of CDDA content works flawlessly and playback resumes
>>> seamlessly after system resume.
>>>
>>> So, from my perspective: Good one!
>>
>> In place of Bart's fix, could you please try this patch ?
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index b80e68000dd3..a81eb4f882ab 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
>> ata_port *ap)
>>          /* tell ACPI that we're resuming */
>>          ata_acpi_on_resume(ap);
>>
>> -       /* update the flags */
>>          spin_lock_irqsave(ap->lock, flags);
>> +
>> +       /* Update the flags */
>>          ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
>> +
>> +       /*
>> +        * Resuming the port will trigger a rescan of the ATA device(s)
>> +        * connected to it. Before scheduling the rescan, make sure that
>> +        * the associated scsi device(s) are fully resumed as well.
>> +        */
>> +       ata_for_each_link(link, ap, HOST_FIRST) {
>> +               ata_for_each_dev(dev, link, ENABLED) {
>> +                       struct scsi_device *sdev = dev->sdev;
>> +
>> +                       if (!sdev)
>> +                               continue;
>> +                       if (scsi_device_get(sdev))
>> +                               continue;
>> +
>> +                       spin_unlock_irqrestore(ap->lock, flags);
>> +                       device_pm_wait_for_dev(&ap->tdev,
>> +                                              &sdev->sdev_gendev);
>> +                       scsi_device_put(sdev);
>> +                       spin_lock_irqsave(ap->lock, flags);
>> +               }
>> +       }
>>          spin_unlock_irqrestore(ap->lock, flags);
>>   }
>>   #endif /* CONFIG_PM */
>>
>> Thanks !
>>
> Well; not sure if that'll work out.
> The whole reason why we initial a rescan is that we need to check if the
> ports are still connected, and whether the devices react.
> So we can't iterate the ports here as this is the very thing which gets
> checked during EH.

Hmmm... Right. So we need to move that loop into ata_scsi_dev_rescan(),
which itself already loops over the port devices anyway.

> We really should claim resume to be finished as soon as we can talk with
> the HBA, and kick off EH asynchronously to let it finish the job after
> resume has completed.

That is what's done already:

static int ata_port_pm_resume(struct device *dev)
{
	ata_port_resume_async(to_ata_port(dev), PMSG_RESUME);
	pm_runtime_disable(dev);
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);
	return 0;
}

EH is kicked by ata_port_resume_async() -> ata_port_request_pm() and it
is async. There is no synchronization in EH with the PM side though. We
probably should have EH check that the port resume is done first, which
can be done in ata_eh_handle_port_resume() since that is the first thing
done when entering EH.

The problem remains though that we *must* wait for the scsi device
resume to be done before calling scsi_rescan_device(), which is done
asynchronously from EH, as a different work. So that one needs to wait
for the scsi side resume to be done.

I also thought of trigerring the rescan from the scsi side, but since
the resume may be asynchronous, we could endup trigerring it with the
ata side not yet resumed... That would only turn the problem around
instead of solving it.

Or... Why the heck scsi_rescan_device() is calling device_lock() ? This
is the only place in scsi code I can see that takes this lock. I suspect
this is to serialize either rescans, or serialize with resume, or both.
For serializing rescans, we can use another lock. For serializing with
PM, we should wait for PM transitions...
Something is not right here.

-- 
Damien Le Moal
Western Digital Research

