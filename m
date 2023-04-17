Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADB6E441D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjDQJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjDQJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2959C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681724160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZozA7MZ/y/4iKOl2TeZkQx7oEXefDUw2m6z73qNdQrc=;
        b=HpKED/0jeCvoOmaSFaaIz3CJib9ma5+q6U1XSDr790pQZa/LgBMleb0O+QbML3kA4PGJF9
        9EY4sHmeKoq/kIvqqhtuzS9qkbuii31oAeY6IWM4xhJTZgzaDnQCGvVzq3XMKLJiMsdbPN
        jaVROCc4MfH0Ud/xTuB60B45cHMnens=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-MfDADmVCNIuxQSgX-JDeog-1; Mon, 17 Apr 2023 05:29:54 -0400
X-MC-Unique: MfDADmVCNIuxQSgX-JDeog-1
Received: by mail-wm1-f71.google.com with SMTP id bd16-20020a05600c1f1000b003f172e02edbso1848966wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723793; x=1684315793;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZozA7MZ/y/4iKOl2TeZkQx7oEXefDUw2m6z73qNdQrc=;
        b=BX0iWSYJj+O3a4p+pCbRhcwR/LIjD6r5xfj4XZhilDe1kK62ZHjC63CAsMA26nNqSu
         p35U7PA0Ks81oUnv9CMvx86xnfYcscVGxZZQZD8gxxTTa58+rFg8o4mWZ07QBZoEmhMz
         P6mhdOIxqOPNTBtej3IUv9egKSF1WlEkk/AKwguJ0gUBrTLmw9/Rct8//iFyoctOfaK1
         WZ6k9Cyq0MUwf0ohTg9A5Y6ONzf0/FH8JhW1yBUgmDEE2NBVn3Qq+rOIDYMNbonAMqJW
         NaSs95X79LLCpmS55KjRtc8vOPwAdupQrY3ZfQ//GWkJBcIUsVP93d0RfyaCy/JPGFRL
         uH8w==
X-Gm-Message-State: AAQBX9eBdXgVMmPXlzP2pvOG6dTqoEzWmhDBV5q+Z4gyoZ6fdL0B2RCP
        rzZserMqCi/HEwvFPsJxK98STsF7hYFCveR3RiZLW3MiGAP8tkU0VOLAoXcz5hM5fUXak3LxexX
        NT4f2lYUs0f31/38g5dL1tsq5
X-Received: by 2002:a05:600c:231a:b0:3f0:4e04:b8f8 with SMTP id 26-20020a05600c231a00b003f04e04b8f8mr9631422wmo.39.1681723793326;
        Mon, 17 Apr 2023 02:29:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVKcINv0hsCXLJ7U0w23pttcQc+XPNvtnV3lcTUDmYDPJpXAoK+AjoxGOAt72/4TZrxWDdvg==
X-Received: by 2002:a05:600c:231a:b0:3f0:4e04:b8f8 with SMTP id 26-20020a05600c231a00b003f04e04b8f8mr9631412wmo.39.1681723792968;
        Mon, 17 Apr 2023 02:29:52 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003ef5e5f93f5sm15041116wms.19.2023.04.17.02.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:29:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Pierre Asselin <pa@panix.com>
Cc:     jfalempe@redhat.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ardb@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <60b7cad3-8923-98b1-2c0f-71bfabd0b2e9@suse.de>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
 <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
 <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
 <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
 <87a5zcsqg8.fsf@minerva.mail-host-address-is-not-set>
 <9e6fff69b09b36cbdd96499cd0015154.squirrel@mail.panix.com>
 <4PxhQn3zK1zcbc@panix1.panix.com>
 <f3004fccf706fb3cbb7ef6877dcd9168.squirrel@mail.panix.com>
 <23d45518-3565-e915-c6d4-45dabe82ea4c@suse.de>
 <87zg76evh3.fsf@minerva.mail-host-address-is-not-set>
 <60b7cad3-8923-98b1-2c0f-71bfabd0b2e9@suse.de>
Date:   Mon, 17 Apr 2023 11:29:51 +0200
Message-ID: <87v8hueu0g.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>> 
>>     stride = DIV_ROUND_UP(si->lfb_width * bits_per_pixel, 8)
>
> I'd rather keep the code as-is until we get an actual bug report.
>

Ok. After all if the pixel format is chosen correctly, the reported line
length should match anyways. So is really a corner case what Pierre had.

> For example, DRM framebuffer sizes are often multiples of 64. Creating a 
> framebuffer of 800x600 will create a framebuffer with 
> stride/pitch/linelength of 832.  I can imagine that some BIOSes out 
> there do something similar with the system framebuffer. Messing with the 
> stride would break them.
>

I see, is not that simple then. Thanks a lot for the clarification.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

