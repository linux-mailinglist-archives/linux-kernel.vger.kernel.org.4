Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABB6E71BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDSDlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjDSDlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:41:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714C6A44
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:41:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so309172pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681875682; x=1684467682;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6mgm3Di7gHIXRR1b3Pr408Mz+NLzzONCXm1uh+AKO4=;
        b=clblKm9O1VpWESzYzftaKLkgtzkFRl4IoswnIWWfM+vYZDxcGdGxNSGPSXXSgLim4o
         aqoJ7QSFVUk4be0sAXrzdjnOqF12e3GdDl+d27cg/ulipwcj0KMuHVTKPXHzxqSpbL+3
         d7+BG/6ZumIdlKEk57i3uJOxyTlSEtHjynHkqukj7yTrpJT1CxWM2zuZlp3n4WSbYjMm
         TpXt/MG267ECLIyBg/y1RfRmCClASzhpwZQ/V7L8GJsmAc2+Ytm+rCNXFsI4qQoCxr5A
         EvYYZWU8hjsztoWKvpNdXTFvmqgbARYHPrkXll9nxVDJluJ1nl3cVfCL1G0HXUvo3t41
         kNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681875682; x=1684467682;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6mgm3Di7gHIXRR1b3Pr408Mz+NLzzONCXm1uh+AKO4=;
        b=H+y7q3JwEvNWatQAHunddua6/u0gTl9M2cGXgsxkn3FVP5bqenIwQuS9mUeRp5Tjr0
         55cjfI61CcRFBBr59aUD9ssK/c98xaGvrZ2r4XcqB6OqBwEcl1kzBxt3bueaA5XKteSQ
         cn7pWFDR3wXlt9OCZCG/BCEuZbz1d+m1btKLn0a6K3/MFRvLGub1oXHx9XJ6gfixXNM3
         8NX/L+JgQww8zhdbgGQiH469EWbF9A5xQydW1zJ66MBlSYHZZ+D1JZPFzAmcBc5qJNVM
         ItGqpdY+HPe+ZEt5KoLi1MsHcGyEQI0MfY+9vHmE5/bYHT5rY9vk48qpfGFfXFSZShd7
         wDAQ==
X-Gm-Message-State: AAQBX9fYmoU6JwQ8lyi76xE/GtXrQxauuD+0z7K5ajm58z0m/eQZuo82
        1lhSwZXotwkevJ8j5wPjJPxy3Q==
X-Google-Smtp-Source: AKy350aFSnjy9GBus6W4i7rBmh5kAse78TXrksJiRFcdAUesKxA80OaYasCBI85Hv8XTlxGQAU0oPA==
X-Received: by 2002:a05:6a20:4423:b0:ee:e922:6747 with SMTP id ce35-20020a056a20442300b000eee9226747mr1933679pzb.56.1681875682524;
        Tue, 18 Apr 2023 20:41:22 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id 190-20020a6308c7000000b00513cc8c9597sm9278189pgi.10.2023.04.18.20.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:41:21 -0700 (PDT)
Date:   Tue, 18 Apr 2023 20:41:21 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Apr 2023 20:40:54 PDT (-0700)
Subject:     Re: [PATCH v2] perf tools riscv: Add support for riscv lookup_binutils_path
In-Reply-To: <20230315051500.13064-1-p4ranlee@gmail.com>
CC:     jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, acme@redhat.com, anton@ozlabs.org,
        dja@axtens.net, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, p4ranlee@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     p4ranlee@gmail.com
Message-ID: <mhng-534349ae-0594-455c-bc27-da0d8a70d0be@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 22:15:01 PDT (-0700), p4ranlee@gmail.com wrote:
> Add RISC-V binutils path on lookup triplets.
>
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> ---
>  tools/perf/arch/common.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 59dd875fd5e4..e80d4d22cabf 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -43,6 +43,20 @@ const char *const powerpc_triplets[] = {
>  	NULL
>  };
>
> +const char *const riscv32_triplets[] = {
> +	"riscv32-unknown-linux-gnu-",
> +	"riscv32-linux-android-",
> +	"riscv32-linux-gnu-",
> +	NULL
> +};
> +
> +const char *const riscv64_triplets[] = {
> +	"riscv64-unknown-linux-gnu-",
> +	"riscv64-linux-android-",
> +	"riscv64-linux-gnu-",
> +	NULL
> +};
> +
>  const char *const s390_triplets[] = {
>  	"s390-ibm-linux-",
>  	"s390x-linux-gnu-",
> @@ -166,6 +180,10 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
>  		path_list = arm64_triplets;
>  	else if (!strcmp(arch, "powerpc"))
>  		path_list = powerpc_triplets;
> +	else if (!strcmp(arch, "riscv32"))
> +		path_list = riscv32_triplets;
> +	else if (!strcmp(arch, "riscv64"))
> +		path_list = riscv64_triplets;
>  	else if (!strcmp(arch, "sh"))
>  		path_list = sh_triplets;
>  	else if (!strcmp(arch, "s390"))

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
