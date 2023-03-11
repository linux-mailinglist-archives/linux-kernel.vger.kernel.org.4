Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC3B6B597E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCKIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCKIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:30:40 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A21912C0FA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:30:37 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a7so4991013pfx.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678523436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc4nKabdPqfBgwO7rnLq++7CTROl4/OQyMvQZkDNAho=;
        b=d8h9PrXeCW23lUYlQIHXCVwnTgRjfeGR1kF46NmNuqkA4qIDvx3zI/b1FY5safD7WA
         UiX0FfdkfbwzuYkSk+1su5ouPqsdn+zBx08Vt5rwu6nZApW+z2d8TAvCUj80jCD5MZOp
         eQZv9kb30flNmGAtK872JAo4+8985s01XbWKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678523436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc4nKabdPqfBgwO7rnLq++7CTROl4/OQyMvQZkDNAho=;
        b=l/0tBRY2haB33QFdGBW9tLxZTEYB8QRXdDqOEZ9gJpAyTmfC4GnLhtSwYYV8GJbboe
         5G6PoFvHHNfPeg66KspFe31zQ1NWqZRN3F3iRQHUyrc4KEbDLAdxzBp/XFFN+Y3g2Ngm
         IJDB8+gS8sSszeKITeDi5M3YPlyNTWEQHoK4utaPfEpwaDErs+O33rPJrhkWAZpZfZka
         HRgKIXIRSNERGPVa03F88zSR/6mKedHBwVDIVCqtZ5fGbknv4PG3/o5y8zzzU9ZNfaP5
         DFE52qMa0/tzJZT/uk0nLKeEMsbt4TWWIPwN4dYmdOuEFgPsWgc0SG0QRwlzD+p+yYye
         2ldg==
X-Gm-Message-State: AO0yUKUyDAzDSjDtznJhyVlk78RjWwBIUff+MM06Spz4WMXGEedRimL8
        fT/NtQkNmBoTQZ3vsSgY47o3FQ==
X-Google-Smtp-Source: AK7set+oSJKJxsw+8idcNLrSQKlQpnAZLaAhG2TQdNinqkUhqoJAdjD7d6Zg0znwuwFEMgZC1o71GA==
X-Received: by 2002:a62:1a8a:0:b0:5a9:c1f9:dc70 with SMTP id a132-20020a621a8a000000b005a9c1f9dc70mr23402354pfa.30.1678523436551;
        Sat, 11 Mar 2023 00:30:36 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b0056be1581126sm1006271pfe.143.2023.03.11.00.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 00:30:36 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:30:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <20230311083032.GI1045797@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <ZAucxpUG5/6Y4GSL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAucxpUG5/6Y4GSL@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/10 13:10), Minchan Kim wrote:
> > v4:
> > -- fixed classes stats loop bug (Yosry)
> > -- fixed spelling errors (Andrew)
> > -- dropped some unnecessary hunks from the patches
> > 
> > v3:
> > -- reworked compaction algorithm implementation (Minchan)
> > -- keep existing stats and fullness enums (Minchan, Yosry)
> > -- dropped the patch with new zsmalloc compaction stats (Minchan)
> > -- report per inuse ratio group classes stats
> > 
> > Sergey Senozhatsky (4):
> >   zsmalloc: remove insert_zspage() ->inuse optimization
> >   zsmalloc: fine-grained inuse ratio based fullness grouping
> >   zsmalloc: rework compaction algorithm
> >   zsmalloc: show per fullness group class stats
> > 
> >  mm/zsmalloc.c | 358 ++++++++++++++++++++++++--------------------------
> >  1 file changed, 173 insertions(+), 185 deletions(-)
> > 
> > -- 
> 
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> Thanks, Sergey!

Thank you!
