Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF56A5757
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjB1K7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjB1K6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:58:51 -0500
X-Greylist: delayed 57567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 02:58:42 PST
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F046B6;
        Tue, 28 Feb 2023 02:58:42 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 1372AC800A8;
        Tue, 28 Feb 2023 11:58:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id qcGQY3fabtmu; Tue, 28 Feb 2023 11:58:39 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 6E8FCC800A7;
        Tue, 28 Feb 2023 11:58:39 +0100 (CET)
Message-ID: <7a515176-c5ac-b049-b615-fa981ff0c6c7@tuxedocomputers.com>
Date:   Tue, 28 Feb 2023 11:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] Input: atkbd - Make it possible to apply
 atkbd.reset via kernel quirk
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dmitry.torokhov@gmail.com, swboyd@chromium.org,
        hdegoede@redhat.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, wsa+renesas@sang-engineering.com,
        tiwai@suse.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227185907.569154-1-wse@tuxedocomputers.com>
 <20230227185907.569154-2-wse@tuxedocomputers.com>
 <Y/2ueXSFK0iOR5M5@kroah.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Y/2ueXSFK0iOR5M5@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 28.02.23 um 08:34 schrieb Greg KH:
> On Mon, Feb 27, 2023 at 07:59:06PM +0100, Werner Sembach wrote:
>> atkbd.reset was only a command line parameter. Some devices might have a
>> known bug that can be worked around by just permanently applying this
>> quirk.
>>
>> This patch adds the ability to do this on the kernel level for known buggy
>> devices.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/input/keyboard/atkbd.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
>> index 246958795f60..ef65c46c4efe 100644
>> --- a/drivers/input/keyboard/atkbd.c
>> +++ b/drivers/input/keyboard/atkbd.c
>> @@ -1731,6 +1731,12 @@ static int __init atkbd_deactivate_fixup(const struct dmi_system_id *id)
>>   	return 1;
>>   }
>>   
>> +static int __init atkbd_reset_fixup(const struct dmi_system_id *id)
>> +{
>> +	atkbd_reset = true;
>> +	return 1;
> Why is this returning 1?  Who calls this?

This function is following the format of the other fixup functions directly 
above it.

It is there to be called as a callback via the atkbd_dmi_quirk_table on a per 
device basis. See 2nd patch of this patchset.

Greetings,

Werner

>
> And this should be a per-device attribute, not a global one, right?
>
> thanks,
>
> greg k-h
