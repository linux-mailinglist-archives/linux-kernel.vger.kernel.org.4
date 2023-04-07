Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5256DAC7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjDGMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbjDGMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D683CD;
        Fri,  7 Apr 2023 05:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B654760F87;
        Fri,  7 Apr 2023 12:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B44C4339B;
        Fri,  7 Apr 2023 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680869038;
        bh=hj8WZn4fsaNVXzouph4VuJoSDtm/pAjQ+hGj5NXmwD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBXLq4fagWKRTewxo4p5y+yltMfue1gHv9h6Rhkf+kT90l5ObTPyf5Q+HxCMGQAsM
         1WP18Sp/Ya3w+QiZ4Uku4/jcrSyIhhTDl6GoeWbpZfrxfYH144zC7BdFXcOmN3Bs8l
         ixgsTZd59XKKamoXJiCD5OBzTnOMIL4T96AiI38v7Ttj3fY3eZPYH/jj8zcKKxqUjw
         yZoR54HGahnG32BUoRdGl3XUEBDexCXzAufgslwOsGCS+z+ydlK/+dWroXXTzS6rYo
         BzhTRRDstfoWaFx2kUjdCg3egxn1cf8mY8FaYa/WqcsUV2RCUa8bxxeEYIVS0jpejz
         CO8A+lDkofXZw==
Date:   Fri, 7 Apr 2023 14:03:52 +0200
From:   Simon Horman <horms@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Chen Jiahao <chenjiahao16@huawei.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, bjorn@rivosinc.com,
        alex@ghiti.fr, akpm@linux-foundation.org, atishp@rivosinc.com,
        bhe@redhat.com, thunder.leizhen@huawei.com
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZDAGqL6CZGrL499u@kernel.org>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
 <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 05:06:24PM +0800, Guo Ren wrote:
> On Thu, Apr 6, 2023 at 10:06 PM Chen Jiahao <chenjiahao16@huawei.com> wrote:
> >
> > On riscv, the current crash kernel allocation logic is trying to
> > allocate within 32bit addressible memory region by default, if
> > failed, try to allocate without 4G restriction.
> >
> > In need of saving DMA zone memory while allocating a relatively large
> > crash kernel region, allocating the reserved memory top down in
> > high memory, without overlapping the DMA zone, is a mature solution.
> > Here introduce the parameter option crashkernel=X,[high,low].
> >
> > One can reserve the crash kernel from high memory above DMA zone range
> > by explicitly passing "crashkernel=X,high"; or reserve a memory range
> > below 4G with "crashkernel=X,low".
> Asked-by: Guo Ren <guoren@kernel.org>

Perhaps 'Acked-by' :)
