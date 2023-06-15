Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF673168C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbjFOLb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244542AbjFOLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01824271F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D3562679
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BC5C433C8;
        Thu, 15 Jun 2023 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686828683;
        bh=i6WtoXhhTNjiBJRZE30sxXg77MZMRy8IHGt7UB7Sl3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scfV/BDVfsYnBezIZYbx7+QbTIu51SrW0IM9BVSZxHJNX8/2poHAVxh+6iRWjfzeW
         JuojBeFosIY6SAtKX5PbQKAoBWmjJ+u7oUGe+ETFeFO77Ut7LYQ/3VRRghnAMj844H
         /SBo9bPBFyFdLD/ngUGB8h5WBGrEQAvnmRDOtnNk=
Date:   Thu, 15 Jun 2023 13:31:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hexingwei001@208suo.com
Cc:     rafael@kernel.org, wangdeming@inspur.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sample/acrn: fix uninitialized_var.cocci warning
Message-ID: <2023061556-unnamed-reliant-9d95@gregkh>
References: <20230614080847.51136-1-panzhiai@cdjrlc.com>
 <90b3c525ca35cfc28c9445036c8327c2@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b3c525ca35cfc28c9445036c8327c2@208suo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:13:35PM +0800, hexingwei001@208suo.com wrote:
> Fix following coccicheck warning:
> 
> samples/acrn/vm-sample.c:53:6-7: WARNING this kind of initialization is
> deprecated.
> samples/acrn/vm-sample.c:54:6-7: WARNING this kind of initialization is
> deprecated.
> samples/acrn/vm-sample.c:37:5-6: WARNING this kind of initialization is
> deprecated.
> 
> Signed-off-by: Xingwei He <hexingwei001@208suo.com>
> ---
>  samples/acrn/vm-sample.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
> index 704402c64ea3..e60b2d0b7e20 100644
> --- a/samples/acrn/vm-sample.c
> +++ b/samples/acrn/vm-sample.c
> @@ -34,7 +34,6 @@ int is_running = 1;
> 
>  void vm_exit(int sig)
>  {
> -    sig = sig;
> 
>      is_running = 0;
>      ioctl(hsm_fd, ACRN_IOCTL_PAUSE_VM, vmid);
> @@ -50,8 +49,6 @@ int main(int argc, char **argv)
>      struct acrn_io_request *io_req;
>      struct acrn_ioreq_notify __attribute__((aligned(8))) notify;
> 
> -    argc = argc;
> -    argv = argv;
> 
>      ret = posix_memalign(&guest_memory, 4096, GUEST_MEMORY_SIZE);
>      if (ret < 0) {

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
