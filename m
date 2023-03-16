Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884056BDBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCPWbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPWbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F802B328A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679005803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnePPKTKmaEIYsfyxDXD5WYxDmgciUFDMNuKm+FuJjM=;
        b=aGJauynrOYKfLp0hRDgNx5TlK72+8HD/Ntb6nmYAPRHfOJjp5+vm6Vz/e3S/xUN2aL+ENQ
        23IGsluy03rxthZYdHsstv5xX53AFQfpcXYGrNM7ohY1pHRYy1cxyyXAItLy9h2BZN0JNh
        lRHc5fZE8SRP69dGSmp6Qa3lrDyntus=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ritx13v_P327odB1VDEOKA-1; Thu, 16 Mar 2023 18:30:02 -0400
X-MC-Unique: ritx13v_P327odB1VDEOKA-1
Received: by mail-wr1-f69.google.com with SMTP id o13-20020adfa10d000000b002d34203df59so50385wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005801;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnePPKTKmaEIYsfyxDXD5WYxDmgciUFDMNuKm+FuJjM=;
        b=sayv92627qbDB+mp8MmPWa9cqJDXVpUc0rsexImvjPRTQ37BnSf5aGnc/wXjMM5GMh
         CabH8Gu+WABqTX0soDoplHg31OaE8ckcwKtKZaxV9qYseqPaE3beLekZHoFlOG56FF3m
         yRmiNntib0PzHpJ3MguruFrQaKsHoezLu3YLkPZj1/y3y4c1chGCGMXX3Cxc5lRBKPTr
         Hy0oJaR2xPrgJtYr4em+Qv1W3LtQoBg/EnpwVWUMMspAwQmai8yR6ULv6AMnP1Jxi4TM
         DCbXGYNZAHXg8n58BD3MUCP6O0sDLEYdNAs+Amuyw0Mz76d+RFCfp3Z7mAFzHfaqW8OL
         YHwQ==
X-Gm-Message-State: AO0yUKXowYBcRLgOLkfzrq3KGwGOygKPnliGLC4Ai25qxDiz98/1a61v
        EJUAg6uCrFoVJpp5G00Gla3zFn+YwqOuji/vJs/CYjJIZTkGZ7p39p1KyeyVQ85DxJUMivTO+Gp
        TzqPP3zQSwcS+gq6tCPGIj0wK
X-Received: by 2002:a5d:56d2:0:b0:2d1:6104:76aa with SMTP id m18-20020a5d56d2000000b002d1610476aamr4059060wrw.2.1679005800793;
        Thu, 16 Mar 2023 15:30:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set+pavBAwLwWKQ9EFH0kovHVMuq3+iTPxofStWBmSEUYWs+tWYytxbJKDvuLhUGIjUzpcr5HmA==
X-Received: by 2002:a5d:56d2:0:b0:2d1:6104:76aa with SMTP id m18-20020a5d56d2000000b002d1610476aamr4059045wrw.2.1679005800473;
        Thu, 16 Mar 2023 15:30:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b002c54e26bca5sm462701wrs.49.2023.03.16.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:30:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Arthur Grillo <arthurgrillo@riseup.net>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/format-helper: Make conversion_buf_size()
 support sub-byte pixel fmts
In-Reply-To: <CAMuHMdUs0bXz1T41=bW0D1NwVYZyKUsrjCkF2hGsRPSt5+qvMA@mail.gmail.com>
References: <20230307215039.346863-1-javierm@redhat.com>
 <CAMuHMdUs0bXz1T41=bW0D1NwVYZyKUsrjCkF2hGsRPSt5+qvMA@mail.gmail.com>
Date:   Thu, 16 Mar 2023 23:29:59 +0100
Message-ID: <877cvgqqhk.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

[...]

>> +       if (!dst_pitch) {
>> +               bpp = drm_format_info_bpp(dst_fi, 0);
>> +               dst_pitch = DIV_ROUND_UP(drm_rect_width(clip) * bpp, 8);
>
> I know I'm a bit late to the party,  but here's actually a helper for that:
>
>     dst_pitch = drm_format_info_min_pitch(info, 0, drm_rect_width(clip));
>

Nice, I didn't notice this. I'll send a follow-up patch. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

