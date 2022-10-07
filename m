Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A25F7EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJGUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJGUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245810047
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70EF461747
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 20:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E240FC433C1;
        Fri,  7 Oct 2022 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665174301;
        bh=+DBDu+TIZ0+ezgXh+xEGUEbnY9odLaY1vmGFN84T6wA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sHRX6GBnNB4GS4TxSGIU21ok/25B+7t7xqremaM++vDU6ZmYINhMkDQKNAwe61Q/P
         LcZNUlRWKJAxvcRm0fGNjXfmo5ldnudDe3YIl01/8p6iz/zj5S54/b2mC/9KUGhxVN
         kKgKV4hsz2tcU+uUttS76wS8sOEZvyC1iNVD7sqv2ODvuJHg2wJEkFo5rOK7L/YrEo
         qkdE0vangyGFPiVRCblU4R19pa/CtrIh+QMVx7hFMZfprXYKlimHZ+G14vn6xNjJOL
         zud5HjJUIL+DHPZFi53N6maMnCWmDO4fdxKmL8VuBto4XJAtptK2w2Hr1yq1aiV1zu
         dhl3vxW2hPGDw==
Date:   Fri, 7 Oct 2022 13:24:58 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen/virtio: Handle PCI devices which Host controller is
 described in DT
In-Reply-To: <014e7036-5daf-6465-663c-b690d6f719ee@suse.com>
Message-ID: <alpine.DEB.2.22.394.2210071324010.3690179@ubuntu-linux-20-04-desktop>
References: <20221006174804.2003029-1-olekstysh@gmail.com> <014e7036-5daf-6465-663c-b690d6f719ee@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022, Juergen Gross wrote:
> On 06.10.22 19:48, Oleksandr Tyshchenko wrote:
> > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > 
> > Use the same "xen-grant-dma" device concept (based on generic IOMMU
> > device-tree bindings) for the PCI devices behind device-tree based
> > PCI Host controller.
> > 
> > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > ---
> > Slightly RFC. This is needed to support Xen grant mappings for virtio-pci
> > devices
> > on Arm at some point in the future. The Xen toolstack side is not published
> > yet.
> > Here, for PCI devices we use the same way to pass backend domid to the guest
> > as for
> > platform devices.
> 
> I should mention we decided at the Xen Summit, that I will start a try to
> modify the virtio spec to include the backend id (domid in the Xen case)
> in the device independent config part.

Good idea


> As this will take some time to be accepted (if ever), other means to
> specify the backend domid are needed until then. DT is one possibility
> (at least on Arm), while Xenstore is the way to go for setups with a
> Xen toolstack.

What do you think of my idea of using PCI config registers on the *root
complex* (not the device) to retrieve the information?
