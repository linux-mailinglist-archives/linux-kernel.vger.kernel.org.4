Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB9631002
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKSRgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiKSRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:36:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3DB00
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 09:36:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so7613656pgr.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLW4Z0w9rkUJ7IXSXGwPNuOYY+1w9O7kTD/y1ul2a3E=;
        b=KHt/rbjbP6nWrefSs/AOzwIVP+Wy+3SxzcKLYxrH6rwg8so8m6dezqlEZjS54C6ysg
         YhnhlMePanaMLry4YsdQWhgEMPTsatntwqbzaN0Bwfjzw0j9n5CaWQ8u1ZgD1fR/PE8N
         JJU6Bpq0fm1mYcqlIBpcPmn4kALexRI9ogzC4+pl1CX+yLsausqmKD4KkmM0FNPvtnuz
         kiGwFbxNPTxH2VbvbqL0/qUvUDThRnHuYN9grNReK2yZ93Q0+RT4Pzz4r9AQq8dXJYxh
         KYgYC/2Rz6N3PR+vJ59pzk8cB5Q6I1YL0lkACzg89jpVjwvTnwIv7ZOvhRfarN3OGiFK
         tUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLW4Z0w9rkUJ7IXSXGwPNuOYY+1w9O7kTD/y1ul2a3E=;
        b=8L+g78gYiQNMnW+hcf49FQiv/ojOTURkEIicstryZx+fSpXTAw/0WmFizsyhygSCby
         4fJX2A/7818aEwA9+8csHl2J3/qGVn0CngxpUTiUExZklGx1gT6sXcnfanoANlHzwNL6
         TtrGOukQ35c9aHNLs6RRFqCPB60FDk2r+qEDQJqu87lZeNCmeIS5TYQVR6E03UVD8g1p
         ElPfeaPtRBCr2IV/iiBKb7Lr1vIQX+ggvat7ng+vx/Hs+RIqGMv3VQ3F7TToUWdbH8nO
         uGJV7Z/kZEdxWgc5nva82HY+gnX0ezbKukrCPjcDiv7/hA8f0WV8qXswgXXG0JofpCrN
         9tJQ==
X-Gm-Message-State: ANoB5pmif7ADv1aIDG9JvnaSIOnVurJNGAun2zWge2oTl1yA8BXfZ/NR
        Q/hNHCWc4pT+Kc+hkPJSQIk=
X-Google-Smtp-Source: AA0mqf6pV+5UWma7bFXHwCt+9kqbiif9VMDiiwazX6+jDjnAD1Y56yKk1Y1zjs33IS0/BTBMkIVvuA==
X-Received: by 2002:a63:535e:0:b0:470:537c:1092 with SMTP id t30-20020a63535e000000b00470537c1092mr11307574pgl.287.1668879361671;
        Sat, 19 Nov 2022 09:36:01 -0800 (PST)
Received: from google.com (c-67-188-95-58.hsd1.ca.comcast.net. [67.188.95.58])
        by smtp.gmail.com with ESMTPSA id s187-20020a625ec4000000b0056b8181861esm5551759pfb.19.2022.11.19.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:36:01 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sat, 19 Nov 2022 09:35:59 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3kT//gL5YNbsTFU@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:15:36PM -0800, Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
