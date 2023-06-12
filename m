Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4472CAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjFLQFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFLQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C609BB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686585862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuCdplsPmJlzp+kH6QUrWWOm1LK9xg7d6ONJhnkdacI=;
        b=I9qCB430kHpSy+gM2ebFNEkszkta8b6pmCCFQVCqFDLJO2iXyzjQnK39FQ04RtTCEXge3s
        gGIJ8hh8hwkiZtybyzv5nPBOZ78J30nvaSeOyh9L6VQh2km1E5e9Xlpr/f3xCaKsF2Wg9d
        H6EUJjdTs32hd2NzOJ4uFyTin13oTbE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-8BLNf1x2Np2QluNM4xyxaA-1; Mon, 12 Jun 2023 12:04:20 -0400
X-MC-Unique: 8BLNf1x2Np2QluNM4xyxaA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fc3469c9bso592189f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585859; x=1689177859;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuCdplsPmJlzp+kH6QUrWWOm1LK9xg7d6ONJhnkdacI=;
        b=AdHs49K4vR2kmu8uVk2lyIUYYTimtFby9wYhVIOxg4shhRf11YbRi9nFod047Z1IN+
         bZQ1DUHP0h9FuX+RP6HuBf8z0uYoUbcc9qrOBlUNW63rqBQ8wXYQFQCzFlVVNFvfOWaD
         Za9fePzgyruXvLPWn0TYYW2xnR+iYQyEJsZD8bpotcmguF7YfTVexpzc3W8sixufasPr
         /JTfGpf43pm64F7ykZj9X8aSr1khNuMSUcdaCuQTrn0s4sjn4AhrYtdu3XrqmkwZXap7
         tEDZoc3n9wVaDcVK7Rh7WlRrIujqwfHa6Fk6btRI3Acezve7lG4y2kxncArf4MgbRbAK
         Udig==
X-Gm-Message-State: AC+VfDxZs3MpmNfgp1UMsm2Xgemsw/fRpykSUf1OyExbmvk3UyiuK8Nf
        tOPGC0iXqEYFqmnbTdi91tShiZzBlNqE8ohEiEP6w2H7kBdnUO/OU0PM4+/rYKB2CVc97zHeYyV
        4hWGBjbNK6fLTkuy+yaP5nFa/
X-Received: by 2002:adf:e984:0:b0:30a:bf2b:e020 with SMTP id h4-20020adfe984000000b0030abf2be020mr5819478wrm.45.1686585859688;
        Mon, 12 Jun 2023 09:04:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4owFNKmEWmuPb++u0T0aPDLLPsp/xgXSi0mOTbIfVKTyTKs1oJaK7lKDIf+8APpdspTz1ouQ==
X-Received: by 2002:adf:e984:0:b0:30a:bf2b:e020 with SMTP id h4-20020adfe984000000b0030abf2be020mr5819445wrm.45.1686585859272;
        Mon, 12 Jun 2023 09:04:19 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d5281000000b0030aded83385sm12896655wrv.27.2023.06.12.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:04:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/38] fbdev: Make userspace interfaces optional
In-Reply-To: <20230612155601.GC1243864@ravnborg.org>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612155601.GC1243864@ravnborg.org>
Date:   Mon, 12 Jun 2023 18:04:17 +0200
Message-ID: <87jzw83bwe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

Hello Sam,

> Hi Thomas,
>
> Nice series, quite some preparations.
>
> On Mon, Jun 12, 2023 at 04:07:38PM +0200, Thomas Zimmermann wrote:

[...]

>>   fbdev/smscufx: Detect registered fb_info from refcount
> I did not try to understand the code, so others must review.
>

No worries, I already reviewed that one.

>>   fbdev/ep93xx-fb: Alloc DMA memory from hardware device
>>   fbdev/sh7760fb: Alloc DMA memory from hardware device
> This smells like bug-fixes, and I do not see what impact the change has.
> So again, someone else needs to provide review here.
>

And same for these.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

