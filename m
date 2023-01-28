Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B067FA10
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjA1RrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjA1RrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AD93F1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A7660C38
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DBAC433EF;
        Sat, 28 Jan 2023 17:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674928029;
        bh=c3n0kLR7Zkg0nZae8x46dJDbuytPTt4re9xU6aLzm0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaA8BK6HSqtWc5lOVwX+JzPNTQGiKe0xth8xnv77yDu9WUdgzvxaKMqTYFrBYxONl
         IBKb05px0pZcZeL6YLK67/ZfW4S6PdSttOkujHjK5x0PUcKeAZwIrAuinReF+8WKcK
         ej/xFp3uy3c1bFQBzfAH5UaFz5J0MB+4wItv3DgU=
Date:   Sat, 28 Jan 2023 18:47:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: remove unused header variable in
 gb_operation_message_alloc()
Message-ID: <Y9VfmT3Umlo7LHN6@kroah.com>
References: <20230128155706.1243283-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128155706.1243283-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 07:57:06AM -0800, Tom Rix wrote:
> cppcheck reports
> drivers/greybus/operation.c:365:31: style: Variable 'header' is not assigned a value. [unassignedVariable]
>  struct gb_operation_msg_hdr *header;
>                               ^

That's not a real problem.

> header is only used to calculate the size of the messge.  This can be done without a variable
> but rather with calling sizeof() with the struct type.
> 
> Fixes: dc779229b538 ("greybus: introduce gb_operation_message_init()")

This is not a bug that is being fixed.

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/greybus/operation.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
> index 8459e9bc0749..9d322fc6531b 100644
> --- a/drivers/greybus/operation.c
> +++ b/drivers/greybus/operation.c
> @@ -362,8 +362,7 @@ gb_operation_message_alloc(struct gb_host_device *hd, u8 type,
>  			   size_t payload_size, gfp_t gfp_flags)
>  {
>  	struct gb_message *message;
> -	struct gb_operation_msg_hdr *header;
> -	size_t message_size = payload_size + sizeof(*header);
> +	size_t message_size = payload_size + sizeof(struct gb_operation_msg_hdr);

The compiler does not use any extra room for header, so this should be
fine, it's not a real issue.

cppcheck almost never finds anything real, be careful...

thanks,

greg k-h
