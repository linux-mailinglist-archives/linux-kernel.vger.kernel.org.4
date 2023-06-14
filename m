Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBF72F53F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjFNG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFNG5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:57:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B91984;
        Tue, 13 Jun 2023 23:57:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 227072188D;
        Wed, 14 Jun 2023 06:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686725834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWmUJHf0Ey81BHg4FfOq6OnR1lg1RZH8qrzAxru/q4U=;
        b=Ae78GTKgCZZmGqmGNhaYT00kHkTw7C22ZCo648dDhJ5Hznq86Qcl4UTSqguQZZMN1B5u2+
        fQVBGbjxDDMK3J4Kzj8D6BBud5Y3rlLwToB8VxsOCRc7c/N6CwY8KWxXUaXM7B2YMc+n2m
        zamjj2L8XPwxE1yYbor492aRMNRvVtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686725834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWmUJHf0Ey81BHg4FfOq6OnR1lg1RZH8qrzAxru/q4U=;
        b=IhtnPGz1B/nlr8hDByMU5YnbQ+jLtCqO6A1zC0rheblThcV4vMvhPDAZGiCZqV2PEaAj7a
        eyODkgpoYD5GMNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F30541357F;
        Wed, 14 Jun 2023 06:57:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TXZdOshkiWS9DAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 06:57:12 +0000
Message-ID: <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de>
Date:   Wed, 14 Jun 2023 08:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
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
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 06:49, Damien Le Moal wrote:
> On 6/11/23 18:05, Joe Breuer wrote:
>> I'm the reporter of this issue.
>>
>> I just tried this patch against 6.3.4, and it completely fixes my
>> suspend/resume issue.
>>
>> The optical drive stays usable after resume, even suspending/resuming
>> during playback of CDDA content works flawlessly and playback resumes
>> seamlessly after system resume.
>>
>> So, from my perspective: Good one!
> 
> In place of Bart's fix, could you please try this patch ?
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index b80e68000dd3..a81eb4f882ab 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
> ata_port *ap)
>          /* tell ACPI that we're resuming */
>          ata_acpi_on_resume(ap);
> 
> -       /* update the flags */
>          spin_lock_irqsave(ap->lock, flags);
> +
> +       /* Update the flags */
>          ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
> +
> +       /*
> +        * Resuming the port will trigger a rescan of the ATA device(s)
> +        * connected to it. Before scheduling the rescan, make sure that
> +        * the associated scsi device(s) are fully resumed as well.
> +        */
> +       ata_for_each_link(link, ap, HOST_FIRST) {
> +               ata_for_each_dev(dev, link, ENABLED) {
> +                       struct scsi_device *sdev = dev->sdev;
> +
> +                       if (!sdev)
> +                               continue;
> +                       if (scsi_device_get(sdev))
> +                               continue;
> +
> +                       spin_unlock_irqrestore(ap->lock, flags);
> +                       device_pm_wait_for_dev(&ap->tdev,
> +                                              &sdev->sdev_gendev);
> +                       scsi_device_put(sdev);
> +                       spin_lock_irqsave(ap->lock, flags);
> +               }
> +       }
>          spin_unlock_irqrestore(ap->lock, flags);
>   }
>   #endif /* CONFIG_PM */
> 
> Thanks !
> 
Well; not sure if that'll work out.
The whole reason why we initial a rescan is that we need to check if the 
ports are still connected, and whether the devices react.
So we can't iterate the ports here as this is the very thing which gets 
checked during EH.

We really should claim resume to be finished as soon as we can talk with 
the HBA, and kick off EH asynchronously to let it finish the job after 
resume has completed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

