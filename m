Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A426CB8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjC1HvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjC1HvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A83C24
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679989760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8slMBXaX5tKJuNxDkb5aHuL3vFrJ6coZs8pJFAMGiK0=;
        b=fdC5SZ8pyg4ek1F+5re7IwEvmVuiYm7pykharUak6CMJ88ofewDVcrGpBHxeT/Wg30MgP8
        cixnorjDcvH8UM8OHyn4QSDjd3KQ44Cx8SnYEY0wD/HCEOwlnLoVmOyteo3C3SyXn7kOnl
        bcjN0m6kHqSxuLNEfXdXMdiHIjDqJac=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-S1U-sEedNAmYkFR8ydSW7w-1; Tue, 28 Mar 2023 03:49:16 -0400
X-MC-Unique: S1U-sEedNAmYkFR8ydSW7w-1
Received: by mail-qt1-f199.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso7633880qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8slMBXaX5tKJuNxDkb5aHuL3vFrJ6coZs8pJFAMGiK0=;
        b=GFTevY/WDRpGuuLZLsihxeZ6ChO7gjsqE5l7xEOeT0QDi3vrVlk1ruHWWCCODoclSY
         yvhSy8DpYpey1bIdl10rq3rkT0hgB5CW86WJPQFla2IuCflIcXLDf16lSbGjq24cfp7E
         0GTdcbFKk8NUWOHP0wG+1cL27OLb9aktKm017hY1eWoEvSX5+IXEOJS/lE0WyQkeEGM4
         mkm8t3H0ukq71m3Y4ar5gWlnUa0k0maqzluvtYTeZ6bGnNgJaa19gKsHtA88s8vxorP5
         HU4Fj+q652ciF01oW4oEXXKhhwrEn8ly8+RSzCgGe5++XOw5j7StIWKHX7Fbig0cZAXb
         1R3g==
X-Gm-Message-State: AAQBX9fL2c0MOY/Ucnl2D71NFHar6HhlBNEIKQqsTn6a/sMVFtFMu1V8
        LMN94ztwQZJBVhLTxqrRKv5LLpIS5asnuPB5u2b9CQ0l1UCREPW+4qIYVBJQgGaz9PwOmDk/Bca
        y/CIN3EnHyJPO40ybac8UIxhZ
X-Received: by 2002:a05:622a:2c1:b0:3e4:e8be:c3a4 with SMTP id a1-20020a05622a02c100b003e4e8bec3a4mr11464855qtx.56.1679989756323;
        Tue, 28 Mar 2023 00:49:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350ail0lTX7WFSmqdfltJySh8ck2FEvfITqls1VGpUAH8boD39DgywjVABQBk7ihF++gBl2ur+A==
X-Received: by 2002:a05:622a:2c1:b0:3e4:e8be:c3a4 with SMTP id a1-20020a05622a02c100b003e4e8bec3a4mr11464840qtx.56.1679989756097;
        Tue, 28 Mar 2023 00:49:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b003e4e7e89828sm1491267qts.20.2023.03.28.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:49:15 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:49:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] testing/vsock: add vsock_perf to gitignore
Message-ID: <w5lm46kj3wfxzscga6333b6bw26lgzqmlkb675px6ya23ysym4@mqt33kghsp7z>
References: <20230327-vsock-add-vsock-perf-to-ignore-v1-1-f28a84f3606b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230327-vsock-add-vsock-perf-to-ignore-v1-1-f28a84f3606b@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:16:06PM +0000, Bobby Eshleman wrote:
>This adds the vsock_perf binary to the gitignore file.
>
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/vsock/.gitignore | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/.gitignore b/tools/testing/vsock/.gitignore
>index 87ca2731cff9..a8adcfdc292b 100644
>--- a/tools/testing/vsock/.gitignore
>+++ b/tools/testing/vsock/.gitignore
>@@ -2,3 +2,4 @@
> *.d
> vsock_test
> vsock_diag_test
>+vsock_perf
>
>---
>base-commit: e5b42483ccce50d5b957f474fd332afd4ef0c27b
>change-id: 20230327-vsock-add-vsock-perf-to-ignore-82b46b1f3f6f
>
>Best regards,
>-- 
>Bobby Eshleman <bobby.eshleman@bytedance.com>
>

