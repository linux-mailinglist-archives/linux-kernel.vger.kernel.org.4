Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F616DCD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDJWnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjDJWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:43:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B01BF1;
        Mon, 10 Apr 2023 15:43:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9A861774;
        Mon, 10 Apr 2023 22:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9A861774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681166586; bh=sdL4HgdX0J5/FoQlEuWdtoEwnN1YfRk4xnoqJRTB27M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PdLV54v7OP2OplG/Spyjj92LtJOd6EX3oMgEYF96bB7GXdqiOp0/rsUo3DZsS41s/
         LSY6wPIS09xGfmhNfIG6o4NqoNXhpyJCMuXjM5pdPxM/WjwjGb5Re3RO1gQDX7CcrV
         XGF7xGYPcceex0hv5eGB49pdFGsus4PgJfSpd93K/nwXdti2SWCD47JMvX+tQ3Q62R
         UWKMJoSUQ+9eUv2AIe/oMF5Cre1i9embAx+MjyLH3Yn5T11OGAcRZP1glCfQy9Pm4j
         FwkxrkXLhu8wasrqCeBEEqm/h8uLY2LmDewFJTAYD1jk/P+f0qaztBgGE7agVpUJaH
         jGTTLzfn/wjKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: firmware: Clarify firmware path usage
In-Reply-To: <20230402135423.3235-1-f.fainelli@gmail.com>
References: <20230402135423.3235-1-f.fainelli@gmail.com>
Date:   Mon, 10 Apr 2023 16:43:05 -0600
Message-ID: <87y1mzcq9y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> Newline characters will be taken into account for the firmware search
> path parameter, warn users about that and provide an example using 'echo
> -n' such that it clarifies the typical use of that parameter.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/driver-api/firmware/fw_search_path.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/firmware/fw_search_path.rst b/Documentation/driver-api/firmware/fw_search_path.rst
> index a360f1009fa3..d7cb1e8f0076 100644
> --- a/Documentation/driver-api/firmware/fw_search_path.rst
> +++ b/Documentation/driver-api/firmware/fw_search_path.rst
> @@ -22,5 +22,10 @@ can use the file:
>  
>  * /sys/module/firmware_class/parameters/path
>  
> -You would echo into it your custom path and firmware requested will be
> -searched for there first.
> +You would echo into it your custom path and firmware requested will be searched
> +for there first. Be aware that newline characters will be taken into account
> +and may not produce the intended effects. For instance you might want to use:
> +
> +echo -n /path/to/script > /sys/module/firmware_class/parameters/path
> +
> +to ensure that your script is being used.

So I have no problem with applying this, but I have to ask...might it
not be better to fix the implementation of that sysfs file to strip
surrounding whitespace from the provided path?  This patch has the look
of a lesson learned the hard way; rather than codifying this behavior
into a feature, perhaps we could just make the next person's life a bit
easier...?

Thanks,

jon
