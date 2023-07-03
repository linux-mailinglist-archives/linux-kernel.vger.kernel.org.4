Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC2745816
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGCJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGCJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC21AA;
        Mon,  3 Jul 2023 02:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F40160E8B;
        Mon,  3 Jul 2023 09:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197C8C433C7;
        Mon,  3 Jul 2023 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688375352;
        bh=2sRwpF29lKch9gUGFa8Xo3m/1780odiTFeHlY6F3e5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=euOZ3FtkYVhTFBWJrw+SKaw8HbCJQoG95szohCEiWJ9i6rGUT//UFlcnvcg0BWYkA
         TRXWKMsujDpj5q5+L7y1/h8SYQLCXusLFJjw/qK3jAvR6kcafZt6alJ2ty8etIzwA6
         UtRsCJd9FTFwKVbR9mj2nqr6Ml+/ayCJTs9vOEJrBSmK1Iod4pjiZ/GyID5JvmeT1I
         pqx7Qv++rn9W5aLm99jBnqTQ5rGp1RUXDssY89zM8Nz/n1yDjOZNfjZO/HGxD4F1E9
         gzDza+ZyuzeuqCTmIdXlqYLn54i15byjN1dPI/KaksuZj+eyg32mzMTpaHYTJ83sqj
         HTWdepogfb/pQ==
Message-ID: <a0c5a05f-2836-08ec-8974-431e487fba3c@kernel.org>
Date:   Mon, 3 Jul 2023 18:09:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ata: libata-scsi: fix bogus SCSI sense after abort
Content-Language: en-US
To:     Lorenz Brun <lorenz@brun.one>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230623181908.2032764-1-lorenz@brun.one>
 <1b44168a-195d-79bd-50cc-bc8baa0d8f16@kernel.org>
 <187b1b46-470c-8fe2-9969-051abf93199b@suse.de>
 <3373decb-56dc-2e18-5c3b-778f344bab4d@kernel.org>
 <ZY31XR.9LODJ0CBUU6X@brun.one>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZY31XR.9LODJ0CBUU6X@brun.one>
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

On 6/30/23 04:11, Lorenz Brun wrote:
> 
> Am Mo, 26. Jun 2023 um 16:51:47 +09:00:00 schrieb Damien Le Moal 
> <dlemoal@kernel.org>:
>> On 6/26/23 16:46, Hannes Reinecke wrote:
>>>  On 6/26/23 09:29, Damien Le Moal wrote:
>>>>  On 6/24/23 03:19, Lorenz Brun wrote:
>>>>>  Since commit 058e55e120ca which fixed that commands without valid
>>>>>  error/status codes did not result in any sense error, the 
>>>>> returned sense
>>>>>  errors were completely bogus as ata_to_sense_error did not have 
>>>>> valid
>>>>>  inputs in the first place.
>>>>>
>>>>>  For example the following ATA error
>>>>>
>>>>>  exception Emask 0x10 SAct 0x20c000 SErr 0x280100 action 0x6 frozen
>>>>>  irq_stat 0x08000000, interface fatal error
>>>>>  SError: { UnrecovData 10B8B BadCRC }
>>>>>  failed command: READ FPDMA QUEUED
>>>>>  cmd 60/e0:70:20:0a:00/00:00:00:00:00/40 tag 14 ncq dma 114688 in
>>>>>  res 40/00:ac:20:5e:50/00:00:5d:01:00/40 Emask 0x10 (ATA bus error)
>>>>>  status: { DRDY }

If the command error field is non-zero, there should be a line printed here
"error: { ... }". See the end of the function ata_eh_link_report(). Given that
you do not seem to be getting this message, I assume it is 0. However, your
status field only has ATA_DRDY set (0x40). With that, the function
ata_to_sense_error() hits the second entry of stat_table, which is:

{0x40,          ILLEGAL_REQUEST, 0x21, 0x04},
// Device ready, unaligned write command

(This table comments are extremely confusing and need cleanup)

Hence the sense data error that you see. And if you check SAT section 11.6 (ATA
Fixed error translation), you will see that this case is not defined in that
table. In fact, only entry 4 is defined:

{0x04,          RECOVERED_ERROR, 0x11, 0x00},
// Recovered ECC error    Medium error, recovered

The sense_table table cover the cases for the error field bits, separated from
the status field bits, which is unlike what SAT defines. Not sure where these
definitions come from, or if they are accumulated "black magic" from decades of
dealing with weird ATA devices and adapters. Need to dig on that.

[...]

>>>>  Did you check SATA IO specs and/or AHCI to see if that says 
>>>> anything about these
>>>>  ? And I wonder if we should check if we have something in 
>>>> tf->status and
>>>>  tf->error...
>>>>
>>>  We really should. The above combination of error masks seems pretty
>>>  arbitrary, as actually you do _not_ want to check for there error 
>>> mask,
>>>  but rather for the fact that the sense code is bogus.
>>>  So shouldn't we rather test for that one directly?
> SCISI / ATA Translation (SAT)-5 has the following to say about it:
> 
> A SATL that detects a link reset sequence for a Serial ATA device or 
> initiates any reset of an ATA device shall
> establish a unit attention condition on behalf of the emulated logical 
> unit corresponding to the ATA device with
> the sense key set to UNIT ATTENTION and the additional sense code set 
> to POWER ON, RESET, OR BUS
> DEVICE RESET OCCURRED for the SCSI initiator port associated with each 
> I_T nexus. The method a SATL
> uses to detect a link reset sequence on the SATA link is vendor 
> specific.
> 
> I am however not sufficiently familiar with SCSI and especially the 
> SCSI midlayer in Linux to know how this Unit Attention causes the 
> requests to be aborted.

Yes, found that text as well. But my thiniking is that strictly speaking, the
reset is not initiated by the translation code. It is libata-eh that decide that
the bad CRC error you are getting is serious enough to warrant a reset. The
point remain that for that command, the adpater returned an error field not
having any of the ATA_ICRC | ATA_UNC | ATA_AMNF | ATA_IDNF | ATA_ABORTED bits
set, and status field only having ATA_DRDY set. Which is weird. I would expect
ATA_ICRC to be set in error and ATA_ERR to be set in status.

> As a simpler fix I checked which err_maks cause a reset and in that 
> case report this error. I'd be happier with the proper SAT-5 solution, 
> but it looks like it would be quite a significant change.

I have a setup that returns:

[ 1531.680502] ata4: SError: { Proto TrStaTrns UnrecFIS }

due to bad data transmission over the wire. But for these failures, I get:

[ 1531.728008] ata4.00: status: { DRDY SENSE ERR }
[ 1531.737741] ata4.00: error: { ICRC ABRT }

Which gives me a hit on the sense_table entry:

/* ICRC|ABRT */         /* NB: ICRC & !ABRT is BBD */
{0x84,          ABORTED_COMMAND, 0x47, 0x00},

SO an "internal target failure". Which makes more sense than the unaligned write
error. Not sure why your setup is not more verbose with error and status. What
adapter are you using ? AHCI ? If yes, which one ? (lspci)

Need to dig further in SATA-IO to see if I can find more hints about how to
handle this case.

[...]

>> Need to check what SAT says about all this as well... Will do some 
>> spec reading.
>> The default sense code for when we cannot figure out proper sense 
>> based on
>> status and error is ABORTED COMMAND/0/0. That seems good enough to 
>> me. The issue
>> may be that we do not reach that default case when we have bogus 
>> status/error.
>> The test:
>>
>> 	if (qc->err_mask ||
>> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>>
>> in ata_gen_ata_sense() is sketchy... Why is that qc->err_mask there ? 
>> It does
>> not seem needed at all. If removed, then we would fall back to 
>> aborted command
>> default.
>  From reading SAT-5 I think most of this function is bogus, but I don't 
> know enough about the pieces involved to come up with the "correct" fix.

I would not put it as "bogus". It is certainly hard to map this to the specs,
but I suspect a lot of that is historical reason. Need to dig in git history,
but most of this may actually predate git :)

Let me dig further to see if I can come up with something. Can you reliably
trigger these errors for testing any patch ?

-- 
Damien Le Moal
Western Digital Research

