Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7D72DC92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbjFMIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbjFMIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783C12A;
        Tue, 13 Jun 2023 01:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFA9F632B6;
        Tue, 13 Jun 2023 08:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAFDC433EF;
        Tue, 13 Jun 2023 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686645341;
        bh=7POap0BgReJndSfBWnUr9sOIww6wKlvURWhxSuQYNcQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PIIvhn49fkhAq5d5lg+8yqih8TDoT9cLzsUMkI1hZK6IuCtrV+MgYvkckz7ek3Bqm
         7+iNMMqJ4QzXPtJyHDGjhhKFlB9E8s41xREM+Yvo8iR9+rqbUIQ5uBJz8MBMwQGXgh
         i5UdQz0UiCPpZvdXGqV4kufnN2fg+MtrX1Y1gp6WGFJT9clzGezrM9jFT5SHMo2KCz
         beTt1JHCMjiF5zEg1FQe64GCMRw7bSzE1+koyqcQE5LLgMV5agu+wtQ9BI10z6XXit
         sYL2u2h/0As18Gh0lyKJvqLwFoEqzUBy1ZTNkF07HkfyEhauJOhEvVIjs7Ym6pylVH
         sz669fxJrD7UA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net/mediatek: strlcpy withreturn
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
References: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664533370.24637.14116409515016851485.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 08:35:39 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Azeem Shaikh <azeemshaikh38@gmail.com> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since DEV_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

The title should be:

wifi: mt7601u: replace strlcpy() with strscpy()

I can fix that, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230613003458.3538812-1-azeemshaikh38@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

