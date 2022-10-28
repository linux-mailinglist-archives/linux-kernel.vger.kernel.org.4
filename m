Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3607661151A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiJ1Oso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiJ1OsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:48:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADF207503
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:47:18 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x15so4206433qvp.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3gw8Fi1JF6YrxksAWlKX0pXJQhOXH/UTrtgzYwimAQ=;
        b=TElGNOcAl/dWYmJnupSk5nSXOKuQ6jyD3COvkf1GfHAAMsXd1PeByxeM9+xhycjIUu
         uba/UssiQQnkJz0ay7n22TJMrm39+5RJz4TvAfAXpnvolEfMaLNc5hcq3+AsROOdE9TO
         LXGVD90zEvKEe4/YGQnUg87r09Kfu8OFXzZ0dbYwRtMmnWlpWNRdledTPp+L2MNQQhpW
         Wkf9ZgOQDGL69lTKAuqqJ3WsJ/yqe05m/IwfQKrMVbBxjfIvDN9Y7p9+azci3MqQYH+r
         Jnq6zh3HtJF2x/uwB18KYXW5+z8DokQ5dWNiV/VVwkRYrs5yuEtAvuUoYNyr2SYzgvpf
         xsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3gw8Fi1JF6YrxksAWlKX0pXJQhOXH/UTrtgzYwimAQ=;
        b=vkpJ4V3mY4C4nAwA8Jn1T1igKGVfLzYSDtbqGCwq8xHKb7eNoiu6dJuiarrQHRz3Qa
         yzTzex3qxt4yWa2Pp4aA5qd2D/TgBTZJCOjYWY/g4iGVPoHjZsZdilArbkKlhUgRjjgs
         tipiTkc/qQTNqqUzRnSCThX/d4MGM9NhWpSZmVMnQM3pqq4yx5g70Byt4iEKqRkfEQky
         pbz/z7DJ8iHf7Vnv+jXu3bHmZIsk6tu1pmDLFPxtjw7PvQHVoaxud646p2I9qall1u0b
         ylpuhy7wJngVzWR0OhGogMkW7k1OSXGieGGt0reQt3Lcx1sriY1ztbS+Eerxe/SHZt4K
         YdRA==
X-Gm-Message-State: ACrzQf0cSSsHvL3WS6dt/gVnpygmMJI0s7gDi6Bd9jyXx2uRpocvjUgf
        IO472RclWAgrUM3dRYRqBeDcgYcLGrVT4w==
X-Google-Smtp-Source: AMsMyM58BTK4/xI0t7LhpMrM6E7EqDN0bSKe1EvX11Ehz9Ycc/AtyshJratstf384NLGWov2g0kvvw==
X-Received: by 2002:a0c:e352:0:b0:4bb:825d:a803 with SMTP id a18-20020a0ce352000000b004bb825da803mr19567376qvm.9.1666968426539;
        Fri, 28 Oct 2022 07:47:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id d198-20020a3768cf000000b006ee949b8051sm2990863qkc.51.2022.10.28.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:47:05 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:47:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y1vraxBcHvoc0SZ/@cmpxchg.org>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026200613.1031261-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:06:11PM -0700, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
