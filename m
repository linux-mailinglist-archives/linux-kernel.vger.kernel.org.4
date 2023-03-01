Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE856A77F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCAXsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCAXsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:48:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01926B1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:48:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u5so12378895plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677714498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9K0sIWZPejM9pWl+DELmXG0JK2MHkeqyKOVm+ED3Kw=;
        b=F9NbCixZ+vCSmB0bRFafb7jHWCH0MDYES7CG10slxxJzjFUh56T/6Lq63siuM6m8kS
         a6b1jS5fyZLerFrMRBCvVs4NkB41XBvaOxyB+ZFPQiZAHGvf6auQqCDHHf0J3/6j2bAQ
         I4cjVT8geYeOqncUxqiaewRCyGj1flNBEmcOYKS+2SipQzxC+GIaBmadjBEynS7fodOm
         gGMxN51EDrM2F6hLp/OvLDydnxN+GF3M3gqqCmcpxJr7TkzcQYcsHxQk/r1E6eQ0C1A8
         l/1594WxtZnKSafbRPuLp4NbeD1LD6TeN5KI0utUVb6bxonkEJhD9k9CdBa7fuIER2h3
         gGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677714498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9K0sIWZPejM9pWl+DELmXG0JK2MHkeqyKOVm+ED3Kw=;
        b=5AyE77uzKNTVvcRLcvWBui/zq+8QjuZpE26LfxnFIFpZYmpcB2TxEy/Qo+ZFzd2o03
         TJbISFFQP2nlQC0hILACD/XvNDEbwUiOzzGFZtM7tGbP244KpL1DLDKOgVVT7m+YyeBC
         Q7aH34kVqmekxOZjxbrWtlqAmt7IN31QFaVrnBj1AFdhEr3LRJEU1AurtKUcaqqGTM4+
         YlQIk94+Ne2FfsAne8KFQjRL1MEoGUbYAp8edKBaexUCPMlDhwiKLLvNyH3XAu57hjRp
         86tdvxABckSJG/U0BQ55YdzNm92rl/gz9tJycxsk+rfyd4HQPG3FZYUGnSfZmqyT5i+N
         yDCA==
X-Gm-Message-State: AO0yUKX2lxQOEnMOnP8IixgCIsZUQr8YFEM7rfNBmtU7gGFNxCF/f12M
        WbZ8y6/wNpN6OKB8BO3si5s=
X-Google-Smtp-Source: AK7set/Q4i3opbyipRt7dpttTMYGub48j7lkG7t2XpI0nSWi3V3q7Mj9GO2W7cYPz0MGNhffPhwKog==
X-Received: by 2002:a17:902:edd1:b0:19c:d7a9:8bf0 with SMTP id q17-20020a170902edd100b0019cd7a98bf0mr218191plk.10.1677714498262;
        Wed, 01 Mar 2023 15:48:18 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a524:71b8:ce7e:745d])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b0019ce470b9fesm9078422plb.140.2023.03.01.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 15:48:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 1 Mar 2023 15:48:16 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/6] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <Y//kQEjoCgoBlfhu@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <Y/f8esHswgLtjkee@google.com>
 <Y/rXFc4dI+190uJa@google.com>
 <Y/59k9T3akHc4JZW@google.com>
 <Y/7NP3LG+L7CKsLu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/7NP3LG+L7CKsLu@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:57:51PM +0900, Sergey Senozhatsky wrote:
> On (23/02/28 14:17), Minchan Kim wrote:
> > Thanks for the explanation, Sergey.
> > 
> > Please include the testing result data in the description of the patch
> > you made significant change to achieve it as well as cover letter.
> 
> OK, I can include it into the "new compaction algorithm" patch.

Thanks.
