Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF965F336E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJCQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJCQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:24:13 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325D1CB3E;
        Mon,  3 Oct 2022 09:24:13 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id g130so11758744oia.13;
        Mon, 03 Oct 2022 09:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xm6T6u54O2R9F7vYSZ9lG+CxOS8xX4jm0KQIA5Ujrr0=;
        b=P5zTYSyqo+aw/k4TVEmG+XgdRcaBEZMnsJcc43Q+O+MEhyya6NbEoCgZiIcBCF68Zb
         bbAOjoW0h5ja5XLBngZORaxKexIadEun9tmp9Eopwc0MZ3+OWimGioWW77TdgLN6G+0x
         q1IldlipkNzRp0FRHslswtcfE7aELkeRGK/8BAKKYtnSHDVwzL8VvKBBDv+1JgQvymQs
         HRVT7tfhTxT/Eism+QpJWgpRy8bucOEMtN4g74N/wGPexyFGBSdYA8+pysbsjpah/N3V
         WhWxGPnkx2h3WWyWID2euVKcwDBPtXvY0Y7yyYbX+tY4fKKfu5QnMTZOjHHEK3Zw78Z8
         1Caw==
X-Gm-Message-State: ACrzQf0VvBC2cQEprrfJI3Dp9//xAVJvCI0wzjngvW3WLYAclC2O1hHr
        WufLH5FLR3/OkQG+ALMwUQ==
X-Google-Smtp-Source: AMsMyM5nYebcrbETBFGmwbJpgUVwD2dOcH1C1UW+QEwHFCygbzFatTj6c/y19d/58+E4oHJDLDID5w==
X-Received: by 2002:aca:5b0a:0:b0:34f:eeab:b853 with SMTP id p10-20020aca5b0a000000b0034feeabb853mr4461049oib.182.1664814252475;
        Mon, 03 Oct 2022 09:24:12 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i8-20020a056870890800b001328ce69d36sm403463oao.9.2022.10.03.09.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:24:12 -0700 (PDT)
Received: (nullmailer pid 2406847 invoked by uid 1000);
        Mon, 03 Oct 2022 16:24:11 -0000
Date:   Mon, 3 Oct 2022 11:24:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: base: Shift refcount decrement in
 of_find_last_cache_level()
Message-ID: <166481423257.2406482.16532672531113101637.robh@kernel.org>
References: <20220930144936.2882481-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930144936.2882481-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 16:49:36 +0200, Pierre Gondois wrote:
> Currently, of_find_next_cache_node() and of_property_read_u32()
> are called on objects after their refcount have been decremented.
> Re-order the calls to decrement the refcount after the function
> calls.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/of/base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
