Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F36816E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbjA3Quq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjA3Quk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:50:40 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC77442C8;
        Mon, 30 Jan 2023 08:50:36 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id p185so10577376oif.2;
        Mon, 30 Jan 2023 08:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNHGc+FYLfWuI0WyP8cgi2QoONQjOUTwM6TUqLZs8f4=;
        b=3u+Uur5pykfJmGIRkOgRpgj1oa6+hhy7WBqhnePD6ct0NyWJSxJd8Ad+HpovVmg8JS
         WdW7y/V4gizL1EKPgE/4EYznxQLzWgBFCXo+iuNmq/y1hTyzZyBu1x5a/xLzgin99KwD
         0Zr5zMliq0XoKAWO6QVsQkpSmm0diuRpLv3vw1tymgZgu9K82hmwg1HMxbjtnnMXlwK2
         SzYTeGUhLyV5BQ2dw3UGlqe+DdgvfUqhCoiwLgqst89cg9nL5PEg0S7yRzXuFF+6o6Xg
         DAWZS05E5KeKVQ+608od0X0Ef+uiiBrmOOXQl6SZb4c/GLzvRRW979RQo5c6+anGoMe+
         t1tQ==
X-Gm-Message-State: AFqh2krXsVwrmaAFn9kjGWbCRaW+IFUxUWR5sMFfN2ljnVOyJOp94wpN
        gg0sJSj5Igv4DDK704Gu1w==
X-Google-Smtp-Source: AMrXdXti2G0mwexjQfuiuQB27g1A+0HBQf48DMV3lRqSFJr1OJsLGzadxFlqI5+H0l2a2gHK/KRN6g==
X-Received: by 2002:a05:6808:1495:b0:364:3de2:bfd1 with SMTP id e21-20020a056808149500b003643de2bfd1mr27752455oiw.32.1675097436054;
        Mon, 30 Jan 2023 08:50:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z11-20020aca330b000000b003458d346a60sm4899521oiz.25.2023.01.30.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:50:35 -0800 (PST)
Received: (nullmailer pid 2794298 invoked by uid 1000);
        Mon, 30 Jan 2023 16:50:34 -0000
Date:   Mon, 30 Jan 2023 10:50:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Erhard F." <erhard_f@mailbox.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3] of: Make of framebuffer devices unique
Message-ID: <167509742194.2793991.9757556857543301296.robh@kernel.org>
References: <20230120180958.30798-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120180958.30798-1-msuchanek@suse.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 19:09:57 +0100, Michal Suchanek wrote:
> Since Linux 5.19 this error is observed:
> 
> sysfs: cannot create duplicate filename '/devices/platform/of-display'
> 
> This is because multiple devices with the same name 'of-display' are
> created on the same bus.
> 
> Update the code to create numbered device names for the non-boot
> disaplay.
> 
> cc: linuxppc-dev@lists.ozlabs.org
> References: https://bugzilla.kernel.org/show_bug.cgi?id=216095
> Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v3:
> - merge fix into original patch
> - Update the device name format
> - add missing const
> - do not continue with iterating display devices when formatting device
>   name fails
> ---
>  drivers/of/platform.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Applied, thanks!
