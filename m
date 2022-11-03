Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F157B617DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiKCNXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKCNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:23:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FAC53;
        Thu,  3 Nov 2022 06:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A551B82798;
        Thu,  3 Nov 2022 13:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9903AC433D7;
        Thu,  3 Nov 2022 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667481819;
        bh=Ptts9H7CMiwi/Nx896qtMeZvxnyHeELD05B85Sla9Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0jYwksaXvB5Vk5tvv3rWzUqTcxijVVas/QEdj/xij+0Fy6/Nj8zXLyG6HjShpIoj
         cC1vGftaHsd76TGUaIzhrORqJ+vXtQYWHEEP8j6CTOKPo6ne6ZNam0FO6aDGR/5NnS
         dqhZBldoSuX8EbW4nuQKa4P0v9318WIdc6rU+aaI=
Date:   Thu, 3 Nov 2022 22:24:19 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb/usbip: Fix v_recv_cmd_submit() to use PIPE_BULK
 define
Message-ID: <Y2PBA5hmqm9G/DNT@kroah.com>
References: <cover.1667480280.git.skhan@linuxfoundation.org>
 <c9790c485bfe31c55bbd2f9b270548ecefddc91a.1667480280.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9790c485bfe31c55bbd2f9b270548ecefddc91a.1667480280.git.skhan@linuxfoundation.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 07:12:43AM -0600, Shuah Khan wrote:
> Fix v_recv_cmd_submit() to use PIPE_BULK define instead of hard coded
> values. This also fixes the following signed integer overflow error
> reported by cppcheck. This is not an issue since pipe is unsigned int.
> However, this change improves the code to use proper define.
> 
> drivers/usb/usbip/vudc_rx.c:152:26: error: Signed integer overflow for expression '3<<30'. [integerOverflow]
>  urb_p->urb->pipe &= ~(3 << 30);
> 
> In addition, add a sanity check for PIPE_BULK != 3 as the code path depends
> on PIPE_BULK = 3.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/usb/usbip/vudc_rx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/vudc_rx.c b/drivers/usb/usbip/vudc_rx.c
> index a6ca27f10b68..e7e0eb6bbca0 100644
> --- a/drivers/usb/usbip/vudc_rx.c
> +++ b/drivers/usb/usbip/vudc_rx.c
> @@ -149,7 +149,10 @@ static int v_recv_cmd_submit(struct vudc *udc,
>  	urb_p->urb->status = -EINPROGRESS;
>  
>  	/* FIXME: more pipe setup to please usbip_common */
> -	urb_p->urb->pipe &= ~(3 << 30);
> +#if PIPE_BULK != 3
> +#error "Sanity check failed, this code presumes PIPE_... to range from 0 to 3"
> +#endif

Perhaps use BUILD_BUG_ON() instead of hand-rolling one?

thanks,

greg k-h
