Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0E638841
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKYLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKYLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DC4D5C9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kvo3ByqVNYtl4Gj5V4V1EtKWGChjY02VeHw9i+vXN5I=;
        b=KWFBlJtX+8VEQG58lpHhJP658qUTL6fTpdPcz4vBAs7xOQwcTSolKh7JNSKsI1rpSSb78v
        Q6g97AGelXktWEqAQE1LNlc7S7rS8JcYd2XoZfQiUdPqKShqYl4zK6WmQM7obSJehX6L4B
        3ujdgT+TF8IFjNK1V4subuzx6O5O6Wk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-g_SPp0kwNCaPuZa-CeykGA-1; Fri, 25 Nov 2022 06:05:33 -0500
X-MC-Unique: g_SPp0kwNCaPuZa-CeykGA-1
Received: by mail-wm1-f70.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so4035586wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvo3ByqVNYtl4Gj5V4V1EtKWGChjY02VeHw9i+vXN5I=;
        b=zhhuxObknTYYW5a0oyQCZLWgd29WyM7Gjdr6H8Wey7a6EHrWh2Kgqb1HB5Zul81gg7
         k3nxIrJabUKAFoUmG7y2URNyl9nRDLgrEZhuijotW4+gYWLc352urEC3IzzkaFOhhK7r
         +8pBhntH20Mm21EBdy4voq9m4nUuybUQFtpN19UFpYqBMCIl1/fgZhdMsgpvx8AZUMz1
         VrIl7C2WoFm/D8y3MLbv2EySJu+Nh/OqMlv3lyNvh3DqV8f8+5EDA8N8AKyg3JPeb2FN
         gSCTCg5qYeY0+5v1K3rF7Jy+MbOZMl1CrnHKe0jjgfBS+n7BnaNU+JB5WXnk7d5jpnd0
         EXRQ==
X-Gm-Message-State: ANoB5pmmkdeR8ZlSbtF66dtGo0dDFwzYX4DFnrbH3dBpuBEUCOhKkwD6
        08CxzGpCSMiDYVyNR3GuksXLczUTDgHdPO8ArUegMdrua1Wf7EXxxhGD5rTUQ+zcJd8m0P7mgnJ
        8OEaVo95xnrrC545VwqvRWmbE
X-Received: by 2002:adf:ce05:0:b0:241:ea29:fa06 with SMTP id p5-20020adfce05000000b00241ea29fa06mr8120165wrn.594.1669374332184;
        Fri, 25 Nov 2022 03:05:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wTdp2+VuVoE5mvN2PyA3RkmkpVRnCk9tCcFb4MGlJIpqCV6lnFcIqScH72xr3oR/swXwGWw==
X-Received: by 2002:adf:ce05:0:b0:241:ea29:fa06 with SMTP id p5-20020adfce05000000b00241ea29fa06mr8120136wrn.594.1669374331867;
        Fri, 25 Nov 2022 03:05:31 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm11765978wmq.36.2022.11.25.03.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:05:30 -0800 (PST)
Message-ID: <0c5c0fa9-7223-2855-04e8-5ce264b873e6@redhat.com>
Date:   Fri, 25 Nov 2022 12:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 13/24] drm/vc4: kms: Constify the HVS old/new state
 helpers
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-13-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-13-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> The vc4_hvs_get_(old|new)_global_state functions don't modify the
> drm_atomic_state passed as an argument, so let's make it const.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

