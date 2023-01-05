Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1765F6EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjAEWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjAEWjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:39:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853B1ADAF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:39:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q9so49305pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdgAvYTBrYnbaUNEv8BIMTzu3Oe5iPdX/uTy6lOBdp8=;
        b=gJQpryXWL+Io+7TfOdR/L7h/MnG9VV9Jz4HEcSeFaLzheIGBhT9XVgQEh2hUgBSpNa
         Akn8+/KMom7qedcO0/agBltAVVd9K44Ma+Ijw97Rs+h7VkcrpJGeESfcc/2L/As8HuWD
         g3BOFMWbO9TtxJ4bWD1f8ZtH2kyVn1Tk+Lyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdgAvYTBrYnbaUNEv8BIMTzu3Oe5iPdX/uTy6lOBdp8=;
        b=4bWaA0/RlbkhMyFnajTNlyo49JRRSbfC/C5+2EjhlMZK77dcl2oiJtysGn1E2XLo2r
         iIbjxhEGknMIt6TSGbpINlJuSiRgHm/xKPc71BrHgSosULJRyPwpbBARqncLZR4rXC1G
         lJp/LPC//2UyluTSOhZ4hqnkO7uYA3XihyaMVpYTfx0JDaiYHcI97GRUB45PcsuhnK6D
         NMTyWzGCwnAGgvkVhsQIQ45GJ8IhoA8LVpqS6Pae5tVu/jLtV0u6zCqCIkmCE/9dre3c
         E2KR8IjbgOGnw+F5ERW++Y8evzhoRIFC0ckaoQe4OuhT2icuZVPgdkOW6cUAl8JsSZAp
         3Ecw==
X-Gm-Message-State: AFqh2kpvbuXgUs/S3wLt7Xhc6EvJOtYJ3RU+GCgS4qZEk4QJRodZmrGc
        w0rc9szGnipHn1OmUgoB8VGUzA==
X-Google-Smtp-Source: AMrXdXuRg8ap1gfmlr1QRcGiFifKwVjGE0OZvbRtHILaqVmV92+uxnMIKqYkNiGkvtxG9Rd772hvxg==
X-Received: by 2002:a05:6a00:1816:b0:583:2a52:6ae3 with SMTP id y22-20020a056a00181600b005832a526ae3mr4621197pfa.6.1672958386670;
        Thu, 05 Jan 2023 14:39:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7-20020aa78f07000000b00580f630a05csm21128326pfr.180.2023.01.05.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:39:46 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:39:45 -0800
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
Message-ID: <202301051438.4FCD7E8AF@keescook>
References: <20230105220151.never.343-kees@kernel.org>
 <Y7dLrdOETjg/+XKq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7dLrdOETjg/+XKq@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Ah-ha! Thank you! I'll move to linux-next for build testing.

-- 
Kees Cook
