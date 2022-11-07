Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6161EA48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 05:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKGE6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 23:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKGE6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 23:58:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB6A10C6;
        Sun,  6 Nov 2022 20:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qNOXgygaWQD0NLhaAK+QylD2mMI3TxgX/W8nMJ43rZs=; b=OjUa0gE7wTj628/GfQ4lG0D4do
        eJABZiNCDs3fC9W3zkO5HD0Dw8FR3c8FZyryxqbNNnLKazn/eHKPJYKJik00OEaenVmZr6cmTRG2X
        NzQJCeP+kSqZl2GM3Uset5KXBaeE7zmBgmQfd3pviKFJ9Yj72fAyG3GOxKpUJjncbH7RAwVjiAkHo
        HZ64c/VDtaRPGk1ZqKTAngPW+r1gS8z25CWSf1jW7YD5B52+V2dAhYRUsES3N5tCsIgNj6UBu1mKz
        1NYyXFtfA5+/bLSDd8FAoMOy2bVPE+jS+A8L4HIxaSCKg53x29v1D7dVbP/bKKGD/GLlhWwiyqy9f
        j5XohMiQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oruDE-00BeWR-6B; Mon, 07 Nov 2022 04:58:20 +0000
Message-ID: <fb7476a9-18b3-d361-1849-517b7f94a0b7@infradead.org>
Date:   Sun, 6 Nov 2022 20:58:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] tty: Move TIOCSTI toggle variable before kerndoc
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221107034631.never.637-kees@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221107034631.never.637-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/22 19:46, Kees Cook wrote:
> The variable "tty_legacy_tiocsti" should be defined before the kerndoc
> for the tiocsti() function. The new variable was breaking the "htmldocs"
> build target:
> 
> drivers/tty/tty_io.c:2271: warning: cannot understand function prototype: 'bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI); '
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/lkml/20221107143434.66f7be35@canb.auug.org.au
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/tty/tty_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index a6a16cf986b7..24ebcb495145 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2255,6 +2255,7 @@ static int tty_fasync(int fd, struct file *filp, int on)
>  	return retval;
>  }
>  
> +static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI);
>  /**
>   * tiocsti		-	fake input character
>   * @tty: tty to fake input into
> @@ -2268,7 +2269,6 @@ static int tty_fasync(int fd, struct file *filp, int on)
>   *  * Called functions take tty_ldiscs_lock
>   *  * current->signal->tty check is safe without locks
>   */
> -static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI);
>  static int tiocsti(struct tty_struct *tty, char __user *p)
>  {
>  	char ch, mbz = 0;

-- 
~Randy
