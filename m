Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6F5BACD5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIPL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIPL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911FB37FA5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20B8C62B39
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C0C43142
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663329458;
        bh=4mAe95msSQk1H+17nLH8cwEk5y1qk5VEu4IIy8UaDa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6QPhiyg9IXbFuqFLDXgN+P1tpHp6w/wnaxSvuTy3k596sfMSPVyO5SIxdulHhQ6m
         lYtKfB/Cf5WDFmVsfOKhM8CcR9qNsz16L+9BxCvu4bOAGPgYhj+B3vQolsh58MhygI
         r1VBOyeDPwG9jbmPviGl0bPpu6ZKZvbpLI945/Um+8ZSU83ivWww5wmG4Se1x/SeqA
         TSZ6wtKQUBjN7ueYBxMqJdy2a/Hm2+EgY0J8X+CeTNqXlDc5Jt2cd8b6E3OqJB4fWa
         PPfWr5iLPngTKOgQ6mSPhN5Vj1ImY2vt3dPsD+p9brHvX6VGvexUUO/VECLn7ARPJm
         B3RIaFPKYhfEg==
Received: by mail-vs1-f52.google.com with SMTP id j7so17040279vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:57:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf0g4rZ5mDp9/ECDdCwNRGZeFiz0+OiYM+PbZHzFqRPkwAg4jw3i
        KP7awMDqjEKrPbucVinzIu4YVIl3VdvCcQ0hGw==
X-Google-Smtp-Source: AMsMyM5KW5eWL7Cqt5T0A2gzwu5JCELe579DpI/4acsgJ1Dh4ttemvDob7uKBCVevdtJkNDewsUUe9f+tsuuCBHwFRM=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr1767890vsi.85.1663329457398; Fri, 16
 Sep 2022 04:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220916094152.87137-1-j@jannau.net> <20220916094152.87137-4-j@jannau.net>
In-Reply-To: <20220916094152.87137-4-j@jannau.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Sep 2022 06:57:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWaYV7uJeJbaJSuHM+ud6f_eZ0_Kq_WwGg3uLDodUV3Q@mail.gmail.com>
Message-ID: <CAL_JsqKWaYV7uJeJbaJSuHM+ud6f_eZ0_Kq_WwGg3uLDodUV3Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iommu/io-pgtable: Add DART subpage protection support
To:     Janne Grunau <j@jannau.net>
Cc:     iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 4:43 AM Janne Grunau <j@jannau.net> wrote:
>
> From: Sven Peter <sven@svenpeter.dev>
>
> DART allows to only expose a subpage to the device. While this is an
> optional feature on the M1 DARTs the new ones present on the Pro/Max
> models require this field in every PTE.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - apply change to io-pgtable-dart.c
>
>  drivers/iommu/io-pgtable-dart.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
