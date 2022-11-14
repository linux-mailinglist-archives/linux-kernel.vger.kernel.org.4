Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24762775C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiKNIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiKNIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:20:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BBE2DD8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668413996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Yxpc0+M0IPWKSXHEyC3cyneUXB0jkXapCGIc8Lc3oY=;
        b=gj2HOp32vgeqSjpAvwAajLUvnNJUke4xPoH+vzCcgK2ESmLy4JRvq1S3qhBXbKebUsJEqq
        pFk5GsqUyz/+NFhoe/m50IEGwattOnD/khiUzaYKp0ggI8NtrKIxtPU+5lfIgJ9P2mrfQH
        AJhY8CYBg4Ju/+c+79xl7CQhkYkJqV8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-RCQkLe4FOVCYQa0JoJ8LDA-1; Mon, 14 Nov 2022 03:19:48 -0500
X-MC-Unique: RCQkLe4FOVCYQa0JoJ8LDA-1
Received: by mail-ej1-f69.google.com with SMTP id qa14-20020a170907868e00b007ae24f77742so4960863ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Yxpc0+M0IPWKSXHEyC3cyneUXB0jkXapCGIc8Lc3oY=;
        b=bECJcnx0jqiwnXJ7bcB7gAufI0Y1cPzreH0ILCeQ4UuB7p1lL/5k6pbuLZpjQaPJxZ
         jAv2SEJifO5nQLwzJnTBTs3DGeooDzTnnJ7l+xfTrAm4RdwZOTCn8OCToOjPwJnvpv1X
         vg15In8Yj/sH4yZ7tc9PPZ0utZt/CZLhyLWvPu/BETxYxSyJda0MBP+vrJVs8KJzYk7E
         w4tgut21qLiIDdQSyxvkgFaYupuviRjAaKuKiIdRI7JZJ/oUDXntVmx+t4yQeF+Rojnk
         GL47SREvBh9JhJaM2lCTchBUklZLsoaQ+KN8XOGh3IgMOQsFMRG/P8kE+VQmgfkmzyXA
         e6XA==
X-Gm-Message-State: ANoB5pldnsHl7BwDAZXkOIsF55f4eGcHUjnEWL57z+ihsAfnsNlPOEIm
        Thc54Wm4GiGKs/KdWsZWrnHXZvx4m5eKw/jJnrVSl1/MmDO78WT0va4RN+2v7CxJ2y3GVzFHfj4
        w6w77N8RYPp26nPhjxom1mPUl
X-Received: by 2002:a17:906:5a6f:b0:7ad:8bd5:b7df with SMTP id my47-20020a1709065a6f00b007ad8bd5b7dfmr9198461ejc.57.1668413986798;
        Mon, 14 Nov 2022 00:19:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51p2NOcFiZ3Q4gnFIwqjGdYGaCfgTUB0YvTQf/RWWvsQXFVt45qefdd8RjE0Fo2ogYIQGtEA==
X-Received: by 2002:a17:906:5a6f:b0:7ad:8bd5:b7df with SMTP id my47-20020a1709065a6f00b007ad8bd5b7dfmr9198451ejc.57.1668413986549;
        Mon, 14 Nov 2022 00:19:46 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id o6-20020a170906768600b007a6c25819f1sm3897632ejm.145.2022.11.14.00.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:19:45 -0800 (PST)
Message-ID: <33ef1207-aad7-b7cd-61ac-327e9afb0699@redhat.com>
Date:   Mon, 14 Nov 2022 09:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: linux-next: manual merge of the drm-intel tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221114102327.6d53341e@canb.auug.org.au>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221114102327.6d53341e@canb.auug.org.au>
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

Hi,

On 11/14/22 00:23, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-intel tree got a conflict in:
> 
>   drivers/gpu/drm/i915/display/intel_backlight.c
> 
> between commit:
> 
>   b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
> 
> from Linus' tree and commit:
> 
>   801543b2593b ("drm/i915: stop including i915_irq.h from i915_trace.h")
> 
> from the drm-intel tree.

This is weird, because the:

   b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")

commit is in 6.1-rc1, so there can only be a conflict it 6.1-rc1 has not
been back-merged into drm-intel yet ?

Regards,

Hans

