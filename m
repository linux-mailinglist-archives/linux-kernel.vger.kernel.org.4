Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526DE62FEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKRUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKRUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:46:44 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347AE6205A;
        Fri, 18 Nov 2022 12:46:44 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id l127so6613294oia.8;
        Fri, 18 Nov 2022 12:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3na0c+zCdiHpYsiS/hKe8VnK8EaiIE0atU3Cp6vqK8=;
        b=EZJGh3pERaS0dPM2mNqSU1Otc4q3hmAOtAGESfEhg5dy5meAnCC68obisZ8R7xeDM0
         M8y4N6EOGfLtGFtLhD7Wt9VT22mIlLouNp0S0RphmG/fTHWPvmFlLIN1qMUde75OrNcU
         CnQ8OpmO019NDz3C3YKrV6zPntCiJ9YNqun+MCCAK/zW8LTiia/Dv4eDdpzRs1yXt7Sv
         GLhImW9gZX0Zga83Y+9FB9SU0l4lhbdgTCAe54d6tMhLC4bdv3qA7DNmXQ6tfHGDMDm6
         zDfDJPSHFCB+WW3EHzhUkt5pJqFWYgU1N0qA/ZWSNHHgpKMdkV9VJXdpEOvmU/Kkd20U
         vXJg==
X-Gm-Message-State: ANoB5pnAzVtwdbaY2sX4DBQoHSs86w56m4DUdINAZOv1r+4kD4dIFh7x
        J+2ErlZfwlZ7PZPp9wazpw==
X-Google-Smtp-Source: AA0mqf77Kvv76+2dRDE7XcyDrmAFDyRj4QvQ7OTBZ2bM59km+E8GbCkPFq9ssjIV4GX905G9Eziucw==
X-Received: by 2002:a54:4596:0:b0:359:fea2:69d0 with SMTP id z22-20020a544596000000b00359fea269d0mr4245868oib.45.1668804403417;
        Fri, 18 Nov 2022 12:46:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k9-20020a544409000000b00359b83e3df1sm1814919oiw.9.2022.11.18.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:46:42 -0800 (PST)
Received: (nullmailer pid 1327692 invoked by uid 1000);
        Fri, 18 Nov 2022 20:46:44 -0000
Date:   Fri, 18 Nov 2022 14:46:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Cleanup DT Overlay intermediate files as
 appropriate
Message-ID: <20221118204644.GA1327355-robh@kernel.org>
References: <20221114205939.27994-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114205939.27994-1-afd@ti.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 02:59:39PM -0600, Andrew Davis wrote:
> %.dtbo.o and %.dtbo.S files are used to build-in DT Overlay. They should
> should not be removed by Make or the kernel will be needlessly rebuilt.
> 
> These should be removed by "clean" and ignored by git like other
> intermediate files.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .gitignore             | 1 +
>  Makefile               | 4 +++-
>  scripts/Makefile.build | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)

Applied, thanks!
