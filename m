Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD876E68AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjDRPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjDRPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6914F4B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C52635FB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236AEC433D2;
        Tue, 18 Apr 2023 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681833088;
        bh=cjoNEFKJsnxGn9jI3vfiGlvd+QKFEzWm+NTDrFboZxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ALTkAZNELep2uIbFTjqID1ZplV3k8EnH5AfFc3Yoy1V6FtNka2qHFsRcqxjamQL5f
         RuqAnvDIZwjTNa+NMwc609odY8AzsWUqf5sQG9XR/DmvqySSAJMauZ8ztp0drxebGq
         7a+F9wi9gVrxB+G3oSe/7NcwJ0HxoD0CjDCRa5kBjbrZkMsCxEi4VFTWnL+5Xjl7yt
         27JtiTtpwTcS55mPZg2uBzWEo5+CkrJpzW6r8oCvOSwPB/Fzve8v9isdui2JhiZLat
         H163dxTlUJFbZexf0CTnIiZBzXZLTJLcXR8TwMDyFNWb0wKZk2g11RLY4jrGf2Snkr
         z0hAiBmNFA5MQ==
Message-ID: <2ad8e637-6914-2d3e-3cfa-5f0f7f5ccaea@kernel.org>
Date:   Tue, 18 Apr 2023 23:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to trigger a checkpoint in the end
 of foreground garbage collection
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230324071028.336982-1-chao@kernel.org>
 <ZCyZGgf4RSEjyHTF@google.com>
 <a4e49177-3959-eb2b-996c-5d07b7390495@kernel.org>
 <ZC2aA+i5+HpdJ6M2@google.com>
 <f4ae2b3a-0aff-8941-4081-9dc53334c590@kernel.org>
 <ZDSaCsLSYLyzUxBQ@google.com>
 <6c9abd05-297a-ea4f-fd5c-9f4d9fb488ab@kernel.org>
 <ZDgmGoWx2bHNO1zP@google.com> <ZDgmvf6O488GG7tH@google.com>
 <ZDhXNMkgnmjccIhF@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDhXNMkgnmjccIhF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 3:25, Jaegeuk Kim wrote:
> Fixed a xfstests failure.
> 
>  From 400c722c2117660b83190c88e5442d63fbbffe6e Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 10 Apr 2023 14:48:50 -0700
> Subject: [PATCH] f2fs: refactor f2fs_gc to call checkpoint in urgent condition
> 
> The major change is to call checkpoint, if there's not enough space while having
> some prefree segments in FG_GC case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
