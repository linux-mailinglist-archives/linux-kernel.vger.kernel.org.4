Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2976D8348
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjDEQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjDEQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C872B4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC3363F4F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90945C433EF;
        Wed,  5 Apr 2023 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711192;
        bh=BgZ2eR1AMfTLT7IXUy09mn13VpKwlChWuOugjbAL2Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCQhPEA/ROBdA0GMysw8V4w4TC9dPizo+YVsyMAMp2/lEiKL611OTOfrQYtTfCRzb
         slUv1YM0F+UkaLhyS5vcyZameDhAmRyc/ln3ZwRT0l+t16BRB8z/RN3aViRQP/3C+V
         ycY+3Me4yyEod6BKC/VoQk6S30yn1QVIke7xFnH6qJAbJo39asjnkxZOfqbgve2y9F
         kGNnJJosk/68kGz+2VhigiIF8/GVXkAI6huZP9PR98le9IG3fYuT+sAu4KkWZ88iY1
         0sCPb9dvVsXrONScmh528MKAltAPeg6ElD3u7s75cpk350FZLZZXYik9yhvtrsemkx
         3cGXdhEP/jVxg==
Date:   Wed, 5 Apr 2023 09:13:10 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: merge lz4hc_compress_pages() to
 lz4_compress_pages()
Message-ID: <ZC2eFqN+UdhM6Qu9@google.com>
References: <20230330164948.29644-1-frank.li@vivo.com>
 <a6d9887f-1ff0-fd43-85ff-e6fee87bbe84@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d9887f-1ff0-fd43-85ff-e6fee87bbe84@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05, Chao Yu wrote:
> On 2023/3/31 0:49, Yangtao Li wrote:
> > +#ifdef CONFIG_F2FS_FS_LZ4HC
> > +	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
> >   	if (level)
> >   		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
> >   					cc->clen, level, cc->private);
> >   	else
> 
> [snip]
> 
> >   #endif
> 
> [snip]
> 
> > +		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
> 
> It's weired that whole else xxx; statement is split by #endif.
> 
> What about?
> 
> 	unsigned char level = 0;
> 
> #if
> ...
> #endif
> 	if (!level)
> 		len = LZ4_compress_default()

I modified like this.

--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -266,17 +266,19 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)

 static int lz4_compress_pages(struct compress_ctx *cc)
 {
-       int len;
-#ifdef CONFIG_F2FS_FS_LZ4HC
+       int len = -EINVAL;
        unsigned char level = F2FS_I(cc->inode)->i_compress_level;

-       if (level)
+       if (!level)
+               len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
+                                               cc->clen, cc->private);
+#ifdef CONFIG_F2FS_FS_LZ4HC
+       else
                len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
                                        cc->clen, level, cc->private);
-       else
 #endif
-               len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
-                                               cc->clen, cc->private);
+       if (len < 0)
+               return len;
        if (!len)
                return -EAGAIN;

> 
> Thanks,
> 
> >   						cc->clen, cc->private);
> >   	if (!len)
> >   		return -EAGAIN;
