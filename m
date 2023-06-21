Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546A7388A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFUPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjFUPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:18:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62782D74;
        Wed, 21 Jun 2023 08:14:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4C0C72AE;
        Wed, 21 Jun 2023 15:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4C0C72AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687360475; bh=PFxuX8mago3vl0Qcs3OhzDNVkxupOWWwKCpDkAT9oYo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=krXsQ9dug4yuevYapGka33Nal5zBrnrDkqPNvU96V638wP5Ike8YE4fgjp2HxulQs
         jtor4PV1fPxkx4qQe5IBYZ72MmrzZiPSqHhGgOFousdOjshqrehri5h/amiU+V/Hvd
         i3R+1vnmQLtvFjyX4BadDuuH/raElYCIG6KgNZfTrsOwItr4Y1DcVq8bOsb8Ms9eNc
         +JAb8f5pC49IhxCEMLwNaKAdF7mPDWjWYlotYq21WvP/9qKAKVsBhOJeNqhsWloTUE
         StRM8X5Wzo+nr4SjueMe62VOkQvadWfwEi7DlhNY/wU5QX09wdLvfqOOwbX4/Vz/d8
         P7NkfRb2/60kg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] docs: trace: Convert decode_msr.py print syntax to python3
In-Reply-To: <tencent_6142CF595B97172A46AF02A34D885D060108@qq.com>
References: <tencent_6142CF595B97172A46AF02A34D885D060108@qq.com>
Date:   Wed, 21 Jun 2023 09:14:34 -0600
Message-ID: <877crwrgo5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Andi]

Rong Tao <rtoax@foxmail.com> writes:

> From: Rong Tao <rongtao@cestc.cn>
>
> Convert the decode_msr.py file to python3 to solve the following running
> errors:
>
>     File "Documentation/trace/postprocess/decode_msr.py", line 35
>         print j,
>              ^
>     SyntaxError: Missing parentheses in call to 'print'. Did you mean
>     print(j, end=" ")?
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  Documentation/trace/postprocess/decode_msr.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/postprocess/decode_msr.py b/Documentation/trace/postprocess/decode_msr.py
> index aa9cc7abd5c2..2d45d6c14987 100644
> --- a/Documentation/trace/postprocess/decode_msr.py
> +++ b/Documentation/trace/postprocess/decode_msr.py
> @@ -32,6 +32,6 @@ for j in sys.stdin:
>  					break
>  		if r:
>  			j = j.replace(" " + m.group(2), " " + r + "(" + m.group(2) + ")")
> -	print j,
> +	print(j + ",")

So I certainly have no problem applying this.  But it occurs to me that
this file hasn't been touched since it was added in 2015, and nobody has
complained that it doesn't work with modern Python.  That leads me to
wonder if it's being used at all.

Assuming that there is value in keeping it, I wonder if a move to
samples/ might make sense?

Thanks,

jon
