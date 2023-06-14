Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBA730AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjFNWou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45C1BF7;
        Wed, 14 Jun 2023 15:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4556281D;
        Wed, 14 Jun 2023 22:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B01C433C0;
        Wed, 14 Jun 2023 22:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686782685;
        bh=lMvudJgKGP6G5z1D5G5ktPPOIHeYLAxIIf2pg1Bn6dA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zk6bt6oVdjWME3wilTbcHVuIxYexd/ugfSoqlxQA+OKl7qFQrKmyiFMXVZXlSLBrh
         7Jry8e84dvXNqFZPIPlrmBuZoyCRj9Y6/+vzIlZqLjR2NWK/Ahana4A/5nbZpJ+xds
         c7GN7maBBDBmKOcMkmw2tuqPXW3rM46twikbRfrEt5C92i+eoeQbNcEOXPuJrwAEOe
         qPfWvLRNKp0EL4+S82/uGEoYOD+Fpg8jyck9vu6YebQG1WBdkb99Gz+xlMyb2XkkyC
         /EzMJ5NBWSplFJ1Wj39Ba6c4ldZQoyJUY+xKb3VF1YWmjkV9RicqPqmO8QnICaTDna
         dUKeQNi4BltJQ==
Message-ID: <bf142e7d-178e-43a8-32e8-7e9e396eeee7@kernel.org>
Date:   Thu, 15 Jun 2023 07:44:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Hannes Reinecke <hare@suse.de>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
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
 <b0fdf454-b2f7-c273-66f5-efe42fbc2807@kernel.org>
 <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu>
 <3f85cb4a-8b14-623f-eb4e-40baab1ed888@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3f85cb4a-8b14-623f-eb4e-40baab1ed888@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 03:04, Bart Van Assche wrote:
> On 6/14/23 07:26, Alan Stern wrote:
>> On Wed, Jun 14, 2023 at 04:35:50PM +0900, Damien Le Moal wrote:
>>> Or... Why the heck scsi_rescan_device() is calling device_lock() ? This
>>> is the only place in scsi code I can see that takes this lock. I suspect
>>> this is to serialize either rescans, or serialize with resume, or both.
>>> For serializing rescans, we can use another lock. For serializing with
>>> PM, we should wait for PM transitions...
>>> Something is not right here.
>>
>> Here's what commit e27829dc92e5 ("scsi: serialize ->rescan against
>> ->remove", written by Christoph Hellwig) says:
>>
>>      Lock the device embedded in the scsi_device to protect against
>>      concurrent calls to ->remove.
>>
>> That's the commit which added the device_lock() call.
> 
> Even if scsi_rescan_device() would use another mechanism for 
> serialization against sd_remove() and sr_remove(), we still need to 
> solve the issue that the ATA code calls scsi_rescan_device() before 
> resuming has finished. scsi_rescan_device() issues I/O. Issuing I/O to a 
> device is not allowed before that device has been resumed.

I am not convinced of that: scsi suspend quiecse the queue, thus preventing IOs
from the block layer, but not internale scsi ml commands, which is what
scsi_rescan_device() issues.

In any case, I am thinking that best (and quickest) fix for this issue for now
is to have libata define a device link to make the scsi device a "parent" of the
ata device (which is the ata link as of now). This way, PM operation ordering
will ensure that the scsi device resume will be done before the ata device. What
I really do not like about this though is that the suspend side would be done in
the reverse order: ata first and then scsi, but we really want the reverse here
to ensure that the request queue is quiesced before we suspend ata. That said,
there is no such synchronization right now and so this is probably happening
already without raising issues apparently.

So ideally:
1) Make the ata device the parent of the scsi device using a device link
2) For suspend, the scsi device suspend will be done first, followed by the ata
device, which is what we want.
3) For resume, ata device will be first, followed by scsi device. The call to
scsi_rescan_device() from libata being in a work task, asynchronous from the ata
resume context, we need to synchronize that work to wait for the scsi device
resume to complete. (but do we really given that we are going to issue internal
commands only ?)

Alan, Rafael,

For the synchronization of step (3), if I understand the pm code correctly,
using device_pm_wait_for_dev() would work only if async resume is on. This would
be ineffective for the sync case. How can we best deal with this ?


-- 
Damien Le Moal
Western Digital Research

