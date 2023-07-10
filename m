Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F474CEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGJHja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGJHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:39:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C4F4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:39:08 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a1e6022b93so3214456b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974747; x=1691566747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nylNd4bJypqjy2p+mIjX7+lH56E0VvWsXGVw57XSk4s=;
        b=OZV5e6X85cMz8lstlN5z4lDR4f9EVfhUISluyAD1bMUMFNGBNEe2n/U1bxS+AnNDN/
         Tb2JYyz1IyFaCCnPpVnCpvk5jVwaGpDInbvV0mIuaI+M4vTvWTcnuyEqyiEMVkNyXTZD
         3Tz3BHIKy0uFm4Rhqh2X+ZWquLnT8ZVk6ELdS4RJtNpxWrcPpKjE3M++9Wwkg6GikQjx
         CW+HmyaO9PMaJlS7G7xQrrhExKMWpP3/ROvzwUAMBxv97jlGuUSLG92QhUU32DoYkql+
         28sGW10aQBzkhFqPR3Eq0Zs3TdZD1I+FaVWN0nmg+QgUk+DmRZfaHvtRhIAxEh8Vt33l
         wYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974747; x=1691566747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nylNd4bJypqjy2p+mIjX7+lH56E0VvWsXGVw57XSk4s=;
        b=FscUWeSHb1qvyFGAf7kM6C8Rjkom43XNG9XCSILZzDvradnb1R+CSJgKXfsCJXSl8g
         rDWtRC30ZkriWkkesCG2hCch9sWycMssRyddMPpSTfWuylgLxikWmJ6RommBZqEBAOos
         ds9wg7sdX6dmjo5NgNGdCMmnztr7KLwoTF5XnQcJ7q8UKWZw2NnETv9CEafJtroViicY
         RLziB5i3R7gkpe2qQfDLOjtzzsXh7rtdj1uq+p2NdB840KrxCAOEufpMbDr531bTdagG
         gBEWej7O6eZj8Y/o9RAd5+oQu6aAGcE9kamP3Fbfp7Op9nJF8E9YWEExYUei8QLa86hp
         K9Vw==
X-Gm-Message-State: ABy/qLZdlcXUCUan/ynxM1TRrDnJePyniBEgrtntpbhmIVFOZR8KlBAl
        j+B00lCILF73S28qpJuKcPLM5sEWBRE=
X-Google-Smtp-Source: APBJJlHbIXs5YdWo0jHlQBb/TaAyGsm319HHwbaGco+P3H2xoPcTXP9B03R5HOdngBmrnSQ7KhrYmA==
X-Received: by 2002:a05:6358:2794:b0:133:7c4:e752 with SMTP id l20-20020a056358279400b0013307c4e752mr13392849rwb.26.1688974747335;
        Mon, 10 Jul 2023 00:39:07 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c1-20020aa781c1000000b0067eb174cb9asm6488392pfn.136.2023.07.10.00.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2023 00:39:07 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:48:03 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Chunhai Guo <guochunhai@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com
Subject: Re: [PATCH] erofs: avoid unnecessary loops in
 z_erofs_pcluster_readmore() when read page beyond EOF
Message-ID: <20230710154803.00004047.zbestahu@gmail.com>
In-Reply-To: <20230710042531.28761-1-guochunhai@vivo.com>
References: <20230710042531.28761-1-guochunhai@vivo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 12:25:31 +0800
Chunhai Guo <guochunhai@vivo.com> wrote:

> z_erofs_pcluster_readmore() may take a long time to loop when the page
> offset is large enough, which is unnecessary should be prevented.
> For example, when the following case is encountered, it will loop 4691368
> times, taking about 27 seconds.
>     - offset = 19217289215
>     - inode_size = 1442672
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>  fs/erofs/zdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5f1890e309c6..d9a0763f4595 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1841,7 +1841,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>  	}
>  
>  	cur = map->m_la + map->m_llen - 1;
> -	while (cur >= end) {
> +	while ((cur >= end) && (cur < i_size_read(inode))) {
>  		pgoff_t index = cur >> PAGE_SHIFT;
>  		struct page *page;
>  

Reviewed-by: Yue Hu <huyue2@coolpad.com>
