Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5D6F05B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbjD0M0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbjD0M0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E48230E8;
        Thu, 27 Apr 2023 05:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD46560A5A;
        Thu, 27 Apr 2023 12:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94798C433EF;
        Thu, 27 Apr 2023 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682598363;
        bh=NDjcnjrD5MYzmw1SLBy1J2PWWpUOnpu9UddoVoHMpQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beqeBPWHIW7HJkLMlmT08248JmMIqiHrt43q8BBhTk2Jz2E1JuyvfNko+56z98ClJ
         Ucfv9H4KCA5Q0x4BApVC2BSCuK9Ylp1552sqTMOhP8hCpXBlymrojPyGFtkGKhvPT2
         goib2pFmGq0bWc8Ev7UBeymkGQeku2LaPy1xqltk=
Date:   Thu, 27 Apr 2023 14:26:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Konrad =?iso-8859-1?Q?Gr=E4fe?= <k.graefe@gateware.de>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Message-ID: <2023042731-pedigree-bash-809b@gregkh>
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427115120.241954-1-k.graefe@gateware.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 01:51:19PM +0200, Konrad Gräfe wrote:
> The CDC-ECM specification requires an USB gadget to send the host MAC
> address as uppercase hex string. This change adds the appropriate
> modifier.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Konrad Gräfe <k.graefe@gateware.de>
> ---
> Added in v3
> 
>  lib/vsprintf.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index be71a03c936a..8aee1caabd9e 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1269,9 +1269,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>  {
>  	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
>  	char *p = mac_addr;
> -	int i;
> +	int i, pos;
>  	char separator;
>  	bool reversed = false;
> +	bool uppercase = false;
>  
>  	if (check_pointer(&buf, end, addr, spec))
>  		return buf;
> @@ -1281,6 +1282,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>  		separator = '-';
>  		break;
>  
> +	case 'U':
> +		uppercase = true;
> +		break;

No documentation update as well?

thanks,

greg k-h
