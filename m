Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631766FEB25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEKFZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjEKFY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:24:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7259C8;
        Wed, 10 May 2023 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jpjx0+1TzM/xElw7zqGQAWr6tHiXW62cpD0aGeOQc4s=; b=mPbIOnc44bauerooZplYxUNlMM
        6NEuJ5+ZiFL2EtPdpLyKm60n8tY4m0hOumEM3lrSlov0BFBMDHUDy3LQx+4emnU5I8XZTAZrpx7n5
        N1GcJZM/WiYKhxqfcGD6wIrGFQZGMk3ztOUT0AXYVAr4xgzonXVWuQJ/4SGMxFY83G00RJ3RDT5d2
        /8lWel8WQteF51UEhyfJTcPgscQ/PuGUNaCoosmNbcphSLxlHV3a/ED/JOac9WqdtEwzOR+1R0xne
        GFcTNigwCOE8q4h8KKsac7Ezr0rj0tUZs2zLSlyD9URVvh+2bQUag1cZ8/+O93DQMa3/GmqjikxWH
        Qzcgkptw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwymw-001cJW-2v;
        Thu, 11 May 2023 05:24:27 +0000
Date:   Thu, 11 May 2023 06:24:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: socket: Use fdget() and fdput()
Message-ID: <20230511052426.GH3390869@ZenIV>
References: <202305051706416319733@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051706416319733@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 05:06:41PM +0800, ye.xingchen@zte.com.cn wrote:
> By using the fdget function, the socket object, can be quickly obtained
> from the process's file descriptor table without the need to obtain the
> file descriptor first before passing it as a parameter to the fget
> function.

>  struct socket *sockfd_lookup(int fd, int *err)
>  {
> -	struct file *file;
> +	struct fd f = fdget(fd);
>  	struct socket *sock;
> 
> -	file = fget(fd);
> -	if (!file) {
> +	if (!f.file) {
>  		*err = -EBADF;
>  		return NULL;
>  	}
> 
> -	sock = sock_from_file(file);
> +	sock = sock_from_file(f.file);
>  	if (!sock) {
>  		*err = -ENOTSOCK;
> -		fput(file);
> +		fdput(f);
>  	}
>  	return sock;

Suppose you've got that far.  If descriptor table had been shared, you've
bumped the refcount of struct file.  If it hadn't been, that refcount
had remained unchanged.  And there is no way for the caller of this
function to tell one outcome from another.

That can't work.
