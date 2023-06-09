Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8CC728C86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbjFIAfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjFIAfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D7A30C5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6DBF6526C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0F4C433D2;
        Fri,  9 Jun 2023 00:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686270935;
        bh=rf9kFWrcbyc3Rq1CjEszyMQMd9LhWryGbqdtczQ/mjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgqbpkCaxpVXWR3bSP70fx3YPU5BCFAtanvK9EiR0D2RNDSWErLeZ6g5iqAuj2U2m
         7I0KHIxx7pgDyK31qgnDwX52R5AncFuTceEeecrbAXWVt5utrDpZAJGFiQp9yJwA7a
         +WwIce73Ee6U//FsTq9XCK/RqZGPw55Y2fSIR1q4=
Date:   Thu, 8 Jun 2023 17:35:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu
Subject: Re: [PATCH] scripts: fix the gfp flags header path in gfp-translate
Message-Id: <20230608173533.1187af36cdb624f3915ae305@linux-foundation.org>
In-Reply-To: <20230608154450.21758-1-prathubaronia2011@gmail.com>
References: <20230608154450.21758-1-prathubaronia2011@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Jun 2023 21:14:49 +0530 Prathu Baronia <prathubaronia2011@gmail.com> wrote:

> Since gfp flags have been shifted to gfp_types.h so update the path in
> the gfp-translate script.
> 
> ...
>
> --- a/scripts/gfp-translate
> +++ b/scripts/gfp-translate
> @@ -63,11 +63,11 @@ fi
>  
>  # Extract GFP flags from the kernel source
>  TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
> -grep -q ___GFP $SOURCE/include/linux/gfp.h
> +grep -q ___GFP $SOURCE/include/linux/gfp_types.h
>  if [ $? -eq 0 ]; then
> -	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
> +	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
>  else
> -	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
> +	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
>  fi
>  

Thanks.  I added

Fixes: cb5a065b4ea9c ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
Cc: <stable@vger.kernel.org>
