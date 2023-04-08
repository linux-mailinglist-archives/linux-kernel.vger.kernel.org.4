Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A16DBA18
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDHKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDHKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:35:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A84E41
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:34:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id r17-20020a05683002f100b006a131458abfso20468691ote.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google; t=1680950013; x=1683542013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atnnfYB8H/1cRTIRhOKd2CzwH9WdqCAcJhjKRDN3luY=;
        b=f36p8T3+z/J6u/o8geXfldjzGTUKvuBwnCOq8aVhPB5Yq0scv4lu22t0IvydiWVBM7
         CU08wz3QuGcIPb3yAdVhAgW3usOu6fLAX0B9dTUyF+DdJBVTJT8oOMZeeGHVuzEsk8U/
         ACJmBPiPbyDgvFE4BNoYWI2q2/7yDxQ5j48C6PILBZX/SdxNHL3oqGlqu/dDTMUrJmJs
         0bwnWui1/dIDcDI/PfO4ScpNdmG7VY3T6R/tIZlS7SRCQlputLk0u0J6wwKpSjlPmnKv
         U/RapLU0djwI0HQLlzVT8qQP9mV23Tbd/Y8AXD8hueIbuxcQessr9EfpsfZaTW/UQGCf
         bfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680950013; x=1683542013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atnnfYB8H/1cRTIRhOKd2CzwH9WdqCAcJhjKRDN3luY=;
        b=cQJ5fHXqpLALtl8Rn3MZXxr7iY9650Eig+BjKKazd6ofL7YEeVRn0pVoeKWR5Mc9DT
         oK7mmz2bZcmkF5rb3aRu9+7Rim189iXPPyPa77e1K4FjrdXyw53tk5A4uXZAXo7R7zFH
         EnsaDbCR7/WOQRiXsEt6KpDb//QGuEPVitZa/KRb0sc1vIxGXho+ErqxfIQMU5Djl18J
         yE3k6Gr9tFNOyr1IdNIPdg//+H6zOJxmXLngt5rjAWZhzRZLmAkx2gG+eZLgXmWW57/Q
         HpWwk6uPQ/h+gZvCGpzVHoV/RM5XV4h8YBDkx1tueveo9mmqiIbR4AkRYvevQsZL4hwB
         f44Q==
X-Gm-Message-State: AAQBX9chJr6wAoawXDtUaAATfA+MHkDvnPmiMQjpG/v4Ri4HwYrh+3s3
        83LJrPHsPU08EafDiQKmZqPSQA==
X-Google-Smtp-Source: AKy350absmUQ6HrjCN8ybKL7JT651jVYn5RTh9izjX/ysr91076zOIBiNMnDzdw113Fn8tlB/GuQ7Q==
X-Received: by 2002:a05:6830:101:b0:6a1:7f69:ffbf with SMTP id i1-20020a056830010100b006a17f69ffbfmr2146604otp.36.1680950013453;
        Sat, 08 Apr 2023 03:33:33 -0700 (PDT)
Received: from calvin.localdomain ([2804:14d:5c5e:5d5b::1000])
        by smtp.gmail.com with ESMTPSA id m14-20020a9d6ace000000b0068bcf7995aesm2442533otq.64.2023.04.08.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 03:33:32 -0700 (PDT)
Date:   Sat, 8 Apr 2023 07:33:20 -0300
From:   Jonas Malaco <jonas@protocubo.io>
To:     Aleksandr Mezin <mezin.alexander@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?utf-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 48/68] hwmon: nzxt: constify pointers to
 hwmon_channel_info
Message-ID: <jkptl4g7jwhz3mij5wffbw2qlwvxsmnwpqhyalq2ayd76pde2h@jfdw7jisg4at>
References: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
 <20230406203530.3012191-7-krzysztof.kozlowski@linaro.org>
 <CADnvcfKwHJ=dOFH1+DsDfn6Y5k6xdzA7QR1uVDv1afwCsiso3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnvcfKwHJ=dOFH1+DsDfn6Y5k6xdzA7QR1uVDv1afwCsiso3w@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 06:14:19AM +0300, Aleksandr Mezin wrote:
> On Thu, Apr 6, 2023 at 11:37 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > -static const struct hwmon_channel_info *nzxt_smart2_channel_info[] = {
> > +static const struct hwmon_channel_info * const nzxt_smart2_channel_info[] = {
> 
> In the rest of nzxt-smart2.c there are spaces only before "*", not on
> both sides (and there are a few "*const" already). Would be nice to
> keep it consistent. The same seems to be true for nzxt-kraken2.c
> (although I'm not a maintainer)

While I don't have a strong preference for either `* const` or `*const`,
it would be prefereable to use a single style in any given file.

As the kernel seems to favor the former style:

$ rg -F '*const ' | wc -l
2593
$ rg -F '* const ' | wc -l
15359

it would be better to change the other two locations in nzxt-kraken2.c
to also use `* const`.
