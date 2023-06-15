Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00D7321F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjFOVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFOVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B93581
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686866036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bOZxGxVdW5/JwsyiF22jqxnsXY9NlvJg+f+VQk5+XCI=;
        b=W1mucEIfcoYejcVMEuQ5NLi4hRD6eWlLI6kbvTAHR+ypPCG/jd/db3PWZoK5FRsLUmHJRR
        a9n5yQ4ZbELq86dPuTK9AB/WlFSZL7Cjm4gbcVUNzTPaZiKo3WC0890/alSNkBnDoe6fxS
        nblGhKzw6j7C2AhAyXYGYJtVQUeXeiY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-ezSs1YOlMLacsQg_TlA7hg-1; Thu, 15 Jun 2023 17:53:55 -0400
X-MC-Unique: ezSs1YOlMLacsQg_TlA7hg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30fb891c5e3so8257955f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866034; x=1689458034;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOZxGxVdW5/JwsyiF22jqxnsXY9NlvJg+f+VQk5+XCI=;
        b=D0rimDnrEIZ//SVdoZGEo8gxQETqwHlUikLt3IspEiy+OUS8ztGHOa+bztu0E8pydp
         Dpz/3JNJ3RJ0w63oyFrLA2fOJmi9Joc4A/b5B9cziQwP+T+nbyDdADLZ9m8w/aDjRreu
         4tyoYLUof6TdvhNbkyCPyRsDpA3K67VI+3ZgqFOsFJxrHk7jv23e8D7zn4wGShjVAnNz
         AhdMnmj6eFzfGsPaHeqd02futfq7j7acqMgtEWcz+j0Dy2I5bRfCmJmYsxECkOtxpog+
         I0gz993DjOAO9LQW3qjs7qkWAY51PhvGkXpuRu2dm22T8BE+qIVqUb6KCstHsN/74SER
         CLYA==
X-Gm-Message-State: AC+VfDzPJp5SYIpU4D1kzgC4ntZwS5ymfsmzT38U3vb+3eCEkplwQvDK
        9MYjog05Mk4x+r/Z7dZBTpHxvYcOxxFXp8YVTjRYPikr0nGjWB7kYmPaRYzG2GzOKuKKS0PnS5q
        jzI4PQ1a2RXPkkS68pqs4jPMxBSNmkIRTqswnODAAI+AlrzGoNvhihjqC3i8K4xo8/3lZ+qBTks
        TwloPBELhg
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id s17-20020adff811000000b0031117afdf96mr61674wrp.44.1686866034035;
        Thu, 15 Jun 2023 14:53:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DAMQzIT9IO9837n5K6eskFWNzXBx+IXLRzoe261fgcZ2HwBQSypM+0c3tLU+kAyC1LECx4w==
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id s17-20020adff811000000b0031117afdf96mr61656wrp.44.1686866033652;
        Thu, 15 Jun 2023 14:53:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l20-20020a1c7914000000b003f709a7e46bsm253139wme.46.2023.06.15.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:53:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/5] drm/ssd130x: A few enhancements and cleanups
In-Reply-To: <20230609170941.1150941-1-javierm@redhat.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
Date:   Thu, 15 Jun 2023 23:53:52 +0200
Message-ID: <87mt10s87j.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Hello,
>
> While working on adding support for the SSD132X family of 4-bit grayscale
> Solomon OLED panel controllers, I noticed a few things in the driver that
> can be improved and make extending to support other chip families easier.
>
> I've split the preparatory patches in this series and will post the actual
> SSD132X support as a separate patch-set once this one is merged.
>
> Best regards,
> Javier
>
> Changes in v2:
> - List per controller default width/height values in DT schema (Maxime Ripard).
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

