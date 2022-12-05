Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176B2642648
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLEKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLEKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:02:26 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1217596;
        Mon,  5 Dec 2022 02:02:26 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9778A2C5;
        Mon,  5 Dec 2022 10:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9778A2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670234545; bh=ookYcONnjY6hxSDBsXVx74LJy/vSHoGH6jArwP3li6Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QtKjcu+Nxoc8ZEHjEv6F+U4sBHak2SZs0uj6W8hTtBkUgKtJ3QkUTfbRA1xcP2jKN
         eftBordTZRUOAa8JSv5OlgH5Av3a0LZTiFV5pUjILvPGmuM5W7eLFoEOIByE/03cOb
         fs7cuBc23Sti/55XQ8dUAcZn/5jS/va9zzCuDRKVTlpC1ur3azXj9mKIwJta1SV5MK
         TJubyfjNDpSP4Bo4DGuOkRCYyd5N1Ejox0gYHs/u/E9cGcKDobleiesaQrCzwfv5Fh
         tXy3BultFAyKv+zmxPTK7WqFtKwQnj+sEhi4G5bB66v6dMUR37UyE+J4W5EzUeAmo6
         KyHLJMu7BXpMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation/features-refresh.sh: Only sed the
 beginning "arch" of ARCH_DIR
In-Reply-To: <1670156327-9631-2-git-send-email-yangtiezhu@loongson.cn>
References: <1670156327-9631-1-git-send-email-yangtiezhu@loongson.cn>
 <1670156327-9631-2-git-send-email-yangtiezhu@loongson.cn>
Date:   Mon, 05 Dec 2022 03:02:18 -0700
Message-ID: <87k036mamt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> It should only sed the beginning "arch" of ARCH_DIR in features-refresh.sh,
> otherwise loongarch is recognized as loong, that is not what we want.
>
> Fixes: be99f610a110 ("Documentation/features: Add script that refreshes the arch support status files in place")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/features/scripts/features-refresh.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/features/scripts/features-refresh.sh b/Documentation/features/scripts/features-refresh.sh
> index 9e72d38..c228812 100755
> --- a/Documentation/features/scripts/features-refresh.sh
> +++ b/Documentation/features/scripts/features-refresh.sh
> @@ -60,7 +60,7 @@ for F_FILE in Documentation/features/*/*/arch-support.txt; do
>  	echo "    |         arch |status|" >> $T_FILE
>  	echo "    -----------------------" >> $T_FILE
>  	for ARCH_DIR in arch/*/; do
> -		ARCH=$(echo $ARCH_DIR | sed -e 's/arch//g' | sed -e 's/\///g')
> +		ARCH=$(echo $ARCH_DIR | sed -e 's/^arch//g' | sed -e 's/\///g')

So ... looking at this now, it strikes me as a bit of a convoluted way
to reimplement "basename" - obviously incorrectly before this fix.  Oh
well, this is better than before, so I've applied the series.

Thanks,

jon
