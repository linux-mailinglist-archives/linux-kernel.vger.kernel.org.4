Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857F5F3C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJDGBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDGBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:01:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0521250;
        Mon,  3 Oct 2022 23:01:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2E85219B4;
        Tue,  4 Oct 2022 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664863258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVUlkoaDmwsWB5tjrAEJpUY3Q7CPwdx0+TpErkfvy8Y=;
        b=yJhiGpi32zwaZcXCCVzGVt/muOCj8E+/EyzFFs6CgUC3s/mGCp0ZjkTifWMXiL2yDPLRfj
        WYY3Nvtg3Tx0FL8Z2a0bHCSTM4TKUWLR2ryg1Sa359cYGW6e13l1e2be0Hk8yTnb+FgW/9
        5F7cutRyn6jP+4budDm3aLHSzgXarr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664863258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVUlkoaDmwsWB5tjrAEJpUY3Q7CPwdx0+TpErkfvy8Y=;
        b=7PZ3Vrh7pt8X6QiY7WDwLppLMuS1Vo/QKPiPQFdVBVrGJhuWBIg6X/bPsOvdFrTMW8fhGC
        qtK/jKTIBnrVBxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9C08139EF;
        Tue,  4 Oct 2022 06:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EpgTJxjMO2PVEQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Oct 2022 06:00:56 +0000
Message-ID: <4a1da181-8a54-d2f8-6d19-d9c1982ab044@suse.de>
Date:   Tue, 4 Oct 2022 08:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/22 23:16, Bart Van Assche wrote:
> On 9/28/22 11:13, Lee Duncan wrote:
>> From: Lee Duncan <lduncan@suse.com>
>>
>> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
>> (front end) do not like the recent commit:
>>
>> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full 
>> page")
>>
>> That commit changed getting SCSI VPD pages so that we now read
>> just enough of the page to get the actual page size, then read
>> the whole page in a second read. The problem is that the above
>> mentioned hardware returns zero for the page size, because of
>> a firmware error. In such cases, until the firmware is fixed,
>> this new black flag says to revert to the original method of
>> reading the VPD pages, i.e. try to read as a whole buffer's
>> worth on the first try.
>>
>> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full 
>> page")
> 
> Hi Lee,
> 
> If we introduce a blacklist flag to skip querying the VPD page size then 
> we will have to find all SCSI devices that do not handle querying the 
> VPD page size correctly. Has it been considered instead of introducing a 
> blacklist flag to not use the reported VPD page size if the device 
> reports that the VPD page size is zero? I am not aware of any VPD pages 
> for which zero is a valid size.
> 
True.
But pre-SPC drives will ignore the VPD bit in the inquiry size. And 
these devices do not set an additional length in the inquiry data we 
will interpret the VPD page response as a zero-length VPD page.
Not good.

And really, we've seen only _one_ instance of this particular behaviour.
And even that could arguably been fixed with a firmware update on the 
target side. But to not introduce regressions we've opted for this flag.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

