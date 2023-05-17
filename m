Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23023705D64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjEQCou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjEQCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5F1706
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13FAA63ECB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44ADC433EF;
        Wed, 17 May 2023 02:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684291486;
        bh=qNDtCoajT3pDCRQM68Y/i7MapdhfLICp5GbRlmJgsYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cKrDFv3Fqj0jRSbVb5JVYzZZ6aQ2YaEDTDuh33Mx3eSy6p93EUDjLrIEryyNUJ4jq
         YpBZPK71rmQNCGaH5Y8aFgRhseEv4fypMy2NHLT0EWd2V61V5tOkNEqPEBMtbiMmur
         mVLGVziAfjLXNvcZ51S3R2KEV+rkYzvcipIojRDruDckZeDHl2OwJ0erUrT46GS/eC
         NsQbO2uAvy9NuSeI67uvwx61Ll8IRSEz+F5ATL9NlJZTuUYoYcVIOfLhSjX6NTn0Tx
         5q9El8T4cyTf0Ig8fSsDJq7eJHEdGVw9fboKGsguIBcH7g8+1FqtQXOpm1vfIQe+l3
         cDLHLLKomed3g==
Message-ID: <45eb63c6-a147-776a-99b5-7ac06848ede8@kernel.org>
Date:   Wed, 17 May 2023 10:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] f2fs: pass I_NEW flag to trace event
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230516120747.68844-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230516120747.68844-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/16 20:07, Wu Bo wrote:
> Modify the order between 'trace_f2fs_iget' & 'unlock_new_inode', so the
> I_NEW can pass to the trace event when the inode initialised.

Why is it needed? And trace_f2fs_iget() won't print inode->i_state?

Thanks,

> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index cf4327ad106c..caf959289fe7 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -577,8 +577,8 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>   		file_dont_truncate(inode);
>   	}
>   
> -	unlock_new_inode(inode);
>   	trace_f2fs_iget(inode);
> +	unlock_new_inode(inode);
>   	return inode;
>   
>   bad_inode:
