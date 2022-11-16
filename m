Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33062C23C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiKPPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiKPPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253804FF92
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B611861E68
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CA7C433C1;
        Wed, 16 Nov 2022 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668611860;
        bh=YLhF/Ea++UhlR7W33Fq52Zp5ffaoubeHoqDup6TI5CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVzyJEvuuxsgMSxiFZfJ5QZ9rUtekRhFl+mNjPjmK0g/1kStr55qINPNL5hOB5vms
         L3IxR7GYaoaxkhqR2KzCj52wJdyc278gSxRvy3f841Kuc5ypnb7mGc/FQiGL5hin0d
         0fjoWWYlqge+A+WTNrhjuRBof2I/5WQcmdcEWRl0=
Date:   Wed, 16 Nov 2022 16:17:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] habanalabs: added return value check for
 hl_fw_dynamic_send_clear_cmd()
Message-ID: <Y3T/ESXEb+MF2QEW@kroah.com>
References: <20221116134126.199087-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116134126.199087-1-marpagan@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:41:25PM +0100, Marco Pagani wrote:
> The clang-analyzer reported a warning: "Value stored to 'rc' is never
> read".
> 
> The return value check for the first hl_fw_dynamic_send_clear_cmd() call
> in hl_fw_dynamic_send_protocol_cmd() appears to be missing.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/misc/habanalabs/common/firmware_if.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
> index 2de6a9bd564d..311942108dbc 100644
> --- a/drivers/misc/habanalabs/common/firmware_if.c
> +++ b/drivers/misc/habanalabs/common/firmware_if.c
> @@ -1782,6 +1782,8 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
>  
>  	/* first send clear command to clean former commands */
>  	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
> +	if (rc)
> +		return rc;
>  
>  	/* send the actual command */
>  	hl_fw_dynamic_send_cmd(hdev, fw_loader, cmd, size);

Are you sure this is ok?  If the first "clean the buffer" command fails,
all should still be good as that wasn't the real command.

But maybe the hardware will never fail this?

thanks,

greg k-h
