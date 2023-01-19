Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C26733BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjASIdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjASIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:33:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6534540;
        Thu, 19 Jan 2023 00:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F84612BF;
        Thu, 19 Jan 2023 08:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C68C433D2;
        Thu, 19 Jan 2023 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674117186;
        bh=2qImJJBtPvbpMy8bN9TWuTOrxUBJRV11KYF65WUjiF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQ6o9iN00moeLnZxGWPPu6Y/EyaZaPzzo5acnghtj9czu7LfWWl1OctyQv2xLPxJn
         jK0/V4HCEm9zYa57hxghEfRvO5siSVGIbk4/nO2UMEUAGpl2bMT3jCepGrRptSnebK
         a256J3ClOqSiQqIs5hEypWEPfXZ1d3lCoO0RPaDj40avpHvLpxYqDxSTnxJT46zWzU
         W7qynKqh7PTke5C7I/SAXYBcoR2JK4Bnm0BtWRo5vf8ZqFbxgquzHs7eB803b8ETpE
         86XnkhP8PX+DNa5aeA925aYMsQl3SfWAkVNwrZzbUeIYqNfUWuoaYH7vBH0h/51pJW
         eWkW0Z/u/QMyw==
Date:   Thu, 19 Jan 2023 09:33:01 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-idmapping tree
Message-ID: <20230119083301.5shri6z3y4eivcpy@wittgenstein>
References: <20230119102659.5f7d3b39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119102659.5f7d3b39@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:26:59AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs-idmapping tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/platforms/cell/spufs/inode.c: In function 'spufs_setattr':
> arch/powerpc/platforms/cell/spufs/inode.c:103:22: error: passing argument 1 of 'setattr_copy' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   103 |         setattr_copy(&idmap, inode, attr);
>       |                      ^~~~~~
>       |                      |
>       |                      struct mnt_idmap **
> In file included from arch/powerpc/platforms/cell/spufs/inode.c:12:
> include/linux/fs.h:2941:19: note: expected 'struct mnt_idmap *' but argument is of type 'struct mnt_idmap **'
>  2941 | void setattr_copy(struct mnt_idmap *, struct inode *inode,
>       |                   ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Ah, cross-compilation...
Thanks for catching and reporting this, Steven!
Fixed now and pushed out.

Christian
