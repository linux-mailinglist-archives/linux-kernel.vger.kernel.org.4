Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A576FD9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjEJIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEJIp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98765FED;
        Wed, 10 May 2023 01:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717F9632CB;
        Wed, 10 May 2023 08:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D498C433D2;
        Wed, 10 May 2023 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683708324;
        bh=3MhIekn+hZe/AiJ39J4oFIjxYsnRwd6Rsjld0h79EhQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hIA1pnzjwKZ7xGRRimNYAu5bVEIusS7FUHf5ldGqXDlhl2Hx07EZWz667UmDNsME0
         qHEtaX8Mhf8epRSF0jT7OuKEGacZjlUmS/sx9iXmM1lnoaEvanfV/aQb+FAtNT0WIH
         u32ldFsUrMKdHOMCgH1DR4Hjiypnxx1L9i3SA9Z0hGlntoccZgsNjWB7SaNvPv8VP1
         GIO/7Ta/34V8Gh1xAGGn2M1KJQgQmuaQ/+ycSShfJHDOfKBWgCU19CfPG7a3tsSL9g
         VrxyRl7rkRQ7PwvUhUsR1xSPzRJafHofZkwt+iGG7cBVfOFeIlhGjGsgBD4ggNkXci
         d+391L11Nf1aQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/13] wifi: mwifiex: Use default @max_active for
 workqueues
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230509015032.3768622-3-tj@kernel.org>
References: <20230509015032.3768622-3-tj@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168370831930.27943.10511536922121448331.kvalo@kernel.org>
Date:   Wed, 10 May 2023 08:45:21 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> wrote:

> These workqueues only host a single work item and thus doen't need explicit
> concurrency limit. Let's use the default @max_active. This doesn't cost
> anything and clearly expresses that @max_active doesn't matter.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> Cc: Ganapathi Bhat <ganapathi017@gmail.com>
> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Cc: Xinming Hu <huxinming820@gmail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

I didn't review the patch but I assume it's ok. Feel free to take it via your
tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

Patch set to Not Applicable.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230509015032.3768622-3-tj@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

