Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5C5F8ACE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJILIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJILIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:08:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004B29C8C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 04:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D1160B36
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC68C433C1;
        Sun,  9 Oct 2022 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665313691;
        bh=16d6kv40ojI7bColT0X9A2Alxf9DIIOwFKAPNQvY80Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wmu0c5pJbWT6qRl7oiu2V7ydwDJK5uZhRlACcvjtqsXDFR+GFMltU1BPxv13PvRDa
         ThSGoLrGODMDsGgeCytuKWDdSnVfO1fFSKoNQ74vU1FyDXiXez7zdYGYu/IipyHs8x
         jtZ9lFG2uoiMGyd86VnaNsryDIQEv9q7EEGqdt/cUiLimSsJK6BHYri+0m8D8xtZmo
         to7GSNJ0y2gNHRp3V7R1CEv6a5jl3OZgFdTzicEVaZs+U1raeFi2urJGzo5eCQGOVj
         FxnIKeaJDOJH7PqN6mymbsvn3H4YSs8RNPOsjmDAgiHD0EQ3Hr1jtmCvvqpIHu3lxO
         Vu3ZShQlW/nHw==
Received: by pali.im (Postfix)
        id 60DEB7C1; Sun,  9 Oct 2022 13:08:08 +0200 (CEST)
Date:   Sun, 9 Oct 2022 13:08:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fsl-pci: Choose PCI host bridge with alias pci0
 as the primary
Message-ID: <20221009110808.agfixtgneshui47o@pali>
References: <20220820123327.20551-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220820123327.20551-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! Any opinion on this patch?

On Saturday 20 August 2022 14:33:27 Pali Rohár wrote:
> If there's no PCI host bridge with ISA then check for PCI host bridge with
> alias "pci0" (first PCI host bridge) and if it exists then choose it as the
> primary PCI host bridge.
> 
> This makes choice of primary PCI host bridge more stable across boots and
> updates as the last fallback candidate for primary PCI host bridge (if
> there is no choice) is selected arbitrary.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/sysdev/fsl_pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 1011cfea2e32..e4b703943dd3 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1125,6 +1125,19 @@ void __init fsl_pci_assign_primary(void)
>  			return;
>  	}
>  
> +	/*
> +	 * If there's no PCI host bridge with ISA then check for
> +	 * PCI host bridge with alias "pci0" (first PCI host bridge).
> +	 */
> +	np = of_find_node_by_path("pci0");
> +	if (np && of_match_node(pci_ids, np) && of_device_is_available(np)) {
> +		fsl_pci_primary = np;
> +		of_node_put(np);
> +		return;
> +	}
> +	if (np)
> +		of_node_put(np);
> +
>  	/*
>  	 * If there's no PCI host bridge with ISA, arbitrarily
>  	 * designate one as primary.  This can go away once
> -- 
> 2.20.1
> 
