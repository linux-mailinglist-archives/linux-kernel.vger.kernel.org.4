Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716426687AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjALXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjALXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:00:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259355E65F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:00:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn22so21664435plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t81IaJAeVAS+TxjZCUSPdXxwgmlKOytFkJBR8yD/ovY=;
        b=bjOBCWWVWv7gYLHe2gpKpRRM70XQEz6CjFHyDUrnqFAFgxL3uvE4YjVesiTqwbb6Bq
         yo6FbDpGqvcTs4zNj9r29IQTUHI8pC1JPCd5nYT8oqvaHvlWXt9go3dWSQppzDsYtwPL
         awgQTlz7jXUwxPZLjyd4bsV7gBW8xFAjHB5ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t81IaJAeVAS+TxjZCUSPdXxwgmlKOytFkJBR8yD/ovY=;
        b=YD67zH8UGQpoFFy7ihCrxRaXrMVde7Y7HFFN4GZ6Ob/IZxq9YdqrY9olTePU15vlSD
         mWBK8DpmiWBQAXnRZ8pUHCnFga+GsV9sS8FCEiNUyU/JtxOtM68nECwWbs7VGac6rgls
         d33t+mNaVMq69Gig1woxy515qEw9bolZaFGlpG4Xgs7xh/OV/5jvjZFGia4MPv99TZ31
         V/Q9JZl/kSwoxpMDdY9H0PNROFGXitn+UNSjAuUbzrDO5Hgw9+peKLJzdPp7qLZLxQ3R
         TYeUZMZEVlyImsIhCLb27Z50XuPZ0wJr+drQilGnpTBtbv5ZR9J2AZlEjlcyX7mZlYCZ
         rAeQ==
X-Gm-Message-State: AFqh2kqF1dUODLc6tgibMa1ZQuO+wIinVxkW7k+FYaEw2eTGzCR3IF53
        FKPJVd1ggilzT/TKndtzbrv/jA==
X-Google-Smtp-Source: AMrXdXv3NLjURBhWZIZRXmTT0Pq5NcaZEvbNnqwyvnrEX1v9Z9hIV8Sq2um6UN04kVyC4yTC2NRYjw==
X-Received: by 2002:a17:902:b10e:b0:194:6265:ba5f with SMTP id q14-20020a170902b10e00b001946265ba5fmr2869914plr.8.1673564440235;
        Thu, 12 Jan 2023 15:00:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709026e0f00b00186c3af9644sm11878082plk.273.2023.01.12.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:00:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:00:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] firmware: coreboot: Check size of table entry and
 split memcpy
Message-ID: <202301121458.865E4834C@keescook>
References: <20230107031406.gonna.761-kees@kernel.org>
 <CAODwPW9SaomZjWQvR1mmV7OzvQkq-_XoDgSmK04fO5rVMGHmpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW9SaomZjWQvR1mmV7OzvQkq-_XoDgSmK04fO5rVMGHmpw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 04:02:26PM +0100, Julius Werner wrote:
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> 
> > -               memcpy(&device->entry, ptr_entry, entry->size);
> > +               memcpy(device->raw, entry, entry->size);
> 
> nit: It's a bit odd to change the source pointer from ptr_entry to
> entry here. Technically the static analyzer would be within its rights
> to give you a warning for that as well, because you're now
> "overrunning" the source struct instead of the destination one.

True. We've been focused on write overflows, but yeah, since the
location of the flex array changed, I'll switch this back to ptr_entry.

-- 
Kees Cook
