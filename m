Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734496154DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKAWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKAWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE4193C6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 565BCB81D5E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D4EC433C1;
        Tue,  1 Nov 2022 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667341152;
        bh=v73XKO2dv2pQM4fjAlceJjzyyZMYGzwj0m0kkoHnX+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1jxn5yUzPeL4LWxwxAZASOqIIgRdDe9758utQluhnfNNyDSOfZu8ClF1k36FvoBA
         AYwU/qVpCCtDIAeDXetD+7ab0keCb2OJhuZJ5+B+jUwPmb9xdWa45bgKzt1PkhnTzn
         cXxVOuL208rThnbGHCJYalTQXS1R8Pp5Ll1r2zl9+6f9wPiuw7VxtkReUXpGmzg9fQ
         05+C6BwXSdgHrh8mNWhvgMC7RaXn2fPihP6MRQ52QRpfOPHYl21b10B/eBGRm5RfGE
         sIv7TFs7yR0K04zVXebQjfu76KvMh4d+q2KX+B8NuktGdK98j3NNm1FWNc3xho721l
         foIiJryaFhtfw==
Received: by pali.im (Postfix)
        id 2C3AB7F8; Tue,  1 Nov 2022 23:19:09 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:19:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fsl-pci: Choose PCI host bridge with alias pci0
 as the primary
Message-ID: <20221101221909.3u5ateevc7ka2ysv@pali>
References: <20220820123327.20551-1-pali@kernel.org>
 <20221009110808.agfixtgneshui47o@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009110808.agfixtgneshui47o@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I would like to remind this patch.

On Sunday 09 October 2022 13:08:08 Pali Rohár wrote:
> Hello! Any opinion on this patch?
> 
> On Saturday 20 August 2022 14:33:27 Pali Rohár wrote:
> > If there's no PCI host bridge with ISA then check for PCI host bridge with
> > alias "pci0" (first PCI host bridge) and if it exists then choose it as the
> > primary PCI host bridge.
> > 
> > This makes choice of primary PCI host bridge more stable across boots and
> > updates as the last fallback candidate for primary PCI host bridge (if
> > there is no choice) is selected arbitrary.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > index 1011cfea2e32..e4b703943dd3 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -1125,6 +1125,19 @@ void __init fsl_pci_assign_primary(void)
> >  			return;
> >  	}
> >  
> > +	/*
> > +	 * If there's no PCI host bridge with ISA then check for
> > +	 * PCI host bridge with alias "pci0" (first PCI host bridge).
> > +	 */
> > +	np = of_find_node_by_path("pci0");
> > +	if (np && of_match_node(pci_ids, np) && of_device_is_available(np)) {
> > +		fsl_pci_primary = np;
> > +		of_node_put(np);
> > +		return;
> > +	}
> > +	if (np)
> > +		of_node_put(np);
> > +
> >  	/*
> >  	 * If there's no PCI host bridge with ISA, arbitrarily
> >  	 * designate one as primary.  This can go away once
> > -- 
> > 2.20.1
> > 
