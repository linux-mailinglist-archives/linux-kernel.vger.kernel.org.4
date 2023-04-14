Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8F6E238A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDNMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F511C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E54864519
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D6EC433D2;
        Fri, 14 Apr 2023 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681476165;
        bh=veX8rxjikr7K0ELmmZv5las5emvf9ZwQDdBp3M1mylI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgV+MHu6RBlZhoE7GcFYEPSWp54sOLzaovFtoCxHqgetaLaV/9z2O8E5mxonneJHv
         ABNdbkwCyO9z4uo7oz23JuomVmVDPRuttLYwyl8zOXgDI95ttBVmgXD2mKV8H089yS
         fWENmfFDafl23iwQlDGV8XBgtxi34KSCFwtZKzhAEqrWA83Pu/51MSnv3510bNh+z4
         d9uR6aVbxO2YSEdeBPXKMEQuOc+wBJburlezYM4ll4w3Egh3DU5ePlnRjcXD2BVA8G
         eLJtc1l6uDZo8C59SXmcuUssG7EwdVuW0dRsezD3HZaXeC4h9DP2WmZyFByMmpwDoG
         4XDXinTIvi0Qg==
Date:   Fri, 14 Apr 2023 13:42:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Geoff Blake <blakgeof@amazon.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com
Subject: Re: [PATCH] perf/arm-cmn: Fix DTC reset
Message-ID: <20230414124239.GA27611@willie-the-truck>
References: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com>
 <b2488619-a306-981c-1172-7efce749c10e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2488619-a306-981c-1172-7efce749c10e@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geoff,

On Thu, Apr 06, 2023 at 04:25:39PM -0500, Geoff Blake wrote:
> Ran this patch on an AWS C6g.metal and unfortunately still see the 
> spurious IRQs trigger quickly (within 10 tries) when using the following 
> flow:
> 
> perf stat -a -e arm_cmn_0/event=0x5,type=0x5/ -- sleep 600
> kexec -e 
> 
> Adding in the simple shutdown routine, I have run over 100 of the 
> above cycles and the spurious IRQs haven't triggered.  I think we still 
> need both for now.

Does that mean you're happy for me to queue this change as-is?

Will
