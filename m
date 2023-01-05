Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F065F7A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjAEXhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjAEXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:37:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1126F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:37:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so142767pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 15:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKQ83TkKEHZNfWaTpd7I1p+Ye/n4ELFtjaRUnS2gPw=;
        b=LMqQtvzt2+QM2CkjErp2jFM2yQtbcYxDV0K/LKxTe1P8YmSGP2p7jeTlg3XOo2UHM0
         1fDkl9f80UNImV2GTHXK1XNYOEXj2ghw/LpXe2GNEp0PPfCpbtR02fZ81Ey9jhZKmQFg
         KkMSbXyc18ptcvRcVAXuifGbERGMhlxK+dMWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHKQ83TkKEHZNfWaTpd7I1p+Ye/n4ELFtjaRUnS2gPw=;
        b=YroX52QLR4UyTSJ1IWAYuvYJK5v8bPeEjbGGNP5ofAkVsWvjevCayH1LqfSglOqYG4
         t2BGNkBIlw1uNOUooR+NhtKWiXTti+P4Nnuy0uLKRojdXT4ntYzgcBtVesVI15sqBHeV
         XveR8P95pbAraHQbd988N4xf4tEQtbskF9GwN+3e5nnmdj8m9iH/WWod0C9f+M6U/YH6
         6aOznyvIFqQXxar14IjwoCrQjotV5PBq/ufprxmCmGA6XStJHeu1HfC3BcIHGdaKToSg
         pkv35M5qW3MReYwqtK0vlbRZ0dz6OGBTr4FJnljD8L729CnTPlXsb6L4gNb5OytX1kGo
         VVDA==
X-Gm-Message-State: AFqh2kqrT0xrsrc4dJu1wjRQeqsprR/XpGRxMFo75apywISnC8aTfVIV
        DVy5Ke1WT3+zN9BDmygElL/c2Q==
X-Google-Smtp-Source: AMrXdXufvlt5jsZ0Z77jyujuetbqgVHWtWYhgi+Ryfjs9AMwVglyDb0750tKRIXFRVwglbTba5/8Gw==
X-Received: by 2002:aa7:8812:0:b0:582:c142:d4b8 with SMTP id c18-20020aa78812000000b00582c142d4b8mr11001418pfo.0.1672961824824;
        Thu, 05 Jan 2023 15:37:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z126-20020a623384000000b00576ee69c130sm24850952pfz.4.2023.01.05.15.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:37:04 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:37:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <202301051536.1D1F92678@keescook>
References: <20230105220151.never.343-kees@kernel.org>
 <Y7dLrdOETjg/+XKq@work>
 <202301051441.C1D7291921@keescook>
 <ec387c6d-acc7-6696-ba17-bb8792090136@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec387c6d-acc7-6696-ba17-bb8792090136@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 05:14:23PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 1/5/23 16:41, Kees Cook wrote:
> > On Thu, Jan 05, 2023 at 04:14:05PM -0600, Gustavo A. R. Silva wrote:
> > > I think this is the same patch:
> > > 
> > > https://lore.kernel.org/linux-hardening/YxKO%2FjY1x0xTpl4r@work/
> > > 
> > > It's actually in linux-next.
> > 
> > Hm, it's been in -next since September? Is this in a tree of yours that
> > didn't get pulled for v6.2?
> 
> No. I didn't send it. It's just one of the two patches I have in my -next
> tree. They didn't look like high priority at the time.

Cool. I'd like to get -fstrict-flex-arrays=3 finished this devel cycle,
if possible. Can you add this one too?

https://lore.kernel.org/lkml/YzIc8z+QaHvqPjLX@work

I don't see it in patchwork which I find confusing too. :P

-- 
Kees Cook
