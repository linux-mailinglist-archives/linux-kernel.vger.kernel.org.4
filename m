Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588DF72B7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 08:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjFLGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:09:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABD11B;
        Sun, 11 Jun 2023 23:09:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E49522760;
        Mon, 12 Jun 2023 06:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686550192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCw5nk0F5PqPIo3UlZE9ej6dRXUskeYlSz5XihTrsDs=;
        b=n1BQblxLy3G4bdU8Qhp0vWHnY2GqWSV6Nj26ZpZkbBclZAEUb9ggkckAs3Cgi/apdCN1iS
        Shh4tCx0bqRfFEvWJrlsyj4lsU0lYWn+2pHMANp+eMS/l4LYvjjwbn0219DwmW5HYOwfL5
        XkTuAZyRlU9zoHCWvTuKlpjHZ4P7U/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686550192;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCw5nk0F5PqPIo3UlZE9ej6dRXUskeYlSz5XihTrsDs=;
        b=JhqVRkLMrpetbd4musbzi1+eymg3KPxuPiMyYVZUqmkw5Y+zMkWftAEYMHs4Jxy5OJJOrN
        swtsgJLmLXVSoBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FC02138EC;
        Mon, 12 Jun 2023 06:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X9joC6+2hmTSSAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 12 Jun 2023 06:09:51 +0000
Message-ID: <0505654c-e487-6b91-57cf-fa7996f5c738@suse.de>
Date:   Mon, 12 Jun 2023 08:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
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
        Joe Breuer <linux-kernel@jmbreuer.net>,
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
 <4005a768-9e45-0707-509d-98ce0d2769bd@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <4005a768-9e45-0707-509d-98ce0d2769bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 05:09, Damien Le Moal wrote:
> On 6/11/23 00:03, Bart Van Assche wrote:
>> On 6/10/23 06:27, Bagas Sanjaya wrote:
>>> On 6/10/23 15:55, Pavel Machek wrote:
>>>>>> #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bug.cgi?id=217530
>>>>>> #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
>>>>>>
>>>>> The reporter had found the culprit (via bisection), so:
>>>>>
>>>>> #regzbot introduced: a19a93e4c6a98c
>>>> Maybe cc the authors of that commit?
>>>
>>> Ah! I forgot to do that! Thanks anyway.
>>
>> Hi Damien,
>>
>> Why does the ATA code call scsi_rescan_device() before system resume has
>> finished? Would ATA devices still work with the patch below applied?
> 
> I do not know the PM code well at all, need to dig into it. But your patch
> worries me as it seems it would prevent rescan of the device on a resume, which
> can be an issue if the device has changed.
> 
> I am not yet 100% clear on the root cause for this, but I think it comes from
> the fact that ata_port_pm_resume() runs before the sci device resume is done, so
> with scsi_dev->power.is_suspended still true. And ata_port_pm_resume() calls
> ata_port_resume_async() which triggers EH (which will do reset + rescan)
> asynchronously. So it looks like we have scsi device resume and libata EH for
> rescan fighting each others for the scan mutex and device lock, leading to deadlock.
> 
> Trying to recreate this issue now to confirm and debug further. But I suspect
> the solution to this may be best implemented in libata, not in scsi.
> This looks definitely related to this thread:
> 
> https://lore.kernel.org/linux-scsi/7b553268-69d3-913a-f9de-28f8d45bdb1e@acm.org/
> 
> Similaraly to your comment on that thread, having to look at
> dev->power.is_suspended is not ideal I think. What we need is to have ata and
> scsi pm resume be synchronized, but I am not yet 100% clear on the scsi layer side.
> 
Which is my feeling, too.
libata runs rescan as part of the device discovery, so really it will 
run after resume. And consequently resume really cannot wait for rescan 
to finish.

What I would be looking at is to decouple resume from libata device 
rescan, and have resume to complete before libata EH runs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

