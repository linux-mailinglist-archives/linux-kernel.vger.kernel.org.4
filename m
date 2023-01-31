Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11895682054
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAaADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAaAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:02:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3692E0F8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:02:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02CB6131D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6A0C4339B;
        Tue, 31 Jan 2023 00:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675123359;
        bh=TUipNKX/jlcRv3XLMTllTS0XM+w4YkLHzokenDDM0mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9PXvf4bUOlm1QPEr1dBh6p4CpGDoyZ3BtQlskG9tnHn8QEkPXlLNKZOIjJKaCT69
         wPE1PGSqsXtWDyl3be4DmDLCxVQWmMh8b6tS9LXBG7yq0U2EQyrzvAEHV7VnA2xDHw
         K229wyn1RkvkpzYIZqEMscLDT+ePeaCtHbf3FbxiRdSDV+KOZRmGNESg0SDr8AU4MF
         w4e2os4Vwaf8hdTp0t4tggT51CWKSy0K4kUcqGK9r8VC9vDDx6sGANET1D8CyvP8Zy
         nxGaNjJrhwJ6ZJlKvFTPpTLyaZ6iRg7SRpsS7dZJ26Ubw9oZt8crj6F3u3WUI/5dTE
         5mj1Jue4tybYw==
Date:   Mon, 30 Jan 2023 16:02:37 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] objtool: explicitly cleanup resources on success
Message-ID: <20230131000237.ibc36fg7twtugily@treble>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20221216-objtool-memory-v2-8-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216-objtool-memory-v2-8-17968f85a464@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 04:01:04PM +0000, Thomas Weißschuh wrote:
> Previously the file was only closed and resources properly freed on
> errors, not on normal exits.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/objtool/builtin-check.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 7c175198d09f..e11c766b98ce 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -229,5 +229,7 @@ int objtool_run(int argc, const char **argv)
>  	if (file->elf->changed)
>  		return elf_write(file->elf);
>  
> +	elf_close(file->elf);
> +
>  	return 0;

I'd rather not unless there's a real benefit to doing this, as it will
just slow down the exit.

-- 
Josh
