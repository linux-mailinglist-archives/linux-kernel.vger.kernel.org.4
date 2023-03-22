Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3996B6C47C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCVKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCVKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B97521F2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679481282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAw1kb+1MttUiaf7ZI4njfkrYYVFnkuOfRgsWc6OSNg=;
        b=U6ADbOB4labQQJP4oCd8f2cIwF/qRaceJ4ZvcuhHtpEgp5WllQoiF+St++w+JgVfcsbvCE
        02TNrKQBMf5SzTLRtdcmzhaV44UNtzPX4NCZ7LjiyDs0msxAf8E9xFInSeqwYFKohZ25ni
        wKB8HQhsZlMQa/Bxqd7U/0J1dG/d/3I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-_Dbtl-9-PTq6KGoM0Vt4GQ-1; Wed, 22 Mar 2023 06:34:41 -0400
X-MC-Unique: _Dbtl-9-PTq6KGoM0Vt4GQ-1
Received: by mail-wm1-f70.google.com with SMTP id m27-20020a05600c3b1b00b003ee502f1b16so1312886wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481280;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAw1kb+1MttUiaf7ZI4njfkrYYVFnkuOfRgsWc6OSNg=;
        b=P2GgaSZcYEdDtFB7415pfYupZeRzD1LdTBDDzbQNwdOvK0Uok6/4GPLoyGoFZMkSuK
         mJTc3QLKhtizZiPnE6IHA3QkJzhEKwf8aLYeHdOaIWxmnQ68tJufXQVVeVvGvRn0jAzX
         koT8DIoad/eM7N13RM4HPSqALLcvilNQJHHvqKj/Ma9fxa3lKi402eMNlvKVwhfWScPt
         xqgOLcnUIyvbIMVh/yixqJR19iSkmgOsqSoIEb5sMxiukxYXCVLy5+Cr/1On+agmKT3v
         fNVQ67+zFOc8qF8BHLvtMK13wxLwxK5tjSDkdn1ePiFTa2xSXOqpRpZRYWUYpvmdaa9O
         4i8A==
X-Gm-Message-State: AO0yUKXWRzhXMFDQTomuRtlmgn9+pXbLTTE3s86ac2BJSqkPPxrndk+A
        o99cEM7OWSrEFXxFSjU+CWKrpBeTotAXJyox1D6diP+zTycqx8EU/0BTQ7Qh411hZi71dBq1CkJ
        hwKbMa4YcO2DYe3k9cTH9gLgW
X-Received: by 2002:a05:600c:ad3:b0:3eb:2b88:9adc with SMTP id c19-20020a05600c0ad300b003eb2b889adcmr4782429wmr.25.1679481280057;
        Wed, 22 Mar 2023 03:34:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set9OJEunbX5gMc6MC+xeRbrZtBcXx8fDHwdAWSwBMT23hK8lYvS2ivGhxvkhzDa1tAAGkQFT7w==
X-Received: by 2002:a05:600c:ad3:b0:3eb:2b88:9adc with SMTP id c19-20020a05600c0ad300b003eb2b889adcmr4782415wmr.25.1679481279722;
        Wed, 22 Mar 2023 03:34:39 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x33-20020a05600c18a100b003ede3f5c81fsm10182838wmp.41.2023.03.22.03.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:34:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Maxime Ripard <mripard@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        Stephen Boyd <sboyd@kernel.org>, Emma Anholt <emma@anholt.net>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Gow <davidgow@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Airlie <airlied@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/8] Support ROHM BU27034 ALS sensor
In-Reply-To: <ZBrSCYp+QrHK47dS@smile.fi.intel.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <ZBrSCYp+QrHK47dS@smile.fi.intel.com>
Date:   Wed, 22 Mar 2023 11:34:38 +0100
Message-ID: <87edphnkg1.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

Hello Andy,

> On Wed, Mar 22, 2023 at 11:05:23AM +0200, Matti Vaittinen wrote:
>
>> Revision history:
>> v4 => v5: Mostly fixes to review comments from Andy and Jonathan.
>> - more accurate change-log in individual patches
>
>> - copy code from DRM test helper instead of moving it to simplify
>>   merging
>
> 1) Why do you think this is a problem?
> 2) How would we avoid spreading more copies of the same code in the future?
>
>
> 1) Merge conflicts is not a bad thing. It shows that people tested their code
> in isolation and stabilized it before submitting to the upper maintainer.
>
> https://yarchive.net/comp/linux/git_merges_from_upstream.html
>
> 2) Spreading the same code when we _know_ this, should be very well justified.
> Merge conflict is an administrative point, and not a technical obstacle to
> avoid.
>

I believe this was suggested by Maxime and the rationale is that by just
copying the helpers for now, that would make it easier to land instead of
requiring coordination between different subystems.

Otherwise the IIO tree will need to provide an inmutable branch for the
DRM tree to merge and so on.

I agree with Maxime that a little bit of duplication (that can be cleaned
up by each subsystem at their own pace) is the path of least resistance.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

