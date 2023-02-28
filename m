Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220646A5492
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjB1ImI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjB1ImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089342A998
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677573672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbHn/o0iOOgDw86GDMNrmGITraFkBlaRTijfg3AOyvE=;
        b=c1JOxHdh6YzfXJXZbzE6f/bmJcy/0G5d0g484hOto9kv3atWIfHiiD+f9GOKXHVgHA8Tk1
        UeGBiFhJsfFF/rhX+b/g8pmj14LneE82xKSQZmS0zNCbKIcEDuoTTZDM/iXSeU9pQRnQuY
        DnQMxC/2b1xZvPatmgGQznGDp4oqcBk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-JIhFnpLdPl61oeVuBkMITw-1; Tue, 28 Feb 2023 03:41:10 -0500
X-MC-Unique: JIhFnpLdPl61oeVuBkMITw-1
Received: by mail-ed1-f69.google.com with SMTP id co14-20020a0564020c0e00b004aab4319cedso12688775edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbHn/o0iOOgDw86GDMNrmGITraFkBlaRTijfg3AOyvE=;
        b=pM3mDQSHU9FRsN5iKXhd4s9BkQSh13nIWoQNpLLedSpnVDNni8U/BRTi9xheZeFsco
         askZB13ShMryUsXy7chTnyylLZglHZ3tvvnH/r1lxuH/11MC8qFfAmCmwDLWej20eNAG
         6atQnxe9y+mM8w+zBPub1TlFRRwAeD2DTE8+j8lh0B4RgYczq6npuFO++JtqsTbrNOse
         XSuaxzQKNAmMSZOrgLa4Smfn6u6yYKNcokSWwiY9JKb9hdYAAh2z4bvWlScusqi8dfw+
         1U2NWVcM3Pt59ttzs8duKr/PJd5+lxiiNo+KxWyxT1AsyiEk5jpJHOLsTyfiAOFW+Vp4
         Xqew==
X-Gm-Message-State: AO0yUKX1gZlFOfI3G+ZWWWB9d/uQP7HDOUYfnBHfvbeL+wFQB0296CDE
        OFrg6u7AmUxn+k6O2WkI0+JapUwju4OIBzmtbjQcCskh4yCcdbszeQZVLffsP9JBdfAy5fpe8uY
        LrtpIE1HstuO1kWLQY8dvIL17
X-Received: by 2002:a17:906:b2c7:b0:88d:d76d:8527 with SMTP id cf7-20020a170906b2c700b0088dd76d8527mr1632778ejb.47.1677573669592;
        Tue, 28 Feb 2023 00:41:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8Exw21/gXqIKVRsH3v0dyQuleJsJAflSB7ZL3dcuaIFhabWYjZ+Ufiesy1PUzV8cL87QsJ0w==
X-Received: by 2002:a17:906:b2c7:b0:88d:d76d:8527 with SMTP id cf7-20020a170906b2c700b0088dd76d8527mr1632767ejb.47.1677573669316;
        Tue, 28 Feb 2023 00:41:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a5-20020a509e85000000b004ace62d6eaesm4120347edf.57.2023.02.28.00.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:41:08 -0800 (PST)
Message-ID: <a2216cc2-b719-12e1-264c-374fc467db14@redhat.com>
Date:   Tue, 28 Feb 2023 09:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/2] Fix "Input: i8042 - add TUXEDO devices to i8042
 quirk tables for partial fix"
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, swboyd@chromium.org,
        gregkh@linuxfoundation.org, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, wsa+renesas@sang-engineering.com,
        tiwai@suse.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227185907.569154-1-wse@tuxedocomputers.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230227185907.569154-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Werner,

On 2/27/23 19:59, Werner Sembach wrote:
> This is a continuation of
> https://lore.kernel.org/linux-input/20220708161005.1251929-3-wse@tuxedocomputers.com/
> 
> That fix did fix the keyboard not responding at all sometimes after resume,
> but at the price of it being laggy for some time after boot. Additionally
> setting atkbd.reset removes that lag.
> 
> This patch comes in 2 parts: The first one adds a quirk to atkbd to set
> atkbd.reset and the second one then applies that and the i8042 quirks to
> the affected devices.

Can you please rework this series so that the quirk based setting of
the "atkbd.reset" equivalent on the kernel commandline becomes another
SERIO_QUIRK_* flag and avoid the duplication of the DMI ids?

Regards,

Hans



