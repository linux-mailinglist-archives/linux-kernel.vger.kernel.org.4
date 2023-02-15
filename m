Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D09698320
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBOSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBOSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:19:43 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA563D0A6;
        Wed, 15 Feb 2023 10:19:40 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-15ff0a1f735so23998192fac.5;
        Wed, 15 Feb 2023 10:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE3bZwYvRZ9vZ2sZGPPI0jZ9KCx2bLE2oeTqnxWuJfE=;
        b=k6r9hAIpg6tK0+93XBqoFhOI1uhZjlX12EXxdcN0hv5ovcm2XwGc7zdGq9s9XQlcBg
         /jdGVyE0H4QVsPx0IBx990U8yqcAESAPumA4ysKEBwqXse4ERa34DWUPVUI4xxnFZDoL
         yULRXdClYuRBeCfNkD6egEHujKQ5Lq0kaQUO1HpMOIjulxbO2zswbry/ifig1dnQ2UHN
         K1fqTk2rkS4q7g3oafuz7qzwhsTu+2VUYGz7+/MgbMXtGEvc2wSSok6aITtkppPdprLd
         xVTHg0GEx/bATBliiMT11Qwglp/IwHqsnl2TAfIVGjYBbobNj16PcCURBB8cQCJFhMXH
         +mvw==
X-Gm-Message-State: AO0yUKUzay7GlxYGZZ/lDE3n6veIT4y/d3Y5YqdVPMQ6yrsMWZvmHM63
        LlS20ZsAZkfi7y9h9eQMog==
X-Google-Smtp-Source: AK7set+ItU1zXRenXaIv0FMCzO0TSaDHveO8pQSBbjEaJ8p2Toawksq/I3vNSxMaID07VGKV01Vevw==
X-Received: by 2002:a05:6870:350d:b0:16e:fd1:80b1 with SMTP id k13-20020a056870350d00b0016e0fd180b1mr1623112oah.29.1676485179431;
        Wed, 15 Feb 2023 10:19:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y10-20020a056870b00a00b0014866eb34cesm7093116oae.48.2023.02.15.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:19:39 -0800 (PST)
Received: (nullmailer pid 362117 invoked by uid 1000);
        Wed, 15 Feb 2023 18:19:38 -0000
Date:   Wed, 15 Feb 2023 12:19:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Liu <liumartin@google.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        minchan@kernel.org, tkjos@google.com, linux-kernel@vger.kernel.org,
        surenb@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v2] of: reserved-mem: print out reserved-mem details
 during boot
Message-ID: <167648517621.362040.7176595866897785827.robh@kernel.org>
References: <20230209160954.1471909-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209160954.1471909-1-liumartin@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Feb 2023 00:09:55 +0800, Martin Liu wrote:
> It's important to know reserved-mem information in mobile world
> since reserved memory via device tree keeps increased in platform
> (e.g., 45% in our platform). Therefore, it's crucial to know the
> reserved memory sizes breakdown for the memory accounting.
> 
> This patch prints out reserved memory details during boot to make
> them visible.
> 
> Below is an example output:
> 
> [    0.000000] OF: reserved mem: 0x00000009f9400000..0x00000009fb3fffff ( 32768 KB ) map reusable test1
> [    0.000000] OF: reserved mem: 0x00000000ffdf0000..0x00000000ffffffff ( 2112 KB ) map non-reusable test2
> [    0.000000] OF: reserved mem: 0x0000000091000000..0x00000000912fffff ( 3072 KB ) nomap non-reusable test3
> 
> Signed-off-by: Martin Liu <liumartin@google.com>
> ---
> Changes in V2:
> -- instead of using debugfs, just print them out during boot
> 
>  drivers/of/of_reserved_mem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Applied, thanks!

