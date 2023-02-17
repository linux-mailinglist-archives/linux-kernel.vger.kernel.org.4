Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B069B497
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBQVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBQVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:21:28 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00AD5FC42;
        Fri, 17 Feb 2023 13:21:27 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1718b32f589so2302528fac.5;
        Fri, 17 Feb 2023 13:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wirRbKhf3MWwNROVpqqNHC4Xkahqi7SWsTs4Gn2w8d0=;
        b=nuw5KN8Nl1SP8TuYCwNVZwWzVMK3GUQjHxu1czi3fJer6/KHdm3rIAi4kKOt6cXNzd
         NOLQ2GEW0dyKjFZuSH0SJilkLhAYtD5or3gA2/D1wTA8ScLtOPL6OeV0fFlOnpTWtOki
         Y/cYXiS5J3U97Utlo7NH5l05Sw3Xey1fXUD9Q1/t2RCPxwVKEKpUcY+7yibX1etdv4G7
         zjmqZKG3kLwrNb0EQSL/1uhclbMxThjg4FWQCOHnxKwbl+S3NCFmcXDP8KTAPK4nwbI0
         fv82WZiRxZMntYDwkMWnOeiX+gKAFxGMazqfJUUpTjEuy3M2/m3pFC61PENpgwNqkZ+Z
         IFbg==
X-Gm-Message-State: AO0yUKVBXo0E2NlIL2nMe0x0AsKMBbmDdiw/6+cVqdWWEH//38AThFAR
        Xw5vNzbYKPDrAcJUhiU1Uw==
X-Google-Smtp-Source: AK7set9Q+FUV+z3tpeRWeGDUyrxrbP90b9GTSGKlVJHVimr2DphyVfenUBR97ZyHVoOENEFa9BRS0g==
X-Received: by 2002:a05:6870:3290:b0:16a:cfc:525e with SMTP id q16-20020a056870329000b0016a0cfc525emr7083386oac.23.1676668887149;
        Fri, 17 Feb 2023 13:21:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g1-20020a056870c38100b0016b0369f08fsm2093082oao.15.2023.02.17.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:21:23 -0800 (PST)
Received: (nullmailer pid 1583881 invoked by uid 1000);
        Fri, 17 Feb 2023 21:21:19 -0000
Date:   Fri, 17 Feb 2023 15:21:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Martin Liu <liumartin@google.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of: reserved_mem: Use proper binary prefix
Message-ID: <167666886188.1582566.4979581606494434424.robh@kernel.org>
References: <20230216083725.1244817-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216083725.1244817-1-geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2023 09:37:25 +0100, Geert Uytterhoeven wrote:
> The printed reserved memory information uses the non-standard "K"
> prefix, while all other printed values use proper binary prefixes.
> Fix this by using "Ki" instead.
> 
> While at it, drop the superfluous spaces inside the parentheses, to
> reduce printed line length.
> 
> Fixes: aeb9267eb6b1df99 ("of: reserved-mem: print out reserved-mem details during boot")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> K = Kelvin
> k = kilo
> Ki = kibi
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

