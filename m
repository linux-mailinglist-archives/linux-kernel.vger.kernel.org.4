Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0906E7EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjDSPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjDSPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C69775
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22ABA63FC4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DBCC433D2;
        Wed, 19 Apr 2023 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681919017;
        bh=kod3aeyjs9KPBA0J3b/X9AKxEmGR0GKnOHbwVB3G+3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvbTI7+5OqSKT1NK0O5sCaCwaU33Yz01LEC96ftaJ4rglBbLR68p/TFwM6h79TSI8
         OZaKXho7IgQvEm8fgrUVZGvLbbT0UJsD9WEyLqRZ9XBMe611D16MOJUvzesrhQHcd6
         Iact9m4uE4RdUMuSdGOcJUpheKmY6x2SUsZqDeecGr+s1l7zBM2UO6/YDnlLhP+3Kx
         3zIRbacDK2T/LxrkFBFobJ0kTkW7WQXpGjslqPPDS2+jK/zeVvJtjNuGdAgJhKNtZy
         dqkNG2WGjhQ7lMLrnr1JB7BTsRJCBfApkwLjBmPbKa4W2P/j+ZT2IQk1II7gGSzGVr
         cwrI8cNmEky1g==
Date:   Wed, 19 Apr 2023 08:43:35 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, akpm@linux-foudation.org, ben-linux@fluff.org,
        wuchi.zero@gmail.com
Subject: Re: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
Message-ID: <20230419154335.4vc7rouxl4gsynzm@treble>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
 <20230410022226.181812-2-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230410022226.181812-2-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:22:25AM +0800, Chen Zhongjin wrote:
> Syzbot has been reporting the problem of stack-out-of-bounds in
> profile_pc for a long time:
> https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
> 
> profile_pc tries to get pc if current regs is inside lock function. For
> !CONFIG_FRAME_POINTER it used a hack way to get the pc from stack, which
> is not work with ORC. It makes profile_pc read illeagal address, return
> wrong result, and frequently triggers KASAN.
> 
> Since lock profiling can be handled with much better other tools, It's
> reasonable to remove lock functions hack for !FRAME_POINTER kernel.
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/x86/kernel/time.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
> index e42faa792c07..e08fac7bb71e 100644
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -29,22 +29,10 @@ unsigned long profile_pc(struct pt_regs *regs)
>  {
>  	unsigned long pc = instruction_pointer(regs);
>  
> -	if (!user_mode(regs) && in_lock_functions(pc)) {
>  #ifdef CONFIG_FRAME_POINTER
> +	if (!user_mode(regs) && in_lock_functions(pc))

If lock profiling is no longer useful then we should just remove it
altogether, not just for ORC.

-- 
Josh
