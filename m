Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF263780A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKXLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKXLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93A620377
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669290682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Upa7JOhV8Luz6o/HTdRR+MHYLEnrm6+OGyDErM/vu0g=;
        b=KBiG2Tzc+P5XywPrOGi1RpKOgO/2juZGZ5ZjGyM/jScPAP52ulQcChBG/xnYwvxE3L9Ecn
        u5iliIcrn7n7knLp1rSSdjUDAE9XlwawG6mELyyLu6GBOKdLdvSOLENilZ1M7eyQxCabIY
        gmV0YQ858eia3ocYqiOQYXwiedXeUk4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-jjex_hpwOzKzEgr6YfvXgA-1; Thu, 24 Nov 2022 06:51:20 -0500
X-MC-Unique: jjex_hpwOzKzEgr6YfvXgA-1
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402350d00b00464175c3f1eso832464edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Upa7JOhV8Luz6o/HTdRR+MHYLEnrm6+OGyDErM/vu0g=;
        b=DpmqHhqEkmN/otod7ZeIKIpa9W9Iyk5HwYMSOFIgc3W5E3uKz0/zCyZE8tFsjbAu1m
         3mShr6slgdFOcjalIU+6hZa8FNiUWl+LgHaXxRgUZmGFyYndb5PoE2y/+nriX04XnSAa
         AYMvbJzBWkRpJx+iEYakSq0KavGwjo+kZgfv5mTjRgazMQwXpz+y6ZVw6q+EVdSKg49P
         q5lr9Y86BqFpXK+q8zKWTcqnX3iiCBF98Y/u/9kJ6XwSSHD7ii2pYeYEUrHgwMXEOp4S
         wK/9HbK+yA/ELCwHL5TfhqCMQ3Fhij1h8xqXBbTDNC8IMeXpPv4RxRoYm0IjePP4TGdl
         sZlA==
X-Gm-Message-State: ANoB5pl9OVI1uaZeHFjXmBxxOioFejDN18LidpbVUfNNaM3k9/JUL5wF
        /g7KLl++tMdAclnZBaJVYcqQJmdHJdxn78WAxNxc/HfwExYpLrnpHQcykR98pHnELheB28dFNLz
        +4hUj4EnZ9BCfC6tAAl2H70yA
X-Received: by 2002:a17:907:c208:b0:7ad:79c0:547a with SMTP id ti8-20020a170907c20800b007ad79c0547amr17271773ejc.41.1669290679388;
        Thu, 24 Nov 2022 03:51:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7zp90EmFXWu2AS+2jsyvw0RuEY/wCJ10Tp+dpiidAQoL7O6kxjm7Rv5tek7hY2r2UaBlb51g==
X-Received: by 2002:a17:907:c208:b0:7ad:79c0:547a with SMTP id ti8-20020a170907c20800b007ad79c0547amr17271757ejc.41.1669290679217;
        Thu, 24 Nov 2022 03:51:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id hs32-20020a1709073ea000b007a8de84ce36sm337523ejc.206.2022.11.24.03.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:51:18 -0800 (PST)
Message-ID: <51f80121-2e8c-0e8e-6f89-a7dc214207b0@redhat.com>
Date:   Thu, 24 Nov 2022 12:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] platform/x86: serial-multi-instantiate: Set fwnode
 for i2c
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221124110718.3925934-1-sbinding@opensource.cirrus.com>
 <20221124110718.3925934-2-sbinding@opensource.cirrus.com>
 <CAHp75VfUqkxyB7J8fbfQKCMaSa55q4zqt7btNb_n5E3-NWhQyg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfUqkxyB7J8fbfQKCMaSa55q4zqt7btNb_n5E3-NWhQyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/24/22 12:35, Andy Shevchenko wrote:
> On Thu, Nov 24, 2022 at 1:07 PM Stefan Binding
> <sbinding@opensource.cirrus.com> wrote:
>>
>> This allows the i2c driver to obtain the ACPI_COMPANION.
> 
> As far as I get how it's done in the SPI case the real fix should lie
> among i2c_acpi_new_device_by_fwnode(), right?

Eventually maybe, but not for the initial change.

It is complicated, making this change has side-effects
and we want to limit those side-effects to only i2c-clients
instantiated from serial-multi-instantiate for now, see
my other reply to this patch.

I do believe that we eventually want to make this change,
to easily give drivers access to all sorts of info
(e.g. _DSM methods) from the matching ACPI fw-node,
but as I said it is complicated...

Regards,

Hans



