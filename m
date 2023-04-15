Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5C6E323C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDOQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDOQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49EC4ECB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A40E60AED
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 16:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6908C433D2;
        Sat, 15 Apr 2023 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681574563;
        bh=Keho5jZUf9JoMSbHmX57TIOBY/LQblSMA+MdqWd6VXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmWfuR3uSekN6HhPeC3PBfkOM6/U+mAO6TNArkm/CpYFEZOpXE3G6j9SZM54hvhw9
         I8aKbZdhpUOpdwQM03SAEvB3mNX9SNwsf/8iuo0YqdQJGHYNA4dsumZ1RdjjpFC+2C
         VW7a3a866ltfvQpIK/zlw/YeYnXoIKRukvV3QmFc=
Date:   Sat, 15 Apr 2023 18:02:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix W_DISABLE# does not work after
 stop/start
Message-ID: <2023041515-overhung-grime-d9fc@gregkh>
References: <20230414183452.GA12295@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414183452.GA12295@matrix-ESPRIMO-P710>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:34:52PM +0200, Philipp Hortmann wrote:
> When loading the driver for rtl8192e, the W_DISABLE# switch is working as
> intended. But when the WLAN is turned off in software and then turned on
> again the W_DISABLE# does not work anymore. Reason for this is that in
> the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
> checked and returned when true. bfirst_after_down is set true when
> switching the WLAN off in software. But it is not set to false again
> when WLAN is turned on again.
> 
> Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
> above described bug.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> Tested with rtl8192e (WLL6130-D99)
> Transferred this patch over wlan connection of rtl8192e
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 +
>  1 file changed, 1 insertion(+)


What commit id does this fix?  Should it go to the stable kernels?  If
so, how far back?

thanks,

greg k-h
