Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772AD5FFA84
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJOOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJOOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 10:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DC205EB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665843904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ME5s8prwombT/Lo7EIJUE8W2dMyQx6j/AxSLPiS4UuA=;
        b=HBKmABlgO91fY1IhFsThx2WeHIF9f2KEo2n16aGO0QOB4hUd9cM859pgYliHgN8QC4SbuW
        gHGvTaPD2drNCGRlNy9bNT2tSfhM4/s67vOWJT+JVgzGL4904TdHx5w6y/6I2AWkTBW6rK
        n/cNx4SStCr+WJrfdlRXZdmPYS6BLmg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-gU62YohOMByD898kQHPiAQ-1; Sat, 15 Oct 2022 10:25:03 -0400
X-MC-Unique: gU62YohOMByD898kQHPiAQ-1
Received: by mail-ed1-f72.google.com with SMTP id q11-20020a056402518b00b0045cf5a2348fso5656241edd.16
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ME5s8prwombT/Lo7EIJUE8W2dMyQx6j/AxSLPiS4UuA=;
        b=VAElCA3U7yLFA4vdVzs69uo17vpDwik2za6XZnGHk4UXFIFO8ROvYzOwtpLpEU+NEN
         B9TElHm4LS43TlnUuvjJdxkdQNWGFPk9sR6Pnrbz6mvmWHuHdzdlx7dE9rmPpIvdMIdX
         lTUFWQ4ZdK5i9EXIqRWoz1V9Vi/gU7PUmgIjvtfJdrE6JkXzIdX5GTgbP+ugKnGwtAkN
         Xj4evzgNSNSfx4kI2nLEoSmI8+R8ygPqSaGzoCMHtRQ456WjPxx105rfE9yOoqlQV7Ad
         KUKyEsnTkzjlFGZdAo7uewJeXJx33kZH9kN/705bcb4ememE9Fk3F0nMNDEJWTb+7zLJ
         ciSg==
X-Gm-Message-State: ACrzQf0naj1C2BxVgqnoubOr5ZJzVR+lnCLBv1B1wP7+C8o4wgOrEEX3
        ZEU/2OA84/R/Yq9+cquNLTSPoCgNGDgWppHP+e0leuU4d08Tj4qdMpw78IDBm1MO9J9OvUGImpj
        XtY7apJjNYrc+zYgW5hFTdA7G
X-Received: by 2002:a17:906:cc4d:b0:78d:fb86:3979 with SMTP id mm13-20020a170906cc4d00b0078dfb863979mr2226150ejb.421.1665843901585;
        Sat, 15 Oct 2022 07:25:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6O0AU5hfqmWbu/hk//FRl4CjyZipzMGuFT1qoXBlaOZeDAnHmq9e4UUbGYBLMQj/xleCZyHQ==
X-Received: by 2002:a17:906:cc4d:b0:78d:fb86:3979 with SMTP id mm13-20020a170906cc4d00b0078dfb863979mr2226143ejb.421.1665843901393;
        Sat, 15 Oct 2022 07:25:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0073bdf71995dsm3163651ejh.139.2022.10.15.07.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 07:25:00 -0700 (PDT)
Message-ID: <e4f7b16e-5b6f-1b2c-5f88-fc4a129ae28f@redhat.com>
Date:   Sat, 15 Oct 2022 16:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: alderlake crashes (random memory corruption?) with 6.0 i915 /
 ucode related
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
In-Reply-To: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/22 22:33, Hans de Goede wrote:
> Hi All,
> 
> Yesterday I got a new Lenovo ThinkPad X1 yoga gen 7 laptop, since I plan
> to make this my new day to day laptop I have copied over the entire
> rootfs, /home, etc. from my current laptop to avoid having to tweak
> everything to my liking again.
> 
> This meant I had an initramfs generated for the other laptop. Which should
> be fine since both are Intel machines and the old 5.19.y initramfs-es
> worked fine. But 6.0.0 crashed with what seems like random memory
> corruption (list integrity checks failing) until I regenerated the initrd ...
> 
> Comparing the old vs regenerated initrds showed no relevant differences,
> which made me think this is a CPU ucode issue (which is pre-fixed
> to the initrd for early microcode loading).
> 
> After some tests I have the following obeservations with 6.0.0:
> 
> 1. The least stable is the old initrd (so with the wrong
> ucode prefixed) this crashes before ever reaching gdm.
> I believe that this is caused by late microcode loading
> kicking in in this case (I though that was being removed?)
> and doing load microcode loading on the i7-1260P with its
> mix of P + E cores seems to seriously mess things up.
> 
> 2. Slightly more stable, lasting at least a few minutes
> before crashing is using dis_ucode_ldr
> 
> 3. Using nomodeset seems to stabilize things even with
> the old initrd with the wrong microcode prefixed
> 
> 4. 5.19, with an old initrd and with normal modesetting
> enabled works fine, so in a way this is a 6.0.0 regression
> 
> 5. Using 6.0 with the new initrd with the new microcode
> seems mostly stable, although sometimes this seems to 
> hang very early during boot, esp. if a previous boot
> crashed and I have not run this for a long time yet.
> 
> 6. After crashes it seems to be necessary to powercycle
> the machine to get things back in working condition.
> 
> 
> With 6.0 the following WARN triggers:
> drivers/gpu/drm/i915/display/intel_bios.c:477:
> 
>         drm_WARN(&i915->drm, min_size == 0,
>                  "Block %d min_size is zero\n", section_id);
> 
> Since nomodeset helps this might be quite relevant, in 5.19.13
> this does not happen, but I'm not sure if 5.19 has this check
> at all.
> 
> 
> There is a 2022/10/07 BIOS update which includes a CPU microcode
> update available from Lenovo, I have not applied this yet in case
> people want to investigate this further first.

A quick update on this, the microcode being in the initrd or not
seems to be a bit of a red herring. Yesterday the machine crashed
twice at boot with 6.0.0 with an initrd which did correctly have
the alderlake microcode cpio archive prefixed.

Where as with 5.19 it boots correctly everytime. I will try to
make some time to git bisect this sometime next week. I expect
this is an i915 issue though since 6.0.0 with nomodeset on
the cmdline does seem to boot successfully every time.

Regards,

Hans

