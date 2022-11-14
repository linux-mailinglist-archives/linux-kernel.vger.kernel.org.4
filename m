Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA30628B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiKNVqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiKNVqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:46:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093C1172
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6A2FB8125E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 21:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6205C433C1;
        Mon, 14 Nov 2022 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668462388;
        bh=3GcDEeuAk8O0S4B39cMYJDrzzSSOnKsFT6Us8olDuog=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YhfZhiXiFPyGeRmLe/OXyNCUV8TvuuWqiBCs3J7yH7Oc1Yjd/gIKdMmSn2Nupxgvz
         DCl9T7T2TSpXN3jrHxIMGdwwYOkWgLFB7LEBvpRScZeORCBlQ02Ujj9rt/Vtb4UTPM
         jLQenLb1EeFmT5CWrRvbc9IRPesgzYVAVS4pywy9165frNmXuQwcgDV+KdlAZPmLYW
         0J0MehT5fKp1cZxr3mh/7hpbaIvZcd1PF+4CJVBwyHKqRWgSJNmYCi33cKK6RDtALH
         7DQf7QXp+i/vL4wqXZhmcpah9r9rk91LI8JcBkqSld45Pgd9k9mgGe3Tllk9q26tMF
         aiHO83c1+INTw==
Date:   Mon, 14 Nov 2022 13:46:26 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH] xen/platform-pci: use define instead of literal number
In-Reply-To: <20221114142348.1499-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2211141346200.4020@ubuntu-linux-20-04-desktop>
References: <20221114142348.1499-1-jgross@suse.com>
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

On Mon, 14 Nov 2022, Juergen Gross wrote:
> Instead of "0x01" use the HVM_PARAM_CALLBACK_TYPE_PCI_INTX define from
> the interface header in get_callback_via().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/platform-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
> index 18f0ed8b1f93..24a3de1b7b03 100644
> --- a/drivers/xen/platform-pci.c
> +++ b/drivers/xen/platform-pci.c
> @@ -54,7 +54,8 @@ static uint64_t get_callback_via(struct pci_dev *pdev)
>  	pin = pdev->pin;
>  
>  	/* We don't know the GSI. Specify the PCI INTx line instead. */
> -	return ((uint64_t)0x01 << HVM_CALLBACK_VIA_TYPE_SHIFT) | /* PCI INTx identifier */
> +	return ((uint64_t)HVM_PARAM_CALLBACK_TYPE_PCI_INTX <<
> +			  HVM_CALLBACK_VIA_TYPE_SHIFT) |
>  		((uint64_t)pci_domain_nr(pdev->bus) << 32) |
>  		((uint64_t)pdev->bus->number << 16) |
>  		((uint64_t)(pdev->devfn & 0xff) << 8) |
> -- 
> 2.35.3
> 
