Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C372F68E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjFNHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbjFNHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:40:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE0119;
        Wed, 14 Jun 2023 00:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4524363841;
        Wed, 14 Jun 2023 07:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB759C433C0;
        Wed, 14 Jun 2023 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686728407;
        bh=9tKEuGeMMCSJYUtkoU+erfANYr53GikoWC56/oucmhw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cNeWSCyzGUnOEq9DRg7LIAwHY7RkxPD1/9283JqRK/sZw9GrXj4l9sexC5UmKqDjl
         La7Ifdv6vRH7BrtN27+yDiiOGzkOM+jnr+8pbbtGN8T1XAAJlGCPWJuDTX+UFssAWp
         nUr7yIZKEKeFYsWG5xGdy4wA/0eLB9r3DIsObl3+yc+aQbiHepcrcr8bOQdsvloSjJ
         C0GlWILU7Xbxxnv8A/3hO5mCAPvRofQ9lN2wttU5BKmEv5m0TiUXpm2Fn+8cszVIc3
         yxTl3Uep7MZX63seF2eThdKIT+dU1VuwQMxRh36SU+30BCW7PN1jp4f5ZvILtfuxjZ
         CTfqBQwI1Gu+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] cfg80211: cfg80211: strlcpy withreturn
References: <20230612232301.2572316-1-azeemshaikh38@gmail.com>
Date:   Wed, 14 Jun 2023 10:40:00 +0300
In-Reply-To: <20230612232301.2572316-1-azeemshaikh38@gmail.com> (Azeem
        Shaikh's message of "Mon, 12 Jun 2023 23:23:01 +0000")
Message-ID: <87fs6ufq5r.fsf@kernel.org>
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

The title should be:

wifi: cfg80211: replace strlcpy() with strlscpy()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
