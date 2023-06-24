Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F7473C6D9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFXFAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXFAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:00:37 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE3926B5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:00:36 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5702116762fso12656367b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687582835; x=1690174835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyrMcuSSVQB12rKgwQVsmA2fvMAsZVrSSN3tWkIR+FA=;
        b=XengcXYYPdgrM+jIIoAae43J9kNFJwSqz4747v216zANqlMRhicUuB/CksfJypOBq8
         JTXFmk//OAPAlDPz0NN0pku0iZa0j51CB5aMzIPeNyrW/qcdACWadz8PV/p8XbQ/v4hj
         IerZl/czqbfEbmqknVtjWfE4+G/l+BXvbf2II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687582835; x=1690174835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyrMcuSSVQB12rKgwQVsmA2fvMAsZVrSSN3tWkIR+FA=;
        b=jO7z6McJ7DJ8Q7XIc1rlbP8nNNpRk/O/XWwwNnHd7Qv/kRdotDbQNuNpByjgEht3My
         zyBrvOrjM2fWwz/SQZUu5OlH0+3sYA823NQf7m+U/E8iv+NTphgOxNmcLBxmaVJS+1ie
         IhpzjspvrabUlW+OH0XJ5akqAcE3Dl7TsYu0EG6gDxlF743JmCn6o9qQ+suG+uHJ/JTn
         YnK4uxD90sMK8gbbOUASWTSM+gEtiefMa7nlAA5E0rCqIAEPdnOsRb6DAn48BPYzZeZa
         xVPNgcetH2jff8YGUqLhThHdi7/YMyNeEaHV8RGGi1/v3wA0RouoK4ZSqK5FbOyL1yX6
         01JQ==
X-Gm-Message-State: AC+VfDzTO4OPNC1scDHS52YMn8f+UwywsYD4zqQjuCl5JBkhwY0f10IF
        KQ0dAB7feleahv/O1w2fkO9FxQ==
X-Google-Smtp-Source: ACHHUZ6WDyv8qByiqWDfrWWSAAqLylaccla3wf3osuUnP2r/JYCMqLR74nKuwkrVJYU0gcLrhhKD6g==
X-Received: by 2002:a81:6d94:0:b0:56d:2038:c31a with SMTP id i142-20020a816d94000000b0056d2038c31amr26570319ywc.22.1687582835420;
        Fri, 23 Jun 2023 22:00:35 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a00270600b005d22639b577sm317638pfv.165.2023.06.23.22.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 22:00:34 -0700 (PDT)
Date:   Sat, 24 Jun 2023 14:00:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] zsmalloc: small compaction improvements
Message-ID: <20230624050031.GG2934656@google.com>
References: <20230623044016.366793-1-senozhatsky@chromium.org>
 <ZJXQW/EFNC5FVjkr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJXQW/EFNC5FVjkr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/23 10:03), Minchan Kim wrote:
> On Fri, Jun 23, 2023 at 01:40:00PM +0900, Sergey Senozhatsky wrote:
> > Hi,
> > 	A tiny series that can reduce the number of
> > find_alloced_obj() invocations (which perform a linear
> > scan of sub-page) during compaction. Inspired by Alexey
> > Romanov's findings.
> > 
> 
> Both patches looks good to me.

Thanks.

> In this chance, can we have little more cleanup after these two patches?

Looks good. I'll pick it up for v2.
