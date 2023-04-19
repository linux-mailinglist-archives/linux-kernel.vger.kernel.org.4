Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CE36E74E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjDSIWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjDSIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC187DA2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681892472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blyeMnej/ZWQUIzL86aP9w1eTIPSx+cVSXGKg3I9FIM=;
        b=UzTXZZkvNyn0NaO1pAmNp/E0V0YT9fJgs0nVSHq+CImcBiMt32nkYOVXJiv6Fj8+OgCGek
        ZhwkIhn8DAFDZ3elwP4XFiQPNlgVC+l/0zYWSgpxWdhzKYy5kI/UBIuSHobhSOQ0QJPW+Y
        7gspV0TRXwnxpBoHLjfuE/HfDEfSjSo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-2CtxDBDOP1-j2P46SM7D5w-1; Wed, 19 Apr 2023 04:21:11 -0400
X-MC-Unique: 2CtxDBDOP1-j2P46SM7D5w-1
Received: by mail-wr1-f69.google.com with SMTP id e10-20020adfa44a000000b002f6c0c4884fso1931360wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892470; x=1684484470;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blyeMnej/ZWQUIzL86aP9w1eTIPSx+cVSXGKg3I9FIM=;
        b=S7Iozmd6K0qSN/wsL5yAABWRo0Kxi5YamcfLhhCencTjwmqOuC8Ilji6x4sX4bceFO
         y5otEyqONhB7Ih514AAEZO71Fx2JhgK+9OwnaQ9Z01FvCZ/x/jEo7c93ycDeXwi4e8dc
         SGIsQWi4Mt67TKlCrfnLqh11Xp5e/blKOfl0Uz7KPqG69Q9UZXMp4LfLOqfy0OrlIxgn
         gSPKN2UVgbwcXkv0WIZK3L95fZsrAIJRM+dOLsu8wIQuZnDS3e8ZOEzW+DW71jAsIF+e
         MTfjIXH/Re0b2CmKm5FHyjMmvog1VMP0GaVnBInfjb++W0RBbWYEWgoyZbvyXy3cRC6e
         3CRA==
X-Gm-Message-State: AAQBX9dH9NJou5qmQBHpxum5aiQp6d6/rggXzoNCUgi1OjrIq8Cjgb3o
        lFNedtRG4L8ojY4KmhHXzeD1H19BTmySwrneTACtRbTygrYAv9uNwleU4bvaf3bgX5v15oumnS9
        8NeUpZT/3eZtggr2QnzvFCww2
X-Received: by 2002:a1c:f612:0:b0:3f1:70cf:a2d9 with SMTP id w18-20020a1cf612000000b003f170cfa2d9mr8744687wmc.9.1681892470211;
        Wed, 19 Apr 2023 01:21:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlRNnBBsh00COjJ+pN5S5+Ilx0hpK+h6SApaydLTxJ7q8I55wPLH+b8inUu2rAfjVb0eb96Q==
X-Received: by 2002:a1c:f612:0:b0:3f1:70cf:a2d9 with SMTP id w18-20020a1cf612000000b003f170cfa2d9mr8744663wmc.9.1681892469870;
        Wed, 19 Apr 2023 01:21:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k25-20020a7bc419000000b003f1736fdfedsm1416894wmi.10.2023.04.19.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:21:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>, dri-devel@lists.freedesktop.org
Cc:     Pierre Asselin <pa@panix.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware/sysfb: Fix VESA format selection
In-Reply-To: <20230419044834.10816-1-pa@panix.com>
References: <20230419044834.10816-1-pa@panix.com>
Date:   Wed, 19 Apr 2023 10:21:07 +0200
Message-ID: <87bkjki8p8.fsf@minerva.mail-host-address-is-not-set>
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

Pierre Asselin <pa@panix.com> writes:

Hello Pierre,

> Some legacy BIOSes report no reserved bits in their 32-bit rgb mode,
> breaking the calculation of bits_per_pixel in commit f35cd3fa7729
> [firmware/sysfb: Fix EFI/VESA format selection].  However they report
> lfb_depth correctly for those modes.  Keep the computation but
> set bits_per_pixel to lfb_depth if the latter is larger.
>
> v2 fixes the warnings from a max3() macro with arguments of different
> types;  split the bits_per_pixel assignment to avoid uglyfing the code
> with too many typecasts.
>
> Link: https://lore.kernel.org/r/4Psm6B6Lqkz1QXM@panix3.panix.com
> Link: https://lore.kernel.org/r/20230412150225.3757223-1-javierm@redhat.com
> Fixes: f35cd3fa7729 [firmware/sysfb: Fix EFI/VESA format selection]

The convention is f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")

> Signed-off-by: Pierre Asselin <pa@panix.com>
> ---

[...]

> +		bits_per_pixel= max(bits_per_pixel, (u32)si->lfb_depth);

You are missing a space here.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

