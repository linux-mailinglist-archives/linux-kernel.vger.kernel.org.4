Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBB6737FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjASML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjASMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:11:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E8474E3;
        Thu, 19 Jan 2023 04:11:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so1128895wmq.0;
        Thu, 19 Jan 2023 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYDHXKfGKMOLeZXEVoSz6EIYCUqDCJgfKR9UAUj/K0U=;
        b=aJGuvCA2vIjsi8uAH84tZm9aAezVq97s9WNCbsZDQmnOpzRW+1lMbXFfSU7HOGVzSW
         wtC/T97Ki7P1ST29TBrs9sS3tCGfDqJ04TTHI3BTR3bzZw4FJhcTNoRt0Oc2xlRVKX2r
         1peVBnvoG837z6+hrn0swqwm96Xlc0IyBn1Koqvx7CJeR6dPikU6hds4X5GZA6JtevmA
         IZhp/S1ZQ9zRWCfC2pmHgnN/Y9ial4zbAfaNB/hCOgTmbdWftA7WYv62O3lSgtb6FKVs
         5qZIHF2bHYzXpxOvcWQelRmJTdQaAlbANmO0o8if7ThepL9UCnX5PZuW9VQuhXd5pl5d
         JoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYDHXKfGKMOLeZXEVoSz6EIYCUqDCJgfKR9UAUj/K0U=;
        b=hyfVTK4nE9r1HNPbP0E2eqTO+AVDen53rUcACm7KbQdu42nU30zFSyamyL6DXgyhYj
         x/ErcTkIwBFdTMd4APVUwSW23q+gPu6LhafeqfjADJFb47zAEjWw75eMOnm3zOuQ7naZ
         4bkIhrxR4NuDfjsNUQN6oa+tG8fKH0LAp05QjeTb4GcXBX0tOCNl2YOWt0TD7FdU1nc/
         ocGEuwE5aWKMCMHvLz6OsEyZOtEeR8SlgJ9/+nQNGaz/vU94YqHPdqRTCsl80aDuyqCS
         EZJOlhxVSxa7/jKDslEoVkUufic5xD9OylG8I61QSb9mzysKU0W60StAl4+bD1hWo/uK
         l49Q==
X-Gm-Message-State: AFqh2kqi7X5Vv8YmBXLR0bUGGk4oOlDHjZ/A0o1w4y0yhWGhscbiDJ87
        Fz/OXrIHm1WQ9izGTv3WJBpBouOk+28=
X-Google-Smtp-Source: AMrXdXvJcQWDLi4Jxn4FqIja5NrGHS0d0QAgadktDo1jcQgFlHSbsdsXSUAe1QA258Miw+iu1ayOhw==
X-Received: by 2002:a1c:6a10:0:b0:3da:f665:5b66 with SMTP id f16-20020a1c6a10000000b003daf6655b66mr10453726wmc.6.1674130282080;
        Thu, 19 Jan 2023 04:11:22 -0800 (PST)
Received: from suse.localnet (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b003db0b0cc2afsm4914948wmq.30.2023.01.19.04.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 04:11:21 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, bigeasy@linutronix.de,
        ira.weiny@intel.com, rppt@kernel.org,
        Deming Wang <wangdeming@inspur.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] mm/highmem: fix spelling mistakeo
Date:   Thu, 19 Jan 2023 13:11:19 +0100
Message-ID: <1841674.tdWV9SEqCh@suse>
In-Reply-To: <20230118004356.4198-1-wangdeming@inspur.com>
References: <20230118004356.4198-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 18 gennaio 2023 01:43:56 CET Deming Wang wrote:
> Substitute occurrencies of "higmem" with "highmem".

s/occurrencies/occurrences
=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/mm/highmem.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index 59d1078f53df..7da4a0d175f0 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -83,7 +83,7 @@ list shows them in order of preference of use.
>    for pages which are known to not come from ZONE_HIGHMEM. However, it is
>    always safe to use kmap_local_page() / kunmap_local().
>=20
> -  While it is significantly faster than kmap(), for the higmem case it
> +  While it is significantly faster than kmap(), for the highmem case it
>    comes with restrictions about the pointers validity. Contrary to kmap()
>    mappings, the local mappings are only valid in the context of the call=
er
>    and cannot be handed to other contexts. This implies that users must
> --
> 2.27.0

I think you missed a patch which is already in Andrew's -mm-unstable tree:

[PATCH] mm: Fix two spelling mistakes in highmem.h
https://lore.kernel.org/lkml/20230105121305.30714-1-fmdefrancesco@gmail.com/

=46abio



