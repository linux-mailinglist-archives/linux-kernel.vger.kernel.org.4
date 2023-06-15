Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8B4730E03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbjFOEUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjFOEUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822910A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B199262A1C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7FAC433C8;
        Thu, 15 Jun 2023 04:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686802833;
        bh=r3ZuN3Io1bp4/Cx8s+S52ckgv49Kj7xPRrS9LZj78qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IfbgiUVc7uLqqHRL8KUASPv6Z16ClS1aiRs7oGyJKkm/vhvLNrYXGPrQvYT/obKXm
         c9h3k8mpXRhCvKEL54FL1UlN0zFVlOpJLoyB1BlcRBMF1FWv62TmYAmyu5XYhzdcxz
         5gnZMnTvnLuEmvFRn93YX9HF/IqxuKZEt22OrrO4sP+8TVqYOr2ywPFWM47ny5A//L
         NG32aWIHLBVnkJBVj3QaELhB9/74dKIcqoo8IzrYq7n1kormZsFT82JdnD8EfbKlBG
         93YF/4eKN2QjvfSpTMjnYaHm6bVAqATiV9rg8aloSxoXYyjxJoVprc3uwH8HawQPih
         +wIdq5NQ88LTQ==
Date:   Wed, 14 Jun 2023 21:20:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     hawk@kernel.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] page pool: not return page to alloc cache
 during pool destruction
Message-ID: <20230614212031.7e1b6893@kernel.org>
In-Reply-To: <20230615013645.7297-1-liangchen.linux@gmail.com>
References: <20230615013645.7297-1-liangchen.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 09:36:45 +0800 Liang Chen wrote:
> When destroying a page pool, the alloc cache and recycle ring are emptied.
> If there are inflight pages, the retry process will periodically check the
> recycle ring for recently returned pages, but not the alloc cache (alloc
> cache is only emptied once). As a result, any pages returned to the alloc
> cache after the page pool destruction will be stuck there and cause the
> retry process to continuously look for inflight pages and report warnings.
> 
> To safeguard against this situation, any pages returning to the alloc cache
> after pool destruction should be prevented.

Let's hear from the page pool maintainers but I think the driver 
is supposed to prevent allocations while pool is getting destroyed.
Perhaps we can add DEBUG_NET_WARN_ON_ONCE() for this condition to
prevent wasting cycles in production builds?
