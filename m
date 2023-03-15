Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009B6BA456
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCOAwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCOAwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:52:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F7F56142
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:52:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23BE8B81C3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F320C4339E;
        Wed, 15 Mar 2023 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678841554;
        bh=Pj7Ygwt586tiLVuPtK5dRag7vRC7++AQFNCKq9Gy9z0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Et/kRuTBV+ZIKBtShCQa/at6oA3c4ZLqi1g7IHliizz5rWt5+NKQMh5QzCPLiv9D5
         4cQbXNX+csNZ+4gxgcCffiOW6NNDaaN+9RNVXvhlH7QB1evk+KXR4L2V9yUkOKilKi
         C5VTGk60gJqhqSqMYs6RQVZZjJ+wDiX/lJwOlj3ttkTkbSw8tP+BrTBXPgnKwVtQGw
         OX9lFe8xKwfZU8ncSIlSVhsrAYYFEnB/i8LRjUJgbUfP9w2ZEEUSMzL8bYpePOpgVA
         OhF72BjXyaZ9/dHjbY3SxG94as9Na2/0Nw6QFaRQGxCDBtg4fNVd1v9Lvg0MI9WS1z
         HQuXNH2rqyyKA==
Date:   Tue, 14 Mar 2023 17:52:30 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Jan Beulich <jbeulich@suse.com>
cc:     Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        Julia Zhang <julia.zhang@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [RFC PATCH 1/5] x86/xen: disable swiotlb for xen pvh
In-Reply-To: <ea0e3852-87ba-984b-4010-5eeac3d6c507@suse.com>
Message-ID: <alpine.DEB.2.22.394.2303141747350.863724@ubuntu-linux-20-04-desktop>
References: <20230312120157.452859-1-ray.huang@amd.com> <20230312120157.452859-2-ray.huang@amd.com> <ea0e3852-87ba-984b-4010-5eeac3d6c507@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023, Jan Beulich wrote:
> On 12.03.2023 13:01, Huang Rui wrote:
> > Xen PVH is the paravirtualized mode and takes advantage of hardware
> > virtualization support when possible. It will using the hardware IOMMU
> > support instead of xen-swiotlb, so disable swiotlb if current domain is
> > Xen PVH.
> 
> But the kernel has no way (yet) to drive the IOMMU, so how can it get
> away without resorting to swiotlb in certain cases (like I/O to an
> address-restricted device)?

I think Ray meant that, thanks to the IOMMU setup by Xen, there is no
need for swiotlb-xen in Dom0. Address translations are done by the IOMMU
so we can use guest physical addresses instead of machine addresses for
DMA. This is a similar case to Dom0 on ARM when the IOMMU is available
(see include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect, the corresponding
case is XENFEAT_not_direct_mapped).

Jurgen, what do you think? Would you rather make xen_swiotlb_detect
common between ARM and x86?
