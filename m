Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9407161150F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJ1Orq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiJ1OrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:47:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A131FAE62
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:46:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a5so3532465qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JbhK0WAu1TP4fT7MkKzuH3m54mzyTiAcFsJp+ELS54=;
        b=hqN8izkdXwMnVjLZnFayzyxMO/+hd0tIFwj41XF8Z5d5SsCCWgelW2O/G+RUh/MeOd
         Z2zEbesVmyp8FSJ5y2cjLT9KILEqgtC7KoqHz1cpgURjaN47oZ9FzheO3E0IKutEg2x4
         AGFjDtYbTETv8iqAf46l9XPMxnpHH+eRoV72L4O6HKBU5oF5wy2Lh8lbrP1/4pilBIy/
         4AH08HK5GKRCgZqf/r4/2zOTYS7O3lSf8Z1jXx50rrlh8BkpE/YdpbCQ3h49VRj7zOFH
         iU9j6DqC6fZbEAUcvxUjV5KJee2GHQBg5bAbL6S4ufikAs4rzkK2GsXAiKRBYcNSAswp
         YE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JbhK0WAu1TP4fT7MkKzuH3m54mzyTiAcFsJp+ELS54=;
        b=QMGWVeVeBzdaTERvq42silut8zC52FDaBLBYDfuoXckknPjw5/he6xWP6frRd3GyV+
         M1QPgxiY8AY9QoYpRwE8P0VO2PnXQtkHz8wUAMhOyDEQU1CUq051uPm4weoZjI9RBgEO
         H1pECQ/o3flWM+BMrTbN2T1+ViIC2FuTMLztQuJGDwAeqFzYN6eFdZeBvv11qhs9pqEq
         jVF+NmD6JjiZiqVWF0vMXO9sc+utuTxQcjb38/DhdCXUUFxrK8+wx2f9b0XmFwqCJ1G7
         vq31NqImjNVTx0MlIKxgmtKS490cxHe+QVPZDJDjgi6cR2gfupMd/9VBtlw0wBwVSvkk
         hiNg==
X-Gm-Message-State: ACrzQf0B4juzFB2NG+uLFBiX/H4qsGNwyaO1MDVgLles05wc0fDX+4cA
        0DMmZwCmCPcBQPamhRNy/3k3kg==
X-Google-Smtp-Source: AMsMyM6rLyEvz1oFaIKmxYvwUnTuL+n+oIU9FRKMF1g3r1G/sKu8v4moHYffGPnwSORz3lOVzZtY7g==
X-Received: by 2002:a05:620a:4449:b0:6ce:d824:d2e2 with SMTP id w9-20020a05620a444900b006ced824d2e2mr38572515qkp.183.1666968395683;
        Fri, 28 Oct 2022 07:46:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id bl4-20020a05622a244400b0039a08c0a594sm2425824qtb.82.2022.10.28.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:46:35 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:46:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y1vrTI3G4xitvFEr@cmpxchg.org>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026200613.1031261-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:06:10PM -0700, Nhat Pham wrote:
> Currently, zsmalloc has a hierarchy of locks, which includes a
> pool-level migrate_lock, and a lock for each size class. We have to
> obtain both locks in the hotpath in most cases anyway, except for
> zs_malloc. This exception will no longer exist when we introduce a LRU
> into the zs_pool for the new writeback functionality - we will need to
> obtain a pool-level lock to synchronize LRU handling even in zs_malloc.
> 
> In preparation for zsmalloc writeback, consolidate these locks into a
> single pool-level lock, which drastically reduces the complexity of
> synchronization in zsmalloc.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
