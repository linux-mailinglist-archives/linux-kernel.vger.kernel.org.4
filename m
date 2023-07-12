Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2796774FFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGLGuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGLGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:50:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96ADC;
        Tue, 11 Jul 2023 23:50:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14BAC22581;
        Wed, 12 Jul 2023 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689144641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0RkH5WqJss4L/epVGtpcnugvrtDh2KTyP98Fes5eso=;
        b=GUv37xgI+gqiC6MqWK9+hM0+lMfuz2ib0W9F1YAXyw6QMovnCBbKTEKQ3pmIUjCIbGWjnE
        x7Lv6Mpzxu1LCOmgdapwTZiRuvDJBmVoZIqngMGHQXhsIvSqXW7gQIcOtGDjmsDyP0FoP4
        7nI+QJoWCcoQRoTfX3Rmej0iK/B3KQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689144641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0RkH5WqJss4L/epVGtpcnugvrtDh2KTyP98Fes5eso=;
        b=3UNbjRgI++VXyRei9e//0f3aU0ELwy0YT3Vc3K3zh6hzoLd3eLAsds/c2/kVWGfGtmcnrY
        F/7tgC8yKAz5GxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9D8C133DD;
        Wed, 12 Jul 2023 06:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rewnNEBNrmQyFQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 12 Jul 2023 06:50:40 +0000
Message-ID: <5f239919-d4bb-17ed-f8d1-8edb4f3659fc@suse.de>
Date:   Wed, 12 Jul 2023 08:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
To:     James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ewan Milne <emilne@redhat.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
 <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
 <0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 00:47, James Smart wrote:
> On 7/6/2023 5:07 AM, Daniel Wagner wrote:
>> Hi James,
>>
>> On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
>>> As much as you want to make this change to make transports "similar", 
>>> I am dead set against it unless you are completing a long qualification
>>> of the change on real FC hardware and FC-NVME devices. There is probably 
>>> 1.5 yrs of testing of different race conditions that drove this change.
>>> You cannot declare success from a simplistic toy tool such as fcloop for 
>>> validation.
>>>
>>> The original issues exist, probably have even morphed given the time 
>>> from
>>> the original change, and this will seriously disrupt the transport 
>>> and any
>>> downstream releases.  So I have a very strong NACK on this change.
>>>
>>> Yes - things such as the connect failure results are difficult to return
>>> back to nvme-cli. I have had many gripes about the nvme-cli's 
>>> behavior over
>>> the years, especially on negative cases due to race conditions which
>>> required retries. It still fails this miserably.  The async reconnect 
>>> path
>>> solved many of these issues for fc.
>>>
>>> For the auth failure, how do we deal with things if auth fails over 
>>> time as
>>> reconnects fail due to a credential changes ?  I would think 
>>> commonality of
>>> this behavior drives part of the choice.
>>
>> Alright, what do you think about the idea to introduce a new '--sync' 
>> option to
>> nvme-cli which forwards this info to the kernel that we want to wait 
>> for the
>> initial connect to succeed or fail? Obviously, this needs to handle 
>> signals too.
>>
>>  From what I understood this is also what Ewan would like to have
> To me this is not sync vs non-sync option, it's a max_reconnects value 
> tested for in nvmf_should_reconnect(). Which, if set to 0 (or 1), should 
> fail if the initial connect fails.
> 
Well, this is more a technical detail while we continue to harp about 
'sync' vs 'non-sync'.
Currently all instances of ->create_ctrl() are running asynchronously,
ie ->create_ctrl() returns a 'ctrl' object which is still in the process
of establishing the connection.
(And there it doesn't really matter whether it's FC or TCP/RDMA; FC is 
kicking of a workqueue for the 'reconnect' call, whereas TCP/RDMA is 
creating the association and issues the actual 'connect' NVMe SQE via
an I/O workqueue; net result is identical).
And when we talk about 'sync' connect we are planning to _wait_ until
this asynchronous operation reaches a steady state, ie either after the 
connect attempts succeeded or after the connect retries are exhausted.

And yes, we _are_ aware that this might be a quite long time.

> Right now max_reconnects is calculated by the ctrl_loss_tmo and 
> reconnect_delay. So there's already a way via the cli to make sure 
> there's only 1 connect attempt. I wouldn't mind seeing an exact cli 
> option that sets it to 1 connection attempt w/o the user calculation and 
> 2 value specification.
> 
Again, we do _not_ propose to change any of the default settings.
The 'sync' option will not modify the reconnect settings, it will just 
wait until a steady state it reached.

> I also assume that this is not something that would be set by default in 
> the auto-connect scripts or automated cli startup scripts.
> 
You assume correctly. That's why it'll be an additional option.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

