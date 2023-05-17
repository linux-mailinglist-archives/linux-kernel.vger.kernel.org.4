Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0038705FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjEQGYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjEQGYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D50359E;
        Tue, 16 May 2023 23:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050836422F;
        Wed, 17 May 2023 06:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F3AC433D2;
        Wed, 17 May 2023 06:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684304661;
        bh=gMk6/EoGfuHArSq0Q8XKhHxU1olH0Y7/8YUqrbeK/Yc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FL8IyGRp6X7P8iL2t+MVz0jzW1UWUAYcxDsC/CE6eib1w50IkJqa54LgNvsl0kyWO
         rzmbyK7nlkeaGwFZFHjEpaahPC5gwXeKJ00OwfL+dLuqxVuh03V2CUzJs1esJnDR6f
         5HdNbKKPT8KUYlL3W7RoBuxNjQJY9bDLiO4/oJMmrwmWVvJDpWgyL6xiwcznhhvhvU
         /1seolds4UBEwVzHC6MJnmJ3LQiD6aKW1K43ccdSZJLQ/Irqhb8f2CoRRZnGx6KPSa
         FTw2fL9au1RYB/4VJsfNbSGJ6ABjpVqgeMTsPQJYaNBTPUxHZ3hg/uEcBpuNe5/9KT
         n5L+7U11iM4kA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] wifi: b43: fix incorrect __packed annotation
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230516183442.536589-1-arnd@kernel.org>
References: <20230516183442.536589-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168430465407.24096.14761627656437604341.kvalo@kernel.org>
Date:   Wed, 17 May 2023 06:24:17 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about an unpacked structure inside of a packed one:
> 
> drivers/net/wireless/broadcom/b43/b43.h:654:4: error: field data within 'struct b43_iv' is less aligned than 'union (unnamed union at /home/arnd/arm-soc/drivers/net/wireless/broadcom/b43/b43.h:651:2)' and is usually due to 'struct b43_iv' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
> 
> The problem here is that the anonymous union has the default alignment
> from its members, apparently because the original author mixed up the
> placement of the __packed attribute by placing it next to the struct
> member rather than the union definition. As the struct itself is
> also marked as __packed, there is no need to mark its members, so just
> move the annotation to the inner type instead.
> 
> As Michael noted, the same problem is present in b43legacy, so
> change both at the same time.
> 
> Acked-by: Michael Büsch <m@bues.ch>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Link: https://lore.kernel.org/oe-kbuild-all/202305160749.ay1HAoyP-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to wireless.git, thanks.

212457ccbd60 wifi: b43: fix incorrect __packed annotation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230516183442.536589-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

