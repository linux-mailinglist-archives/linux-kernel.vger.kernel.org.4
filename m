Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D376F0D93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjD0VEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbjD0VEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:04:25 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD0213A;
        Thu, 27 Apr 2023 14:04:19 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-18f16bb1a9bso6992218fac.1;
        Thu, 27 Apr 2023 14:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629459; x=1685221459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7iFliujUSkel6mL8gHDSSVDhGL8j5l+idukWslg6ZU=;
        b=OdCfcKSTrmcEiVsz4T10Vs0pDyj/sfJrv5QfOTjUodhN96qVLeNwK3LpgpT33UT868
         plMY3NNnRxi6X/naS9BlrH4/YtPa5jspbn+MOIDxDLPqKB/NkFBA8+34qEQ5qvsjB6nC
         KnMQ2RXNkTutnGgXY+a/KrpZY5sVhgCIgzoMj6ZUHit3PivRKZG+8wjGnO/RFk8KGt+0
         y718j4RgdUyi8gHFkOhCNmutCkak5sgTCsbqeX2wFAjso/lhwvxiCRA/07+mLOW3MB90
         /7rQT1QVW6yywXuJ7UBIN0AEy7PnCo+vOk0xXEVtwX7E7TOz0eEJZo7nDeK5pAg8eDo5
         ckkA==
X-Gm-Message-State: AC+VfDzgaO6GufNCFo6f/CfOusWJPxSKUE6GSD+EuC1fnL6C3OMrj669
        XsNHj67WqWpvyIMlkdzYuA==
X-Google-Smtp-Source: ACHHUZ4wTFSImmRssQrZ4PnbGSQf+qWZtCP0hXDPeYZT+0kKmU67xeci9GANGGKB7AUUIraxz9LhTQ==
X-Received: by 2002:a05:6871:6b8a:b0:176:9fbe:fe02 with SMTP id zh10-20020a0568716b8a00b001769fbefe02mr1603936oab.8.1682629459102;
        Thu, 27 Apr 2023 14:04:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy14-20020a056870c78e00b0017197629658sm8035605oab.56.2023.04.27.14.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 14:04:18 -0700 (PDT)
Received: (nullmailer pid 3518678 invoked by uid 1000);
        Thu, 27 Apr 2023 21:04:17 -0000
Date:   Thu, 27 Apr 2023 16:04:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com,
        devicetree@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        martin.blumenstingl@googlemail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-amlogic@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, jbrunet@baylibre.com,
        stefan@agner.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] of: fdt: Scan /memreserve/ last
Message-ID: <168262872454.3491083.6407810340850053636.robh@kernel.org>
References: <20230424113846.46382-1-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424113846.46382-1-tanure@linux.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2023 12:38:46 +0100, Lucas Tanure wrote:
> Change the scanning /memreserve/ and /reserved-memory node order to fix
> Kernel panic on Khadas Vim3 Board.
> 
> If /memreserve/ goes first, the memory is reserved, but nomap can't be
> applied to the region. So the memory won't be used by Linux, but it is
> still present in the linear map as normal memory, which allows
> speculation. Legitimate access to adjacent pages will cause the CPU
> to end up prefetching into them leading to Kernel panic.
> 
> So /reserved-memory node should go first, as it has a more updated
> description of the memory regions and can apply flags, like nomap.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>i
> ---
> Previous Threads:
> #regzbot link: https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@agner.ch/#regzbot
> #regzbot link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/

Note that this should have been a 'Link:' entry in the commit message 
for regzbot. I added it.

> 
> V1: https://lore.kernel.org/all/20230406151429.524591-1-tanure@linux.com/
> v2: https://lore.kernel.org/all/20230410120017.41664-1-tanure@linux.com/
> v3: https://lore.kernel.org/linux-mm/20230412224620.8909-1-tanure@linux.com/T/
> 
> Change from V3:
>  - Drop cover letter
>  - Add more information into the patch
> 
> Change from V2:
>  - Remove region overlap and reserved checks
> 
> Change from V1:
>  - Instead of allowing to mark nomap a region already reserved, give
> precedence to /reserved-memory node scan.
> ---
>  drivers/of/fdt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks!

Going to let this sit in linux-next for a bit. I also didn't tag for 
stable kernels. I want it to get some exposure in mainline at least for 
a few -rc releases rather than getting backported right away. Please 
help ensure that happens if you see stable review emails. I'm going to 
be offline most of the next month.

Rob

