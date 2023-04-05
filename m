Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6B6D728D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjDECmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjDECmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3A030F8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F53622DC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E250C433D2;
        Wed,  5 Apr 2023 02:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680662522;
        bh=LRvCEbZX7PFF5LKWejNln0Ezi9mXPo/nLruBdPi7Q6g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=btupqg2jLJ6NzEKRnMhqpVDn9yJOIMqiTmpFS9GWjLMvqAgoTY+9GW7NmNh7mMcmC
         SeBxdkmKs50CO5dk5nMBjz0Ff7Q4fqsgIt/6L5s2RzpvPbRXPZrFI+x8+awpaE1LmP
         bXV1aazE6iuHVTIP26qAt8keDnaVGEY+yKlBMdBBxh58arR4M6+MSW/tvp9dS2j997
         siWc5B+zk1TJvtuygO9vG+/zy0hT9Pt06F0y2jdaKSD6MLQIG3A+pEgkSTga+7bkgJ
         F9YcTFw2JZm8LIUBFjq9zPymaGcYcUW4RlVQx173DoFQfQFwMOvLXxWex7P4tX23PT
         tS5CNvzk8Z8XA==
Message-ID: <a6d9887f-1ff0-fd43-85ff-e6fee87bbe84@kernel.org>
Date:   Wed, 5 Apr 2023 10:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: merge lz4hc_compress_pages() to
 lz4_compress_pages()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230330164948.29644-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330164948.29644-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 0:49, Yangtao Li wrote:
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
>   
>   	if (level)
>   		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>   					cc->clen, level, cc->private);
>   	else

[snip]

>   #endif

[snip]

> +		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,

It's weired that whole else xxx; statement is split by #endif.

What about?

	unsigned char level = 0;

#if
...
#endif
	if (!level)
		len = LZ4_compress_default()

Thanks,

>   						cc->clen, cc->private);
>   	if (!len)
>   		return -EAGAIN;
