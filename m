Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335465F423F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJDLsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:48:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591674D4D4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB266B81A13
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3584CC433C1;
        Tue,  4 Oct 2022 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664884105;
        bh=jVsr8vDY6btfVtvTcnIpc1i/LL+SGq9Q+ZvamuQM0GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXEVEkFNYLkprSJaZMK9wxbK0VreILO1l1TZVyG++VdCjqrVzAMlKIYpm+gudlW46
         unMdKy4zgUQ6fgK/ao0bPd/rqHcAOrHr2dgWrFeTEhEg3pz6opH+DbSuiijVyWCP+O
         fms8tk1Wp36kZmkGfD/rY3Toa55gJpZcojOJ7IuDwJEONdEbQl4LPEiJEb0MGmM3nb
         t8Be7NWHGM5GiafTFuGibkKqm4Z+HvDJNEHCoZSA0f27++2gQWibJvr33NK08T3hHW
         TiMCDj40QQWzbQCowJQ51fE1hqtJqlbCNdWvKJNZWY1+1Tzstnb05+Aph9JrU3irjo
         8YYALxcJUP4Tg==
Date:   Tue, 4 Oct 2022 12:48:19 +0100
From:   Will Deacon <will@kernel.org>
To:     xu.panda668@gmail.com
Cc:     catalin.marinas@arm.com, broonie@kernel.org, maz@kernel.org,
        kristina.martsenko@arm.com, vladimir.murzin@arm.com,
        mark.rutland@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cgel.zte@gmail.com, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] arm64/idreg: use strscpy() is more robust and
 safer
Message-ID: <20221004114818.GA23663@willie-the-truck>
References: <20220929072905.282639-1-xu.panda668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929072905.282639-1-xu.panda668@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:29:06AM +0000, xu.panda668@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda668@gmail.com>
> ---
>  arch/arm64/kernel/idreg-override.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 95133765ed29..61bbec7ef62e 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -246,7 +246,7 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
>                         return;
> 
>                 len = min(len, ARRAY_SIZE(buf) - 1);
> -               strncpy(buf, cmdline, len);
> +               strscpy(buf, cmdline, len);
>                 buf[len] = 0;

Aren't we terminating the buffer explicitly here anyway?

Will
