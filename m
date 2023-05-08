Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC76FB3D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjEHPaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjEHP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1009691;
        Mon,  8 May 2023 08:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D8A61DFF;
        Mon,  8 May 2023 15:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA21C433D2;
        Mon,  8 May 2023 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683559793;
        bh=OmU/svdFtbjVNgVAsdOkNUGzGdzCuBkqJ74yv6PqUeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PM3Y6cvOHXVo097NkR2gMxxZekPAAMO+tETbMAW5XyvilNuWYDhqy5wZzBNdVRyzA
         MeFKNeF7c/o/9XaQej+r39g6KYMdnowHOj6/XS5onGLn75Cf5vxrJ0kY9rA5Tko1Bv
         c2vsVfWk06pyJZojxP9BafHN6o0jgPvwa57mfe3JWVNXIo/yaAJlpgQoCuSDIFV81V
         mGwK13zhfqCeXZ+l86i80bH5TdOi4cXDjc6fQ4j7tHDMX2IRzZynFFwDuDhUNXuhTk
         EuT/uktkPmST8rBufECiNLa5nGXl9OFZvFXTuB1Z72bUBH4pb/i4tMn8gch91BxsVe
         tUpuJk3uYHXLw==
Date:   Mon, 8 May 2023 08:29:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix undefined behavior of shift into sign bit
Message-ID: <20230508152952.GA858799@frogsfrogsfrogs>
References: <20230508120634.2598765-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508120634.2598765-1-geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:06:34PM +0200, Geert Uytterhoeven wrote:
> With gcc-5:
> 
>     In file included from ./include/trace/define_trace.h:102:0,
> 		     from ./fs/xfs/scrub/trace.h:988,
> 		     from fs/xfs/scrub/trace.c:40:
>     ./fs/xfs/./scrub/trace.h: In function ‘trace_raw_output_xchk_fsgate_class’:
>     ./fs/xfs/scrub/scrub.h:111:28: error: initializer element is not constant
>      #define XREP_ALREADY_FIXED (1 << 31) /* checking our repair work */
> 				^
> 
> Shifting the (signed) value 1 into the sign bit is undefined behavior.
> 
> Fix this for all definitions in the file by shifting "1U" instead of
> "1".
> 
> This was exposed by the first user added in commit 466c525d6d35e691
> ("xfs: minimize overhead of drain wakeups by using jump labels").
> 
> Fixes: 160b5a784525e8a4 ("xfs: hoist the already_fixed variable to the scrub context")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  fs/xfs/scrub/scrub.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
> index b38e93830ddea2b0..e113f2f5c254b085 100644
> --- a/fs/xfs/scrub/scrub.h
> +++ b/fs/xfs/scrub/scrub.h
> @@ -105,10 +105,10 @@ struct xfs_scrub {
>  };
>  
>  /* XCHK state flags grow up from zero, XREP state flags grown down from 2^31 */
> -#define XCHK_TRY_HARDER		(1 << 0)  /* can't get resources, try again */
> -#define XCHK_FSGATES_DRAIN	(1 << 2)  /* defer ops draining enabled */
> -#define XCHK_NEED_DRAIN		(1 << 3)  /* scrub needs to drain defer ops */
> -#define XREP_ALREADY_FIXED	(1 << 31) /* checking our repair work */
> +#define XCHK_TRY_HARDER		(1U << 0)  /* can't get resources, try again */
> +#define XCHK_FSGATES_DRAIN	(1U << 2)  /* defer ops draining enabled */
> +#define XCHK_NEED_DRAIN		(1U << 3)  /* scrub needs to drain defer ops */
> +#define XREP_ALREADY_FIXED	(1U << 31) /* checking our repair work */

DOH.  My mistake. :(

Does gcc have an explicit warning for that?  I turned on W=12e on gcc
11.3 and UBSAN and neither complain about this.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  /*
>   * The XCHK_FSGATES* flags reflect functionality in the main filesystem that
> -- 
> 2.34.1
> 
