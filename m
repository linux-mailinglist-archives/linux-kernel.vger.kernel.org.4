Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F56718931
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEaSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjEaSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD6126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED4D63E69
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31C8C433D2;
        Wed, 31 May 2023 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685556964;
        bh=0iS4QEZtR9R14+8r9lidPyx64MxNgwHzBGnd4gRrIV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vs8CeFQRe9fRbvMmR0S/zocnCs7QJhJ7gyu+urrAAFLV3XXO9la5SApk3p7INC+5e
         ZjDbjo7nu3ytwZc0o6BUyCmNN9L9kpK5x3RlR8af5fZC5PcJ1S/QQ/PzZHcZuYaga6
         rLeN27HZDXmD5PwG5XhLy4cJkqZRXQ64/5CO0mmWOFe0ZzJg+qPKzrDHZz9TJ4mN9y
         85qUD9KFKyDcWp0H5Ebthgt1H0nqbYlG3JonroemeI6mePWXtBeyzZyd13G3w8GQh/
         EGTrn+8gGsLnWmnmHzA2IoT47IwTqUbkWweY2dPh1w6ynNiaxW1K58VByuzCKtu0Cz
         2mTGTq806G1tw==
Date:   Wed, 31 May 2023 11:16:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Qingfang DENG <dqfext@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Ville Nuorvala <vnuorval@tcs.hut.fi>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [PATCH net] neighbour: fix unaligned access to pneigh_entry
Message-ID: <20230531111602.7ecf401b@kernel.org>
In-Reply-To: <20230531104233.50645-1-dqfext@gmail.com>
References: <20230531104233.50645-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 18:42:33 +0800 Qingfang DENG wrote:
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	u8			key[];
> +#else
> +	u8			key[] __aligned(4);
> +#endif

I'd appreciate a second opinion, but to me it's very unlikely we'd save
any memory even with efficient aligned access here. No reasonably key
will fit into 3 bytes, right? So we can as well avoid the ifdef and
make the key[] always aligned. Or preferably, if it doesn't cause
compilation issues, make the type of the key u32?
