Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7E680A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjA3KRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjA3KRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463395252
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675073820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlvqrRsIaGySNIWgyEtFe3L6DCZPEcBZ6mU4ziiJiuQ=;
        b=XyCUXFOUG+yTe6/yHtXhlQpuRB8epzj0ffIf6D9Qf8V6sLDgngbBn7Qyn7wx+9B1ZR9Osi
        SM2hlLzIsZu8UDUVh3XpjgAcQRiz1RxXgO13qiUouyBRVaRNlf296XzSBrFygeBWfORcQ2
        w1Ub5BGlTmOBUSQT1PFf9PjNe723qgw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-PTN4PoCkPyuKe7clzUBuqQ-1; Mon, 30 Jan 2023 05:16:59 -0500
X-MC-Unique: PTN4PoCkPyuKe7clzUBuqQ-1
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b0049e385d5830so7952663edw.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlvqrRsIaGySNIWgyEtFe3L6DCZPEcBZ6mU4ziiJiuQ=;
        b=Ov/9tWZ3CkJEsjp8n+SNJqQxmkZ9qxb3GiUtg/spsq698zm5VxMzpIZuDLNYKYHY67
         285lLmqRkyS/BxUd+BFFa5nRzr99+53pONHScRzgriPUtmNYlOsj+UU9qV5DasW0rvCK
         kGgRI/frxlMHzJULGILDScUz7BeQjevX3AevANd4OfArsfz7rM4JyjjfsASOi17NuFBM
         HjZKN1CG7TzzBtHQrYrwxwSlKLz63gn8WP6EAL0ezGM6n1Xjb5hdgiQVwa6VDMznF4jR
         sEHZsB5P1+59loQapWpIMWoHkCNo97fO+lBn81zbdA9K56ylzw2ppTCzRTgZZUm922YQ
         r88g==
X-Gm-Message-State: AFqh2krlT1n/6JyCfjjf15Iala4raapDWcJPjjW1UePfpdxjoFD82spb
        J69VoNXMqpelfyVOYyQsXViMhN76Se7gEJG3OTX/pd6/5yo9s7jwr4MxiLEFu80gUdRwuzFidHC
        nYxyNunRoW3SeXDBf/QFT0ikx
X-Received: by 2002:a17:906:8608:b0:86b:9216:2ddb with SMTP id o8-20020a170906860800b0086b92162ddbmr53439640ejx.52.1675073817913;
        Mon, 30 Jan 2023 02:16:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNsJWKTnv3uN7vRaSshEY3jYIx5DQ3/vAPthUQAXBa0hLAWrs8TG38BNBGQctubhL/2gLNCg==
X-Received: by 2002:a17:906:8608:b0:86b:9216:2ddb with SMTP id o8-20020a170906860800b0086b92162ddbmr53439629ejx.52.1675073817696;
        Mon, 30 Jan 2023 02:16:57 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f19-20020a05640214d300b004a0a915e726sm3390528edx.73.2023.01.30.02.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 02:16:57 -0800 (PST)
Message-ID: <325be2be-0c58-7414-70e9-9585e35874a2@redhat.com>
Date:   Mon, 30 Jan 2023 11:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [regression] Bug 216977 - asus t100 touchpad registered but not
 working
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <btissoir@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        jessegodfroy@gmail.com
References: <2f4dc626-5287-6ec7-a31d-335e5dbb9119@leemhuis.info>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2f4dc626-5287-6ec7-a31d-335e5dbb9119@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 1/30/23 10:22, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216977 :
> 
>>  jessegodfroy@gmail.com 2023-01-29 15:44:34 UTC
>>
>> After upgrading the kernel from 6.0 series to the 6.1 the touchpad on my asus t100 no longer works. 
>>
>> The device is registered in dmesg. I believe hid_asus is responsible for the keyboard and touchpad.  The keyboard continues to function, but the touchpad does not. 
>>
>> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0001: input,hidraw0: USB HID v1.11 Keyboard [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input0
>> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0002: Fixing up Asus T100 keyb report descriptor
>> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0002: input,hiddev96,hidraw1: USB HID v1.11 Device [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input1
>> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0003: input,hiddev97,hidraw2: USB HID v1.11 Mouse [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input2
>>
>> I do not see any changes to hid_asus that should be responsible for the change in performance.
> See the ticket for more details.

This is my bad, I accidentally broke SW_TABLET_MODE reporting on
the Asus T100* and T101* series and it is now reporting that it
is in tablet mode while it is actually docked and thus in laptop
mode.

This is causing libinput to suppress touchpad events, as
it would for a 360° hinges style 2 in 1 with the keyboard +
touchpad folded behind the display (so in tablet mode).

A fix for this has already been merged for 6.2-rc6:

"platform/x86: asus-wmi: Fix kbd_dock_devid tablet-switch reporting"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fdcc0602d64f22185f61c70747214b630049cc33

And the fix is also queued for the next 6.1.y stable series release:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1

I'll also add this info as a comment to the bug.

Regards,

Hans

