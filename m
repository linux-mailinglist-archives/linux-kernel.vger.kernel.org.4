Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19674D54F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGJMZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703FDB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688991872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvML2ZTbSvNa76WH3v+ED/1x/GpVFa6SlPl50qQBVD4=;
        b=C5vLb6RP/zGiUOiCbYRfmtDTJT+4EQUTiDbkbpgMDWIx+NdCKfakOrUDkobgGmYfMQ8S2v
        bc+wgqqhG8J/kJRVVi82UOsv6Lc2/QwtHjDgPIXQSABgURRyT0/+h4Pi7xKkinkVMwI+AK
        zA2xp8aIRKgJLIVedh6o5dbEnm4YMQ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-vg3EBT3fMS6m10tFc3C1hQ-1; Mon, 10 Jul 2023 08:24:28 -0400
X-MC-Unique: vg3EBT3fMS6m10tFc3C1hQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31596170243so1064442f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991867; x=1691583867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvML2ZTbSvNa76WH3v+ED/1x/GpVFa6SlPl50qQBVD4=;
        b=itK8cpj538pN6Bdbt4Stv189qP0RTB78UEiyr8VK1Va+seJJJohxqob0XQ6eRnHQe+
         S+Y5uzsrXGjp9g8Jn4O8EaSeCbJujCMsvSBuJ9yj9sFhYKiScYrExWZrgSHbjIwUNRYC
         YShsOyXP7b/3YJQoNmx5VHRxBCKeM8cQ2oUZxcJKrGcqWMV6ihs/OVtjbCXjYulg7XEC
         VVi5B6CghnLdAlx2BqkoomYj9l+zNrtmiarvEs7ydJTq47ZTL2CJcs/kmepnm4GpP+Ml
         SSeJva7KIG48WJR3nOr83ttvdfhUCuRV6XqbRvEYhtJt4xQDrW2ClfydUnQIaS9kWf5G
         6v1g==
X-Gm-Message-State: ABy/qLbk+p08k5K2h8OgBuON00yQRkz5wjCA746BP/b3h65sDxHaqSW2
        jKaz8vc//cEyxlGIjl9llJpkNex2zdizM6zDBsFcEYggbCkhXhqRlKo7fGkJnbK3FmU1lp1ttrU
        QYk9sHGHipumXCGT12kAzZuvg
X-Received: by 2002:a5d:6992:0:b0:313:f4e2:901d with SMTP id g18-20020a5d6992000000b00313f4e2901dmr11318659wru.22.1688991867030;
        Mon, 10 Jul 2023 05:24:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCfHIfxXiWxsjzpJqDBImSNlKwiDDmZPDNf+ZmkYEr3xDoS7La+lATpQqDI1yIxm7fr9+CSg==
X-Received: by 2002:a5d:6992:0:b0:313:f4e2:901d with SMTP id g18-20020a5d6992000000b00313f4e2901dmr11318632wru.22.1688991866762;
        Mon, 10 Jul 2023 05:24:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f17-20020adfe911000000b0031416362e23sm11618363wrm.3.2023.07.10.05.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 05:24:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        neil.armstrong@linaro.org, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     Nishanth Menon <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v7 0/8] drm/tidss: Use new connector model for tidss
In-Reply-To: <be2c4c02-43bc-5b16-2162-b8ace8d34996@ideasonboard.com>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
 <1f284e9d-5a1e-9fca-ceb0-478a413ae4ef@linaro.org>
 <1b31f36c-b1ba-43b5-9285-0f50384a78cf@ti.com>
 <42151d11-12d9-c165-0d4b-a0af80b683c3@linaro.org>
 <be2c4c02-43bc-5b16-2162-b8ace8d34996@ideasonboard.com>
Date:   Mon, 10 Jul 2023 14:24:25 +0200
Message-ID: <87bkgkhs3q.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:

Hello Tomi and Neil,

> On 06/06/2023 12:48, neil.armstrong@linaro.org wrote:
>> On 06/06/2023 11:46, Aradhya Bhatia wrote:
>>> Hi Neil,
>>>
>>> Thank you for reviewing the previous patches!
>>>
>>> On 06-Jun-23 14:37, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 06/06/2023 10:21, Aradhya Bhatia wrote:
>>>>> Hi all,
>>>>>
>>>>> I have picked up this long standing series from Nikhil Devshatwar[1].
>>>>>
>>>>> This series moves the tidss to using new connectoe model, where the SoC
>>>>> driver (tidss) creates the connector and all the bridges are attached
>>>>> with the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR. It also now creates 
>>>>> bridge
>>>>> to support format negotiation and and 'simple' encoder to expose it to
>>>>> the userspace.
>>>>>
>>>>> Since the bridges do not create the connector, the bus_format and
>>>>> bus_flag is set via atomic hooks.
>>>>>
>>>>> Support format negotiations in the tfp410, sii902x and mhdp-8546 bridge
>>>>> drivers as a first step before moving the connector model.
>>>>>
>>>>> These patches were tested on AM625-SK EVM, AM625 SoC based BeaglePlay,
>>>>> and J721E-SK. Display support for AM625 SoC has not been added upstream
>>>>> and is a WIP. To test this series on AM625 based platforms, basic
>>>>> display support patches, (for driver + devicetree), can be found in
>>>>> the "next_AttachNoConn-v2" branch on my github fork[2].
>>>>
>>>> I can apply all bridge patches right now so only the tidss change 
>>>> remain,
>>>> is that ok for you ?
>>>>
>>>
>>> While the bridge patches and the tidss patch can be separately built
>>> without any issue, the tidss functionality will break if only the bridge
>>> patches get picked up, and not the tidss.
>>>
>>> Would it be possible for you to pick all the patches together once Tomi
>>> acks the tidss patch?
>> 
>> Sure
>
> I think this looks fine. For the series:
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>

It seems this series fell through the cracks? Since you both already
reviewed the patches, I've just pushed all the set to drm-misc-next.

Thanks all!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

