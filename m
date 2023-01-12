Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23E666B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjALHLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjALHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:11:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA89630A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:11:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so40728pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iPyrg0DtEaf3W1nn9XRn6Wwv8d6QmlMBX2Zvvut2+E=;
        b=gdRCqJRulQK10XMSXaD5n2XL88L0eEvXNTIDbcSg5qZwi/HhkR3GKbevncdYCvIv8R
         VBZmm42uZDImXVrIO6Vyod7qxfVyq5kCxucf6tKkxTV4rjzeIjWfBceyHw1CWXl57KT/
         pvj9D72tjiMZ33wrtsvtxPRRGYAvggmpbgRP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iPyrg0DtEaf3W1nn9XRn6Wwv8d6QmlMBX2Zvvut2+E=;
        b=MaLYhoero61QGUV2DZTa1pIBNzDqQteXM8GbPB8ACZh8rlMUDyp9O+jNVDFnQiGGmc
         VQKudMa79RPmJnvdJ75MmoLROceyB1GMRHAuad+kfCylrBGLHiHfWx/nGDXG1XDDNE3L
         /b51zZ8lHTJz2YSzG1nI/LvqapvySPr4nu5t1NlkxGJIPn3YFySjhgm90IFPfWuoSWZS
         subD21ql95khIqVHNNPfKl6der9IX6h1pgwVhcM8KlXan0lbEUiktPCgRLaHCIY0hKKM
         HWgmHxNSXCJaCHh7kG2/U5jVs8Nps7A6G5OwhhHeuZYWvg/WsivWPmO4J8eUzfBhQ1vi
         9tMQ==
X-Gm-Message-State: AFqh2kqVBnkDTOsrRKFtkxEpAcXopF2Mp30laRQSmqa7zhkRMk/zaT5V
        AKmyl/4+WRT9+WcdYcgCwEKlqw==
X-Google-Smtp-Source: AMrXdXvwt775kMrjXQjPrzPgckZnot3BpcRnCqeDcvcDFfzEFZX0ItcYurMciOQ85DNLjhNZoyr5vw==
X-Received: by 2002:a17:90a:2bcd:b0:225:be4c:2586 with SMTP id n13-20020a17090a2bcd00b00225be4c2586mr68702819pje.45.1673507487855;
        Wed, 11 Jan 2023 23:11:27 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b002132f3e71c6sm10240471pjb.52.2023.01.11.23.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 23:11:27 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:11:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 3/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y7+ym2gT+XMuL/U5@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <20230109033838.2779902-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-4-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/09 12:38), Sergey Senozhatsky wrote:
> Remove hard coded limit on the maximum number of physical
> pages per-zspage.
> 
> This will allow tuning of zsmalloc pool as zspage chain
> size changes `pages per-zspage` and `objects per-zspage`
> characteristics of size classes which also affects size
> classes clustering (the way size classes are merged).

Andrew I have small fixup patch (0day build bot failure on
parisc64). How would you prefer to handle this?
