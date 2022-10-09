Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712185F8B68
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJIM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJIM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485722D1C2
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665320287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vr+g9NEZ6N0t1xLUDdSRWI2Abr9SkF9mTFx6fjixacs=;
        b=KkrArRnuv3VwhU7gScxN43IFh6gN2gFeSYjuEhch98Ppyj56iAe43OY4BYVEQdWcE4dI2u
        C08I3gKo8SUWTGqT8sLN4ltbeowpYH7plAJGdTevxj2UPmXnS+eQ9YJaQsR2lIRdJbBxDi
        V7/eSAghyWbA+OYybCKDklzEVzAaVbU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-YbMrxzIhNUOaWKDp002efw-1; Sun, 09 Oct 2022 08:58:05 -0400
X-MC-Unique: YbMrxzIhNUOaWKDp002efw-1
Received: by mail-ed1-f69.google.com with SMTP id m13-20020a056402510d00b0045c1a055ee7so177177edd.22
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr+g9NEZ6N0t1xLUDdSRWI2Abr9SkF9mTFx6fjixacs=;
        b=IKws/WjGOWIkcWbHXPjxhjpl+Ra3k/NTDjFOmMg2zC6Z/WmpFsGvQYHQjUUs+SBwxx
         9BZBMEPy6FuPjE500kC17Yi2kxIAl/Qglo4TzArrYcm3x1BSQmjQ4x2Y57mdo4RYmB9B
         qfKO5VFGFMD6lvtq9wVsoIe1v7zsJIOFTxBSJvQjaOS2oOV4YAtbRz2tbEY1WzLM+2l4
         Q7ZKlOMAJJsKaRfPl5uVaS/boFtsXkNYS5xZMpXmqKNrhixvTr6A97+9bXkK9wOEv0w3
         Zzhd60PXpvYjtBsQiUcFMRraGO3G4un14g4k5CVN1DD5CP1hxOh3oola+HpTFzN+p5xx
         SRtw==
X-Gm-Message-State: ACrzQf39X061MfvhhN0hKavSFzCoA1H9cwBdTcdUyTml+N8gVMl5J1bq
        7lXcUzw9g3V2gv5bnFs8Q/qFvrAvwnFNRfoWj5z5eUjm90qX3x3OxETD7SUThu11WLOQg4AVZVl
        eEOqSVq0B5Axlvyi7CcZEHOx9
X-Received: by 2002:a17:907:94c6:b0:787:9157:a87a with SMTP id dn6-20020a17090794c600b007879157a87amr10980695ejc.5.1665320284427;
        Sun, 09 Oct 2022 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6uscZndzfPa7wjviSzgEzf5qmBAsBe6JxBfWXQVjRhiBBwdm4Pqvvtu3gjf99zjcmWq47MLg==
X-Received: by 2002:a17:907:94c6:b0:787:9157:a87a with SMTP id dn6-20020a17090794c600b007879157a87amr10980681ejc.5.1665320284204;
        Sun, 09 Oct 2022 05:58:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060f8600b007813968e154sm3917005ejj.86.2022.10.09.05.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 05:58:03 -0700 (PDT)
Message-ID: <189ed242-4ccb-4935-ede0-c5807d7b5083@redhat.com>
Date:   Sun, 9 Oct 2022 14:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL] Backlight for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHk-=wgF_0+au4cz-ZmH4qOpgDWmmbJC101fh_RVAbsJRH7d-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/9/22 01:23, Linus Torvalds wrote:
> On Sat, Oct 8, 2022 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Yeah, I don't expect he driver to work on real hardware,
>>
>> I'm not sure what you mean here. I guess you mean that you
>> do not expect to be able to test the driver on real hw
>> yourself?
> 
> Well, that too, but I really along the lines of "make it build as a
> module when I2C_DESIGNWARE_PLATFORM is a module"

Actually because the driver only works properly when builtin the
driver itself is a bool option not a tristate. So I am not sure
if even if we change the the:

        depends on I2C_DESIGNWARE_PLATFORM=y

to:

        depends on I2C_DESIGNWARE_PLATFORM=y || COMPILE_TEST

it still will not be build with an "allmodconfig" build? I must
admit I don't know what that does with bool options.

If it says yes to bool options, then yes adding the " || COMPILE_TEST"
will give you build coverage with an "allmodconfig" build and
I would be happy to submit a patch adding this for all the affected
x86 PMIC drivers.

> Because if it depends on some symbols from I2C_DESIGNWARE_PLATFORM,
> and that one can be a module, then the Intel PMIC driver also needs to
> be built as a module to just get the build coverage, at least.

See above, currently these are bool-s I guess we may be able to
come up with some Kconfig magic where they can be build as module
only when COMPILE_TEST is set ? Anyone now the right Kconfig magic
for this ?

> And I can imagine that that will not work very well on actual hardware
> with some of these core drivers that may want to initialize early?

Right, we want to enforce things, including the i2c controller driver
to be build in because that is necessary on actual hw and allowing
these to be build as modules has lead to bug reports in the past.

> But I'd love to at least have the build coverage.

I agree, see above for some gotchas though.

FWIW as a side-project I actively work on keeping these platforms working
well with the latest mainline kernel, so I do build these with the latest
rc kernels all the time.

Regards.

Hans



