Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC09B65C6CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbjACSzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjACSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:55:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A001275D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:55:15 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v126so34150626ybv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60s8/1qZh8c3Dcc7cFNt5aFCnbeZvcI/OzWL4Nko71Y=;
        b=k9ZpERD1UMFfi2rU0SikxaJDEAr8JGbJfXrT4J9IjbaIjADkl4Okn3a6EOsrxKQyQe
         DglGIRI40X5UYm6H/lbdIFPWg4N+zdJ0Vyxm+DnuRF86yKbL+/1VzdU29dRsCJD6j2d1
         tGQxyMAntY7J3iHylSisYIggi81xn3DKNtvv8AmJ5tasSb6GZt8z+zgTnfcdljsb9ZWI
         q9AJHSOPW7DEgbL9xiK4G+psUmX4pe5c1n8j3I4ssjaQZhkeZRjxLOGgR2YlqcA8cdOd
         wrA9/dW/kdTTz/GFb9WHsPa6WDQf9Cay/Q1qiwTsyuHEOxY0GpelRmCY5UEhy9BmuyUg
         MZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60s8/1qZh8c3Dcc7cFNt5aFCnbeZvcI/OzWL4Nko71Y=;
        b=PTjy3iWPxh5UvyB5tr0V6nOL7DwFoa1Sgiw4kT1b95CvqyVXi6WGSYHCOb4cmAql0D
         aEeJw1pYU27ImRvpCPsbHwr+vMQYcQid9zd2Yv0F5FziCZIw+48NN3FH+gijpIlonYCC
         QNWsfq553fybAzeLAwBNYsXw3eI6K+N69s8ilMjtQIW8NTnfzs+Fy4d++BHLSScwqR1E
         zIQV5jhUtPsOJaZxdZxfR9kheZgRI2rzRtPYjyzhXux9HFLVpFbm8fqXpW4ayIyQdmYd
         kBwQ2TO76HM/gGgFIRhMwHhFnd6JXyR65XQVkHBydPbBbEI9qO5zxK46U3FAfq6N9hsP
         9fHQ==
X-Gm-Message-State: AFqh2krARY2ZfobpJm3rnm4H45JBhoE8dWFKtO4Mrt0Cg5o4yPWnYvR2
        4e6QULy7kszxtaQYtolalAdUK7OBfaaT/liMz+nimKg+qZLy5g==
X-Google-Smtp-Source: AMrXdXtgyCEJSEXyde46jTTMw3EoQhBhcFBBlVHOZgyzJ+zkrL2pbU00+jbMUdYJt0RyCiKJeLVXzJa2tKpEsz3hRd0=
X-Received: by 2002:a05:6902:281:b0:73b:eea3:accb with SMTP id
 v1-20020a056902028100b0073beea3accbmr5005526ybh.327.1672772114084; Tue, 03
 Jan 2023 10:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20230103145023.40055-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230103145023.40055-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 3 Jan 2023 10:55:03 -0800
Message-ID: <CABXOdTdLFbi+-wUk1ohX+5bs01b0WX-MRSH9tUWD316vucpdmw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/chrome: cros_ec_proto: Use asm intead of asm-generic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 6:50 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no point to specify asm-generic for the unaligned.h.
> Drop the 'generic' suffix.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Subject: s/intead/instead/

otherwise

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index c6a83df91ae1..08c58d031593 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -5,7 +5,8 @@
>
>  #include <kunit/test.h>
>
> -#include <asm-generic/unaligned.h>
> +#include <asm/unaligned.h>
> +
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>
> --
> 2.35.1
>
