Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8765CAE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbjADAcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbjADAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:32:28 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906817406;
        Tue,  3 Jan 2023 16:32:18 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id z10so10583254ilq.8;
        Tue, 03 Jan 2023 16:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0HWYpjQaX7ldH4mHs3NZWF3iU3LaK0CNwI61COw/5A=;
        b=Lmp3hv7/d1/pu+bmocwW5Iy7OMtNNGO+PTBcbL0H+qjKUKmFx2k4kmytcZWrADlUPF
         jJslExssTntHnhLNGHUUddFZfWRTpVzWA5Uewpbry/BnFEeomzFnCHQoR333vlQ9OOJA
         xMaK5ioESTyAGOSiF5aMNxha2+n5yKbLkXzgbtwJB/seFOAyCTJoMlzxs7jPFnJEcktq
         76ExLNnvsRbcUYl1epfF6gfoLXeZ1BqxCkXcWsvJ6tT5Me/Ulc10jHKg3T1kqAf+L6PX
         WLlhbq3tFKcJ0ef9vs7Q9sA+V8AdcDp/z908a7eIrbwonTPpig4EAzLmr6hVzzKxjx9C
         Q+9g==
X-Gm-Message-State: AFqh2krWliTvJCDZrUpPYMArdcXhKo+aPNo/hlJ0VX5XQtNqBnDf6vpw
        wIGhx5wv3+ztSLVZ0SzB9BPsmcLYRA==
X-Google-Smtp-Source: AMrXdXv5//+lPsQzSrlx9/riMtZNBAQmKumpjUxf4tuh8jnEtWHRr09lyIS0kEVtx0xDtI1icCA7rw==
X-Received: by 2002:a92:b703:0:b0:305:e3da:fae8 with SMTP id k3-20020a92b703000000b00305e3dafae8mr30732849ili.10.1672792337560;
        Tue, 03 Jan 2023 16:32:17 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t22-20020a02c496000000b00375192e7484sm10271937jam.90.2023.01.03.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:32:17 -0800 (PST)
Received: (nullmailer pid 147661 invoked by uid 1000);
        Wed, 04 Jan 2023 00:32:16 -0000
Date:   Tue, 3 Jan 2023 18:32:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] of: base: use strscpy() to instead of
 strncpy()
Message-ID: <167279233345.147541.3032747140502271485.robh@kernel.org>
References: <202212231039128402297@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212231039128402297@zte.com.cn>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 10:39:12 +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  drivers/of/base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
