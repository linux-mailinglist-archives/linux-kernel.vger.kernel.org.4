Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300064F844
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 09:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLQIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 03:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiLQIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 03:35:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3A3EAC2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:35:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3230373wmo.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DU+nq1yAV5PgsulgJiVUWHn8Kc4JYcELGBs8WBm7AI=;
        b=l1CQ1p1MNceaSRdaXPewlWK8ssYBc5oPTax28lyDarDIhSLx0tY1/887CIgfkfNjmi
         XO8bpBdoMqw+9uwzARCDMj8ZAaXbQQJyY0deg++Q0p7ItDsriA2Nx616Cpoe02G8zI4H
         2dKYWrMfVCNzKaj8dxehUG9IKd/M6Mrb1Q3f9Q/qJSj9a2YIr1pTPXvFqqh2dpG+z/vL
         0JYIWC2XsZK+qwIIhoFbaKOBP8G8QwkmshoIVSG9XA9Ja+CcoqsFvciuOk2pcrLXrkkX
         OwpiS/gT9rXGMWQoYWLuR3jUpPx6af74J7FVIdGzRI74j8IovS7MM/MgeXeOrTX+a6OC
         DWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DU+nq1yAV5PgsulgJiVUWHn8Kc4JYcELGBs8WBm7AI=;
        b=XFhGGc7plbcDoVHKlSm3EW8/4kHs+TCcI6t106ne5jOzkWlqZXm/Mib3FnZbYpWy0A
         x8bkUOxIOIWjlghJa2Vd8uV0STO+BwH2KsgSR8Oeuk2pMOfDIVXbuh4P7qSs4UL4c9oF
         Q/DNplTcMbyIqUTb/vTXNDNE9Svynj9q0o+jUTGmJdmaRcwJFVDo+YU4n49y1u0U9l3z
         xGS3L+mwG3DC8fVJPMvNhnKjXZoQJIUcmsWifCRvymmGzufy5A9WXIdRiyxT7Bw88pNv
         32Z+pOoUH6evMlNUKN0QNHFPn4+KW4zVyer9vKPoNv3bPVkSDMiqOy/EttQYAVZJ808v
         rs6w==
X-Gm-Message-State: ANoB5pnyFz7ZKB5eBKDJPfGT890/6v/BZpV2zFWyHrXm0OyaWriM1Bz8
        BdlovyjezNfnF0UIl0SgD38=
X-Google-Smtp-Source: AA0mqf4HETWSaFTR6jDg8lYfQOsOFg4at09P7p+XxWuVrhzcaKTvwdRaiz2/5WLw8EKxJj5d9QtNzg==
X-Received: by 2002:a1c:4b16:0:b0:3cf:7197:e68a with SMTP id y22-20020a1c4b16000000b003cf7197e68amr27603277wma.18.1671266099989;
        Sat, 17 Dec 2022 00:34:59 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b003cf71b1f66csm5645298wms.0.2022.12.17.00.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 00:34:58 -0800 (PST)
Date:   Sat, 17 Dec 2022 08:34:58 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <Y51/Mt70d++6Zzzq@lucifer>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y51L496TjNuiSxsG@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mel

On Sat, Dec 17, 2022 at 04:56:03AM +0000, Matthew Wilcox wrote:
> I think we're waiting to see if any users show up.  It's only been 18
> months or so, so perhaps wait a little longer?

Apologies, I should have researched the background of this further. I see it was
added speculatively in 0f87d9d30f.

> Also, if we do get rid of this, then __alloc_pages_bulk() can lose
> the "list" argument.

Ack. Will do a v2 if Mel feels it's appropriate to remove at this stage,
otherwise we can drop the idea and wait for users to emerge.
