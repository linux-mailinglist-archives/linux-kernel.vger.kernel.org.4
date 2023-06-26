Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0043173DF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFZM3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFZM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5542958
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687782435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7A4QtIPQ46OJKI9lflLzm3DTzPmnZrWIQG2/OeQ3hc=;
        b=E40kuhyeeJn+memFc4h8hHi9mddsNPlOd953mDRSvscvBcf5NU/bQmOlvuP7q/BGrMFe5Z
        g+nwJr9/dgM+xEv7IteGQB6cYLSiRuX5HTFX/K7vvzSjTBrCuWS/l7pVQZZXpBVl7w1u2h
        M08dtx7zAFeW96v/DGscvYb5crW1pMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-2AxJB9b1P_uUBNg4xmh88Q-1; Mon, 26 Jun 2023 08:27:12 -0400
X-MC-Unique: 2AxJB9b1P_uUBNg4xmh88Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313f442806dso378979f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687782431; x=1690374431;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7A4QtIPQ46OJKI9lflLzm3DTzPmnZrWIQG2/OeQ3hc=;
        b=I8sv13CcA+kyQdVXLaW4eHsOmz+CCLN2HEaU8t3hK108nUHEiRi0z7kjQx+qpWTIx/
         Ee0uIG+YDe9pnwQMPdV5y23SZRlK+1IQpfHKaYRiRlgmdzpH3DbM9opYiFU7Mrs/JvF3
         YgNkxsrcKJavApg3EG69SxWnR5U+zAnV4oNGIQIs6YI7y/ceVbjYXEIf4Y5xBOR0WFxi
         7RHPFpLjrXMbKlA31AspWR9Tv3j8vVDVAm/KsPMISiAgkgnEGhUazV19u37ru7bBpGnx
         Xcn542A0myuTOhQA6NjUpwLXIZnGt7UXgpANoARpd98t12H2YmIohpKSPHlzaI/Ynzwh
         7MHw==
X-Gm-Message-State: AC+VfDwmHswH0fcLU/u+wQdzJKxnG6nfeC04mOPCsQILk1KnF8i0wrLc
        0S/5KlI3wozDzFcMmiLFUvbppViWTvKZgGA5hUolpDP73dI0L/IvLVxdvJJ07bS0yrsSKKFhdO1
        xsYWmwtHoy1E7xpDhaRFDvyCd
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr25143865wrm.62.1687782431247;
        Mon, 26 Jun 2023 05:27:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5s+xo+3GocfRAN2ddT936OL6TbSjlftKvOe/WQg4sXaYYvHxhA/vC/T+Q/4yNgIvb7WBFVgw==
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr25143851wrm.62.1687782430944;
        Mon, 26 Jun 2023 05:27:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm3108010wrw.117.2023.06.26.05.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:27:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 27/38] fbdev/sh7760fb: Alloc DMA memory from hardware
 device
In-Reply-To: <20230613110953.24176-28-tzimmermann@suse.de>
References: <20230613110953.24176-1-tzimmermann@suse.de>
 <20230613110953.24176-28-tzimmermann@suse.de>
Date:   Mon, 26 Jun 2023 14:27:09 +0200
Message-ID: <87sfaeh0iq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Pass the hardware device to the DMA helpers dma_alloc_coherent() and
> dma_free_coherent(). The fbdev device that is currently being used is
> a software device and does not provide DMA memory. Also update the
> related dev_*() output statements similarly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

