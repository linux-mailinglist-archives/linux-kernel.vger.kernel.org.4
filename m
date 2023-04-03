Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321936D3B73
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjDCBWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCBWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52F5FF2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E0561347
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B443C433EF;
        Mon,  3 Apr 2023 01:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680484929;
        bh=vq3meEfVALEsBBZwbhHHOz4f21+3fAlMxYKkExq8F4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d+mlQC511tiET5KQC6WLBW+REjP2kps5koa6Mx6XqUtzJN3Cou+TdGNfkuGTgtbWJ
         q7OaXM0brsN/McY+OrLjyV58lT6HOyUCe5rPdDwWSL8r/19U0D0K/g2MUYXW1H2ESv
         uGiltclUTvvPQOdaDWzP0VhAaJ+SOd9nlSfIfSLYRk44fJVnZfjR3LThtqh3JpdIVE
         6LhygwBwn2cbSm1YpCPuIihFUsUpJJqMeJWQObqJ9uNrkapC6GpeyBWTezh/7huer6
         PvCs+Sxq+/bL28ide2XVlLj3D5R4YGuIg9S9NGgIp7+ppf9tc6YyZPZ/ubqQZHbVQy
         /L/l8Zm+qcWDg==
Message-ID: <d1bbd9b1-9fcb-526b-30b1-efa4b1b92c4c@kernel.org>
Date:   Mon, 3 Apr 2023 09:22:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: f2fs: support fault injection for f2fs_down_write_trylock()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <cc346bd6-16bb-a38d-d0d8-ec7e928b27e9@kernel.org>
 <20230331185505.58726-1-frank.li@vivo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230331185505.58726-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/1 2:55, Yangtao Li wrote:
>> I guess we can cover all trylock w/ FAULT_LOCK_OP type fault injection,

Oops, there is a typo, s/FAULT_LOCK_OP/FAULT_LOCK.

I meant introducing FAULT_LOCK to cover all below functions, and keep
FAULT_LOCK_OP as it is to just cover f2fs_trylock_op...

- inode_trylock
- down_read_trylock
- down_write_trylock
- mutex_trylock
- sb_start_write_trylock
- trylock_page

Thanks,
