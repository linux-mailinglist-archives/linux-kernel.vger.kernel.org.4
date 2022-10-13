Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BDE5FDAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJMNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJMNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:35:58 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668DDB8C1D;
        Thu, 13 Oct 2022 06:35:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 260ED7F9;
        Thu, 13 Oct 2022 13:35:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 260ED7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665668145; bh=gfYhNJG+ASRdf/168GtPQechsmW64l6yj4+IKgpNJqw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LpkICErC1A/s79gQ/tFwYbTEN/BvC8liud5rFqz2p5Yr6Ow43WuvZVqDurZBGZyr9
         QoT3lfizYsUTrgmoeg78iukky6KdoyF+WYuW4pfwIgGuA1r4qS+WHZZfPkRCqCc4hG
         lNpUg91OFavpYctJqRdng/HR23Gzsujg9bWs+oH1fyGygMV8yum3X/1otyJYSYMhOM
         0v+bctEJUeXS/BpEwiPo54m1r7cAAAe1zhIsppEXrazeumpNDNA+86g7MDO/U+Ztp3
         DiIypArAJMBcI0vs00jWzkvFhUAZONcEvAQdb3LyXz49/oMKlpIvpsy4kQqm2Skdi+
         lcBOzujkR5Bhg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     sndanailov@wired4ever.net
Cc:     rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sotir Danailov <sndanailov@wired4ever.net>
Subject: Re: [PATCH] doc: process: add privacy warning when using some SMTP
 servers
In-Reply-To: <20221013123115.17419-1-sndanailov@wired4ever.net>
References: <20221013123115.17419-1-sndanailov@wired4ever.net>
Date:   Thu, 13 Oct 2022 07:35:44 -0600
Message-ID: <8735brkfrj.fsf@meer.lwn.net>
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

sndanailov@wired4ever.net writes:

> From: Sotir Danailov <sndanailov@wired4ever.net>
>
> Warn the user about "Received" headers and how some
> SMTP servers use them by attaching the user's IP addresses,
> when using some email clients. Add suggestion on how to
> test this behavior and how to avoid it.
>
> Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
> ---
>  Documentation/process/email-clients.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
> index fc2c46f3f82d..9c49f9b33fdb 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
> @@ -350,3 +350,24 @@ although tab2space problem can be solved with external editor.
>  
>  Another problem is that Gmail will base64-encode any message that has a
>  non-ASCII character. That includes things like European names.
> +
> +Privacy/Security
> +----------------
> +
> +Keep in mind, that even if you're using a working email client, the SMTP
> +server might have configurations you don't like.
> +
> +For example, if you decide to use the Gmail SMTP server with the Thunderbird
> +client, the server will add your private and public IPs into "Received"
> +headers, which are attached to all of your sent emails. This is done
> +to avoid spam and to check where in the routing path an error might have
> +occurred. Gmail's web GUI client doesn't add your IPs, because it's sent from
> +Google's servers directly, not an external machine. Unfortunately the web
> +client is not good for sending patches. You can check if your IPs are present
> +in the headers by reading the raw email source.
> +
> +If you do not wish this behavior, you need to find a provider which doesn't
> +do it or configure and host a SMTP server yourself.
> +
> +If you're concerned, always first send an email to yourself, read the email
> +source and if you see no issues, continue to the mailing lists!

So this seems to be just a description of how email works - the Received
headers always show the path through the net.  Is this really something
that we need to cover in the kernel docs?

Thanks,

jon
