Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5429F72A552
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjFIVYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjFIVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD53A80;
        Fri,  9 Jun 2023 14:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1B465C4B;
        Fri,  9 Jun 2023 21:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12594C433EF;
        Fri,  9 Jun 2023 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686345863;
        bh=2uK6s5kWFrJC8PAsfuMuNcv1/WhnTGiBdiffYDfLlN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnLhkW6/ZlA0rRks8fS5weuLudIv/y+NYmji/2Nt9FtdyhcetkQ4XH6YBzwhiVRVz
         lVTu1AdpipFRbFbIfA33+VnUMokx+xwoh5IQ1OR68Rwqdojjg3KPb2ziTHIYUMG8bp
         2yUbhoRoDV1rmud4ZNpvyPDkAJCOV3So+6draJatSZvaWYhp4hAjmlFr8J8C2ht8ZX
         nZpw63ahhqo7ZTS3dbbvTXNnNS2XGsjCocybPrE6VYkMsXOIIGaA54/50CoYwSDlF+
         oVHpDp5STSOTFwm00a/p2E9sw/Aeo7DUbJ94irlYkKHOxJVqV4t+y5VnfJuePVj3vp
         cWKZfHk96I+GQ==
Date:   Fri, 9 Jun 2023 14:24:20 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] x86/orc: Make the is_callthunk() definition
 depend on CONFIG_BPF_JIT=y
Message-ID: <20230609212420.ida7mc2w3xxij3h4@treble>
References: <168630229338.404.8674192988459787200.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168630229338.404.8674192988459787200.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:13AM -0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     301cf77e21317b3465c5e2bb0188df24bbf1c2e2
> Gitweb:        https://git.kernel.org/tip/301cf77e21317b3465c5e2bb0188df24bbf1c2e2
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Fri, 09 Jun 2023 11:04:53 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 09 Jun 2023 11:09:04 +02:00
> 
> x86/orc: Make the is_callthunk() definition depend on CONFIG_BPF_JIT=y
> 
> Recent commit:
> 
>   020126239b8f Revert "x86/orc: Make it callthunk aware"
> 
> Made the only user of is_callthunk() depend on CONFIG_BPF_JIT=y, while
> the definition of the helper function is unconditional.
> 
> Move is_callthunk() inside the #ifdef block.
> 
> Addresses this build failure:
> 
>    arch/x86/kernel/callthunks.c:296:13: error: ‘is_callthunk’ defined but not used [-Werror=unused-function]

Sorry about that.  The bots didn't complain for some reason :-/

-- 
Josh
