Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE19698135
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBOQsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBOQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:48:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E58685
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49806B82284
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE88C433D2;
        Wed, 15 Feb 2023 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676479683;
        bh=ujgKUuvt37wzLHeG30iyu5zgb7f5X2kmbZN33nBLmDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxrYp75+aVQFpcQ/QW1BK0ZAMs0ooomsrdD2rZJFNZf3D9fFFDNoJy/lAtSj2eB/u
         etoojdSergZL4yLelc7T+YJ5WxPWVG0GrCHz7oRzExtUdNV38gie9YSlxlyNcejMxl
         2cUEoESLTU0zM2afbPRyzlHT25r8C3edX+8v88iI=
Date:   Wed, 15 Feb 2023 17:48:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jialu Xu <xujialu@vimux.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH] scripts/tags.sh: fix incompatibility with PCRE2
Message-ID: <Y+0MwIucdhrCVzs8@kroah.com>
References: <Y+snZioVyo82mAUj@kroah.com>
 <20230214204142.1514599-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214204142.1514599-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:41:42PM +0000, Carlos Llamas wrote:
> Starting with release 10.38 PCRE2 drops default support for using \K in
> lookaround patterns as described in [1]. Unfortunately, scripts/tags.sh
> relies on such functionality to collect all_compiled_soures() leading to
> the following error:
> 
>   $ make COMPILED_SOURCE=1 tags
>     GEN     tags
>   grep: \K is not allowed in lookarounds (but see PCRE2_EXTRA_ALLOW_LOOKAROUND_BSK)
> 
> The usage of \K for this pattern was introduced in commit 4f491bb6ea2a
> ("scripts/tags.sh: collect compiled source precisely") which speeds up
> the generation of tags significantly.
> 
> In order to fix this issue without compromising the performance we can
> switch over to an equivalent sed expression. The same matching pattern
> is preserved here except \K is replaced with a backreference \1.
> 
> [1] https://www.pcre.org/current/doc/html/pcre2syntax.html#SEC11
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Jialu Xu <xujialu@vimux.org>
> Cc: Vipin Sharma <vipinsh@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  scripts/tags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Shouldn't this get a "Fixes:" tag with the commit that caused the
problem?  And if this affects older kernels (as it does), it should also
get a cc: stable?

thanks,

greg k-h
