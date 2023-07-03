Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3E74637A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGCTob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGCTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0BE69
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E033A61022
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F9C433C7;
        Mon,  3 Jul 2023 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688413468;
        bh=JhZb50vovyTnsLJREDIpXMbd3ET0Yiy5SJpuD7Hpuzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fyYi2ewwMB5oM4c2XuxPDW769rz8FoMqEAXWFv0RHga4P7/zGbWzhBx/DubmJ090q
         btmsEQyWKNnJPwyWP2SNNoBZle+lBO+8mSQwsynjbU38tlE1qwEHHJvp9PXcYH0n2W
         fns1Qp5NpZq7LtAuc1mJZfafrIgMfKR4O4wa8USG3wnK+Ii8iyb/7WOUrCfG5/EOTD
         usf6jQKU86toUKUlf8wcqwNFyR+udfuYDylrlwB66iU3hD9hOd/zl16UrrdbBEzUsc
         yTp5lsVPQBFGLC/18U6i0cFvFvud7cmRmAoNYHp1D5tpkTxH23kEc779xuN6S3KRuA
         BWsfmG1FCQipA==
Date:   Mon, 3 Jul 2023 12:44:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     leitao@debian.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.or,
        Dave Jones <davej@codemonkey.org.uk>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230703124427.228f7a9e@kernel.org>
In-Reply-To: <20230703154155.3460313-1-leitao@debian.org>
References: <20230703154155.3460313-1-leitao@debian.org>
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

On Mon,  3 Jul 2023 08:41:54 -0700 leitao@debian.org wrote:
> +	uname = init_utsname()->release;
> +
> +	newmsg = kasprintf(GFP_KERNEL, "%s;%s", uname, msg);
> +	if (!newmsg)
> +		/* In case of ENOMEM, just ignore this entry */
> +		return;
> +	newlen = strlen(uname) + len + 1;
> +
> +	send_ext_msg_udp(nt, newmsg, newlen);
> +
> +	kfree(newmsg);

You can avoid the memory allocation by putting this code into
send_ext_msg_udp(), I reckon? There's already a buffer there.
-- 
pw-bot: cr
