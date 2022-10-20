Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F576054BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJTBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJTBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:13:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A7176B9E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1436AB825C9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C0C433D6;
        Thu, 20 Oct 2022 01:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666228430;
        bh=Cw8qrt3ip8gdBceNfL9nXfoDDLcgJOWUQORT9U0OgmY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=IQUwkQjFOTCfLM8HbhUEy4XKNP9Jua0cFIHTDSKL7E+HSUUU6BqJdrw1o4ABHxkuj
         G/Znji3mQIAyUupvJbUAwgzn36pWrA3yO4/mOAxewL0xcp+9Myzk+ZEahVPCs3rRgD
         SZpoQ6oFys+3LBS0CzU7QPMA2TItQEkrzg23J0EEX2qZlAl4Sfo8lIxPpJLqmSFvUu
         8YtZh5KZS5aZIAYn39v+f+68Sbh1p5ju+KJXDQlUfiai1FnNjAp1qlNtvCcTeGfyt8
         W84XVmKayITrKeTd0O0hxV/Oqr9BxGT8nXCvszXxhYwoFzu0gtQabRd2DVx5G2WVZm
         ROJFg2GzF9TYg==
Message-ID: <b578c945-f695-d505-1e97-fcfbcef6e670@kernel.org>
Date:   Thu, 20 Oct 2022 09:13:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: let's avoid to get cp_rwsem twice by
 f2fs_evict_inode by d_invalidate
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221018005806.892778-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221018005806.892778-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 8:58, Jaegeuk Kim wrote:
> f2fs_unlink
>   -> f2fs_lock_op
>   -> d_invalidate
>    -> shrink_dentry_list
>     -> iput_final
>      -> f2fs_evict_inode
>       -> f2fs_lock_op
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
