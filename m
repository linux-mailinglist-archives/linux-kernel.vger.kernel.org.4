Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A36812C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjA3OZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbjA3OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:24:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F841B74
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:23:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20BAFB811D8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D4C433A4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675088552;
        bh=Rv7vpedtXmMsC2ZldBorrpLV/hQ3cPb3cZwp/JPOZMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PU5fThWqx7vIQyvz3mb74830sa8egZGsH2qeMRCRy43qW6nOElB5Nb+7LguvkSUvv
         eIf/W6YzfJygJaSbS2P9Lz0XBYCRnIGQUIfcCD9aME9acc2v5mOAlrbBNIsC03gpFC
         nEDTuaPOwviKV6EF4rSqLFqLY881xSSX6A5UjmcfmZxo/73Gltjtq+szt9dSpiqeFq
         2Nb/PwncE1oGBgYKKaV3Iwb37qub0kNJ3ap4KDMUlMcx9wIXUycBGhRpccWySMxFmq
         RbHsmckF7gub26TuexrKXaaxwZiAjEOHlmzDQeUf60+HFVTv2MRP6QMrGw/AUrg0f9
         1PJcaH8dzXZcg==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4ff1fa82bbbso161346227b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:22:32 -0800 (PST)
X-Gm-Message-State: AO0yUKUK4KBfnCZ/8UBR37bY11qhsN1szflkk+CoPRGGOr1EuCCe1f4S
        TuiuwT6cF3tMjo3z1soOj1xcQQCBtq/cgumQDOI=
X-Google-Smtp-Source: AK7set/iKN4GPoJ3AAU9c4a2d2Iu3bNsL3i+70I4GSg0waYe1ZW2WThCeen4GZUVB6daPLK/wVYIgd144SKxmDFciPE=
X-Received: by 2002:a81:6007:0:b0:50f:9101:2eb4 with SMTP id
 u7-20020a816007000000b0050f91012eb4mr701547ywb.182.1675088551824; Mon, 30 Jan
 2023 06:22:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673978700.git.robin.murphy@arm.com> <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com> <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
 <Y9KRBRKdwSIRrvQw@nvidia.com> <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
 <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com> <Y9PxKLyQg/+ZrK6a@nvidia.com>
 <df59477f-3751-7314-40ab-9519dbfe0fe2@linux.intel.com> <14a5130c-3180-87db-5a14-2aaeaf97b7ce@arm.com>
 <Y9fL6gc4gZlQSzht@nvidia.com>
In-Reply-To: <Y9fL6gc4gZlQSzht@nvidia.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 30 Jan 2023 16:22:05 +0200
X-Gmail-Original-Message-ID: <CAFCwf135w+iVn2qiucNrgig+cj=+kQiSUwxMcBPVYVPp-doE5Q@mail.gmail.com>
Message-ID: <CAFCwf135w+iVn2qiucNrgig+cj=+kQiSUwxMcBPVYVPp-doE5Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 3:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Jan 30, 2023 at 01:49:20PM +0000, Robin Murphy wrote:
>
> > All in all, it's only actually the habanalabs ones that I'm slightly wary
> > of, since they're effectively (mis)using device_iommu_mapped() to infer the
> > DMA ops implementation, which could potentially go wrong (or at least *more*
> > wrong) on POWER with this change. I guess the saving grace is that
> > although
>
> IMHO habana is not using the DMA API abstraction properly. If it
> doesn't work on some archs is their bugs to deal with - we don't need
> to complexify the core code to tiptoe around around such an abuse in
> an obscure driver.
>
> Jason
Agreed, feel free to change the kapi as you see fit. Do the right
thing for the kernel.
In any case, we limit ourselves to x86-64 arch in the 6.3 merge cycle.

Oded
