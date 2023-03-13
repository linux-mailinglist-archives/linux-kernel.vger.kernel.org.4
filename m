Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913E6B7F85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCMR3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD88024139
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678728489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0evT8Vtbk81R/TosIabCJgTCcIOpvJ7DhYFh1FtAtkk=;
        b=eLKhDUJtKo0wW9+oQOUjmDlNaHEUsXLP2o2AbbHxOjGF3FPbUWVtpd/0G6lx9gfkiEQPcc
        q8R6Brl0N8ip/d69pwLvJsKT/NajMsKFJY6WODSqXjHllyRCW4toK6T7o6ZY+pSe9LjmGc
        5jltgq/Ld5YiBCLJEGj2Vzqp2wUj6xA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-XhUdX-MXP7ye3tomj4rmBA-1; Mon, 13 Mar 2023 13:28:07 -0400
X-MC-Unique: XhUdX-MXP7ye3tomj4rmBA-1
Received: by mail-wm1-f72.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so8090156wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678728483;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0evT8Vtbk81R/TosIabCJgTCcIOpvJ7DhYFh1FtAtkk=;
        b=UzBm2SatG2YzcWkMsWCuDhhUn3/BhWjP4vJGvycVyYhW1XrvClsj2SGusbnWK4axWo
         MP7l6PSqH2JLtE5mUd9RPgawuxydgX1CXRfyfhSvzDha4OgFDb1O/yWv6zxpomyaefQp
         XT7pF7b9vKb1I+O6ciymwXqzKVaxE0fveL2paJdvRU3a4msxF+qXdWWzEwinyQV8Mtfk
         b/FADFcXaM3GuY+QSeZtR/GcrdEooLOLMQLa2ortQTeF2rA6BTDHXKSdvTacBn/o68oU
         XdQOQHf4ztV1Lo6KZLo45nxkg8g2pVZSNMHKnQf4vHWVT2Go2L5DdT1CC7m3pfkdUxia
         4Cqg==
X-Gm-Message-State: AO0yUKXVuNglriqhOf/whBu+8JL0HhoBGAAX3lr7DdHyOkf6jmHFXVNz
        kcgy0tbbrQs1+kAVa0XQzCn+/yIVYTiwr7nJZ3bcwFA/9DdYPomfYcVKX2zM83662J+8w3LEpr+
        bvRuMiXI6NWsdXFkkFA1zm57FeeB6NvfdDqRr/fnnGJHFOkghh8tmAqUkpoI7WHR0XjNEjF8MKz
        7KwqH7LTgn
X-Received: by 2002:a5d:67c5:0:b0:2cf:a4a4:4990 with SMTP id n5-20020a5d67c5000000b002cfa4a44990mr2719460wrw.12.1678728483530;
        Mon, 13 Mar 2023 10:28:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set/7GgtuVqfDGuMBUhrVNWrlcKe6Ov6XP2yqoEXeAWGzA4mJRnXO1p4TuJbvR1Qp74HfmtJO/Q==
X-Received: by 2002:a5d:67c5:0:b0:2cf:a4a4:4990 with SMTP id n5-20020a5d67c5000000b002cfa4a44990mr2719430wrw.12.1678728483226;
        Mon, 13 Mar 2023 10:28:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4570000000b002c5539171d1sm35268wrc.41.2023.03.13.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:28:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Christian Hergert <chergert@redhat.com>,
        Albert Esteve <aesteve@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] drm/virtio: Enable fb damage clips property for the
 primary plane
In-Reply-To: <20230310125943.912514-1-javierm@redhat.com>
References: <20230310125943.912514-1-javierm@redhat.com>
Date:   Mon, 13 Mar 2023 18:28:02 +0100
Message-ID: <87ilf4lfx9.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Christian Hergert reports that the driver doesn't enable the property and
> that leads to always doing a full plane update, even when the driver does
> support damage clipping for the primary plane.
>
> Don't enable it for the cursor plane, because its .atomic_update callback
> doesn't handle damage clips.
>
> Reported-by: Christian Hergert <chergert@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

