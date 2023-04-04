Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C96D55C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjDDBQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDDBQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72A2101
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F2061631
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B40C433D2;
        Tue,  4 Apr 2023 01:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680570993;
        bh=ImnzqcPQJHnWnlK8ylnOnQS3YAQ3sNcQ92eD3xoDbq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sjx6yjbtf6SN1EgfbkCuvIp60VLjP0+4e2Lu4AEVPzlWM4u0GjdN+S/xuwnUS+8sX
         919EQa5LUhSsM/z9XnX3Nc9OWTyVY7ShNHLZnGINtH1iRmssTA8UdyaUFMQ8ZY7ege
         /28ieBV/+RMFuKXuUf0PA2g4ZBSb9UYrLzppi/XAbwWszXFMK3ZFkpGxQSxy/aQ/Y+
         CzqroVEsQ3p3CRbc+ZnLvdC/BeXWwLv839Su+fuh8+knCeKw3MOFwbiEXBSvJEQaAO
         Ckyw7s5iSVQalPjngaCtsTVFIfCsZhPFf+Qzmwl1SO9USBOGWZd/F3+XWU9XHubRLd
         DYBX7jZHDsjaA==
Message-ID: <5b766d0c-fae7-885a-0dc9-a16d90540260@kernel.org>
Date:   Tue, 4 Apr 2023 09:16:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND] f2fs: add sanity compress level check for compressed
 file
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org, terrelln@fb.com
References: <20230330162811.18923-1-frank.li@vivo.com>
 <20230403133359.6649-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230403133359.6649-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/3 21:33, Yangtao Li wrote:
> Hi Chao,
> 
>> Why not zstd_max_clevel()?
> 
> zstd_max_clevel() is only defined when CONFIG_F2FS_FS_ZSTD is enabled,
> using zstd_max_clevel() will result in compile errors otherwise.
> 
> If using the following code,
> 
> ----------------------------------------------------------------------------
>          switch (ri->i_compress_algorithm) {
>          case COMPRESS_LZO:
>          case COMPRESS_LZORLE:
>                  if (compress_level)
>                          goto err;
>                  break;
>          case COMPRESS_LZ4:
>                  if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
>                                  compress_level > LZ4HC_MAX_CLEVEL)
>                          goto err;
>                  break;
> #ifdef CONFIG_F2FS_FS_ZSTD
>          case COMPRESS_ZSTD:

Hi Yangtao,

How about:

#ifdef CONFIG_F2FS_FS_ZSTD
	if (!compress_level || compress_level > zstd_max_clevel())
		goto err;
#endif
	break;

>                  if (!compress_level || compress_level > zstd_max_clevel())
>                          goto err;
>                  break;
> #endif
>          default:
>                  goto err;
>          }
> ----------------------------------------------------------------------------
> 
> then we will get this result:
> 
> 	F2FS-fs (loop0): sanity_check_compress_inode: inode (ino=4) has
> 			unsupported compress level: 0, run fsck to fix
> 
> Another way is to use the following code, which ignores the check for
> level when CONFIG_F2FS_FS_ZSTD is not enabled.
> 
> ----------------------------------------------------------------------------
>          switch (ri->i_compress_algorithm) {
>          case COMPRESS_LZO:
>          case COMPRESS_LZORLE:
>                  if (compress_level)
>                          goto err;
>                  break;
>          case COMPRESS_LZ4:
>                  if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
>                                  compress_level > LZ4HC_MAX_CLEVEL)
>                          goto err;
>                  break;
>          case COMPRESS_ZSTD:
> #ifdef CONFIG_F2FS_FS_ZSTD
>                  if (!compress_level || compress_level > zstd_max_clevel())
>                          goto err;
>                  break;
> #else
>                  return true;
> #endif
>          default:
>                  goto err;
>          }
> ----------------------------------------------------------------------------
> 
> Perhaps exporting ZSTD_MAX_CLEVEL is a better choice?
> 
> Thx,
> Yangtao
