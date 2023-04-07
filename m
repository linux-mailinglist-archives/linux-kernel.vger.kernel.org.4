Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646F66DA6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjDGBW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDGBW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20B49FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6ED64052
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CCCC433D2;
        Fri,  7 Apr 2023 01:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680830545;
        bh=YAEuWYm9lK18MqiZgFjU2fpTN2+518FfqL/Eo+yVUY4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KhBSoofFLD9bp1DKr+0j3g2IeG+Z+0XB++sZioLL6m6Wj2BZ6eXDflwG5O2gJZXIa
         25GGvf4+APi8azyL5B46z3itwHtxi6F1tAeoMD5MvRtbrfAuPRDydycA1McQJ/Lg37
         zmfUnZJwoIzSGbJHEGXugUBzFD5Fivy8OJkaaBdpqn8kRKazjGHBpyRfD9o3HXUh6b
         1DaZTAkkAaS3tf5VoVbPWZIx/kyi6VpKGVATE0l4FeOilcIamFV1CYEvIJqGqOVohS
         YGTFw7bA1WaUfiSQWDGMfUWqlUb7DBsm2rZ3t+zERql+CVusz+l0Gf7hrUG0524Vcn
         alaVaOWPPodQA==
Message-ID: <ea5102a1-eb91-6799-4353-aefd877e0864@kernel.org>
Date:   Fri, 7 Apr 2023 09:22:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] f2fs: merge lz4hc_compress_pages() to
 lz4_compress_pages()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230330164948.29644-1-frank.li@vivo.com>
 <a6d9887f-1ff0-fd43-85ff-e6fee87bbe84@kernel.org>
 <ZC2eFqN+UdhM6Qu9@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZC2eFqN+UdhM6Qu9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/6 0:13, Jaegeuk Kim wrote:
> On 04/05, Chao Yu wrote:
>> On 2023/3/31 0:49, Yangtao Li wrote:
>>> +#ifdef CONFIG_F2FS_FS_LZ4HC
>>> +	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
>>>    	if (level)
>>>    		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>>>    					cc->clen, level, cc->private);
>>>    	else
>>
>> [snip]
>>
>>>    #endif
>>
>> [snip]
>>
>>> +		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>>
>> It's weired that whole else xxx; statement is split by #endif.
>>
>> What about?
>>
>> 	unsigned char level = 0;
>>
>> #if
>> ...
>> #endif
>> 	if (!level)
>> 		len = LZ4_compress_default()
> 
> I modified like this.
> 
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -266,17 +266,19 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
> 
>   static int lz4_compress_pages(struct compress_ctx *cc)
>   {
> -       int len;
> -#ifdef CONFIG_F2FS_FS_LZ4HC
> +       int len = -EINVAL;
>          unsigned char level = F2FS_I(cc->inode)->i_compress_level;
> 
> -       if (level)
> +       if (!level)
> +               len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
> +                                               cc->clen, cc->private);
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +       else
>                  len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>                                          cc->clen, level, cc->private);
> -       else
>   #endif
> -               len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
> -                                               cc->clen, cc->private);
> +       if (len < 0)
> +               return len;
>          if (!len)
>                  return -EAGAIN;
> 

Better.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
