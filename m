Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5074F15A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGKONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjGKONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EDDB0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E34BA61507
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A383C433C7;
        Tue, 11 Jul 2023 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689084791;
        bh=ey4qn+pT0IA1mK/T0+mJ6fLdRbp//RxtgG7x1mdoLLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EciwUIRWaebB86Qom7c2/r8nP+TILoFVFBdaKK6DYkhMRyCA8COYXi7ESsPZ6Gs5g
         O/igAFHMLW30AQAvyNH1IRHYHZZ71sLeUCmiHwtveXv9iVhaLzeeh55Q/Bv2LZ4Wj0
         CICwMo4kyjDBC2xmrw/dwoOyMcLRqU6sUWlnlymtOBwoNjDB9e0VBADysTMLsExYvH
         Jqb/turISJkZhLq/2hjcwzwZcQe9PPO/D6ZgcQ29/Tl4b0Yzag/n/lXxt7orIVRsLV
         RlkQ3L4JQHzOPPWfkEUTcMNy9RodN62f99g9mrA7wXDkwjrILI9YXCSH1btkIv2BOw
         8S1uGbN9Tptug==
Message-ID: <b80ed611-7844-5cb8-255e-b41e78901942@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: fix to avoid infinite loop in
 z_erofs_do_read_page() when read page beyond EOF
Content-Language: en-US
To:     Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc:     huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230710093410.44071-1-guochunhai@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230710093410.44071-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/10 17:34, Chunhai Guo wrote:
> z_erofs_do_read_page() may loop infinitely due to the inappropriate
> truncation in the below statement. Since the offset is 64 bits and min_t()
> truncates the result to 32 bits. The solution is to replace unsigned int
> with a 64-bit type, such as erofs_off_t.
>      cur = end - min_t(unsigned int, offset + end - map->m_la, end);
> 
>      - For example:
>          - offset = 0x400160000
>          - end = 0x370
>          - map->m_la = 0x160370
>          - offset + end - map->m_la = 0x400000000
>          - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>      - Expected result:
>          - cur = 0
>      - Actual result:
>          - cur = 0x370
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
