Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038447301B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbjFNOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjFNOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F71721;
        Wed, 14 Jun 2023 07:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89100642ED;
        Wed, 14 Jun 2023 14:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D4C433C0;
        Wed, 14 Jun 2023 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686752664;
        bh=FqUvtv9fuBbOa2cF0stc7Ubtd7EhOO9sRUnWlgEUXAQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LiBeaZK8BUyAEjBrPaLbVcm91bl8Yb5AL+52JlAkAMN9cHgJZQ/RoxtPXQWvLZJxU
         pL0men2FEq1b51j9taoqaMWFzz/KYrPxexiVI8VlVVqFlQAwcOA7+HAeIvcQh4hQ6a
         K61OZ8DNdl+cLehJPmoXz9F6pB75znxKlvyppP8knd2zE4b9B5t6BASD0hLGvJPGbY
         Zv93cyUotdQ8zCG7i2DA14XmNfwhaVNtPaGHO6JzJ/o28HoEkhAFtNCIbakz/ZwM20
         IZM3sew8V4B8QPEuveh7AoqxEXpdaDkPWiCvk6+HbIjpf9LGWi8lhhocfHykjS9NvC
         yEj1kv5BqbmUA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: replace strlcpy() with strscpy()
References: <20230614134956.2109252-1-azeemshaikh38@gmail.com>
Date:   Wed, 14 Jun 2023 17:24:20 +0300
In-Reply-To: <20230614134956.2109252-1-azeemshaikh38@gmail.com> (Azeem
        Shaikh's message of "Wed, 14 Jun 2023 13:49:56 +0000")
Message-ID: <874jnaf7fv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Azeem Shaikh <azeemshaikh38@gmail.com> writes:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is safe here since WIPHY_ASSIGN is only used by
> TRACE macros and the return values are ignored.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20230612232301.2572316-1-azeemshaikh38@gmail.com/
> v2: https://lore.kernel.org/all/20230614134552.2108471-1-azeemshaikh38@gmail.com/

In the change log (after the "---" line) you should also describe what
changes you made, more info in the wiki below. In this case it's clear
as the patch is simple but please keep this in mind for future patches.

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
