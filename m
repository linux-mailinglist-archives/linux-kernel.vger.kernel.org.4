Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7C74E8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGKIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6091;
        Tue, 11 Jul 2023 01:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F7986136C;
        Tue, 11 Jul 2023 08:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C54C433C8;
        Tue, 11 Jul 2023 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689063756;
        bh=nA/0HHKApOjo4ebOQAYBWybrleEkpT23SyXmQekfRRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ll/fOj6keaEqkWYdfQdmE9hijwu3oeVdT4Hu9opB1+5T6I+kgNiRjYEGew17HGQqs
         hRElcg2uvSxkIsmRriYQm62Ag5KKdyYf7BoZ3HML0AWCtmCOKfy+gACKxrzLWpG3RY
         D29AcWgMNnwzylEXCeu3ZK3n16HOfKeDmlgDvPe0f4f//X3tGZ0HRDdNzVcfJXI7m6
         9U1QsxPhJCIjDikZSFn07TtCwU49D8uhIqCsrgSfEpP7zJLcxLRaEFHJhPZ0o6tVdI
         wDyvGpj2XdmVwJPBpHzYqX29oJcQs9dxcl9oms2FS7kETiWMPp/OQAtrMHdaP8qrzj
         NXVzColV9Z7MA==
Date:   Tue, 11 Jul 2023 09:22:31 +0100
From:   Will Deacon <will@kernel.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, maz@kernel.org,
        quic_pkondeti@quicinc.com, quic_kaushalk@quicinc.com,
        quic_satyap@quicinc.com, quic_shashim@quicinc.com,
        quic_songxue@quicinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Message-ID: <20230711082226.GA1554@willie-the-truck>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <20230710093751.GC32673@willie-the-truck>
 <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:02:22PM +0800, Aiqun(Maria) Yu wrote:
> On 7/10/2023 5:37 PM, Will Deacon wrote:
> > On Mon, Jul 10, 2023 at 01:59:55PM +0800, Maria Yu wrote:
> > > In order to be able to disable lse_atomic even if cpu
> > > support it, most likely because of memory controller
> > > cannot deal with the lse atomic instructions, use a
> > > new idreg override to deal with it.
> > 
> > This should not be a problem for cacheable memory though, right?
> > 
> > Given that Linux does not issue atomic operations to non-cacheable mappings,
> > I'm struggling to see why there's a problem here.
> 
> The lse atomic operation can be issued on non-cacheable mappings as well.
> Even if it is cached data, with different CPUECTLR_EL1 setting, it can also
> do far lse atomic operations.

Please can you point me to the place in the kernel sources where this
happens? The architecture doesn't guarantee that atomics to non-cacheable
mappings will work, see "B2.2.6 Possible implementation restrictions on
using atomic instructions". Linux, therefore, doesn't issue atomics
to non-cacheable memory.

> > Please can you explain the problem that you are trying to solve?
> 
> In our current case, it is a 100% reproducible issue that happened for
> uncached data, the cpu which support LSE atomic, but the system's DDR
> subsystem is not support this and caused a NOC error and thus synchronous
> external abort happened.

So? The Arm ARM allows this behaviour and Linux shouldn't run into it.

Will
