Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76BB5B6605
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiIMDLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiIMDLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:11:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ABA53D3C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54664B80E0E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14998C433C1;
        Tue, 13 Sep 2022 03:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663038687;
        bh=T82nGUCNImec5KMWq8d1Rk3J3+w64aQ6jgFDyTq/njw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=jg6Jw+RpYDfVREd/4Ipyatsnyv5+EI3o7gVvwtQwZNYswbGDXsJ41NlNDwl5B4265
         KEbyW6s43OSRFTx0Tz9qf/smJYBcOJ2zvkCXdQnlnqdaBKPPDH8wPdpoL/ASjPlJW/
         o59obaVTdh6OIjzg0NoxU9H5EM+XZjxKsqQUVGC7aXzs0YzCGNtDgjQrcvPOdE4iry
         B528uq0Rg0TcbSoom1szEQd5ICY4CzJUIxenJPyRbyhfg8EiR4I224dqQUIKeXToMp
         GoVuK6RqrfdII7UHERsgHDUO2pBWMZF9e3wHF8HhRB8VxeDi7i9IOkAnh3C8N2kADW
         E/llEWOoQ78/g==
Message-ID: <791f5692-0814-2bd7-712a-829e1cedb891@kernel.org>
Date:   Tue, 13 Sep 2022 11:11:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: complete checkpoints during
 remount
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220819231514.3609958-1-jaegeuk@kernel.org>
 <20220819231514.3609958-2-jaegeuk@kernel.org> <YwaKbmB23U9czf51@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YwaKbmB23U9czf51@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/25 4:30, Jaegeuk Kim wrote:
> Otherwise, pending checkpoints can contribute a race condition to give a
> quota warning.
> 
> - Thread                      - checkpoint thread
>                                add checkpoints to the list
> do_remount()
>   down_write(&sb->s_umount);
>   f2fs_remount()
>                                block_operations()
>                                 down_read_trylock(&sb->s_umount) = 0
>   up_write(&sb->s_umount);
>                                 f2fs_quota_sync()
>                                  dquot_writeback_dquots()
>                                   WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));
> 
> Or,
> 
> do_remount()
>   down_write(&sb->s_umount);
>   f2fs_remount()
>                                create a ckpt thread
>                                f2fs_enable_checkpoint() adds checkpoints
> 			      wait for f2fs_sync_fs()
>                                trigger another pending checkpoint
>                                 block_operations()
>                                  down_read_trylock(&sb->s_umount) = 0
>   up_write(&sb->s_umount);
>                                  f2fs_quota_sync()
>                                   dquot_writeback_dquots()
>                                    WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
