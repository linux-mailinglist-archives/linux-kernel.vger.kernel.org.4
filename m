Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CDD6E74AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjDSIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjDSIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:10:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B888A5CE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:10:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso108395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681891822; x=1684483822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsGwV2Q8hiUUCin8FfQuNgJhB+1Rkf9xa+k9rhAHqZo=;
        b=zQJ8vS4RxsDCS7E0LTCt87h1B2g+itFCXg/Y7oCyhQxecwl/ymjeTP2UNW4kILWCfq
         vDO9QvkLpVx/K77cuk0nFrvPj9JZTG/GqNCc69q7FwiJB6HWp/UGpBqIKB++oGIXIwWu
         Q/+IjAclnE0qosL1x70GrgKTqioCaGZUjPcxECSE8wcJFsYW6zISEE0oQVWhiFQKT9Qe
         mBecJmzU3DkHc/DTFPO92SXu0GOK2m3JZF4Y59XmLKy7mH4B+d6QBftimrHWubbl3gXQ
         PIDkUyUqTWvALTxlSRSsPXL9NQd1wGonI1LHVod557K/UNND1ua43TCFdNUmEhbNXGzU
         RrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681891822; x=1684483822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsGwV2Q8hiUUCin8FfQuNgJhB+1Rkf9xa+k9rhAHqZo=;
        b=H03VSeA7mWBQn45eP9wYarzoj2mL4tWdn19+X9Tn/43Geh+fpmFm0FWrBy1mm37Kkr
         RSSOItvxFs5BsJgDbL9KpDCZaoW9PhiDQWxQh5MUiHpgHdxhnxate2J0517MQeF5P9CK
         8DFZROA+WPAcV75Ezm5t3wOfDwqjQYThYAVtbcjlt7y7RHJkqA+wM+7d0hroL/tjWzz+
         lIt9tQ2SfGZPB0bdbpenyAFvtKlF3R9MindIZr3hjdrrymFDEUn2i/rneJ0EuowQgMUv
         jy7DEPlnUDa4rcR4t5xb6+tBY6Zi3eLI6176FgGn/q1c89bjyoBEN7D3PJPv7tD50mgY
         uS0g==
X-Gm-Message-State: AAQBX9cyIQR2ULI43PVpzqQxQWAbvoGgAQvuijc5CyzUvo9lwm2xP/h6
        tndzvt6dmJetjYY60QJ06uIg5A==
X-Google-Smtp-Source: AKy350aswh3IRcXsvvw2ETIZyZZt4fSbriSdkF+WXX88/JuCVVzPnt3DMpU/ck62cZtnIIRI5mVsaA==
X-Received: by 2002:a1c:7c06:0:b0:3f1:6f35:f677 with SMTP id x6-20020a1c7c06000000b003f16f35f677mr93206wmc.1.1681891821553;
        Wed, 19 Apr 2023 01:10:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:adc2:d1ba:3d22:aaca])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc2aa000000b003f080b2f9f4sm1342501wmk.27.2023.04.19.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:10:20 -0700 (PDT)
Date:   Wed, 19 Apr 2023 09:10:19 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Yifan Hong <elsk@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Daniel Mentz <danielmentz@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kheaders: Follow symlinks to source files.
Message-ID: <ZD+h60QyBYEXnCHQ@google.com>
References: <20230419002946.2566272-1-elsk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230419002946.2566272-1-elsk@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:29:36AM +0000, Android Kernel Team wrote:
>When the kernel is built inside a sandbox container,
>a forest of symlinks to the source files may be
>created in the container. In this case, the generated
>kheaders.tar.xz should follow these symlinks
>to access the source files, instead of packing
>the symlinks themselves.
>
>Signed-off-by: Yifan Hong <elsk@google.com>
>---
> kernel/gen_kheaders.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
>index 1ef9a87511f5..183d9a44aa39 100755
>--- a/kernel/gen_kheaders.sh
>+++ b/kernel/gen_kheaders.sh
>@@ -87,7 +87,7 @@ find $cpio_dir -type f -print0 |
> # pre-sorted, as --sort=name might not be available.
> find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
>     tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
>-    --owner=0 --group=0 --numeric-owner --no-recursion \
>+    --owner=0 --group=0 --numeric-owner --no-recursion -h \

I would have a preference for the long form --dereference as it is more
descriptive.

With that, feel free to add

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias


>     -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
>
> echo $headers_md5 > kernel/kheaders.md5
>-- 
>2.40.0.634.g4ca3ef3211-goog
>
>-- 
>To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
