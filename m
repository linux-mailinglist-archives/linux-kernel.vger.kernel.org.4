Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB26D5163
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjDCTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjDCTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:32:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C21A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:32:51 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7064B1EC01E0;
        Mon,  3 Apr 2023 21:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680550370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dVDZhweLWsTSv9fCvQmUSvuBXWZan9fh4o49G/RYkag=;
        b=o5eVZze3bFP2YFld2fvQ9vb7TaCW1W1i/hJl5MSIy98rViO/GMoKY6w+gLIhpQ/8JHwTYq
        jyLgMYY0ZZhoMkU6rYm2LPXYulcQfMN/yhOML0Vtw+kyZXQx1fPm27D1G2JlU7qRMN7Tjt
        +x9OWNtIymwUKsUTl5oSIsi7QGXpwFE=
Date:   Mon, 3 Apr 2023 21:32:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Message-ID: <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403164244.471141-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 04:42:44PM +0000, Yazen Ghannam wrote:
>  int amd_smn_read(u16 node, u32 address, u32 *value)
>  {
> -	return __amd_smn_rw(node, address, value, false);
> +	int err = __amd_smn_rw(node, address, value, false);
> +
> +	if (PCI_POSSIBLE_ERROR(*value)) {
> +		err = -ENODEV;
> +		*value = 0;
> +	}

Why not put this check in __amd_smn_rw()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
