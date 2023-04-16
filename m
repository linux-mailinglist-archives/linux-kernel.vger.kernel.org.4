Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C36E397E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDPOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B31AD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B44613EA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3863AC433D2;
        Sun, 16 Apr 2023 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681656423;
        bh=x/zF9nQGcQmo9J0zDMKFR6/60lK6sJYHHMJyzn5OqyA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iIQnBNiOrw67ku333VmuCHTxqwb3OmXUK8Tk+5/KZ2gLTOY0bfRi3eDvWFA/pIGeA
         NmFzgRsURvpnN4rqgwJVnNKUXjB8FlULg+y+5nr1n5H0dI6ilHOu+AztB4wtCkiofi
         4n55gx+KIoztTEnVrxCkB9wCENvp83H8+EJVuPu0TzipeY6H79cVcg2EeEDc9omcjm
         ZG2nBD1kxyqYii1JrvTwIsAah1hhvhakzn/9PrLAyE1i3QbCwaSSzn1bEYGYy/Bzs/
         qwNOgHCzJMQlssacdK2HPRhDHMMloZsLhRknSUtJxvGNzVTUARTfyyvvGoQ4y9YEi4
         vV5Z1QGdyWbvg==
Message-ID: <363cf8e8-326b-6547-b780-268ce2e3c1a5@kernel.org>
Date:   Sun, 16 Apr 2023 22:47:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: fix potential overflow calculating xattr_isize
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 14:18, Jingbo Xu wrote:
> Given on-disk i_xattr_icount is 16 bits and xattr_isize is calculated
> from i_xattr_icount multiplying 4, xattr_isize has a theoretical maximum
> of 256K (64K * 4).
> 
> Thus declare xattr_isize as unsigned int to avoid the potential overflow.
> 
> Fixes: bfb8674dc044 ("staging: erofs: add erofs in-memory stuffs")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Good catch!

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
