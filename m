Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17A6DD456
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDKHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDKHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4291734;
        Tue, 11 Apr 2023 00:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8810960AAE;
        Tue, 11 Apr 2023 07:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE4DC433EF;
        Tue, 11 Apr 2023 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681198561;
        bh=9ighdUcP/UTYLMiyXaga2dDu7U1Ozp7TXI7PHr3dDYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pc3B3hgSIKCjI2c/0a4HjZdd2ehgt6z2AB/2lkt3ZD6vimWx/pG5aGfdOrQOKPqBx
         gjPeI3PzxplsapH8uFKl4f+UNMeQlirH6NJ6KQEL4JYpMdrlAhgc1e/+qQSLPnJ6Jt
         Z1r3Ty3+mnw9Oj7MUoOrTlHiUY2ndF8deB2I3KnvL3FWE7fXSuDRq+RSoWwlPp3c6D
         qv/asV3Ccah13L3j+wQu/EayolE5EbXi4uitIEu42TucY1rgfDOee6evA4HatXTpwF
         6dJhup7XFRTiwuy8FxHXbRACloOKnZ5kfXVq4yfp6LSnzMlnfs/3XmYg/cP3gsVGh1
         8lMMn383lj2Lw==
Date:   Tue, 11 Apr 2023 09:35:55 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com
Subject: Re: [PATCH -next v4 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZDUN2+WG3OKGN/oq@kernel.org>
References: <20230410130553.3226347-1-chenjiahao16@huawei.com>
 <20230410130553.3226347-2-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410130553.3226347-2-chenjiahao16@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 09:05:52PM +0800, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
> 
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Here introduce the parameter option crashkernel=X,[high,low].
> 
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low".
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

