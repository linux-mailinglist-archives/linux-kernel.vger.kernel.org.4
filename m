Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897D6F90A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjEFIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9210B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1307361961
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB60AC433EF;
        Sat,  6 May 2023 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683362371;
        bh=E1OI6VFi/ffnOvki9cGJPS5IS5qEue6LkIXtPgppa5E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DnG+TnlSAjYKWUdoYcNGlP73sW/zpXQvIuUuRF9g6vnCP5JMSL5suSjmAjFKS4NKR
         6kEjEGVE1pJbQkqGtmYsZn+XVh9PJExWkH0DBZac91X7Y9rH9ZtABqMKSLviFcpJDQ
         mvxy7jPIVArBTvZXsrhkAdBCuOd2NceQN/b4oRvd+aUlRhWB+HFtoXOBwyHthr6yHe
         rnv9oC8F4DxCuCCDb1qeL54rV5Vlav9Mp/SxBBISTTZMMyVS1WE2Loa6hn2LnhyXHY
         y/PwN2X/BrrpJjttPr2DL/ekfIjp7F0HGRRNDv4lfR0B6JEnIds1uDJzh04wTL9uSY
         4HiQPxJsI30PA==
Message-ID: <de87f124-b5c1-b7c0-b132-1be615184389@kernel.org>
Date:   Sat, 6 May 2023 10:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] w1: replace usage of found with dedicated list iterator
 variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220324073227.66486-1-jakobkoschel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220324073227.66486-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 08:32, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/w1/w1.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)

Hi,

I am going through old w1 patches and wanted to apply this, but it pops
a checkpatch warning about indentation. Can you fix the warning and send
a new version?

Best regards,
Krzysztof

