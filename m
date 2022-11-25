Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8916387CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKYKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKYKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48348401
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669373190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhtxmsEdvR+vP3o5ErpJAl9TfXKJOalFPCGhKeyHyZg=;
        b=ikawExKZZ3pZfykQMlIe31+QzPpxxoTVe5oj9UWI2SPkbaK9+/PyPKn9TGn+te92OApmm2
        y88IGtJJEZDO79fMlzPrpkTxfP5D9jm/nREvjFCL8SfLAzpe98JDAGjSmhCo7Cl/bVYw0W
        C17ytomflp4HD1BZK2epZzpgvkoS73Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-fknlTA1_MXSyA3AwD0kIhA-1; Fri, 25 Nov 2022 05:46:28 -0500
X-MC-Unique: fknlTA1_MXSyA3AwD0kIhA-1
Received: by mail-wm1-f70.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so3970976wmp.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhtxmsEdvR+vP3o5ErpJAl9TfXKJOalFPCGhKeyHyZg=;
        b=kyoY6ioCGmYcecIysSZ7wfVKvAjBrgT7Dz41nlTGPM7KPsxjewHjTL82BsyygrAx0g
         KhDQmEXUC+n9uhwgrDW5FcK12M9WXZt+AEc9RUBGZqqEgVDnN3+3GMYAGe7EBPQ+a+U7
         CLMIDgBwdFLO8iuu4cOCpukOXL4GzoH+xFQYTnn7WIGRLUzHqf08vp3VBKHLJacHPR+r
         tvXGH0rv1kWoPL607THJXCKqdC/nBqqmSZzNbngd/UH52tokBmFbArH0FUfIhqlov+eZ
         ROyNfG/GAB1bFkjuTvGpoH1OfGKIpFfxISh8ut2odanPpOol0CDoN5DrCIuCU3No672Q
         0iMA==
X-Gm-Message-State: ANoB5plZB0neqZyNOtVEPzuIUhqfaG0LfCCzHHvuEtkTkvCA315grKBm
        JxqO6izN2ZFWuT0q/+2lUu/mxEyFQeTaOJy0SnZy6DYOzPLaXTrNixWrd2N3nN+I6X1AfF2baYP
        HFQa9ScNsmeobFH6Y9wRM52mK
X-Received: by 2002:adf:e305:0:b0:236:6089:cc5e with SMTP id b5-20020adfe305000000b002366089cc5emr13952912wrj.118.1669373187605;
        Fri, 25 Nov 2022 02:46:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KaINgjKp/2wkkwi92QDcPVCibVYhE6To5a67U+PrJPM+QNYF8tla3vcgJY0rGOjh5rJYqvg==
X-Received: by 2002:adf:e305:0:b0:236:6089:cc5e with SMTP id b5-20020adfe305000000b002366089cc5emr13952885wrj.118.1669373187352;
        Fri, 25 Nov 2022 02:46:27 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cc18-20020a5d5c12000000b002238ea5750csm4218998wrb.72.2022.11.25.02.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 02:46:26 -0800 (PST)
Message-ID: <4aad755a-a0b3-cdab-694f-750c8903e5df@redhat.com>
Date:   Fri, 25 Nov 2022 11:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 06/24] drm/tests: kunit: Allow for a custom device struct
 to be allocated
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-6-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-6-051a0bb60a16@cerno.tech>
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

On 11/23/22 16:25, Maxime Ripard wrote:
> The current helper to allocate a DRM device doesn't allow for any
> subclassing by drivers, which is going to be troublesome as we work on
> getting some kunit testing on atomic modesetting code.
> 
> Let's use a similar pattern to the other allocation helpers by providing
> the structure size and offset as arguments.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

