Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA9637B69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKXO1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKXO1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:27:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBEE9172
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:27:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D91FB82834
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39214C433B5;
        Thu, 24 Nov 2022 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669300037;
        bh=NwnLbZ+fYIFT1sQNHNWPNuDrG0lF0nQj3aZpm7ljHUs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MkY1vANKSNMc9/l6jC5yLRxz0sBj3WTo6WPTv9hQLEPkuKFgHuXzfeBw9W2Rx25c3
         Ye6cDWlfsj9DuKU8wlrcGXiVC4wsX904paUzDJLWUtnmvB4iWDNUa1mq6nsVybe0qB
         hndf3p6S8AaZ/18vc/8Zz+ikrQginnRiNiEr4J4ALfIzX9VypS2yK1XMIG8driR4UJ
         OgPsXlUpa1IfttFM/Abgxg9FXVzn21aDdzGmarOEjGZPVeFWAFyBgjFRue6uIL0ieu
         yXnXnV8uGTueuwcWcnLCGlItCsumIhE1aQjkM1d8L0NpCx+B+Z3S6RPhK8BI+kg/yN
         cH4eVAkwsjAag==
Message-ID: <121c8fec-6194-b9de-5019-205c448e9f62@kernel.org>
Date:   Thu, 24 Nov 2022 22:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: fix to enable compress for newly
 created file if extension matches
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong@oppo.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <f508dea8-5dc3-e29e-0d8b-4d64735817ac@kernel.org>
 <20221115160155.1037163-1-shengyong@oppo.com> <Y3QaDU2n34nmPaiD@google.com>
 <Y36UqrnKcOq5dLrn@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y36UqrnKcOq5dLrn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/24 5:46, Jaegeuk Kim wrote:
> If compress_extension is set, and a newly created file matches the
> extension, the file could be marked as compression file. However,
> if inline_data is also enabled, there is no chance to check its
> extension since f2fs_should_compress() always returns false.
> 
> This patch moves set_compress_inode(), which do extension check, in
> f2fs_should_compress() to check extensions before setting inline
> data flag.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

