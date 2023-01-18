Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9F67231A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjARQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjARQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:26:02 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4914F4ED3D;
        Wed, 18 Jan 2023 08:24:42 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id s124so12227126oif.1;
        Wed, 18 Jan 2023 08:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLKcoDALgcZRRERyZiAG5jr/svh+5o9z/KSymkfcfvs=;
        b=C1hGUI/uW65ZvxYs9ceqYcb/1ra6vdiDlr7SICozdZ62aOyIRrBAIFYG9+g6gyn58S
         oCBPj+XRAnFWi/Dgr+fpo7I0dxQYyAskrUqbS3TrzaNVRBCQ0NZynF0De9UwqFNB6rG9
         FDwYbEJYUdgusUuDFAEiOot/rBzRaBvC9N+buYthDwyD/jcxLIKGIKwzILSd+eaYZb81
         bHbh6wPmoEdyelIZluw/pbQoTzHonSa+GHUgXQ7D3xJEryGl7kIXHouQClDvg5tnOjre
         5lSuduNV5i/MSx4TkhhIf0EejCGSChkRhlx5+hxjPVeIv/6cZ9TzirL09sURVMll1PDk
         QNfQ==
X-Gm-Message-State: AFqh2krwzO4bH7JjINNZW2Q7AnVL8mTaVwMoOcPwa3OJClX2JJm2t3ID
        t17/frUh0C9LwO3HtHSO5g==
X-Google-Smtp-Source: AMrXdXtm0y3C+j4QS0qnUyLJyugYaKfylubqxMyLMxyM4AMIqsUK/Uqdq/g4sL8kemFKghbIMFrHFw==
X-Received: by 2002:aca:b882:0:b0:35e:d30c:e918 with SMTP id i124-20020acab882000000b0035ed30ce918mr3131659oif.39.1674059081490;
        Wed, 18 Jan 2023 08:24:41 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id v2-20020a544d02000000b00364b516055bsm7641924oix.13.2023.01.18.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:24:41 -0800 (PST)
Received: (nullmailer pid 115499 invoked by uid 1000);
        Wed, 18 Jan 2023 16:24:40 -0000
Date:   Wed, 18 Jan 2023 10:24:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, "Erhard F ." <erhard_f@mailbox.org>
Subject: Re: [PATCH] of: Make of framebuffer devices unique
Message-ID: <167405907668.115378.12014688448945768358.robh@kernel.org>
References: <20230117165804.18036-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117165804.18036-1-msuchanek@suse.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jan 2023 17:58:04 +0100, Michal Suchanek wrote:
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
>  drivers/of/platform.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Applied, thanks!
