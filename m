Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5380F74EBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGKKZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGKKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A5D136;
        Tue, 11 Jul 2023 03:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85AF26145D;
        Tue, 11 Jul 2023 10:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F8BC433C8;
        Tue, 11 Jul 2023 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689071116;
        bh=TOqlJUFHaJBKmQf2cGYAl73/mk9Gcc2SsywmsziYi5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsBVrD0VftvJCAMA4m23UBTa2QMEpfh8VPytwt6VbmLtjVMZbDL22pwmxIYgsGvvd
         KPPBk+sSC3gr1EcGohswi97s3Kwup2+aZeaps9CmTPeEGTmI+r6yF3F+yDHo0PrW++
         xeWdIEkQJuWPJf+hbT+SmYC5SzKWwTiMbfnzkEd7z7JwVtNiK1PRhe8Nm0RporIEc/
         6rmAZE8BYet39GdehoVcfD+RuKGLMESsIkPYCdLZScxU/b1xOwOWQnz1qo7JxEWo7M
         AgFTtNtXCrrKNgvx/dUdbFooaddoZEhBBnbIcgV+7y6e5hBswhaIP2IudW+48ZpQbR
         dPfGmovBooH7A==
Date:   Tue, 11 Jul 2023 11:25:11 +0100
From:   Will Deacon <will@kernel.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, maz@kernel.org,
        quic_pkondeti@quicinc.com, quic_kaushalk@quicinc.com,
        quic_satyap@quicinc.com, quic_shashim@quicinc.com,
        quic_songxue@quicinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Message-ID: <20230711102510.GA1809@willie-the-truck>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <20230710093751.GC32673@willie-the-truck>
 <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
 <20230711082226.GA1554@willie-the-truck>
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
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

On Tue, Jul 11, 2023 at 06:15:49PM +0800, Aiqun(Maria) Yu wrote:
> On 7/11/2023 4:22 PM, Will Deacon wrote:
> > On Tue, Jul 11, 2023 at 12:02:22PM +0800, Aiqun(Maria) Yu wrote:
> > > On 7/10/2023 5:37 PM, Will Deacon wrote:
> > > > On Mon, Jul 10, 2023 at 01:59:55PM +0800, Maria Yu wrote:
> > > > > In order to be able to disable lse_atomic even if cpu
> > > > > support it, most likely because of memory controller
> > > > > cannot deal with the lse atomic instructions, use a
> > > > > new idreg override to deal with it.
> > > > 
> > > > This should not be a problem for cacheable memory though, right?
> > > > 
> > > > Given that Linux does not issue atomic operations to non-cacheable mappings,
> > > > I'm struggling to see why there's a problem here.
> > > 
> > > The lse atomic operation can be issued on non-cacheable mappings as well.
> > > Even if it is cached data, with different CPUECTLR_EL1 setting, it can also
> > > do far lse atomic operations.
> > 
> > Please can you point me to the place in the kernel sources where this
> > happens? The architecture doesn't guarantee that atomics to non-cacheable
> > mappings will work, see "B2.2.6 Possible implementation restrictions on
> > using atomic instructions". Linux, therefore, doesn't issue atomics
> > to non-cacheable memory.
> 
> We encounter the issue on third party kernel modules and third party apps
> instead of linux kernel itself.

Great, so there's nothing to do in the kernel then!

The third party code needs to be modified not to use atomic instructions
with non-cacheable mappings. No need to involve us with that.

> This is a tradeoff of performance and stability. Per my understanding,
> options can be used to enable the lse_atomic to have the most performance
> cared system, and disable the lse_atomic by stability cared most system.

Where do livelock and starvation fit in with "stability"? Disabling LSE
atomics for things like qspinlock and the scheduler just because of some
badly written third-party code isn't much of a tradeoff.

Will
