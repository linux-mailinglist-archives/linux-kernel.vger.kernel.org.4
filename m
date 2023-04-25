Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219416EE45A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjDYPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjDYPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1549F9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682434786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmHJJuMRIAs9z/Z/rzUvpHfW1r9FW2m/BibSgr5QHbU=;
        b=LJmhbiGNz5m5sKqEN3RsNGXjUYa/rICHezUES6RnSPypufL0KDIp6Ytf8GMJa4EOaa+Tgp
        ll9hzvRdhiELvMjf6xDhg/6TEHM7219sDrIoNfrVLO/a5lZNNbKF2iaVgzOvoxuixlE+D9
        YVG9wnk8RUxzGtD+t9KQetR0ulTg0Bk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-OjKDwdP8MR-jeFpur--fWQ-1; Tue, 25 Apr 2023 10:59:44 -0400
X-MC-Unique: OjKDwdP8MR-jeFpur--fWQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-953759a9d18so548352366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682434782; x=1685026782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmHJJuMRIAs9z/Z/rzUvpHfW1r9FW2m/BibSgr5QHbU=;
        b=YD2os4OEtG7RDaZuBZLWGohnSBLgmcFe8jc/w5dWPtHLz5pGp04SFb/vgVzamtnIh3
         PrH0gsAXTbwDGWxmuKrt9fIBZRqCshujo8ZxVHu8jY2+Wj50nHqE378ARI0rc81M5Gvq
         HpE79kt6U40XQNAZjrOEHbeIdiFhsB9M4BLCiLAcgzVK4NZWjkJ4Tra4N2xiDYRIWSFU
         0YuNJfXpY1v5rWNVIqttj2s27QSUpaywGD9NUHj/yHA7fWne1NIeYTf2yT4FKfaXvCfN
         7ZXAKq2z0by9rweYKR86iKrPfJwgyt4LakAqcFXageI7a3k6VPV2k4l4BNxu2TW4PoFE
         k2JQ==
X-Gm-Message-State: AAQBX9fhIwuinfF/8G+mnH//Dh5aS3/ItvqD+2BaDc0mkT5dGdE4SJgu
        p/xRX+QaPHgt8kio1B6qUogVJX0X8SijQxATXjn6P4SwBFVE8kMXvXKxXseqP06Gsd4+bAGIm5N
        A50IrxvnKa+vCisFqeUv5DCH9hFuLsQF9
X-Received: by 2002:a17:906:43d7:b0:94e:fdec:67e3 with SMTP id j23-20020a17090643d700b0094efdec67e3mr12181203ejn.56.1682434782804;
        Tue, 25 Apr 2023 07:59:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350btCTKjchRHSSd3YTHfqQIm+NttAodLaSMiht2bZfAs+LmJL3mqM7ILAuCO4WsAkWSyr7/74Q==
X-Received: by 2002:a17:906:43d7:b0:94e:fdec:67e3 with SMTP id j23-20020a17090643d700b0094efdec67e3mr12181186ejn.56.1682434782515;
        Tue, 25 Apr 2023 07:59:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906285100b0094e597f0e4dsm6776665ejc.121.2023.04.25.07.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 07:59:41 -0700 (PDT)
Message-ID: <9216dfe9-eea0-b0c0-3630-339a2b60aa2d@redhat.com>
Date:   Tue, 25 Apr 2023 16:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 03/14] HP BIOSCFG driver - bioscfg
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
 <20230419151321.6167-4-jorge.lopez2@hp.com>
 <38929a45-79de-964b-5d6f-cfa44099b35e@gmx.de>
 <6c05cc9e-815d-7a94-8b2d-f17fd5d47354@redhat.com>
 <CAOOmCE_W7_pgQT=8bQBi8_0pD74O6uen6-8p0Orvi1qjEcaHng@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAOOmCE_W7_pgQT=8bQBi8_0pD74O6uen6-8p0Orvi1qjEcaHng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/23 16:32, Jorge Lopez wrote:
> On Tue, Apr 25, 2023 at 5:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> On 4/19/23 20:04, Armin Wolf wrote:
>>> Am 19.04.23 um 17:13 schrieb Jorge Lopez:
>>
>> <snip>
>>
>>>> +static int __init bioscfg_init(void)
>>>> +{
>>>> +    int ret = 0;
>>>> +    int bios_capable = wmi_has_guid(HP_WMI_BIOS_GUID);
>>>> +
>>>> +    if (!bios_capable) {
>>>> +        pr_err("Unable to run on non-HP system\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>> +
>>>
>>> Currently, this driver will no get automatically loaded on supported hardware,
>>> something which would be quite beneficial for users to have.
>>> Since the HP_WMI_BIOS_GUID is already handled by the hp-wmi driver, maybe this
>>> driver (which also already implements a function similar to hp_wmi_perform_query())
>>> could register a platform device which is then used by this driver? This together
>>> with MODULE_DEVICE_TABLE() would allow for automatically loading the module on supported hardware.
>>
>> Both drivers can already co-exist since the old hp-wmi driver uses the old
>> wmi kernel functions and is not a "wmi_driver" so there is no need for
>> a platform_device for this driver to bind to since the wmi_device is
>> still free for it to bind to.
>>
>> This does indeed need a MODULE_DEVICE_TABLE() statement for
>> the bios_attr_pass_interface_id_table[] id-table. Note only for that
>> table, because the HP_WMI_BIOS_GUID is present on models which do
>> not support this and we don't want the module to auto-load there.
>>
> 
> I am considering adding a check for the  HP_WMI_SET_BIOS_SETTING_GUID
> and HP_WMI_BIOS_GUID during the initialization process.
> The driver will report a message If HP_WMI_SET_BIOS_SETTING_GUID is
> found or not.
> If HP_WMI_SET_BIOS_SETTING_GUID does not exist, the driver cannot
> change the BIOS settings.

Right, adding a check for  HP_WMI_BIOS_GUID to bioscfg_init()
sounds like a good idea.

That + add a a MODULE_DEVICE_TABLE() statement to
the bios_attr_pass_interface_id_table[] id-table.

Regards,

Hans


