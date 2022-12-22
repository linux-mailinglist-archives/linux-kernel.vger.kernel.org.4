Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5148965492F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLVXPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLVXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:14:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E0FD24
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:14:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F9ADB81F6E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E24C433EF;
        Thu, 22 Dec 2022 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671750893;
        bh=JA2bLvlEnV7mEWPSobqdn6WnIG1Hk0vKA9vXUhZr3r0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CmZ7q4WO0WV2j2CrZbQTU1MyVtB46zbwFfCmEE0gcJ2FYIX3EE8F8NweOSA5d62I4
         OWJrQWeRRoK5b8544OUZYaSUkcEwqhd4vouoYgbCoMR4+X4Exi1iV5jGU38QAQKAHt
         Je5eBnJgvRqnsaL/P7h8sGzeblmhexLBCvbVCIv0+d8/Udw0A40gJE3BXv7zA+lhf1
         TFdkd773qTpa8Jch8TL355+ESbXVqO6q+Nc1aZsMVCgxlw5eYjUBB5lE2lXVldPy4g
         Cnx/ev3Ix1Xdd4xdqndxGUVRGl7hHoKzoPxHZwQRlH5/SozEnCQYYe6IAGcDQxiQpq
         aKV+XNRPjJIRg==
Date:   Thu, 22 Dec 2022 15:14:50 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
cc:     "sstabellini@kernel.org" <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xen/pvcalls: free active map buffer on
 pvcalls_front_free_map
In-Reply-To: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>
Message-ID: <alpine.DEB.2.22.394.2212221514360.4079@ubuntu-linux-20-04-desktop>
References: <6a762ee32dd655cbb09a4aa0e2307e8919761311.1671531297.git.oleksii_moisieiev@epam.com>
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

On Tue, 20 Dec 2022, Oleksii Moisieiev wrote:
> Data buffer for active map is allocated in alloc_active_ring and freed
> in free_active_ring function, which is used only for the error
> cleanup. pvcalls_front_release is calling pvcalls_front_free_map which
> ends foreign access for this buffer, but doesn't free allocated pages.
> Call free_active_ring to clean all allocated resources.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/pvcalls-front.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index 1826e8e67125..9b569278788a 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -225,6 +225,8 @@ static irqreturn_t pvcalls_front_event_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void free_active_ring(struct sock_mapping *map);
> +
>  static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
>  				   struct sock_mapping *map)
>  {
> @@ -240,7 +242,7 @@ static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
>  	for (i = 0; i < (1 << PVCALLS_RING_ORDER); i++)
>  		gnttab_end_foreign_access(map->active.ring->ref[i], NULL);
>  	gnttab_end_foreign_access(map->active.ref, NULL);
> -	free_page((unsigned long)map->active.ring);
> +	free_active_ring(map);
>  
>  	kfree(map);
>  }
> -- 
> 2.25.1
> 
