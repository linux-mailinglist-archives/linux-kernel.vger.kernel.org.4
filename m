Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87331734993
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 02:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFSAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFSAyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 20:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE519C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 17:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFE160FED
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D6C433C9;
        Mon, 19 Jun 2023 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687136077;
        bh=J5rPQv5FZPHF2Y1H1ENGnLbVVE0JpWkmTsnb0eHScI0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P8K4CmEjNDfHnh0orkbOZPaEX5mgFJXcCqfNf0JBhIrSAAagGvGRGeZfyFgUp4Y5J
         juNLAB5KOgahrRYNYG9UkQtwjI5zIfP4R2/kMYjvFEPLltxaSurNxeZF5rENBMpJTR
         Pz2L546yiFkP/pPV1+7Q+uhZLpLWkxoq56PjVQZmzWahwiRLTnrfuT0pKTph3zpvnd
         UfOwEKYRP20u8snxlEQ+9+FjqvLkDgkmeGN3kyEPBl8Q5iAbwcAqnf1h+CG+nj2dUu
         n/1Jc+wi4v8V0eKFRn7Yv8Lb3glrYAjZbUnuI0E0RKLZQroum02RtsS7Bzrlu+kzna
         us1rDRFrpgFcw==
Message-ID: <7ab6b6f9-37fa-9bf2-69ce-7b1b1944d9f3@kernel.org>
Date:   Mon, 19 Jun 2023 08:54:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] f2fs: compress: don't force buffered io when in
 COMPR_MODE_USER mode
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230609131555.56651-1-frank.li@vivo.com>
 <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
 <dde6972a-e98c-8a6e-493b-9aff5668101d@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <dde6972a-e98c-8a6e-493b-9aff5668101d@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 12:14, Yangtao Li wrote:
> 
> On 2023/6/12 22:38, Chao Yu wrote:
>> On 2023/6/9 21:15, Yangtao Li wrote:
>>> It is observed that when in user compression mode
>>> (compress_extension=*),
>>> even though the file is not compressed, the file is still forced to use
>>> buffer io, which makes the AndroBench sequential read and write drop
>>> significantly. In fact, when the file is not compressed, we don't need
>>> to force it to buffer io.
>>>
>>>                    | w/o patch | w/ patch |
>>> seq read  (MB/s) | 1320.068  | 3696.154 |
>>> seq write (MB/s) | 617.996   | 2978.478 |
>>>
>>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/f2fs.h | 14 ++++++++++++++
>>>    fs/f2fs/file.c |  2 +-
>>>    2 files changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 1efcfd9e5a99..7f5472525310 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct
>>> inode *inode)
>>>            is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>>>    }
>>>    +static inline bool f2fs_is_compressed_file(struct inode *inode)
>>> +{
>>> +    int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>>> +
>>> +    if (compress_mode == COMPR_MODE_FS)
>>> +        return f2fs_compressed_file(inode);
>>> +    else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||
>>
>> Should check dirty page as well? i_compr_blocks may increase after
>> data writeback.
>>
> IIUC, in COMPR_MODE_USER mode, i_compr_blocks will only be updated when
> FI_ENABLE_COMPRESS is enabled.
> 
> If FI_ENABLE_COMPRESS is not enabled, i_compr_blocks will never be
> updated after data writeback.
> 
> So there is no need to additionally judge whether there is a dirty page?

Oh, user mode, that's correct.

If we allow dio/aio on compress file, it needs to consider race case in
between aio and ioc_compress_file.

Thanks,

> 
> 
> Thanks,
> 
>> Thanks,
>>
>>> +        is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
>>> +        is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
>>> +        return true;
>>> +
>>> +    return false;
>>> +}
>>> +
>>>    static inline bool f2fs_need_compress_data(struct inode *inode)
>>>    {
>>>        int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 74ecc9e20619..0698129b2165 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode
>>> *inode, int rw)
>>>            return true;
>>>        if (fsverity_active(inode))
>>>            return true;
>>> -    if (f2fs_compressed_file(inode))
>>> +    if (f2fs_is_compressed_file(inode))
>>>            return true;
>>>          /* disallow direct IO if any of devices has unaligned blksize */
