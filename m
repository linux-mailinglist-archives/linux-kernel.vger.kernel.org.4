Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8036E7457B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGCIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGCIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F310CB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688374175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=+TImfC7tK2SsSjZEh/HT3vdbJQbag2Dkm/n26z7WMho=;
        b=Nme9C41kSZ57gRoAj4g/SfFueSciOMPiWDxnysOxi6IIFv3ydb1J2J+aGYGQIJAYOYdiFo
        R39vEAy/dJLX73q4zrcnu6pJ/KrXLj8goCOtTuDJ4F4spMa3DmDiuvW7jRneOh5QEDmUbF
        FzDhWK41YuF4/MhD5QT3ouj7FKCNsDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-XuwZrOGJPH-BkGFDhrbsmQ-1; Mon, 03 Jul 2023 04:49:34 -0400
X-MC-Unique: XuwZrOGJPH-BkGFDhrbsmQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb34f7224so26158775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688374173; x=1690966173;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TImfC7tK2SsSjZEh/HT3vdbJQbag2Dkm/n26z7WMho=;
        b=LFrflBhitY92jJQPzwHaoZ236lXj8UXBXwedv/DDhSWt6M0xGe0ATl9ORsfWwORMFm
         79YiGZrYJbTDmRgpb90Fq4zKIa29h8LBuzwgEzbLpxhIZCAdaRz+W9j4yqdyaMnm78QH
         qQUkrMhaRvoHQkIsN/tVqeutd3QaFQn/PPGNjJP/fDPGz8nFvRr69MRmQkOvIPRWkKyb
         Un28lqqbGzddbsZTkdGoB0wiqFblsPzpyZOwYAslBdglWiBPpdztSF08l+qc2nRJmY3F
         ijwmAoHtLJR5TrnOIn+SFrLpMyq86sV/Uq3ykU483vuaN+CbeAxaAr1iUGiRzBt0vDJQ
         UUtA==
X-Gm-Message-State: ABy/qLZ+u/Il2omjLdg5EnR7r0Bl34+1bSaD1b2qSDcIuwxla0feDU9+
        F/WVBccAOqvOUfvmW+KfFIrgrFsggqCwnyuqKjTY3uf6SGFzRRXglQLUzXR00mML9mx6hnHVlOo
        CuCAYMQ7AbVJd+z5SDHlZtDjR
X-Received: by 2002:a5d:5141:0:b0:313:e88d:e6d6 with SMTP id u1-20020a5d5141000000b00313e88de6d6mr8286630wrt.14.1688374173214;
        Mon, 03 Jul 2023 01:49:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGg6K8WUHE8euyn+3LOEa30xbblNJ36iK0ft7TSKaKSogN5/e+nUCA42ROWlI7aSWhx9VYj0A==
X-Received: by 2002:a5d:5141:0:b0:313:e88d:e6d6 with SMTP id u1-20020a5d5141000000b00313e88de6d6mr8286616wrt.14.1688374172926;
        Mon, 03 Jul 2023 01:49:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id da16-20020a056000197000b0031274a184d5sm25157550wrb.109.2023.07.03.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:49:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        dri-devel@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <04fa72f3-d6ca-bd68-7ed9-57151c1877df@suse.de>
Date:   Mon, 03 Jul 2023 10:49:26 +0200
Message-ID: <87o7ktz8fd.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>>>>    config FB_DEVICE
>>>>    	bool "Provide legacy /dev/fb* device"
>>>> -	depends on FB
>>>> +	select FB_CORE
>>>
>>> This should depend on FB_CORE.
>>>
>> 
>> Yes, already fixed in v3 too. I did a select to prevent symbol circular
>> dependencies but doing that lead to CONFIG_FB_CORE=y even if CONFIG_DRM
>> was set as a module.
>> 
>> But with the "select FB_CORE if DRM_FBDEV_EMULATION" in the DRM symbol as
>> Arnd suggested, I was able to have FB_DEVICE to depend on FB_CORE again.
>
> BTW, where does this item now show up in the menu? It used to be in the 
> framebuffer menu. It's now in the graphics-drivers menu?
>

No, it's still in the framebuffer menu. But after the FB_CORE split the
menuconfig ends broken (no sub-level for fbdev drivers anymore).

I was talking with Arnd and Geert about this. I think that will pause this
series and instead first focus on cleaning up the fbdev Kconfig, then it
should be easier to add the FB_CORE on top of that.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

