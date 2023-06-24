Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0543473C533
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFXAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FA1AC;
        Fri, 23 Jun 2023 17:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE6D6146A;
        Sat, 24 Jun 2023 00:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47185C433C8;
        Sat, 24 Jun 2023 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687567248;
        bh=tVg5s9VJqtFDSCB4yf/yVZmsm6c9AOFNIJmymZLmQXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2qp1uOot+UAgUcb76qH1ad157/Hycte5aC0DoRw2TJHQYoKtbkg8eXZUTAZHsJUj7
         AuxEbij+raRz67arMMpNbuOOf59d30MNdX2GBpsASw1bVgEDP0sawF2CB12dn6miqR
         heDOOOryHpBmd8PqehNqIjKVWuY/v7Q74uo+VaZU=
Date:   Fri, 23 Jun 2023 17:40:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     "Yajun Deng" <yajun.deng@linux.dev>,
        "Christoph Hellwig" <hch@lst.de>, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de,
        peterz@infradead.org, rdunlap@infradead.org, kim.phillips@amd.com,
        rostedt@goodmis.org, thunder.leizhen@huawei.com, ardb@kernel.org,
        bhe@redhat.com, anshuman.khandual@arm.com,
        song.bao.hua@hisilicon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Barry Song <baohua@kernel.org>
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Message-Id: <20230623174046.66ce934bcf5c1303003a5afc@linux-foundation.org>
In-Reply-To: <20230515133821.769158bb@meshulam.tesarici.cz>
References: <20230515094955.GB23880@lst.de>
        <20230512094210.141540-1-yajun.deng@linux.dev>
        <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
        <20230515133821.769158bb@meshulam.tesarici.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 13:38:21 +0200 Petr Tesařík <petr@tesarici.cz> wrote:

> On Mon, 15 May 2023 11:23:27 +0000
> "Yajun Deng" <yajun.deng@linux.dev> wrote:
> 
> > May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
> > 
> > > This looks fine to me. Can you please work with Barry to make sure
> > > the slight different place of the initcall doesn't break anything
> > > for his setup? I doubt it would, but I'd rather have a Tested-by:
> > > tag.  
> > 
> > Barry's email is no longer in use. I can't reach him.
> 
> Which one? I would hope that his Gmail account is still valid:
> 
>   Barry Song <21cnbao@gmail.com>
> 

Maybe his kernel.org address works...

I have this patch stuck in limbo for 6.4.  I guess I'll carry it over
into the next -rc cycle, see what happens.

fwiw, it has been in -next for six weeks, no known issues.
