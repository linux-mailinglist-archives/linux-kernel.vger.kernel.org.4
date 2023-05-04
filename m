Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46C6F695F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjEDK7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:58:30 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F2B49FC;
        Thu,  4 May 2023 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=wPc+1lRKbuuh0qu/VajEPCBbvOr3RpZaWW8UHDepHkc=; b=Vvj0BwKde6+t0ZO80Mfm6u6rnf
        9KEC96O66zJwWfCn1viz5ae2MwDgqv4PWH2dcS5AjIT6pQ6kjAc5K7WRilrpF55gzBXDK2huXME2W
        Tsr61tZoN8ab1rYhkY4+UFbfnsdZaW5LTqMazogClEXAUDNEmDnDu38EghAvrrQqSWfZD5Jb+dUK5
        7Me+IThulsuoFydHuxU6HZTBvLab904xi46MLOMLwDfwFxOsSyLy3A6WY8Oa9tAQaIKZGtMg8AWwd
        j9vc92QFDsegoX0FoBuGT+tNJlGaF3wWq5yhJZAZO6+9A+U6wDrn7QnGhLj5QVAgtsRvzC2j7Lqqx
        cHJNDHOK6V08pjVpJ31ceSZ2yVFeM2D2hA9fCrA3eQgtK9jRv0DKtoYuAZg1hx4nYr0OOOPZU+OTB
        740XxMNpgS7FvFGvjvXkch2sBqNUckMRbi2a8z4rEP8f5aMJFTrPfQxfkcJb11V6sYTMFXPsEij/6
        I1Ebd8F//Nku4wwvONyPCYYw+8kS7FIWwz+abO1/nlfYYddBacbsYZRnKYE+3RS3bfsGPGyX5741m
        hIuOZizMVR4fk4se52QWYLHelV5a7nq0FuqGZpucXJKdOlJFT6Z9soEUX5DcktANdxPI7xwJw85lD
        0RkGqyONPAvUoVE2ax6+I7616t5F7ZttP+rahGesM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jason Andryuk <jandryuk@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] 9p: Remove INET dependency
Date:   Thu, 04 May 2023 12:58:08 +0200
Message-ID: <4317357.pJ3umoczA4@silver>
In-Reply-To: <20230503141123.23290-1-jandryuk@gmail.com>
References: <20230503141123.23290-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 3, 2023 4:11:20 PM CEST Jason Andryuk wrote:
> 9pfs can run over assorted transports, so it doesn't have an INET
> dependency.  Drop it and remove the includes of linux/inet.h.
> 
> NET_9P_FD/trans_fd.o builds without INET or UNIX and is unusable over

s/unusable/usable/ ?

> plain file descriptors.  However, tcp and unix functionality is still
> built and would generate runtime failures if used.  Add imply INET and
> UNIX to NET_9P_FD, so functionality is enabled by default but can still
> be explicitly disabled.
> 
> This allows configuring 9pfs over Xen with INET and UNIX disabled.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> v2
> Add imply INET and UNIX


