Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31DD61F022
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKGKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:20:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309B15814;
        Mon,  7 Nov 2022 02:20:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CE79225A3;
        Mon,  7 Nov 2022 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667816406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31W9fG101zNzaHGLccQbFGakruspMGp88d1+Z6akzTQ=;
        b=Mhi2thsXfu74Y69IHi0P38X6LmyNwLa+96iaD7GYWhRYdYqL8C/RP1TIt/CIduH+pjaSCj
        T1BudNaW0s9A5E0yOMWh7HajjFriIhOTZC4r6g9sVKLji8cugmMyO/OOsak3lUb/dESHIY
        fxMJ0eAg7QkFr7ZKrrb+b43Uo1wFPck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667816406;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31W9fG101zNzaHGLccQbFGakruspMGp88d1+Z6akzTQ=;
        b=xrwOIk9Bj4wvUajWW/U8kLaO8E9SQohK95LtOh0F8G8PQBVFfnNNxrCwhTvorWJTJjGRvR
        Jz/rL0Pdyh39AXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D22C13AC7;
        Mon,  7 Nov 2022 10:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPXKAtbbaGO1awAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Nov 2022 10:20:06 +0000
Message-ID: <f4c4b350-70da-9f28-8675-d3319217e471@suse.de>
Date:   Mon, 7 Nov 2022 11:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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
 <331fffd7-b5db-9b4a-42ae-940a6b54a37f@suse.de>
 <59947ba8-d1a1-2e50-6199-f3974221f8fb@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC v3 16/22] ata: libata-scsi: Allocate sdev early in
 port probe
In-Reply-To: <59947ba8-d1a1-2e50-6199-f3974221f8fb@oracle.com>
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

On 11/7/22 11:09, John Garry wrote:
> 
>>>>>>    @@ -4289,26 +4294,16 @@ void ata_scsi_scan_host(struct ata_port
>>>>>> *ap, int sync)
>>>>>>     repeat:
> 
> I've been trying to follow this thread, below, but got a bit lost ....
> 
>>>>>>        ata_for_each_link(link, ap, EDGE) {
>>>>>>            ata_for_each_dev(dev, link, ENABLED) {
>>>>>> -            struct scsi_device *sdev;
>>>>>> +            struct Scsi_Host *shost = ap->scsi_host;
>>>>>>                int channel = 0, id = 0;
>>>>>>    -            if (dev->sdev)
>>>>>> -                continue;
>>>>>> -
>>>>>>                if (ata_is_host_link(link))
>>>>>>                    id = dev->devno;
>>>>>>                else
>>>>>>                    channel = link->pmp;
>>>>>>    -            sdev = __scsi_add_device(ap->scsi_host, channel, 
>>>>>> id, 0,
>>>>>> -                         NULL);
>>>>>> -            if (!IS_ERR(sdev)) {
>>>>>> -                dev->sdev = sdev;
>>>>>> -                ata_scsi_assign_ofnode(dev, ap);
>>>>>
>>>>> Is there something equivalent to what this function does inside
>>>>> scsi_scan_target() ? I had a quick look but did not see anything...
>>>>>
> 
> So are we discussing below whether we can have fixed channel, id, lun 
> per ATA sdev per shost? If so, I don't think it would work as libsas 
> uses dynamic target ids per host.
> 
Not static. target port enumeration would still be left to the driver / 
transport, so it can do whatever it wants here.
Idea was to match the 'ata_port' structure to the scsi target port; 
well, not exactly 'match' but have a 1:1 relationship between them.
_And_ to have a defined way on how the devices are enumerated; PATA 
drives would always have LUN 0 and LUN 1(for the slave), and everything 
else would use REPORT LUNs. For which we need an emulation for libata, 
but that should be trivially to implement.

With that we would know exactly how many scsi target ports we'll have, 
and can create them based on hardware details before probing starts.
Whether or not a _device_ is attached to that port is being determined 
during scanning via the 'slave_alloc' or 'slave_configure' callbacks, so 
we still would be able to blank out any not implemented or not connected 
ports.
_But_ it would align better with the SCSI layer, such that we can work 
on integrating scanning and resetting, and make things like 
'sd_revalidate' actually work for libata.

And for libsas it might be worthwhile to check the 'scan_start' and 
'scan_finished' callbacks; that seems to be the ticket here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

