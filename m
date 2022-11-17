Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189062E67F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiKQVLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiKQVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:11:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2769D22283
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3168010pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEdicyo8kKMcDcP6jXDPS7VZPkCWUqa7K7Caag7NcIg=;
        b=EUyg1tesRoQPe0SnCnm0UwTABVrLfxyJWbbVMkhrfQLfWZ/tlLjjHIKOuPlwn/71ax
         +ZhOqBjWguZJv5A0WRj/qoWf5lzr/54yYQu+XwxaJCM1diY9nrXJIyYOgofRoncuz42z
         HTHJUfwFvZzfZ2pkemb1C0YQJjdKFvwoblMat7y8qG7XtPk+XoTwYPz0ldkk37THfsEW
         b2ADdG+A3zXHyF0kfeG95rnQxJDe9m8hMF4aomTAoX5/Bwx6ud3LPZAjtztC9Eotnuku
         V1eLxmEzwcZNcnBQR9aTL35krykVEqK2ohdsC7d55TKBFC+dso9usvXAIawd+Csp4iyp
         M/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEdicyo8kKMcDcP6jXDPS7VZPkCWUqa7K7Caag7NcIg=;
        b=mrn0OMR0nqbdIEOHrpHw0x5Qefjo6SyozAE3yL7rclD0I/n9ZkfCWQp+qeYG/i4YEv
         xyDjKOsMdad7AQf7nPSK31PJj6bHIjnEAuaXdftdp3lf9yJRl0/RMGuBaYFXhrT4trqE
         6pO0S8iPoYQ9zpa5rO53bfCVGAS/n0gey4Vj6qcN0JHrUayUS+0Y42OzMOQlNNNhrs0u
         1NKaEEjomeWSoe5nEU4rSoj6YrI5qpa/EHu1NaUw2nZo3cvKOTNs9EEUyWKUoj4Ke/Hk
         wW8MBbwNveEMZPKIxwaWabgj/Qc93ArSmuITC+1GtUaxfCCC499T07CQgaKV8KdiTFmz
         2Axg==
X-Gm-Message-State: ANoB5pk0OGVrTjfMEgMNu3SHstlJtripL6uPDtiqapoww/r+ZFZ9zI+M
        KZyjvsOTocKKt8S98OeKFtX8Fm1xi2g=
X-Google-Smtp-Source: AA0mqf5c/H1o0JhbQlzEYygr7tXFvjUns/3OPOKxQx7Ig3wAhbJizx4v5a359Z7ktn5wbnJ6gm3d2g==
X-Received: by 2002:a17:90a:9e2:b0:218:7103:ea94 with SMTP id 89-20020a17090a09e200b002187103ea94mr4887030pjo.215.1668719507517;
        Thu, 17 Nov 2022 13:11:47 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6bbc:b70a:8f80:710d])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709027fc800b00186c37270f6sm1894640plb.24.2022.11.17.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:11:47 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 17 Nov 2022 13:11:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: remove unused stats fields
Message-ID: <Y3ajkcJKCQYEJL9d@google.com>
References: <20221117141326.1105181-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117141326.1105181-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:13:26PM +0900, Sergey Senozhatsky wrote:
> We don't show num_reads and num_writes since we removed
> corresponding sysfs nodes in 2017. Block layer stats are
> exposed via /sys/block/zramX/stat file.
> 
> However, we still increment those atomic vars and store
> them in zram stats. Remove leftovers.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
