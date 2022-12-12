Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493664978C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiLLBAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:00:04 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF70BC33;
        Sun, 11 Dec 2022 17:00:03 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id t62so9869132oib.12;
        Sun, 11 Dec 2022 17:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W35EUGtKuZIlx3Jt/4hZsEC7qcAbcwTqSE5lgDE03js=;
        b=N1C/4ETb8wKxU2mjmJlGFTD5YbGti5sV3RmhSQlXYnY7vgMjpMeDtY2AcLEQ4X7Zpg
         XPF8Szwe7OMdYcOBmNGWPddvaxC/b/ZfrDFwKXFulKcr3D+Ne342JoErjQqb67FN80u5
         kCT+7MMSbXr7PlfAVub5R8C0j+tn1vh/7PsxsNgNDPZS3FIW6L+IYPNFTs5dDfG7qgDD
         wfvcalhDPafx/eG63J0yCayhDiMGYzHXZvToM+OCJ1/AiNJxYReCErqwbqBW9ELwwVDR
         akV8V7D+lCWdIa6NvUJ/nZBdoXoRpuwEk0apd4/JIBWq+J/kebIU1I/6qG+Z2FjYJ27x
         2Fbg==
X-Gm-Message-State: ANoB5plemCK6lwTMNEgccWSVWaAy+iiFlMTQRgzyQBq0R4hyficwYrc3
        aKs1E2IFyCH0r3slhaa+JE6cq0EZmw==
X-Google-Smtp-Source: AA0mqf7iDzQBRpglkQy74NrkOv3Uki9vRPKEmJrScUsrQ2R8bGpDJcZdof0fC6mpXaDn8G07nB298w==
X-Received: by 2002:a05:6808:16a8:b0:35a:56f5:860d with SMTP id bb40-20020a05680816a800b0035a56f5860dmr7679587oib.38.1670806802751;
        Sun, 11 Dec 2022 17:00:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l8-20020aca1908000000b003546fada8f6sm3002004oii.12.2022.12.11.17.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 17:00:02 -0800 (PST)
Received: (nullmailer pid 4109402 invoked by uid 1000);
        Mon, 12 Dec 2022 01:00:01 -0000
Date:   Sun, 11 Dec 2022 19:00:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] of: overlay: fix null pointer dereferencing in
 find_dup_cset_node_entry() and find_dup_cset_prop()
Message-ID: <167080679960.4109328.1276719128104210210.robh@kernel.org>
References: <20221211023337.592266-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211023337.592266-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Dec 2022 10:33:37 +0800, ruanjinjie wrote:
> when kmalloc() fail to allocate memory in kasprintf(), fn_1 or fn_2 will
> be NULL, strcmp() will cause null pointer dereference.
> 
> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - not care return code, so check whether fn_1 or fn_2 is NULL in assigning node_path_match
> ---
>  drivers/of/overlay.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
