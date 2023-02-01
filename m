Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B6680EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjA3N3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjA3N3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105024137
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675085297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAMPPrar8OAIvnPipq/Mby6BJP4m+tsjTfvNt2nu5yY=;
        b=Aa4/xwVHM3mm0p6hGV3WbjIAOYs7lc9whLts1MEucXhsXx1FkmcvR9nqZy4Z7qq4bm+FMd
        1hD8FheAlH52Rbi3+BZZoua8pCUJ8E1kuBVwKD9Zm3ou1AWwHMxb4KJgu9nU+ciKK1MwFr
        LbsPbzn1gPv3TQiVuvQBdT76OMSFX2Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-W51CwNF_Og2WMtclcBtH_A-1; Mon, 30 Jan 2023 08:28:16 -0500
X-MC-Unique: W51CwNF_Og2WMtclcBtH_A-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020a05640227cc00b0049e2c079aabso8121718ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAMPPrar8OAIvnPipq/Mby6BJP4m+tsjTfvNt2nu5yY=;
        b=dD7EvxlJEbGPmjMYGV3w9nwolFdXYK6JTFBdjte7OM3i0IW6WH7ozupDFo5lRkcsnd
         FSZMtfLDKw2wckaqK2KpeSkQPDsZmqV7C0+KzrzqiHJGfwGuiwazL6erlqR+yEGO6vFe
         aCFJ/jb93fHbnIIltzSsA4W5Q9mpuZBK32MhxUF8vlsQAo4EK/mE5wICFW5njYuYGYbb
         nc807T8KBiIGWQ4JPpQ9FkMgMXcnUk2DA/lDKvQnA12y9Z1H+PAjrF358kBZCUzjsPRV
         /2Afgg3wCk0+1S0zLJiT9JIU07OSq9ODxs7FhDBVt4A9cjfjzrhM3XLm9+57ODXFNvVf
         cemA==
X-Gm-Message-State: AFqh2kq6onh/F6FskwRBHEO1N9LYJycd0fmgaQ7VadltD8MRBuuNjYAX
        hcmftOQOxn2z1Crg6/IClBBk3tACv1v24T2V2C8ljkG5roQIbXfFuC74RLMsYFircdIFspXv3Tt
        yEzHMUtIZXA6RPSa1Cu7oTalT
X-Received: by 2002:a17:907:6f18:b0:84d:4e4f:1f85 with SMTP id sy24-20020a1709076f1800b0084d4e4f1f85mr51466007ejc.59.1675085295108;
        Mon, 30 Jan 2023 05:28:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvkJUOVVr34vm+zmg/PWqvYKnlznq2hZ3URz42Cd9fuhjNyt2zqjNQQSbqM6nPUBQR5mwpvXA==
X-Received: by 2002:a17:907:6f18:b0:84d:4e4f:1f85 with SMTP id sy24-20020a1709076f1800b0084d4e4f1f85mr51465985ejc.59.1675085294943;
        Mon, 30 Jan 2023 05:28:14 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kl13-20020a170907994d00b00882f9130eafsm3774140ejc.26.2023.01.30.05.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:28:14 -0800 (PST)
Message-ID: <b6eca5e1-2340-cd09-ede9-116350bca346@redhat.com>
Date:   Mon, 30 Jan 2023 14:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/9] HID: Constify lowlevel HID drivers
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
 <0937b9a5-0caa-2a73-33c4-82e6cab02ef0@redhat.com>
 <20230130132620.3cmmq5ga3uebazwf@t-8ch.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230130132620.3cmmq5ga3uebazwf@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/23 14:26, Thomas Weißschuh wrote:
> Hi Hans,
> 
> On Mon, Jan 30, 2023 at 09:36:32AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 1/30/23 04:59, Thomas Weißschuh wrote:
>>> Since 52d225346904 ("HID: Make lowlevel driver structs const") the
>>> lowlevel HID drivers are only exposed as const.
>>>
>>> Take advantage of this to constify the underlying structures, too.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>
>> Thanks, series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> I'll also pick up / merge patches 7 + 8 into pdx86/for-next
>> sometime this week.
> 
> Please note that patch 7 depends on commit 52d225346904
> ("HID: Make lowlevel driver structs const") which is not yet in Linus'
> tree, only in the HID tree (branch for-6.3/hid-core).
> 
> Maybe it's better to take it via the HID tree or I can resend when the
> prerequisites are in Linus' tree.

Ah yes then it would be better to take the entire set through the HID tree,
here is my ack for that:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>>> ---
>>> Thomas Weißschuh (9):
>>>       HID: amd_sfh: Constify lowlevel HID driver
>>>       HID: hyperv: Constify lowlevel HID driver
>>>       HID: logitech-dj: Constify lowlevel HID driver
>>>       HID: steam: Constify lowlevel HID driver
>>>       HID: intel-ish-hid: Constify lowlevel HID driver
>>>       HID: surface-hid: Constify lowlevel HID driver
>>>       platform/x86: asus-tf103c-dock: Constify lowlevel HID driver
>>>       platform/x86: asus-tf103c-dock: Constify toprow keymap
>>>       staging: greybus: hid: Constify lowlevel HID driver
>>>
>>>  drivers/hid/amd-sfh-hid/amd_sfh_hid.c      | 2 +-
>>>  drivers/hid/hid-hyperv.c                   | 2 +-
>>>  drivers/hid/hid-logitech-dj.c              | 4 ++--
>>>  drivers/hid/hid-steam.c                    | 2 +-
>>>  drivers/hid/intel-ish-hid/ishtp-hid.c      | 2 +-
>>>  drivers/hid/surface-hid/surface_hid_core.c | 2 +-
>>>  drivers/platform/x86/asus-tf103c-dock.c    | 4 ++--
>>>  drivers/staging/greybus/hid.c              | 2 +-
>>>  8 files changed, 10 insertions(+), 10 deletions(-)
>>> ---
>>> base-commit: e04955db6a7c3fc4a1e6978649b61a6f5f8028e3
>>> change-id: 20230130-hid-const-ll-driver-fcfdd3af11b8
>>>
>>> Best regards,
>>
> 

