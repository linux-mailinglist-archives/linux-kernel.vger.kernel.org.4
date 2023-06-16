Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED773255F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjFPCp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjFPCp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A9297A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA60361AD5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD01C433C0;
        Fri, 16 Jun 2023 02:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686883526;
        bh=gYUxWe5lBhmkMYsrBGaBMQPWQ2ckcLGPdVZjk0GP85U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q2W4JTTRMfMNSa1N88Adux27avcE66JFfT10h52ja9l+3QONDugwvypiULgHlq/8v
         yRIvpE4e+2I2zJsSCRR43ocl4Hf+AzxUPgwxQ+h1paBcgoL4yJQMfI0WicIq0Sw4Wk
         zQoiIy7XwLpPQUbgWc23DkGD/4GC9P21J9504FrFWUjYWXjrJ+BvrU6oNIYweAye50
         85b9S5Bc75QIG24REpNZH9HjPkkQI8XzcUIMmvdNJtWz3io0MH8Obe9N4fVdYOJPjq
         aIm/0P/9M6+5dOQrSRKLq3l0YXWVm0/GURvWQEmd2nal0A58o8f40p6pKXRW/3jU/9
         ANHx9KMoWBPAA==
Date:   Thu, 15 Jun 2023 19:45:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Liang Chen <liangchen.linux@gmail.com>, brouer@redhat.com,
        hawk@kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] page pool: not return page to alloc cache
 during pool destruction
Message-ID: <20230615194524.1201bd0d@kernel.org>
In-Reply-To: <b28b0e3e-87e4-5a02-c172-2d1424405a5a@redhat.com>
References: <20230615013645.7297-1-liangchen.linux@gmail.com>
        <20230614212031.7e1b6893@kernel.org>
        <b28b0e3e-87e4-5a02-c172-2d1424405a5a@redhat.com>
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

On Thu, 15 Jun 2023 16:00:13 +0200 Jesper Dangaard Brouer wrote:
> Adding a DEBUG_NET_WARN_ON_ONCE will be annoying as I like to run my
> testlab kernels with CONFIG_DEBUG_NET, which will change this extreme
> fash-path slightly (adding some unlikely's affecting code layout to the
> mix).

That's counter-intuitive - the whole point of DEBUG_NET is to have 
a place where we can add checks which we don't want in production
builds. If we can't use it on the datapath we should just remove it
completely and have its checks always enabled..

I do feel your pain of having to test code both with debug enabled
and disabled, but we can't have a cookie and eat it too :(
