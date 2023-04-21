Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5886EADB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjDUPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjDUPIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5302D49
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F5F61475
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F95C433EF;
        Fri, 21 Apr 2023 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682089716;
        bh=1i7j+X46zvSlI6Z+TMWDeqVeOCFHR1IVigQcStEkzH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AA1N0siPr1NrFT1Ip0ph8FAyQLTqMG2B9SBxBsb7eUH7X7iXCjSPDUa5yJxKFhI+a
         5MvtYuC9M9CL+4Gi6cb88NtS64WNOliJK92OWfwpBf7tVf6z5umaLOzwkG/1LLHbOH
         c7VBfw0XituE9xg5Z7m0Z1sw4K7sSxmdcH4gKI6w=
Date:   Fri, 21 Apr 2023 17:08:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Scott Branden <sbranden@broadcom.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v4 1/1] test_firmware: fix some memory leaks and racing
 conditions
Message-ID: <ZEKm8Z2Ez84nC5NB@kroah.com>
References: <20230421145700.20931-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421145700.20931-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:57:01PM +0200, Mirsad Goran Todorovac wrote:
> Some functions were called both from locked and unlocked context, so
> the lock was dropped prematurely, introducing a race condition when
> deadlock was avoided.
> 
> Having two locks wouldn't assure a race-proof mutual exclusion.
> 
> __test_dev_config_update_bool(), __test_dev_config_update_u8() and
> __test_dev_config_update_size_t() unlocked versions of the functions
> were introduced to be called from the locked contexts as a workaround
> without releasing the main driver's lock and causing a race condition.
> 
> This should guarantee mutual exclusion and prevent any race conditions.
> 
> Locked versions simply allow for mutual exclusion and call the unlocked
> counterparts, to avoid duplication of code.
> 
> trigger_batched_requests_store() and trigger_batched_requests_async_store()
> now return -EBUSY if called with test_fw_config->reqs already allocated,
> so the memory leak is prevented.
> 
> The same functions now keep track of the allocated buf for firmware in
> req->fw_buf as release_firmware() will not deallocate this storage for us.
> 
> Additionally, in __test_release_all_firmware(), req->fw_buf is released
> before calling release_firmware(reqs->fw) foreach test_fw_config->regs[i].
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> Cc: Luis Chamberlain <mcgrof@kernel.org> 
> Cc: Russ Weight <russell.h.weight@intel.com> 
> Cc: Tianfei zhang <tianfei.zhang@intel.com> 
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr> 
> Cc: Zhengchao Shao <shaozhengchao@huawei.com> 
> Cc: Colin Ian King <colin.i.king@gmail.com> 
> Cc: linux-kernel@vger.kernel.org 
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>  lib/test_firmware.c | 81 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 63 insertions(+), 18 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
