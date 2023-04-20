Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B9D6E92F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjDTLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjDTLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E65135;
        Thu, 20 Apr 2023 04:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026D961490;
        Thu, 20 Apr 2023 11:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172AAC433D2;
        Thu, 20 Apr 2023 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681990686;
        bh=E9efpz6H7IX3Lm8biAUjQz0BhZRtbYxfkYkzIpWjHDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooDl0hDofVKWsvg+I+HQfCQZT0DGI9PG2sTOTKf1kn6JtnTHEHs7O/FW8P4jeqafl
         p3PUYQxc0Vs3gP1bGCT0FkOzdE2FResjmD/NupJ1Mvc9sbIhkSAcIpl+no61w8VIIN
         TJ5gYq73vpTCnTW/JvbDu2pfxBdMxhj2PUqltdlk=
Date:   Thu, 20 Apr 2023 13:38:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_exar: Add support for USR298x PCI Modems
Message-ID: <ZEEkGzoemaSgKovK@kroah.com>
References: <20230413214421.6251-1-afd@ti.com>
 <20230413214421.6251-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413214421.6251-2-afd@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:44:21PM -0500, Andrew Davis wrote:
> Possibly the last PCI controller-based (i.e. not a soft/winmodem)
> dial-up modem one can still buy.
> 
> Looks to have a stock XR17C154 PCI UART chip for communication, but for
> some reason when provisioning the PCI IDs they swapped the vendor and
> subvendor IDs. Otherwise this card would have worked out of the box.
> 
> Searching online, some folks seem to not have this issue and others do,
> so it is possible only some batches of cards have this error.
> 
> Create a new macro to handle the switched IDs and add support here.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Please redo this without patch 1/2 as that would not make sense to
backport anywhere, but adding new device ids are allowed in stable
kernels.  Also, as others pointed out, either convert them all or none
:)

thanks,

greg k-h
