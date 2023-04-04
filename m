Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558E56D5CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjDDKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjDDKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FA1704
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680602740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMCzWKaut/dN2TteOQeTt4t+0LoKg/jXl68FDuqkqUg=;
        b=D6CT/czG2494BcUHXKKnDkCkCKiXnTKbZBLzELPvwCREYxINCpqvdOrWPsPqi4LX8sWVZo
        q3grfCEDjn9f/AaE86pYq+JZqa1ICKVhwuFt3FMBrf70chmcfCklZIjb0wNmf9kJxsIL8d
        lIIphGV7UJJYCOOfqexHlIfjGN+4Fn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-8J2x0Q1RPZqoxx9ycvLz8Q-1; Tue, 04 Apr 2023 06:05:39 -0400
X-MC-Unique: 8J2x0Q1RPZqoxx9ycvLz8Q-1
Received: by mail-wm1-f69.google.com with SMTP id j27-20020a05600c1c1b00b003edd2023418so17538885wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMCzWKaut/dN2TteOQeTt4t+0LoKg/jXl68FDuqkqUg=;
        b=JzpqvY778OoP3M5rvEQgiEgidA7bwOcurHrz0GIjOw3MW5f6kw5BM/kXe3porI+6Az
         mdFIcYUmP69vJhjUis5WRvuZ6hFc3SkMwv921p4+VgpvbJA+ADCuSMsOiPFM+tecnP1C
         JSlMOYevLMSRkBKvgwsv9f2lMoLOiZ4xKbruXUdcPawgycSByIAQxUxj2j3nXTHiEfWK
         9B+TvYhPc6YpqaqQ5DMM0zgXGIKiHsWu9vCqcHvE1x9eMMLhN2vekc7DlKKLqaXjYTr8
         pJmsrnmYNVAhtcfMfwOaoyslIElwTGSZUoDkq+RM3lJ/EHNKVZWk4DlU4KK8Qtk4vaaY
         CtnQ==
X-Gm-Message-State: AAQBX9cMPrr9XXScFPYCUvaGg5YSs+72+ThJOQuyxM75+HnLXQWZVMRK
        8EqE6aMGoTgj9Iy5xezAMlQDsz6k2oCA6x7hUuPGaFK6faajpf5ub/XiCsG9CwJaE5xIT53hdn4
        YAmXJ5zjc5YfRtspPEk55LmbS
X-Received: by 2002:a05:600c:2304:b0:3eb:383c:1870 with SMTP id 4-20020a05600c230400b003eb383c1870mr1736137wmo.11.1680602738075;
        Tue, 04 Apr 2023 03:05:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350YDNcJtl8vS0GQ3xwhc4h9mR4/DZ4CsaVtJuVBEk4OvhBOdtLF2QHnh3n/hwDWqXrOpPWKP1w==
X-Received: by 2002:a05:600c:2304:b0:3eb:383c:1870 with SMTP id 4-20020a05600c230400b003eb383c1870mr1736121wmo.11.1680602737684;
        Tue, 04 Apr 2023 03:05:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm22001437wmq.19.2023.04.04.03.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:05:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <20230404040101.2165600-1-suijingfeng@loongson.cn>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
Date:   Tue, 04 Apr 2023 12:05:36 +0200
Message-ID: <878rf8dksv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sui Jingfeng <suijingfeng@loongson.cn> writes:

>  EFI FB, VESA FB or VGA FB etc are belong to firmware based framebuffer
>  driver.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

