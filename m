Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF6629DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiKOPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiKOPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:34:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3AE007;
        Tue, 15 Nov 2022 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668526450; x=1700062450;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9Xa8FNyt4rbCBBfcK3IywB5xwQCsUT/g+nCwG40O7yQ=;
  b=nOFGz8ARev2fl6USzBW2a0Yq5ZVrPRy9Fqgm/5nDHOF+r6+lVYCWF/9x
   Hnx9V1fetWZwbrsS625VLBiu2QVLiQmGQEZZnOJLJEybE9YYxMz01VkRM
   +ZIYSgC+vQnhval7zWDR2cb3zbgduMU3rmSQVnDI+1DzcBWBSjftBFMbu
   180US7G7XeuxXGc5jCE5m6i/M9posjW/cxGK9zXeBbAOT3uyR98LQ7ma2
   hYn+gknLmnjJUzpYpxV9J6zdMR7GVnZCNFaDGpuJQlqGuKs2ip/KUMFux
   9sVf5tE1iKkhRnKRQhDwn+f5Zi1mvYcj+MmMlyBhN7PaBlCz+GJKr80A6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374413702"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="374413702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:33:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="641245703"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="641245703"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:33:48 -0800
Date:   Tue, 15 Nov 2022 17:33:47 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 02/14] serial: liteuart: use bit number macros
In-Reply-To: <20221112212125.448824-3-gsomlo@gmail.com>
Message-ID: <40b5679c-5316-9c5c-7e4-5c8c74ba1acf@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-3-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 32b81bd03d0c..1497d4cdc221 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -38,8 +38,8 @@
>  #define OFF_EV_ENABLE	0x14
>  
>  /* events */
> -#define EV_TX		0x1
> -#define EV_RX		0x2
> +#define EV_TX		BIT(0)
> +#define EV_RX		BIT(1)
>  
>  struct liteuart_port {
>  	struct uart_port port;
> 

This seems to assume some random header provides BIT() for you?

-- 
 i.

