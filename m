Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0A71FB52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjFBHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjFBHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1919A;
        Fri,  2 Jun 2023 00:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A085864D0D;
        Fri,  2 Jun 2023 07:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4623C433EF;
        Fri,  2 Jun 2023 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685691929;
        bh=os/KAnDFQ4pvdo7apKPtfWWjGJ3xGGoRFKdJzbIPCZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZSxTw8TYua8wkZJHIX7ioCkIlJR0EfYeNlSQJCzYO8BbGaKfgNJk8V7vlZtnehs/
         HSUdoKy5glYrWXdMUNGcDlK6xlpFBIZt2xfkxWdM/57ksP3QthoCQntHS5UVMVyur5
         CWZgiJMsgTBvxhXrjHogdTIkTZ6C3XFFYc/rAUVc=
Date:   Fri, 2 Jun 2023 08:45:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Fix extraneous semicolon
Message-ID: <2023060210-foam-flip-6f2d@gregkh>
References: <20230601213342.3334659-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601213342.3334659-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:33:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent patch introduced a typo in the fwnode_typec_mux_get()
> stub function that causes a build failure in some configurations:
> 
> In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:23:
> include/linux/usb/typec_mux.h:77:1: error: expected identifier or '(' before '{' token
> include/linux/usb/typec_mux.h:76:33: error: 'fwnode_typec_mux_get' used but never defined [-Werror]
> 
> Fixes: 3524fe31538c1 ("usb: typec: mux: Remove alt mode parameters from the API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/usb/typec_mux.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
> index 11bfa314529fd..2489a7857d8e1 100644
> --- a/include/linux/usb/typec_mux.h
> +++ b/include/linux/usb/typec_mux.h
> @@ -73,7 +73,7 @@ void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
>  
>  #else
>  
> -static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode);
> +static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
>  {
>  	return NULL;
>  }
> -- 
> 2.39.2
> 

Should already be fixed in my tree, and in the next linux-next, sorry.

greg k-h
