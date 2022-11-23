Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EF636A70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiKWUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbiKWUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:01:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C5C742FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:00:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E092761EF2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA3EC433D6;
        Wed, 23 Nov 2022 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669233657;
        bh=SMv7mBGrmySfdDPu0Z8LvdKwa3iMqVR3fH69IYs0FVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENbHOwN+5CRk8k1YeGHHM6lui96My9Wil9Rn0SFp3B1g2Igt7FNhOtL1PwgWtcOkS
         A1SL586WYc1cxdxIibu5vlSGRjjYS71cNZQccrdsjVlRtaDoxdFy6Jxa5aGazcL9pA
         qXqBZHq3Svqk6l8ITDVNL+ZZ4Kww3PKXrOkYrEbxFBEXeBo4ETFlrgEtnlLgaMTyxl
         ptyoIHt4p4X++NMxjteDgZDqBIFnLis21u/JnfY9PcMvJpwxV095qMVDBcyQgoD+w3
         lDzCnapyhPwA1kyA8Gzo8ms40nvpS9QDBi595D9sPoh2bw5rXkihpWGIyUXmbEXVIK
         WDfp4CYpWjbUA==
Date:   Wed, 23 Nov 2022 20:00:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 3/5] riscv: ftrace: Reduce the detour code size to half
Message-ID: <Y35783GmAtJ+JuGW@spud>
References: <20221123153950.2911981-1-guoren@kernel.org>
 <20221123153950.2911981-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123153950.2911981-4-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:39:48AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Use a temporary register to reduce the size of detour code from
> 16 bytes to 8 bytes. The previous implementation is from
> afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of
> MCOUNT").
> 
> Before the patch:
> <func_prolog>:
>  0: REG_S  ra, -SZREG(sp)
>  4: auipc  ra, ?
>  8: jalr   ?(ra)
> 12: REG_L  ra, -SZREG(sp)
>  (func_boddy)
> 
> After the patch:
> <func_prolog>:
>  0: auipc  t0, ?
>  4: jalr   t0, ?(t0)
>  (func_boddy)
> 
> Link: https://lore.kernel.org/linux-riscv/20221122075440.1165172-1-suagrfillet@gmail.com/
> Co-developed-by: Song Shuai <suagrfillet@gmail.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

FYI missing a sign-off from Song Shuai. They were happy with you folding
their patch in during the discussion linked above - so I suppose that is
an accidental omission?

Thanks,
Conor.

