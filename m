Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40782694617
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBMMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjBMMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC634EE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVV8BP4LQ7jR9rjLOdk919ok2Vjalky2DrMtW9FxH5o=;
        b=fFilD6KIIDr9h95hLgmf72Fd8j1VtuahC6sh4oJ0PqQ2JZ2n7VSVzhfK2wxAl+BevdscQq
        2HO1EpGg+49+rl0b8VEjHMR/ifzxV97s2J8W/cIMiaQ2yGiO2GIOpdC3QtTBKMbc2GKhdN
        ndt/rok3VCk9RQHATLA65M+r8eis6K8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-OzJXKwdoNUOgK4rD1q6Row-1; Mon, 13 Feb 2023 07:43:24 -0500
X-MC-Unique: OzJXKwdoNUOgK4rD1q6Row-1
Received: by mail-wm1-f71.google.com with SMTP id l38-20020a05600c1d2600b003ddff4b9a40so6779393wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVV8BP4LQ7jR9rjLOdk919ok2Vjalky2DrMtW9FxH5o=;
        b=HnI5xYIOcl6iCczW+/BYyCUC51M+eTqxgINDno6H71qz2pbWslQVbdlCJDcQKXBl5r
         ECeCzq7vcNYl+7mldvt/NejJC1SKhIM6ffiIEcCMQGXHJIP8waANTIuBJ0PuZ2HrIyaR
         lIIpcAes7SCsv5ExnoGXJUMb/UB63MLGUBv7QrXACwlkgn2lwzWYG3ExYQ+vK0EZZYHU
         ix1lcP7gpWc9lzuvIaODnhDEMI+etV2OgsViKjbYFNcFD6mW4pgEU1HC2y4OUkQAXjum
         SY0qXgKWUMR436M8AdD+y83Hc9MBx6GReBWsJpe2/7gvJEWI1rPEx77r4ISBM0fohD9J
         oTXA==
X-Gm-Message-State: AO0yUKX34wEfPbcJ1hdu1a8bWOu/bHM3dHlkeRkzt+mhnLeO2eNmg89q
        MBu/wCllAHQzehcpj3vK6nLWX5JUrWy1oQPMqe7H7LdPinswEWckKftRMUtPHqnCMhBtgRxNC2y
        sJbqkF5AfvsYM9Xh3ZzAFzYF5
X-Received: by 2002:a05:600c:1684:b0:3dc:5622:5ded with SMTP id k4-20020a05600c168400b003dc56225dedmr18654764wmn.12.1676292203099;
        Mon, 13 Feb 2023 04:43:23 -0800 (PST)
X-Google-Smtp-Source: AK7set97ib5TNiHa0msyXoExrWiUWQimrwXn3808DgNhxrnl8PyhnOStpk5fjbjAEli+lM9FsDUDYg==
X-Received: by 2002:a05:600c:1684:b0:3dc:5622:5ded with SMTP id k4-20020a05600c168400b003dc56225dedmr18654751wmn.12.1676292202954;
        Mon, 13 Feb 2023 04:43:22 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003d9aa76dc6asm17874868wmb.0.2023.02.13.04.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:43:22 -0800 (PST)
Message-ID: <ba4cb015-1c76-c6f9-ec09-83d751e9e10e@redhat.com>
Date:   Mon, 13 Feb 2023 13:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/4] drm/vc4: hdmi: Replace hardcoded value by define
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230126-rpi-display-fw-clk-cleanup-v1-0-d646ff6fb842@cerno.tech>
 <20230126-rpi-display-fw-clk-cleanup-v1-1-d646ff6fb842@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230126-rpi-display-fw-clk-cleanup-v1-1-d646ff6fb842@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 18:05, Maxime Ripard wrote:
> The 120MHz value hardcoded in the call to max_t to compute the HSM rate
> is defined in the driver as HSM_MIN_CLOCK_FREQ, let's switch to it so
> that it's more readable.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

