Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58420628F07
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiKOBQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiKOBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:15:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75513F75;
        Mon, 14 Nov 2022 17:15:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B555B8165D;
        Tue, 15 Nov 2022 01:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB0C433C1;
        Tue, 15 Nov 2022 01:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668474948;
        bh=Zmxsw+WMrSQ5KSvvst5HClsbTbH/T6qsb3zD+F60Q0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV0h1djW1CL/g46jRKWt+OmNgrg671wwc0TP73GGB1j25i0HajWf1ZwtnzpW6MNwf
         zxJ7M6v+eqT60XW2qXVJ5J7KhBYqmrJ5DjYABsZzc7LQjfBmn94eT8fqaDrOlfjx63
         NdkUKMjpy9TRDmZg36NxikTCASulGkK5FGIORAaLiC3nFGMzNIbLYSUbEwKm6/2PjH
         aHpXihyXaGsbGN/cL3iIlkhpzzZ2sxdopkWi9QlbtkpP/eEmJqmUKpxk76MK6txyjv
         +tLORXmsfwA9/qPVyfT5FnbGTkgH/mOgEjerqAzgw3BAqNYgzMlEvLz2X4jxvPSd8y
         pL7fg9ph8TtKw==
Date:   Mon, 14 Nov 2022 19:15:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     guo.ziliang@zte.com.cn
Cc:     robh+dt@kernel.org, frowand.list@gmail.com, keescook@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH linux-next] scripts/dtc: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y3LoNLVzdYPmGU2J@work>
References: <202211150903277271642@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150903277271642@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:03:27AM +0800, guo.ziliang@zte.com.cn wrote:
> From: guo ziliang <guo.ziliang@zte.com.cn>
> 
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
> ---
>  scripts/dtc/libfdt/fdt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
> index f2e6880..f66fff1 100644
> --- a/scripts/dtc/libfdt/fdt.h
> +++ b/scripts/dtc/libfdt/fdt.h
> @@ -35,14 +35,14 @@ struct fdt_reserve_entry {
> 
>  struct fdt_node_header {
>         fdt32_t tag;
> -       char name[0];
> +       DECLARE_FLEX_ARRAY(char, name);
>  };
> 
>  struct fdt_property {
>         fdt32_t tag;
>         fdt32_t len;
>         fdt32_t nameoff;
> -       char data[0];
> +       DECLARE_FLEX_ARRAY(char, data);
>  };

This was addressed in commit:

        5224f7909617 ("treewide: Replace zero-length arrays with flexible-array members")

My question here is why these changes were reverted by commit:

        ea3723a541c1 ("scripts/dtc: Update to upstream version v1.6.1-63-g55778a03df61")

?? :O

Thanks
--
Gustavo
