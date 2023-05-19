Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64C570A2C8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjESW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjESW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BAB1A8
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6529B65B7A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EB8C433D2;
        Fri, 19 May 2023 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684535237;
        bh=3++Hz/H0Ny8iNnJK/HwTOxVy8iKIyU2vlNFkX6To6V8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMNQ+KnSqIGNuGe3uYk1BjH4DhXTj3M0pEM6ts97Oe75qGoI4/bM7UJ81xFdYa01/
         28QeawEBbtM6Ou0uajuvn0QxJuWgODz3qt/84ZM5TDU5ZMAmrMzNW//56/tPSHI5yR
         DEgaNOKopY4SR0Zf/rw+81uy8zk+qRItdlE/WesPVVbQRc2OAYOJIqlBsAqNQPMEPo
         WC2oIi13vw709nUDVb48rqMMBjWwfojI1SgsVv3Xg0ManDOdMtIinOCKdXeHoYuiS9
         1ifR2XvFgM3XuVICy2X5RVtCXDlD21fS50Q5udLIhvdsGkyLDtEWTYInCEx3MTkyos
         YntJnPPLrqioA==
Date:   Fri, 19 May 2023 15:27:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: compare p->des0 and p->des1 with __le32
 type values
Message-ID: <20230519152715.7d1c3a49@kernel.org>
In-Reply-To: <20230519115030.74493-1-minhuadotchen@gmail.com>
References: <20230519115030.74493-1-minhuadotchen@gmail.com>
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

On Fri, 19 May 2023 19:50:28 +0800 Min-Hua Chen wrote:
> -		if ((p->des0 == 0xffffffff) && (p->des1 == 0xffffffff))
> +		if (p->des0 == cpu_to_le32(0xffffffff) &&
> +		    p->des1 == cpu_to_le32(0xffffffff))

Can you try to fix the sparse tool instead? I believe it already
ignores such errors for the constant of 0, maybe it can be taught 
to ignore all "isomorphic" values?

By "isomorphic" I mean that 0xffffffff == cpu_to_le32(0xffffffff)
so there's no point complaining.
-- 
pw-bot: reject
