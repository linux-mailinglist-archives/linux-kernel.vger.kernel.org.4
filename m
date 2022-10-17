Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938176008B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJQIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJQIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ADA101DE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665995530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KNWIHzpfETNzO8vvu/OBgkc6l21+ViC5ZaicSgrrSY=;
        b=bZkx3hMZLZ+mjOEZeqY+ri0V9HVd9n2kZPqrvU9fFQZp9YgKSydfRUqt9b5PVx2SoGjDmO
        ZwlE+KgntGx4xi4pAy6rEXuGIJsmsUbpkiWMG9UfzcOkSOF+YMMq6ATirbpU8zbWTrS4Cl
        atuZkksHfr52ARHWZZ1D9q7DbrW1q4c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-j94CZNNjMZqXV9kHKKuYaQ-1; Mon, 17 Oct 2022 04:32:09 -0400
X-MC-Unique: j94CZNNjMZqXV9kHKKuYaQ-1
Received: by mail-ej1-f69.google.com with SMTP id qa14-20020a170907868e00b0078db5ba61bdso4198799ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KNWIHzpfETNzO8vvu/OBgkc6l21+ViC5ZaicSgrrSY=;
        b=qp4osz3+r25KQd0NuZNUybOwcCcyduXJM/5FsGPXrWN0puBIjfT0kgtu37+BywAT3M
         Nx+9aCpRVY9JdXmrPEOJttGMLKNIe6P127qeO+ozG5DKiB6G0ZbUZO1W2TyrIrr3H1aj
         GmauYC1AGJUgvNpOfj3n2xQ6mnRE+HomXw+BnsQUTeL/4QoeW0UCz5V88eZgbLPFySs+
         kdp0Lmyh4GVEdn333p+wKXKw4q19d9lIwMZuIOkPNxevZa+W78m44Jm9SlYisGrcgaB1
         0BPVs6lOcQf73i7p+3ZDEKkbCyIGk5WrRW44jcttiGUS8q8dW7r5udQTCLwja81aJxg/
         9zww==
X-Gm-Message-State: ACrzQf20RHkbMu/aUwCMTW9OfoKI2YfQ4PAfn9lyGmsOYiQtLRFfwsNA
        3S2IsWD37gE0D7dMFttdqyyEK4we10oSyHzO5HQejSMCD9SN9GK3CtHZS9mOy8bJVx1EV2mMAua
        rOOfxO+ME2RDzXeMXdJfPksZ2
X-Received: by 2002:a05:6402:b5a:b0:458:f4c6:8039 with SMTP id bx26-20020a0564020b5a00b00458f4c68039mr9369390edb.349.1665995528001;
        Mon, 17 Oct 2022 01:32:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7QuvGwAFxw2yDVIsfRtapjZUWFuS2M3QCz8GxWrTpVGgtbyBqCpFgd+txoTDoqfvdNlZAcgg==
X-Received: by 2002:a05:6402:b5a:b0:458:f4c6:8039 with SMTP id bx26-20020a0564020b5a00b00458f4c68039mr9369385edb.349.1665995527837;
        Mon, 17 Oct 2022 01:32:07 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709061e4800b0078d4c72e2cesm5746763ejj.44.2022.10.17.01.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 01:32:07 -0700 (PDT)
Message-ID: <05660cbc-3c66-2bcf-f3ed-d2232b92f7ba@redhat.com>
Date:   Mon, 17 Oct 2022 10:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87a65usvgq.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/17/22 10:30, Jani Nikula wrote:
> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>> With 6.0 the following WARN triggers:
>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>
>>         drm_WARN(&i915->drm, min_size == 0,
>>                  "Block %d min_size is zero\n", section_id);
> 
> What's the value of section_id that gets printed?

It is 42.

Regards,

Hans

