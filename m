Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F6736099
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjFTAdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTAdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E5E60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C9160DF7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F13C433C0;
        Tue, 20 Jun 2023 00:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687221222;
        bh=2fIhx9gewgHQdAG7ylH52oVyteZ+F4kPWjIGNK8Ut3g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m8uf3fI1rWhcDoQc1vzBdZELxEoK+yqcFGwVQIhjuDHQqVMTtD0uRQQ2Bcujun0DY
         Kg/cB9HATnKguN9rHJp+bGbSXAFjT/2o5GwawmSNRXWOk6Qxe6O4bHt16L8LUmaRuV
         mMKf+6Kew4YAwDOg02Sf6rjsc72Hd/rx2ESgAeCVOqQ2LCo5YwszxhfLe6Pfqq34x8
         rFMqyz8qI6+TfgGdctzolZ/EU2PxrtJmpInHpuwL5rUFBM0ULBDb7ST5J9EYx54A8z
         hEVNljD126RpkA96NjNOGg0NssXNHqELKZNT2dsDaRK5GwUaOaYiabdjxDEB5XTges
         n3YuMusFEmEEQ==
Message-ID: <b8523d41-246b-b11e-f6e3-423e32cc597a@kernel.org>
Date:   Tue, 20 Jun 2023 08:33:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH] f2fs: not allowed to set file both cold and hot
Content-Language: en-US
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613085250.3648491-1-heyunlei@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230613085250.3648491-1-heyunlei@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 16:52, Yunlei He wrote:
> File set both cold and hot advise bit is confusion, so
> return EINVAL to avoid this case.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>
> ---
>   fs/f2fs/xattr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 213805d3592c..917f3ac9f1a1 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -127,6 +127,9 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
>                  return -EINVAL;
> 
>          new_advise = new_advise & FADVISE_MODIFIABLE_BITS;
> +       if ((new_advise & FADVISE_COLD_BIT) && (new_advise & FADVISE_HOT_BIT))
> +               return -EINVAL;

Yunlei,

What about the below case:

1. f2fs_xattr_advise_set(FADVISE_COLD_BIT)
2. f2fs_xattr_advise_set(FADVISE_HOT_BIT)

Thanks,

> +
>          new_advise |= old_advise & ~FADVISE_MODIFIABLE_BITS;
> 
>          F2FS_I(inode)->i_advise = new_advise;
> --
