Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4673F4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjF0Gvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjF0Gvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:51:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE9122;
        Mon, 26 Jun 2023 23:51:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0179621898;
        Tue, 27 Jun 2023 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687848710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=siNVEFVMJbaY/pqwCdt8cIyoPzgMxgexWD0B44SPTLo=;
        b=UEbDNx5f0+pil+MzDr8DPuk1QyYOAEKCTGVBCTEPOqP6Un9zNN82B+auHpNkJnO/HOviC9
        q2Z1QJtA/iR2s8Wbc5K/S7q8LKZwL8QT52UANItmEq6FKkULrci7LoDUc67dP6uZYv1O49
        wGTW7BoSkeUOpml+sdM55z6D/SMd+xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687848710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=siNVEFVMJbaY/pqwCdt8cIyoPzgMxgexWD0B44SPTLo=;
        b=lOWUdHCXJzuSBtm1InI3hB8FKT7x/UforKVHDV1gZBw7N2o2/kfv1bhQrJPJfFMH9SVNr3
        VmVu7JgvZgqw0rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3A4013276;
        Tue, 27 Jun 2023 06:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gmLqKQWHmmRYCgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 27 Jun 2023 06:51:49 +0000
Message-ID: <9b01b4b3-0beb-4159-1ce9-4ed4b531d7a6@suse.de>
Date:   Tue, 27 Jun 2023 08:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
To:     Daniel Wagner <dwagner@suse.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <3ea88e87-9b24-4f7a-958c-97e27d94ec30@moroto.mountain>
 <s7ojt6ad3i3t4ddqwxvxsxv4zxisz6skomogwbw3qljbuqkwr6@akwaxv2cyg2d>
 <17321e5d-3744-dd7c-5ed9-cecf055ada39@suse.de>
In-Reply-To: <17321e5d-3744-dd7c-5ed9-cecf055ada39@suse.de>
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

On 6/27/23 08:39, Hannes Reinecke wrote:
> On 6/27/23 08:18, Daniel Wagner wrote:
>> On Mon, Jun 26, 2023 at 02:33:18PM +0300, Dan Carpenter wrote:
>>>> @@ -2943,6 +2943,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl 
>>>> *ctrl)
>>>>       /* force put free routine to ignore io queues */
>>>>       ctrl->ctrl.tagset = NULL;
>>>> +    if (ret > 0)
>>>> +        ret = -EIO;
>>>
>>> All these checks for ret > 0 make me unhappy.  I don't understand how
>>> they are a part of the commit.
>>
>> We have two types of error message types in the nvme subsystem. The 
>> negative
>> values are the usual ones and positive ones are nvme protocol errors.
>>
>> For example if the authentication fails because of invalid credentials 
>> when
>> doing the authentication nvmf_connect_admin_queue() will return a 
>> value of
>> NVME_SC_AUTH_REQUIRED. This is also the value which gets propagated to 
>> this
>> point here. The problem is any positive error code is interpreted as a 
>> valid
>> pointer later in the code, which results in a crash.
>>
>>> I have tried to look at the context and I think maybe you are working
>>> around the fact that qla_nvme_ls_req() returns QLA_FUNCTION_FAILED on
>>> error.
>>
>> The auth blktests are exercising the error path here and that's why I 
>> added
>> this check. BTW, we already use in other places, this is not 
>> completely new in
>> this subsystem.
>>
>>> Also the qla_nvme_ls_req() function EINVAL on error.  I just wrote a
>>> commit message saying that none of the callers cared but I missed that
>>> apparently gets returned to nvme_fc_init_ctrl().  :/
>>> https://lore.kernel.org/all/49866d28-4cfe-47b0-842b-78f110e61aab@moroto.mountain/
>>
>> Thank!
>>
>>> Let's just fix qla_nvme_ls_req() instead of working around it here.
>>>
>>> And let's add a WARN_ON_ONCE() somewhere to prevent future bugs.
>>
>> This makes sense for the driver APIs. Though for the core nvme 
>> subsystem this
>> needs to be discusses/redesigned how to handle the protocol errors first.
>>
> I would stick with the 'normal' nvme syntax of having negative errors as 
> internal errors (ie errnos), '0' for no error, and positive numbers as 
> NVMe protocol errors.
> As such I would also advocate to not map NVMe protocol errors onto error 
> numbers but rather fix the callers to not do a pointer conversion.
> 
Aw. Now I see it.

It's the ->create_ctrl() callback which will always return a controller 
pointer or an error value.
If we were to return a protocol error we would need to stick it into the 
controller structure itself. But if we doing that then we'll be ending 
up with a non-existing controller, ie we'd be returning a structure for 
a dead controller. Not exactly pretty, but it would allow us to improve
the userland API to return the NVMe protocol error by reading from the
fabrics device; the controller structure itself would be cleaned up when 
closing that device.

Hmm.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

