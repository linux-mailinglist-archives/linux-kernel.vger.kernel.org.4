Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963416BD724
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCPRca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPRc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD188C83D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678987871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/08vluPjzxrx+ms2g2CAdKVV//z599hvAytsqxrTszw=;
        b=SshpMsvdSum/13JCSXE9dwBXnqgf+JS76RckR1cBix1LlwBXc317k7QRRLulDf4jYxdScf
        RPd1CwEP83OsTtWHdhzzJKZhSbweScxAkZInP5Ouu62mw7CL+EIA4gUtzFfsHOCp4K6dwY
        ZgZjvAXJ+QuYyZVFcGs0Hf03NDjwT2E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-sTBVA9BaNNq-xdqZ8rnWlw-1; Thu, 16 Mar 2023 13:31:10 -0400
X-MC-Unique: sTBVA9BaNNq-xdqZ8rnWlw-1
Received: by mail-wm1-f70.google.com with SMTP id j13-20020a05600c190d00b003ed26189f44so2929588wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987869;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/08vluPjzxrx+ms2g2CAdKVV//z599hvAytsqxrTszw=;
        b=LX/uVEIZhcw6FpK+XrsY0lxKJogQNTSGpeHBbXtS4kW32AFYlY7/dwpjKqL2++t1Um
         GwQ3TpP4ZgIFp57uCFQw9soHGomH1dJ3mAh4i3eu953Swt4uiRxKOgDz2aiXe570jZs/
         xyUtU5UO2Sh5Yt0775OrZ7BQHCvrtl9MSPQJlUH3Ahk3l01PHIbF82kcSEEdIVc0tqe0
         AZvMXJDYGPesuahli/1JvkGScgO3XhFLv+lnou9PBH0+ZrtOiel5PJqER5NLIb57fg8S
         UNcQFJT4+PzH9yfOsJHaHBtq9ZATeUXG3p4NGJTF5BSJ/80RFbt6FLmy+CveAArtunP6
         GebA==
X-Gm-Message-State: AO0yUKWclL9Fqf6BMwEPEDFVicIL2b0ISC+5CoZI9y2eVeeED2/FjCC/
        QtXWIbMJYNyu5m2tdNzlDxf2gWJLk14Ump5Bt4Rw30QzJRb+sBSzCoRTJl3LRxW412fDQ/cU+2i
        xhJgEt0Qk69bwUXvQa4wnHGoy
X-Received: by 2002:a05:600c:34c3:b0:3eb:5ab3:b6d0 with SMTP id d3-20020a05600c34c300b003eb5ab3b6d0mr22301109wmq.6.1678987869082;
        Thu, 16 Mar 2023 10:31:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set8in/lkI4jv3umpLr5SfG/+NupQAriJfTTzpU2lr1Cm4vESkvwCGyoOm7e3Bzmv2djyZ7kNsQ==
X-Received: by 2002:a05:600c:34c3:b0:3eb:5ab3:b6d0 with SMTP id d3-20020a05600c34c300b003eb5ab3b6d0mr22301088wmq.6.1678987868741;
        Thu, 16 Mar 2023 10:31:08 -0700 (PDT)
Received: from localhost ([90.167.94.186])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b003ed1fa34bd3sm5477336wme.13.2023.03.16.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:31:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] platform: olpc: mark SPI related data as maybe unused
In-Reply-To: <51d9b1de-5f22-2085-1d3e-6c29afb44120@redhat.com>
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
 <63814b1b-1297-da4d-79fe-8f2e58e30482@redhat.com>
 <f9408067-ee3c-9f5b-d1b3-7017113c8026@linaro.org>
 <51d9b1de-5f22-2085-1d3e-6c29afb44120@redhat.com>
Date:   Thu, 16 Mar 2023 18:31:07 +0100
Message-ID: <87o7osli1w.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

[...]

>>> Exposing modaliases for a non supported way of binding the driver does not really seem useful ?
>> 
>> However binding the device and module loading (uevent) uses sometimes
>> different pieces. Maybe something changed in kernel, but sometime ago
>> certain buses where sending uevent for module loading with one ID (e.g.
>> platform or spi bus) but device matching would be according to OF. Thus
>> if you did not have entries in spi_device_id, the module would not autoload.
>> 
>> It was exactly the case for example here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c46ed2281bbe4b84e6f3d4bdfb0e4e9ab813fa9d&context=30&ignorews=0&dt=0
>> 
>> You needed spi_device_id for proper module autoloading.
>> 
>> Unless something change in between in the kernel?
>
> Looks like your right, the spi_uevent() code always emits "spi:xxxxxxx" style modalias even for dt/of enumerated devices:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c#n398
>
> So the table needs to stay.
>

Yeah, and in fact dropping the spi_device_id table will cause the kernel
to warn that an spi_device_id entry doesn't exist for a given of_device_id
entry since commit 5fa6863ba692 ("spi: Check we have a spi_device_id for
each DT compatible").

Fixing that is not trivial because a lot of drivers are rely on current
behaviour of the SPI core always returning a spi:<dev> modalias. So don't
even have an OF table, even when the SPI devices are instantiated by DT.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

