Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3A631677
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKTUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTUzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE4D248CA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668977696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNL2L2LFNIY8Im7UTmMW5Q1LQ251njAyX8358TQUZfg=;
        b=F54iqSriDXs/9e2tc5qfMHJKdlUdqFTSWkG0DBB4sCmWnBzmOY6h+2Nj/fcUUWKAbQDHpm
        WQJ7lQGVgx1Ils7dOhPJ/6tapx4ecsRj0cy77Et4dUrHAvzKJPJTbP3PNRXH2a/hSfFIG/
        RtwZNU+QGy9ecjxS4F0kRLAH2m3EFWA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606--0ThKcOpPbSjxYUa2ZSnww-1; Sun, 20 Nov 2022 15:54:54 -0500
X-MC-Unique: -0ThKcOpPbSjxYUa2ZSnww-1
Received: by mail-ej1-f71.google.com with SMTP id ne36-20020a1709077ba400b007aeaf3dcbcaso5652970ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNL2L2LFNIY8Im7UTmMW5Q1LQ251njAyX8358TQUZfg=;
        b=ySBUMAd5Nk4RPNKPMWmTw5L+3MYMkjo5XS7xP6l3/6BY6q8nHAJi8g5EP6XpS7Ca/n
         Gyv0uKtoTtgkUNop8G24QRp5nqLrE8kTFXphbs/upuJEfLk5H0EU9VErGfjnb4Is0AkW
         UsjbtA54XhPjHGg8ppfNjP5eTHUXZYYLBhPLXBQY5IUKQX8hXXNVUrwUrrZF/OFbuhFv
         ZB57taZY8hBOCUmUUMPxGFnrmO5JkWcnSSQou3EW+ftTO8Q4oJosBWv6GnXEmt7peNu0
         L9xZGNxji4iXuaV1bhs/EeCNryjbArZYmAgbf1Q/+mPBaOtcNfAY0tqFl7pdxxHMZ0cO
         RUUw==
X-Gm-Message-State: ANoB5pl/8uizdJ0ncX7Nhr8DijyH/Omg3O7vWipgt9XbzpFLEet17Akt
        l1eOJzv+GEFPt5G0fkdvkyXM2NhYou1kwv+ldWS4NgEdIXTU98+ok9qgGspB1W83U7W2q7K0lzk
        pfPBAL4wdUkf41rf0/Mn3KBIc
X-Received: by 2002:a05:6402:10d1:b0:467:7508:89ca with SMTP id p17-20020a05640210d100b00467750889camr13361391edu.284.1668977693284;
        Sun, 20 Nov 2022 12:54:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7sqvwU+BqzJEbjVUgabQPQnq3+OoVdM/iBkaMR0q/80qQbY9uvFHcm2wK8nrVOvpG3dqIYdw==
X-Received: by 2002:a05:6402:10d1:b0:467:7508:89ca with SMTP id p17-20020a05640210d100b00467750889camr13361380edu.284.1668977693087;
        Sun, 20 Nov 2022 12:54:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402105900b004610899742asm4306513edu.13.2022.11.20.12.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 12:54:52 -0800 (PST)
Message-ID: <961a7d7e-c917-86a8-097b-5961428e9ddc@redhat.com>
Date:   Sun, 20 Nov 2022 21:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/18] platform/x86: int3472: fix object shared between
 several modules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alobakin@pm.me>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Derek Chickles <dchickles@marvell.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221119225650.1044591-1-alobakin@pm.me>
 <20221119225650.1044591-12-alobakin@pm.me>
 <Y3oxyUx0UkWVjGvn@smile.fi.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y3oxyUx0UkWVjGvn@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/20/22 14:55, Andy Shevchenko wrote:
> On Sat, Nov 19, 2022 at 11:08:17PM +0000, Alexander Lobakin wrote:
>> common.o is linked to both intel_skl_int3472_{discrete,tps68470}:
>>
>>> scripts/Makefile.build:252: ./drivers/platform/x86/intel/int3472/Makefile:
>>> common.o is added to multiple modules: intel_skl_int3472_discrete
>>> intel_skl_int3472_tps68470
>>
>> Although both drivers share one Kconfig option
>> (CONFIG_INTEL_SKL_INT3472), it's better to not link one object file
>> into several modules (and/or vmlinux).
>> Under certain circumstances, such can lead to the situation fixed by
>> commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects").
>>
>> Introduce the new module, intel_skl_int3472_common, to provide the
>> functions from common.o to both discrete and tps68470 drivers. This
>> adds only 3 exports and doesn't provide any changes to the actual
>> code.

Replying to Andy's reply here since I never saw the original submission
which was not Cc-ed to platform-driver-x86@vger.kernel.org .

As you mention already in the commit msg, the issue from:

commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects")

is not an issue here since both modules sharing the .o file are
behind the same Kconfig option.

So there is not really an issue here and common.o is tiny, so
small chances are it does not ever increase the .ko size
when looking a the .ko size rounded up to a multiple of
the filesystem size.

At the same time adding an extra module does come with significant
costs, it will eat up at least 1 possibly more then 1 fs blocks
(I don't know what the module header size overhead is).

And it needs to be loaded separately and module loading is slow;
and it will grow the /lib/modules/<kver>/modules.* sizes.

So nack from me for this patch, since I really don't see
it adding any value.

Regards,

Hans





> 
> ...
> 
>> +MODULE_IMPORT_NS(INTEL_SKL_INT3472);
>> +
> 
> Redundant blank line. You may put it to be last MODULE_*() in the file, if you
> think it would be more visible.
> 
>>  MODULE_DESCRIPTION("Intel SkyLake INT3472 ACPI Discrete Device Driver");
>>  MODULE_AUTHOR("Daniel Scally <djrscally@gmail.com>");
>>  MODULE_LICENSE("GPL v2");
> 
> ...
> 
>> +MODULE_IMPORT_NS(INTEL_SKL_INT3472);
>> +
>>  MODULE_DESCRIPTION("Intel SkyLake INT3472 ACPI TPS68470 Device Driver");
>>  MODULE_AUTHOR("Daniel Scally <djrscally@gmail.com>");
>>  MODULE_LICENSE("GPL v2");
> 
> Ditto. And the same to all your patches.
> 

