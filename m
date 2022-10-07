Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C865F7239
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiJGAXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJGAXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9623FC510A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D41861921
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5011DC433C1;
        Fri,  7 Oct 2022 00:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102217;
        bh=Et26OS3EyRmy77qPfsgsF4rcn/zFt1wMAuvka68v87U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HqwJ3XEQ4nYbxIa9HgoA/a7H7BKi8YZZgdoGyWU0p1t3yobUxFminM/Nmzhx7DtWE
         g4/UdyCL2b9YXIq1ufshqRbgzCmpCujqe7CRjCh91WSJLx7henkuE10iQE7vtgo6dY
         zXDO45zb0YclllssCxvKoeyufx+tocHyVs+cx5lHeQDZFeRQQemgF3IhCiEVamV9eb
         30YVr2Fmf1Z5khqxrznRy+C9swz/2Uk6a+pB/9IU/kZEA5U0wrm3KfX3vE/FqKy2dN
         m4Wu2Qgb5t2q7Loz10eQPfMmSYbNs4gVT67zOGi6UmnKvwcr1VkpAQAojRkD2jRt1o
         qzNf6xBnqQqUg==
Date:   Thu, 6 Oct 2022 17:23:34 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
cc:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 1/3] xen/virtio: restructure xen grant dma setup
In-Reply-To: <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>
Message-ID: <alpine.DEB.2.22.394.2210061723240.3690179@ubuntu-linux-20-04-desktop>
References: <20221006071500.15689-1-jgross@suse.com> <20221006071500.15689-2-jgross@suse.com> <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>
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

On Thu, 6 Oct 2022, Oleksandr Tyshchenko wrote:
> On 06.10.22 10:14, Juergen Gross wrote:
> 
> Hello Juergen
> 
> > In order to prepare supporting other means than device tree for
> > setting up virtio devices under Xen, restructure the functions
> > xen_is_grant_dma_device() and xen_grant_setup_dma_ops() a little bit.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> 
> Patch looks good,
> 
> one NIT, xen_dt_grant_setup_dma_ops() down the code doesn't actually 
> setup DMA OPS, it retrieves the backend domid via device-tree means and 
> stores it,
> 
> so I would rename to it, maybe something like 
> xen_dt_grant_setup_backend_domid() or xen_dt_grant_init_backend_domid(), 
> but I am not sure it would be good alternative.
> 
> 
> So, w/ or w/o renaming:
> 
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> also
> 
> Tested-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> # Arm64 
> only

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
