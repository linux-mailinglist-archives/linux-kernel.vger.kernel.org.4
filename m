Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6F72F4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbjFNGdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjFNGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B471FC9;
        Tue, 13 Jun 2023 23:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AFA6304E;
        Wed, 14 Jun 2023 06:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A3AC433C0;
        Wed, 14 Jun 2023 06:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686724313;
        bh=U3PE7SCQ1RxmKERA37xeQi0YnSmGXq/InAGZE9u2dUg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ba63IBzLXf4v1BRJlu0Aery8nmHq4ZxH63PyyGkxlUNZSWJqBkTKv7wf/kO3KB3UG
         2IEh8nKDRrjkjXhwUNSwp1kTIbq6fEVimy41dBu4bjRLG57V73MRcOnr/AISqi4Lux
         EEHm4j7cSnQ2+qzYaUJfJIH+b2/ILC83y3qfsdH9zB+0d8RZHqMAKI+/7ZlmqI130L
         WTA5mONXSvdWQ4+Xn0ZukvhF7DX9TtcYtgT2ZX3ZxndN8HIsXcB17kSng8Ee8QCRRo
         s/FrS9aYRuvf0HbW545P1InaKsRjsvwynmBgiCSTR3ZnwQh2oDHdsCeZRdd0S9al3Z
         X9Kcf9w1IZ7hw==
Message-ID: <e7fce935-68ac-6e8f-072f-87e6271c2f96@kernel.org>
Date:   Wed, 14 Jun 2023 15:31:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Martin Kepplinger <martin.kepplinger@puri.sm>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
 <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
 <CAAd53p665S+dfOvWZt2UwTs=VrxE=FtpqjzUrSuLKR5tBpAa9Q@mail.gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAd53p665S+dfOvWZt2UwTs=VrxE=FtpqjzUrSuLKR5tBpAa9Q@mail.gmail.com>
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

On 6/14/23 14:37, Kai-Heng Feng wrote:
> On Wed, Jun 14, 2023 at 12:49 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
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
> 
> Issue still persists at my end, when /sys/power/pm_async is 0.
> device_pm_wait_for_dev() in its current form is only usable for async case.

OK. Thanks for checking. Let me dig further.

> 
> Kai-Heng
> 
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index b80e68000dd3..a81eb4f882ab 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
>> ata_port *ap)
>>         /* tell ACPI that we're resuming */
>>         ata_acpi_on_resume(ap);
>>
>> -       /* update the flags */
>>         spin_lock_irqsave(ap->lock, flags);
>> +
>> +       /* Update the flags */
>>         ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
>> +
>> +       /*
>> +        * Resuming the port will trigger a rescan of the ATA device(s)
>> +        * connected to it. Before scheduling the rescan, make sure that
>> +        * the associated scsi device(s) are fully resumed as well.
>> +        */
>> +       ata_for_each_link(link, ap, HOST_FIRST) {
>> +               ata_for_each_dev(dev, link, ENABLED) {
>> +                       struct scsi_device *sdev = dev->sdev;
>> +
>> +                       if (!sdev)
>> +                               continue;
>> +                       if (scsi_device_get(sdev))
>> +                               continue;
>> +
>> +                       spin_unlock_irqrestore(ap->lock, flags);
>> +                       device_pm_wait_for_dev(&ap->tdev,
>> +                                              &sdev->sdev_gendev);
>> +                       scsi_device_put(sdev);
>> +                       spin_lock_irqsave(ap->lock, flags);
>> +               }
>> +       }
>>         spin_unlock_irqrestore(ap->lock, flags);
>>  }
>>  #endif /* CONFIG_PM */
>>
>> Thanks !
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>

-- 
Damien Le Moal
Western Digital Research

