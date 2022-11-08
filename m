Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5C6209CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiKHG5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiKHG5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:57:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074941FCD3;
        Mon,  7 Nov 2022 22:57:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4021F899;
        Tue,  8 Nov 2022 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667890628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HsuM9y0VlNY6STi9GVfvRAUeLwjjk0OZ0q1YrHxZxA=;
        b=PQlOorVSacK9kBqqDTVufL791tp1f97C0geHzbp95MGeTsZrL1SptB3ufb5MIGOH3E0VS5
        SgA1P81wR6/yW64dw1I5HhiMvWcSkEnAPdk93oIE35HbD0DuKzNIG7KtE+5LU5u0OtM7I0
        0cnYUrxTZTQEfIn2X4QIp0V7K/MsUkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667890628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HsuM9y0VlNY6STi9GVfvRAUeLwjjk0OZ0q1YrHxZxA=;
        b=Wz2Raops3HzN72/wiUuvca6T64lLPFg4WcdKN/30PzSOnpqusLRxF3vKEsWuQwrvWe7ViB
        iRiZO1hdcKaXyuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57ABE139F1;
        Tue,  8 Nov 2022 06:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4e3RFMT9aWMzIQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 08 Nov 2022 06:57:08 +0000
Message-ID: <6349abb3-9fb5-8bd1-7d71-e8a1435b0cef@suse.de>
Date:   Tue, 8 Nov 2022 07:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
 <4a1da181-8a54-d2f8-6d19-d9c1982ab044@suse.de>
 <yq1k046kwyv.fsf@ca-mkp.ca.oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <yq1k046kwyv.fsf@ca-mkp.ca.oracle.com>
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

On 11/8/22 03:50, Martin K. Petersen wrote:
> 
> Hannes,
> 
> I have been contemplating this for a bit.
> 
>>> Has it been considered instead of introducing a blacklist flag to not
>>> use the reported VPD page size if the device reports that the VPD
>>> page size is zero? I am not aware of any VPD pages for which zero is
>>> a valid size.
> 
> That would also be my preferred approach, I think. I haven't received
> any bug reports about devices returning short VPD pages since this
> change was introduced. So I think I'd prefer falling back to a
> (hopefully small) default if a device returns a 0 page length.
> 
> Now, my question is which VPD pages are actually supported by this
> device and how large are they?
> 
>> But pre-SPC drives will ignore the VPD bit in the inquiry size. And
>> these devices do not set an additional length in the inquiry data
> 
> Can you elaborate a bit on your experience with older devices? I checked
> SCSI-2 (1991) and don't see any indication this would be valid behavior
> even back then.
> 
This is primarily crappy USB devices, which implement only the absolute 
minimum to get SCSI rolling.
In particular, if devices do _not_ check the VPD bit in the inquiry 
command they will continue to return the standard inquiry data.
And if the additional length is zero we have exactly the scenario above.

However, we _could_ turn things around, and use the BLIST_NO_VPD flag 
for these cases; so I'd be fine with having a default length for the VPD 
page and delegate any fallout from the to use the BLIST_NO_VPD flags.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

