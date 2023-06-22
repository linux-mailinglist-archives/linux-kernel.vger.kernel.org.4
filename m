Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42873A62C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFVQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFVQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D809E57
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B11618BB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87F3C433C8;
        Thu, 22 Jun 2023 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687451809;
        bh=pjzGP8R3SPlmAyHxL8Ci6L9a/VYrrsL3N2kb9NS++3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AH0Vg54iyLm1ss/adA4DhrQGdrGEfvYWoDA2wFK2DHDppXKNoysk5XoG2PlPoibAS
         sA69c3hiN0f2AyVBphkp7NSM3XWtVxEAuihcBh93+UYoAp+7f29WnKKBH0Mu1lpIJg
         spe3v1eZWxbNJntqvmykMb+PYDaHP9Fob+q2ZBtidnFfa0KtFO2SGQIM0uFy2/uAiA
         SebmjtnhWVXthwU5jaoo5ymrz3Lr4IzaFcLtrkx9BFD76PqHyfOeqAWmuyGebo0uiv
         MFILz2lMvgj7JyKyfHzM3rmaIUsKPYWk8QNwPLLSrNQKcukJCgeFdBcSMuAIyXIX5v
         s5Kk7+gRBS5Vg==
Date:   Thu, 22 Jun 2023 09:36:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Igor Russkikh <irusskikh@marvell.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH] net: atlantic: fix ring buffer alignment
Message-ID: <20230622093648.3795e325@kernel.org>
In-Reply-To: <98b9dc2d-9232-d0e0-022e-2e8339b3cb66@marvell.com>
References: <20230616092645.3384103-1-arnd@kernel.org>
        <ZIxfK1MVRL+1wDvq@corigine.com>
        <20230620120038.0d9a261c@kernel.org>
        <98b9dc2d-9232-d0e0-022e-2e8339b3cb66@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 07:49:52 +0200 Igor Russkikh wrote:
> > Agreed that the comment is confusing seems to be incorrect post-change.
> > Flags for instance are overlapped with len, is_gso etc. so they can't be
> > a separate 8B at the end.
> > 
> > Igor, please advise how you want to proceed.  
> 
> I do agree better to remove the comment at all - it explains almost nothing.
> 
> Thats not a hardware related structure, so explicit pack is for sure not required.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>

Thanks Igor! 
Arnd, could you respin with the comment removed?
