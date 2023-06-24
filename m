Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54B73CD49
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 00:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFXW2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 18:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXW23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 18:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072710D8;
        Sat, 24 Jun 2023 15:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C75160A71;
        Sat, 24 Jun 2023 22:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF96C433C0;
        Sat, 24 Jun 2023 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687645707;
        bh=Xr9seD7Mt0PFVk1QOrKGfmugFEuY6PJhYDOWIjAJ3WA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FDUqIVyjZ3Cfh7ExAtZpIjceASv+BaEVlPCa8QEJ4bwPEW+jTqHQZEhfONR2MUwc3
         5Mp0gKdkLj4yYQLd4HON2qkF41Gafrrox+E8wFnOW/o5l/4AJbOUNJWX33+EWfgGPg
         IMlt1eu3C19cBzoreFP44pgNG2aoeP1nlScOiTGit6W6FmW3c+wdZg8Z/Irg/2VY/z
         Va3h1a652baAJCbUVekzBE2STG4luQM/yDQ6HLorqhIp8fbo+xUhdkDX4AMjOZ5DwS
         gkOJ3WQc57aXgpkdEaF2BUlXnavrG1sH82rKexDKVDH4aTA6K8cg+7HxoqVa2B0Lza
         4jV57LkHmGFlQ==
Date:   Sat, 24 Jun 2023 15:28:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Veerasenareddy Burru <vburru@marvell.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
Message-ID: <20230624152826.10e3789b@kernel.org>
In-Reply-To: <20230623211457.102544-3-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
        <20230623211457.102544-3-Julia.Lawall@inria.fr>
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

On Fri, 23 Jun 2023 23:14:33 +0200 Julia Lawall wrote:
> -	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
> +	oq->buff_info = vzalloc(array_size(oq->max_count, OCTEP_OQ_RECVBUF_SIZE));

vcalloc seems to exist, is there a reason array_size() is preferred?
-- 
pw-bot: cr
