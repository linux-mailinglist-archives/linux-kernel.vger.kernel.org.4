Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B43647F75
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLIInj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:43:36 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A114FF83;
        Fri,  9 Dec 2022 00:43:35 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id ay40so3038138wmb.2;
        Fri, 09 Dec 2022 00:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIm8jBi1uHkIfS3Wl7d7PG6c8PZssWdtIsqEZpRqaW8=;
        b=XJkJEmbSYrFSkg61RFiv6v7Migro65/W6ebgCEUnRSTTAAU46W52HM9XakfPUb7nC5
         PLj7+1vafA5JiSP+6w4sMNp3EM6q22rpi5Np8EgVCvFXscrbirjRrAJm/m89Lv/RmJ8v
         QobzgtVNTf3UpwidWguIEQFur29SE+rlPjbur/QdyJcFKT/SZi+WoHz30dPlbVMFNov1
         VWOgQaziD0yzHFig7oE8sETD75i+htYnf1G23C/m7+nAt9XTDGAy8mJl8YEU/caakWb0
         tQoUJzXlrAo13ese87fIdRFzWHp/xDdFwUrgAo3PPyPP3yB/koWtT6ZZaR9eofgh0/Dv
         OPzQ==
X-Gm-Message-State: ANoB5pnngEWNYwzxhXwN8X5filclscK783Harvjbc2pyVavBVjnNABda
        jHr1TXS5VcBls9g5or/QSny/Yge9yuk=
X-Google-Smtp-Source: AA0mqf7+Rr/3kLnvSoW5iw+V1lDD+iVpn8+CWnBBTptFaKON3+660CWadJWGtCkQMZRF3dFMIASWww==
X-Received: by 2002:a05:600c:5124:b0:3c6:eeb8:717d with SMTP id o36-20020a05600c512400b003c6eeb8717dmr4001017wms.1.1670575413915;
        Fri, 09 Dec 2022 00:43:33 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id bl1-20020adfe241000000b00241fea203b6sm798062wrb.87.2022.12.09.00.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 00:43:33 -0800 (PST)
Message-ID: <ab7d0789-7e97-5ceb-a5de-110c62f08780@kernel.org>
Date:   Fri, 9 Dec 2022 09:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] tty: fix out-of-bounds access in
 tty_driver_lookup_tty()
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20221207075236.23171-1-svens@linux.ibm.com>
 <20221207075236.23171-2-svens@linux.ibm.com>
 <6614f5d2-d99b-ea8a-f660-7a3433499a9f@kernel.org>
 <yt9dtu25vvyh.fsf@linux.ibm.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <yt9dtu25vvyh.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 12. 22, 9:10, Sven Schnelle wrote:
> Jiri Slaby <jirislaby@kernel.org> writes:
> 
>> On 07. 12. 22, 8:52, Sven Schnelle wrote:
>>> When specifying an invalid console= device like console=tty3270,
>>> tty_driver_lookup_tty() returns the tty struct without checking
>>> whether index is a valid number.
>>> [..]
>>
>> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>>
>> Yes, this makes sense as a sanity check for all drivers. But I would
>> _also_ disallow registering such a console in vt:
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -3075,6 +3075,11 @@ int vt_kmsg_redirect(int new)
>>    * The console must be locked when we get here.
>>    */
>>
>> +static int vt_console_setup(struct console *co, char *options)
>> +{
>> +       return co->index >= MAX_NR_CONSOLES ? -EINVAL : 0;
>> +}
>> +
>>   static void vt_console_print(struct console *co, const char *b,
>>   unsigned count)
>>   {
>>          struct vc_data *vc = vc_cons[fg_console].d;
>> @@ -3158,6 +3163,7 @@ static struct tty_driver
>> *vt_console_device(struct console *c, int *index)
>>
>>   static struct console vt_console_driver = {
>>          .name           = "tty",
>> +       .setup          = vt_console_setup,
>>          .write          = vt_console_print,
>>          .device         = vt_console_device,
>>          .unblank        = unblank_screen,
>>
>> That means dmesg would say:
>>    Console: colour dummy device 80x25
>>    printk: console [ttyS0] enabled
>>
>> And not:
>>    Console: colour dummy device 80x25
>>    printk: console [tty3270] enabled
>>    printk: console [ttyS0] enabled
> 
> Makes sense. Should i add that to my patch, add a second patch, or
> will you submit that?

If you can create a second patch, it would be great. And if you redo 
this one, please trim the stack traces (you can likely even drop the 
first one).

thanks,
-- 
js
suse labs

