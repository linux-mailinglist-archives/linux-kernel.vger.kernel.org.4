Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305C742D57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjF2TSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF2TSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:18:09 -0400
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23923594;
        Thu, 29 Jun 2023 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:References:In-Reply-To:Message-Id:Cc:To:Subject:From:
        Date:From:To:Subject:Date:Message-ID:Reply-To;
        bh=tFsDQ9M8pTGDJDmZIQVItVcWxyvrqoHvTx69aypSedE=; b=pkCz2dx9D7E3FahsKfVLZwxi+N
        h77aCdJDv6XJeHS8sNJR+Vx9BzGkfK/VbvTurGceLT4VenpFHr8tKVeHIQhk/70MshrFncrAt29dL
        QvEyt3XRQYbs+NzicUBp1xTSfVTugNk0+x08NuENb+frCNqXrHHd8xGmHTVa21OMHl0cnZkm0FA74
        0gKpsjN9mgq4KxUOpExKLswzplKqCNHNO1yJ/QbHKKxcdcky0Mut0JHQIH9+Xpa+7dmuXaAlAON/P
        ezLmM8iJ1o9HxuEV3d0XYmGJGZwnI1v2az5sGp+z6oHK3b2taHu2XrlCGF30pnyWhUBQbnZF1Onfm
        zdMCMGiw==;
Received: from [212.51.153.89] (helo=[192.168.12.232])
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1qEx3A-003mE8-0q;
        Thu, 29 Jun 2023 19:11:28 +0000
Date:   Thu, 29 Jun 2023 21:11:23 +0200
From:   Lorenz Brun <lorenz@brun.one>
Subject: Re: [PATCH] ata: libata-scsi: fix bogus SCSI sense after abort
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <ZY31XR.9LODJ0CBUU6X@brun.one>
In-Reply-To: <3373decb-56dc-2e18-5c3b-778f344bab4d@kernel.org>
References: <20230623181908.2032764-1-lorenz@brun.one>
        <1b44168a-195d-79bd-50cc-bc8baa0d8f16@kernel.org>
        <187b1b46-470c-8fe2-9969-051abf93199b@suse.de>
        <3373decb-56dc-2e18-5c3b-778f344bab4d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Mo, 26. Jun 2023 um 16:51:47 +09:00:00 schrieb Damien Le Moal 
<dlemoal@kernel.org>:
> On 6/26/23 16:46, Hannes Reinecke wrote:
>>  On 6/26/23 09:29, Damien Le Moal wrote:
>>>  On 6/24/23 03:19, Lorenz Brun wrote:
>>>>  Since commit 058e55e120ca which fixed that commands without valid
>>>>  error/status codes did not result in any sense error, the 
>>>> returned sense
>>>>  errors were completely bogus as ata_to_sense_error did not have 
>>>> valid
>>>>  inputs in the first place.
>>>> 
>>>>  For example the following ATA error
>>>> 
>>>>  exception Emask 0x10 SAct 0x20c000 SErr 0x280100 action 0x6 frozen
>>>>  irq_stat 0x08000000, interface fatal error
>>>>  SError: { UnrecovData 10B8B BadCRC }
>>>>  failed command: READ FPDMA QUEUED
>>>>  cmd 60/e0:70:20:0a:00/00:00:00:00:00/40 tag 14 ncq dma 114688 in
>>>>  res 40/00:ac:20:5e:50/00:00:5d:01:00/40 Emask 0x10 (ATA bus error)
>>>>  status: { DRDY }
>>>> 
>>>>  got turned into the following nonsensical SCSI error
>>>> 
>>>>  FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>>>  Sense Key : Illegal Request [current]
>>>>  Add. Sense: Unaligned write command
>>>>  CDB: Read(16) 88 00 00 00 00 00 00 00 0a 20 00 00 00 e0 00 00
>>>> 
>>>>  This has nothing to do with an unaligned write command, but is 
>>>> due to an
>>>>  ATA EH-triggered abort. But ata_to_sense_error only knows about
>>>>  status and error, both of which aren't even valid here as the 
>>>> command
>>>>  has been aborted.
>>>> 
>>>>  Add an additional section to ata_gen_ata_sense which handles
>>>>  errors not coming from the device first, before calling into
>>>>  ata_to_sense_error.
>>>> 
>>>>  According to the SAT-5 spec a reset should cause a Unit Attention 
>>>> event,
>>>>  which the SCSI subsystem should handle to retry its commands but I
>>>>  am not sure how much of that infra is present in Linux's SCSI 
>>>> layer, so
>>>>  this is a simpler solution.
>>>> 
>>>>  Signed-off-by: Lorenz Brun <lorenz@brun.one>
>>>>  ---
>>>>    drivers/ata/libata-scsi.c | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>> 
>>>>  diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>>>  index 551077cea4e4..61c6a4e8123a 100644
>>>>  --- a/drivers/ata/libata-scsi.c
>>>>  +++ b/drivers/ata/libata-scsi.c
>>>>  @@ -13,6 +13,7 @@
>>>>     *  - http://www.t13.org/
>>>>     */
>>>> 
>>>>  +#include "scsi/scsi_proto.h"
>>>>    #include <linux/compat.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/kernel.h>
>>>>  @@ -1013,6 +1014,21 @@ static void ata_gen_ata_sense(struct 
>>>> ata_queued_cmd *qc)
>>>>    		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
>>>>    		return;
>>>>    	}
>>>>  +	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_ATA_BUS | 
>>>> AC_ERR_HOST_BUS |
>>>>  +		AC_ERR_SYSTEM | AC_ERR_OTHER)) {
>>> 
>>>  Did you check SATA IO specs and/or AHCI to see if that says 
>>> anything about these
>>>  ? And I wonder if we should check if we have something in 
>>> tf->status and
>>>  tf->error...
>>> 
>>  We really should. The above combination of error masks seems pretty
>>  arbitrary, as actually you do _not_ want to check for there error 
>> mask,
>>  but rather for the fact that the sense code is bogus.
>>  So shouldn't we rather test for that one directly?
SCISI / ATA Translation (SAT)-5 has the following to say about it:

A SATL that detects a link reset sequence for a Serial ATA device or 
initiates any reset of an ATA device shall
establish a unit attention condition on behalf of the emulated logical 
unit corresponding to the ATA device with
the sense key set to UNIT ATTENTION and the additional sense code set 
to POWER ON, RESET, OR BUS
DEVICE RESET OCCURRED for the SCSI initiator port associated with each 
I_T nexus. The method a SATL
uses to detect a link reset sequence on the SATA link is vendor 
specific.

I am however not sufficiently familiar with SCSI and especially the 
SCSI midlayer in Linux to know how this Unit Attention causes the 
requests to be aborted.

As a simpler fix I checked which err_maks cause a reset and in that 
case report this error. I'd be happier with the proper SAT-5 solution, 
but it looks like it would be quite a significant change.

>> 
>>>>  +		/* Command aborted because of some issue with the ATA subsystem
>>>>  +		 * Should technically cause unit attention, but this is better
>>>>  +		 * than nothing, which results in nonsensical errors.
>>>>  +		 * POWER ON, RESET, OR BUS DEVICE RESET OCCURRED
>>>>  +		 */
>>> 
>>>  Multi-line comment style: start with a "/*" line please. The 
>>> phrasing of the
>>>  comment is not very clear. Maybe something like:
>>> 
>>>  		/*
>>>  		 * If the command aborted because of some issue with the
>>>  		 * adapter or link, report a POWER ON, RESET, OR BUS DEVICE
>>>  		 * RESET OCCURRED error.
>>>  		 */
>>> 
>>>  Did you check that all of the above error flags lead to a drive 
>>> reset ? The
>>>  issue I have with this is that the drive reset is triggered by 
>>> libata EH after
>>>  it got these bad errors but the sense data you use here normally 
>>> indicate that
>>>  the reset was initiated by the adapter or the drive. Not sure this 
>>> is ideal.
>>> 
>>  Yes. We should rather return a DID_RESET status instead of any made 
>> up
>>  sense code for which we don't have a good justification, and which 
>> might
>>  get invalidated by future SATL versions.
> 
> Need to check what SAT says about all this as well... Will do some 
> spec reading.
> The default sense code for when we cannot figure out proper sense 
> based on
> status and error is ABORTED COMMAND/0/0. That seems good enough to 
> me. The issue
> may be that we do not reach that default case when we have bogus 
> status/error.
> The test:
> 
> 	if (qc->err_mask ||
> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 
> in ata_gen_ata_sense() is sketchy... Why is that qc->err_mask there ? 
> It does
> not seem needed at all. If removed, then we would fall back to 
> aborted command
> default.
 From reading SAT-5 I think most of this function is bogus, but I don't 
know enough about the pieces involved to come up with the "correct" fix.
> 
Regards,
Lorenz



