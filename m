Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530C26EAAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDUMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDUMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660A10FD;
        Fri, 21 Apr 2023 05:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EAF9615AE;
        Fri, 21 Apr 2023 12:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0249C433D2;
        Fri, 21 Apr 2023 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682081623;
        bh=M++VIMNmaVWIzCgybL4bENpdg0Qjt9D7WbUzfJowSDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkDz6aRrIXaUxlJaVIY9a3UZo6G9mR1qEuwvpOfgE1EhZdF3I8/HU2c6MH5zfdY0K
         C1I7GN/4A5gACQautDwJ7hcP6R46wd0geekXt5FgcQFjcnkwYup/udDXyFtafWlv0A
         G7lRxNq8O0Ww+ZQxY2lDXUPV9+2mHbtn+8/y5Y325l5erPh7l7M6284JUlMm93Ykp9
         vAgbZSoMGaO1TA2YNT0I5Oqy8LUibswbTSp/rSgoDE3V+Ur8AH60QFZ31H5cUur+1m
         7eZ5Z/A3cGvEbhzSOaUcBd8b0YwcEDe99cAcST0FOh/anl2RLEgI7+umDX+pI4hWCT
         zHXREaDyHkxZg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ppqGj-00AAr7-FR;
        Fri, 21 Apr 2023 13:53:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 1/2] KVM: arm64: Slightly optimize flush_context()
Date:   Fri, 21 Apr 2023 13:53:38 +0100
Message-Id: <168208160323.3020266.2140087436255343350.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <97bf2743f3a302b3066aced02218b9da60690dd3.1681854412.git.christophe.jaillet@wanadoo.fr>
References: <97bf2743f3a302b3066aced02218b9da60690dd3.1681854412.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, christophe.jaillet@wanadoo.fr, yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 23:47:37 +0200, Christophe JAILLET wrote:
> bitmap_zero() is faster than bitmap_clear(), so use it to save a few
> cycles.

Applied to next, thanks!

[1/2] KVM: arm64: Slightly optimize flush_context()
      commit: 4be8ddb48b1b6c6067fb59c846b9c6e19d6efe14
[2/2] KVM: arm64: Use the bitmap API to allocate bitmaps
      commit: a00e9e4319c2a8a8b166da028292de83190e39a4

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


