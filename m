Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0C6540C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiLVMMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiLVMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:12:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B45726C5;
        Thu, 22 Dec 2022 04:05:01 -0800 (PST)
Received: from [IPV6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a] (unknown [IPv6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1201471;
        Thu, 22 Dec 2022 13:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671710698;
        bh=o97tTGiyRJiqtRawzNrOFqtwVzXfZ20MOnFXnWX8hhA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bjTfWMggUYqu+kG1g0r+BHK2n4Ys/PUqqer9M+ZWYc7TwbrH/2vlw7RnK7vJy2HJm
         R3Q3i5rr1JoaO+9jAjn1Quh8To21YsuWEFzUDJb6FlQ0u20K95USQxYrJWaNaFk9d0
         bSb/U8+8gVxLqefFkG/zM4GqlRmZ/4NgKSlG7xHc=
Message-ID: <6baffa7c-ea7c-aaa6-361a-1a043b065f29@ideasonboard.com>
Date:   Thu, 22 Dec 2022 17:34:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 5/7] vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage
 on disconnect
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
 <20221219115725.11992-6-umang.jain@ideasonboard.com>
 <8fcbdf54-98ae-6a06-ecaf-591a43b863a1@i2se.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <8fcbdf54-98ae-6a06-ecaf-591a43b863a1@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 12/22/22 4:37 PM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 19.12.22 um 12:57 schrieb Umang Jain:
>> Drop the usage of VCHIQ_RETRY when the vchiq has connection status
>> VCHIQ_CONNSTATE_DISCONNECTED. Disconnected status will not be valid to
>> carry on a retry, replace the VCHIQ_RETRY with -ENOTCONN.
>>
>> This patch removes the usage of vCHIQ_RETRY completely and act as
>> intermediatory to address the TODO item:
>>     * Get rid of custom function return values
>> for vc04_services/interface.
>>
>> Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
> please drop this fixes tag since this commit doesn't fix a real issue 
> and also shouldn't be applied to stable.

Should I send a v3 of the series with updated commit message or can you 
drop the tag while applying?

Other option would be to send v2.1  --in-reply-to this patch. I am fine 
with anything as long as it aligns with the merging workflow.

Thanks,
Umang
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> index 9c64d5de810e..ddb6d0f4daed 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> @@ -3641,7 +3641,7 @@ vchiq_loud_error_footer(void)
>>   int vchiq_send_remote_use(struct vchiq_state *state)
>>   {
>>       if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
>> -        return VCHIQ_RETRY;
>> +        return -ENOTCONN;
>>         return queue_message(state, NULL, MAKE_REMOTE_USE, NULL, 
>> NULL, 0, 0);
>>   }
>> @@ -3649,7 +3649,7 @@ int vchiq_send_remote_use(struct vchiq_state 
>> *state)
>>   int vchiq_send_remote_use_active(struct vchiq_state *state)
>>   {
>>       if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
>> -        return VCHIQ_RETRY;
>> +        return -ENOTCONN;
>>         return queue_message(state, NULL, MAKE_REMOTE_USE_ACTIVE,
>>                    NULL, NULL, 0, 0);

