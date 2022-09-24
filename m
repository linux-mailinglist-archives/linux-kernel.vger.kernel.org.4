Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B95E8CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIXMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIXMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC1A19D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB8260B23
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 12:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C15C433C1;
        Sat, 24 Sep 2022 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664024071;
        bh=iTo+23ABRQoYs4KDb6OqCvvhIifHYjMgkR/mvdZEnZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Txy57F92um38s+iFx0Gy+MK+KjGQCbO/rsYUU+vJ3pCYh8QbfJ1baYTBZzhi/923t
         f5zMCaUD1YRkAxa/oPixtwW6o+3Qaq56NFDOYar/fJjgjHgX8oUMDvwcpAC+4vLNO8
         Q3AcUbNY9fk7zkaYcED91bOWU6sTnUzUC56RqtTU=
Date:   Sat, 24 Sep 2022 14:54:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Yy7+BCQnGaQiNlyF@kroah.com>
References: <20220919143205.207353-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919143205.207353-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:32:05PM +0800, Zheng Wang wrote:
> In grufile.c, gru_file_unlocked_ioctl function can be called by user.
> 
> If the req is GRU_SET_CONTEXT_OPTION, it will call gru_set_context_option.
> 
> In gru_set_context_option, as req can be controlled by user,
> 
> We can reach gru_check_context_placement function call.
> 
> In gru_check_context_placement function, if the error path was steped,
> 
> say gru_check_chiplet_assignment return 0,
> 
> Then it will fall into gru_unload_context function.
> 
> And it will finnaly call kfree gts in gts_drop function.
> 
> Then gru_unlock_gts will be called in gru_set_context_option function.
> 
> This is a typical Use after free.
> 
> The same problem exists in gru_handle_user_call_os and gru_fault.
> 
> Fix it by introduce the return value to see if gts is in good case or not.
> 
> Free the gts in caller when gru_check_chiplet_assignment check failed.

Your text formatting is a bit odd, don't you think?

> 
> Reported-by: Zheng Wang <hackerzheng666@gmail.com> Zhuorao Yang <alex000young@gmail.com>

Why twice?

Should be two different reported-by lines, right?

Otherwise looks good, can you fix that up and resend?

thanks,

greg k-h
