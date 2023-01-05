Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7052A65F6F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjAEWlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjAEWle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:41:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C701C41E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:41:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d15so40871735pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbEJ6C+ug2NsljTwx4DoQKNa+OlQLxZIBsSb223c9lE=;
        b=asfVO7RRpHj7y2lWWMRxdkl4uWIT0Zk7rrOxBjwe9bKXgbEimJH8eSs5y7phpZbhat
         Xstmhy+yo3meVAL6UXTXRdfEM8C08TPjaMjJaVECOe36cCJoonFoyZh8S7sYdx2VU96X
         0sOKfsNGdk4DKJK/HfeyNbwuCgDd+9cgb3jFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbEJ6C+ug2NsljTwx4DoQKNa+OlQLxZIBsSb223c9lE=;
        b=0Hwcn6tRHCMpEisEvAZwogBRVsNx+qMST4IkGU7bZ+f0vxdz/cg5/f0JsfE6VmHRLY
         A0YuCVPXw8ibBICvyGjQLlqAXf3F1OBNuiCVgHq0Dao8d0I0NLtC0WxoQ3EBjqli/UNh
         XtlHYreaOZZDHNV0qQfcG/BMxcphCc+Ar+PBmu1ixtmkoxcHTzNFxXdvX8Y9Pq8uloye
         QfQCDhIX7OUbi5UUCTqVPfZOBF/PYYuU/rObe/ww9dwfmpcnjDgyWZk7SZZkRxIVV5L3
         Lgl3sC+ndxfeBjXEE/qsl8wIqT/jglXNWw506/+ZBSLj/9+3JQhDraVMH8aZcjAU0JIw
         CQ+g==
X-Gm-Message-State: AFqh2kq/cn+z52zNYoyIzjuB/R4P0EuR9aT343wtKkdu41tTSasoVMTZ
        zOq7svI0HOCrAmu49GunDn4Kig==
X-Google-Smtp-Source: AMrXdXtRgYj4OiBZyps7r7FG9SkHxrncQcTUVL9JLKBGfn3J0hm3xbYWINTp2A3YBjRyZct6O4L3nA==
X-Received: by 2002:a17:902:f78d:b0:192:ae36:f760 with SMTP id q13-20020a170902f78d00b00192ae36f760mr27050793pln.47.1672958492567;
        Thu, 05 Jan 2023 14:41:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001925016e34bsm26665004plg.79.2023.01.05.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:41:32 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:41:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memremap: Replace 0-length array with flexible array
Message-ID: <202301051441.C1D7291921@keescook>
References: <20230105220151.never.343-kees@kernel.org>
 <Y7dLrdOETjg/+XKq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7dLrdOETjg/+XKq@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 04:14:05PM -0600, Gustavo A. R. Silva wrote:
> I think this is the same patch:
> 
> https://lore.kernel.org/linux-hardening/YxKO%2FjY1x0xTpl4r@work/
> 
> It's actually in linux-next.

Hm, it's been in -next since September? Is this in a tree of yours that
didn't get pulled for v6.2?

-- 
Kees Cook
