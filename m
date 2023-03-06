Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5E6ACD09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCFSuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCFSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:50:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745732CEA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3277361058
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99355C433A7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678128609;
        bh=cw4MV8nhP9uMJq9CJ23NV3cgqudora4kWu/txjBsI3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cEkmOOnvXhLbLazXfIZ00/n4XYJnPZnWq1w2GHKk1uIpn+Mwc9PPSKJbd+m2IJ60c
         O0+G7jl0UwS98d2baFNreCyo9aasoZL6qKchMJrWErwuvw9HBjiZDBwZ1RALz/aAnw
         4BU1s7YxLnf5OJwvBbiMXeuuuW0Iucf0IO2DU49niWv/a+nkiwa1pAzOu+n53m9kyK
         9om1eppN8gMxzZRDv2U9pG5zk7LgjpvG47wteJjoobixg8NwGoKHS5Ar1wtuO5Y2Gw
         LOoCJeFCNitd8ougwLHSBXX2InwFOHmts663hcple2ggafGFU8nH7Rt0z4sh1ac/40
         Dy7nCunhc+j/Q==
Received: by mail-ed1-f52.google.com with SMTP id ec29so11967625edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:50:09 -0800 (PST)
X-Gm-Message-State: AO0yUKXnvtCLI6+/7RBAT+D9Q8oW+0Sz1gAuDembCUmE28pTg7zRllbm
        OICMR5U9a8YDXm46v+YupaUr9iM1+7fl2z1ANtY=
X-Google-Smtp-Source: AK7set+UaPbEynbBrh3UGSmnCiCaBv5SW96OSLxKRVIp5XxUSeUCjpli5uTzFJE3TrT+rpVXfDhirUviv4fr07TrXDs=
X-Received: by 2002:a50:d581:0:b0:4bf:7914:98c5 with SMTP id
 v1-20020a50d581000000b004bf791498c5mr6451214edi.4.1678128607845; Mon, 06 Mar
 2023 10:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20220904214134.408619-1-jim.cromie@gmail.com> <20220904214134.408619-33-jim.cromie@gmail.com>
In-Reply-To: <20220904214134.408619-33-jim.cromie@gmail.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Mon, 6 Mar 2023 12:49:30 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXHGW1iceWgB47wSUhG_hYA48JWtOPRrVRnL-EvRCxhBA@mail.gmail.com>
Message-ID: <CAOZdJXXHGW1iceWgB47wSUhG_hYA48JWtOPRrVRnL-EvRCxhBA@mail.gmail.com>
Subject: Re: [PATCH v6 32/57] nouveau: adapt NV_DEBUG, NV_ATOMIC to use DRM.debug
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, linux@rasmusvillemoes.dk,
        seanpaul@chromium.org, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 4:48 PM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> These 2 macros used drm_debug_enabled() on DRM_UT_{DRIVER,ATOMIC}
> respectively, replace those with drm_dbg_##cat invocations.
>
> this results in new class'd prdbg callsites:
>
> :#> grep nouveau /proc/dynamic_debug/control | grep class | wc
>     116    1130   15584
> :#> grep nouveau /proc/dynamic_debug/control | grep class | grep DRIVER | wc
>      74     704    9709
> :#> grep nouveau /proc/dynamic_debug/control | grep class | grep ATOMIC | wc
>      31     307    4237
> :#> grep nouveau /proc/dynamic_debug/control | grep class | grep KMS | wc
>      11     119    1638
>
> the KMS entries are due to existing uses of drm_dbg_kms().
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Has this patch set been forgotten?  It was posted six months ago and
there's no sign that it was picked up.

The changes to drm_debug_enabled have impacted NV_DEBUG and NV_ATOMIC
and something needs to be fixed.  I posted a simpler patch a few weeks
ago, but maybe Jim's is better.
