Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ACC681D07
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjA3Vn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjA3Vn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:43:27 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CAFF1C;
        Mon, 30 Jan 2023 13:43:20 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so1890298otj.4;
        Mon, 30 Jan 2023 13:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SejxQqdFgMkhj6Xj4Gy/52IxSsmOXAM8Ok+nGPQVBI=;
        b=ZBPZbisc5Ou6YKOHhSvg9qEjcXqxn7gOpxlztZH8bcAwnQNhZraN9sibv433lP5iAs
         nY5jfmQ8KmpFrNK+h8uAJgKpAQI10pDbY5CqxUjrccwpvfqnKv6GemcGA8ePXAv3tF3Z
         LwIVPOceyQW0W7nDln/+bjmdi3j2FXLJ1K4LMFULwq5h2wxghQIf+AAY+KSRRIQcGPeK
         0frPQMtuguNO+dCmUFg1hRt5cXEARifTN8ZemO9sR5l88S/q6QmdyMvDVeOXT1F+QwU9
         b8rlGbAbgbwUW8Dc/KDRBP9V3x9vJgeAlfeMFfs1Udw+ufuJuzsvO1TkNTGxZsprTEXv
         jyjg==
X-Gm-Message-State: AO0yUKUXl0mUyjTQ8I3zzpy22hrgFd5JaMDXmfYGoimaBCjpAb/HIcle
        hafN9zs1AE+x923bL9extQ==
X-Google-Smtp-Source: AK7set+Zq4Zg9iwgDcwGz6H3CDNxFCGs9k7j0KgtqNRnUgu9UcLA6H/1SgxLFO7Fsy+N/+OIzsvkwA==
X-Received: by 2002:a9d:822:0:b0:68b:c9a2:4d79 with SMTP id 31-20020a9d0822000000b0068bc9a24d79mr4492277oty.33.1675115000207;
        Mon, 30 Jan 2023 13:43:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 31-20020a9d0622000000b0068bb1b235f1sm4418585otn.76.2023.01.30.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:43:19 -0800 (PST)
Received: (nullmailer pid 3580713 invoked by uid 1000);
        Mon, 30 Jan 2023 21:43:19 -0000
Date:   Mon, 30 Jan 2023 15:43:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        993612@bugs.debian.org,
        Luca Di Stefano <luca.distefano@linaro.org>,
        stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of/address: Return an error when no valid dma-ranges
 are found
Message-ID: <167511499566.3580584.7454212476889148702.robh@kernel.org>
References: <20230126-synquacer-boot-v2-1-cb80fd23c4e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126-synquacer-boot-v2-1-cb80fd23c4e2@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Jan 2023 17:47:50 +0000, Mark Brown wrote:
> Commit 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
> converted the parsing of dma-range properties to use code shared with the
> PCI range parser. The intent was to introduce no functional changes however
> in the case where we fail to translate the first resource instead of
> returning -EINVAL the new code we return 0. Restore the previous behaviour
> by returning an error if we find no valid ranges, the original code only
> handled the first range but subsequently support for parsing all supplied
> ranges was added.
> 
> This avoids confusing code using the parsed ranges which doesn't expect to
> successfully parse ranges but have only a list terminator returned, this
> fixes breakage with so far as I can tell all DMA for on SoC devices on the
> Socionext Synquacer platform which has a firmware supplied DT. A bisect
> identified the original conversion as triggering the issues there.
> 
> Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Luca Di Stefano <luca.distefano@linaro.org>
> Cc: 993612@bugs.debian.org
> Cc: stable@kernel.org
> ---
> Changes in v2:
> - Don't leak parsed resources.
> - Link to v1: https://lore.kernel.org/r/20230126-synquacer-boot-v1-1-94ed0eb1011f@kernel.org
> ---
>  drivers/of/address.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 

Applied, thanks!
