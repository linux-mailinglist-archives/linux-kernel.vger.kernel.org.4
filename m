Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6046D606241
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJTNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJTNxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EA1A913E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666273994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9NhUtGxO6K74gqQdZfG6EzOgRH0Jnrjb43QwxtH/NI=;
        b=H7MwrIVAtvYB7QmXAKzSTcndp+PN+XBPkNX414oCKI9bVc+4mVczrjrI3C40tpHvGYcKK2
        kRH4v2z+bWNf1tZKDRMCEGohHkyAu5RjuGNsSLTupvEK8QOn9cRejUEcLokUs8ybri6rfg
        Y5yEfudEQhrR8HpY22fI+Fz/dqEDyaU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-tGUNIB2dMby1Cv7uYW3BDQ-1; Thu, 20 Oct 2022 09:53:13 -0400
X-MC-Unique: tGUNIB2dMby1Cv7uYW3BDQ-1
Received: by mail-ej1-f69.google.com with SMTP id hd11-20020a170907968b00b0078df60485fdso9712392ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9NhUtGxO6K74gqQdZfG6EzOgRH0Jnrjb43QwxtH/NI=;
        b=2wYJ/hQzzbaInBCeXw38ojYkJUdwxN2n9QicryCqnJjyDSamUqUkL2zvYWUu2mbLoh
         RxuE0YrhLqHzZfcOLihGpaaVdg88AnEgspLHcirI4e4+hGYobgH3N3MqReRsQWw3O3yr
         7aHwizgOhCF037ze5d2/pXRSQLaxQCKd8YN6lBwbCrnj2TLS9hAKAdIEbxFj352TPx2i
         BMVngIirbhB91a/sgvDX/IoZwG1B83m5N2bI6/I5FTtCEde2uI58JXQLzQpUCetMy88R
         QRpd3s3DpaBgae5glqmk/oSStPpuMXbXNcmFfpGZQLp/hsKJZVASCUp/1wv51ULi632L
         b23Q==
X-Gm-Message-State: ACrzQf2MVTvE35YLVbYPAensxWp2r4luu3xrxhMCwAU40BJ6AEaSNTSn
        Eu9J49GEFZZjKFPOPGOE06rfDXAN2/c88SFORVccgGp+IRQ7bsA0XHPxVfM5vrnf9N8/kCMstSj
        sL33GexIZvom4Il0f1HI+uQbk
X-Received: by 2002:a17:907:d02:b0:78d:b3cd:a277 with SMTP id gn2-20020a1709070d0200b0078db3cda277mr11010885ejc.622.1666273992058;
        Thu, 20 Oct 2022 06:53:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4PotGcQ07K6ypuchl5tD8IgFsrRkxFuy7goJ/+FeOLMHBFjGRjP71jovTbqc1KjV7/6G7ilA==
X-Received: by 2002:a17:907:d02:b0:78d:b3cd:a277 with SMTP id gn2-20020a1709070d0200b0078db3cda277mr11010870ejc.622.1666273991734;
        Thu, 20 Oct 2022 06:53:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id j18-20020a17090623f200b0078db18d7972sm10327867ejg.117.2022.10.20.06.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:53:11 -0700 (PDT)
Message-ID: <8bc59991-53c2-cff1-c63a-07da93a34bf4@redhat.com>
Date:   Thu, 20 Oct 2022 15:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [GIT PULL] Backlight for v6.1
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
 <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
 <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
 <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
 <d66fa3ea-1efe-e7da-be80-89507067e2a9@redhat.com>
 <CAHk-=wgF_0+au4cz-ZmH4qOpgDWmmbJC101fh_RVAbsJRH7d-Q@mail.gmail.com>
 <189ed242-4ccb-4935-ede0-c5807d7b5083@redhat.com>
 <e0fb158f-81af-8f3d-5d8b-c4c423feec6c@infradead.org>
 <Y1FRwfeX+ynmHxPm@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y1FRwfeX+ynmHxPm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/20/22 15:48, Andy Shevchenko wrote:
> On Wed, Oct 19, 2022 at 08:31:33PM -0700, Randy Dunlap wrote:
>> On 10/9/22 05:58, Hans de Goede wrote:
>>> On 10/9/22 01:23, Linus Torvalds wrote:
>>>> On Sat, Oct 8, 2022 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>>> Because if it depends on some symbols from I2C_DESIGNWARE_PLATFORM,
>>>> and that one can be a module, then the Intel PMIC driver also needs to
>>>> be built as a module to just get the build coverage, at least.
>>
>> I don't see intel_soc_pmic_crc.c using any direct calls into
>> i2c-designware-platform code. If it calls into it, it must be thru some
>> indirect pointers (?).
> 
> It's on hardware level, the PMIC is connected to the I²C host controller,
> which is Synopsys DesignWare and being services by the respective driver.
> 
> Any access to the PMIC's registers requires the I²C to be involved.
> What we talked above is even bigger loop, that takes AML code in
> the chain.

Right and the involvement of AML means that we need this all to
work early on during boot, which means that all the bits, including
the I2C controller needs to be builtin. So things will compile fine
without the "depends on I2C_DESIGNWARE_PLATFORM=y" but then things
start breaking at runtime.

After a bunch of bug-reports due to wrong kernel configs I decided to
add the "depends on I2C_DESIGNWARE_PLATFORM=y" and since then we have
received no more bug reports about it. So although technically there
is no dependency on symbols from the i2c-designware driver I would
still very much like to keep the dependency around.

As I already mentioned earlier in the thread adding a
' || COMPILE_TEST' to this is absolutely fine and if I get Cc-ed
on such a patch I'm more then happy to Ack it.

Regards,

Hans

