Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01872A9F1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjFJHfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjFJHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974035BB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 00:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 748C661135
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC69C4339B;
        Sat, 10 Jun 2023 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686382524;
        bh=pfP6hF5eB6pavsu9cEBqpKwYLlpSSxHWXvcOTt1FRm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYJk0F97LxoWrI0+Y7fbINbigv9JctuB04yEW99SkI1H+gBPTOBczdnN3+waRjc2v
         b+dNoq9d+KDncGhSpbxZfHxKlbPK04NSZWoYTyQZz8E/PwcdabRZ5OtspH0ZvCksX2
         TkIpCUgIkZ1I3b+T/3YoIsH+TCUiBDMxtOeoWM3ySSepheYY/seOpV0m3wNzcd0YJe
         bqSQ9S3TpD9IKQ9kOFjXjtsSMhZfjqjuO1gcoF4M6/Md2wrYAB768HkvE4iuuUxu8z
         8fkH0Sm4z48P4I5dlApgrQ6g7B4WmrAszXtJ072+RPhYLgVSu5CH5+k9vnNw/LLAJE
         Ggd3VNC7mKBRQ==
Received: by pali.im (Postfix)
        id 8C1616EB; Sat, 10 Jun 2023 09:35:21 +0200 (CEST)
Date:   Sat, 10 Jun 2023 09:35:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Fix PCIe MEM size for pci2
 node
Message-ID: <20230610073521.prpxivjcwtcfwl3u@pali>
References: <20230505172818.18416-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230505172818.18416-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2023 19:28:18 Pali Rohár wrote:
> Freescale PCIe controllers on their PCIe Root Ports do not have any
> mappable PCI BAR allocate from PCIe MEM.
> 
> Information about 1MB window on BAR0 of PCIe Root Port was misleading
> because Freescale PCIe controllers have at BAR0 position different register
> PEXCSRBAR, and kernel correctly skipts BAR0 for these Freescale PCIe Root
> Ports.
> 
> So update comment about P2020 PCIe Root Port and decrease PCIe MEM size
> required for PCIe controller (pci2 node) on which is on-board xHCI
> controller.
> 
> lspci confirms that on P2020 PCIe Root Port is no PCI BAR and /proc/iomem
> sees that only c0000000-c000ffff and c0010000-c0011fff ranges are used.
> 
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/boot/dts/turris1x.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> index 6612160c19d5..dff1ea074d9d 100644
> --- a/arch/powerpc/boot/dts/turris1x.dts
> +++ b/arch/powerpc/boot/dts/turris1x.dts
> @@ -476,12 +476,12 @@
>  		 * channel 1 (but only USB 2.0 subset) to USB 2.0 pins on mPCIe
>  		 * slot 1 (CN5), channels 2 and 3 to connector P600.
>  		 *
> -		 * P2020 PCIe Root Port uses 1MB of PCIe MEM and xHCI controller
> +		 * P2020 PCIe Root Port does not use PCIe MEM and xHCI controller
>  		 * uses 64kB + 8kB of PCIe MEM. No PCIe IO is used or required.
> -		 * So allocate 2MB of PCIe MEM for this PCIe bus.
> +		 * So allocate 128kB of PCIe MEM for this PCIe bus.
>  		 */
>  		reg = <0 0xffe08000 0 0x1000>;
> -		ranges = <0x02000000 0x0 0xc0000000 0 0xc0000000 0x0 0x00200000>, /* MEM */
> +		ranges = <0x02000000 0x0 0xc0000000 0 0xc0000000 0x0 0x00020000>, /* MEM */
>  			 <0x01000000 0x0 0x00000000 0 0xffc20000 0x0 0x00010000>; /* IO */
>  
>  		pcie@0 {
> -- 
> 2.20.1
> 

PING?
