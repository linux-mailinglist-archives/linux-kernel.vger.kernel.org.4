Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340F6E5707
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjDRBpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjDRBoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:44:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E909742
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f66-20020a255145000000b00b7f75c3cafdso9881114ybb.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782116; x=1684374116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DALAO2ExmfoURx8M3mnwBONzpAf0Sbtvw4FW/zSKTOw=;
        b=b1pQ3Wp8pZEzXCbTH1QL/Ey40sMcU1WsteMeb2jyEsZgnjoUBXs5syd1fmCtVJ54BM
         ucvMArZe1DkIAPgCv6jTYYdZaXqPr1r6ky4LmwZHPamxAuGCy1nVGcp7zftCUflOLmmi
         aJeYevODjYE4KqIk27YivRkHUUBNXZTg0n5uJXu+HFhCaXhwv304SKI0sISs3mHSDnGE
         5o+CzIg5h/iHNjnXmuv+lRIg+H2gVBT1ZeY2rFDaAJ2oL3N4SRNTTIZZDhGXtWOFHsrW
         uSS3X2aDmNNPhbbfdU+hPMiEwfIzOyfTT3qhJgQj1/9EC9ZxyNIJ7+fpnVzr+Azzqjmw
         gbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782116; x=1684374116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DALAO2ExmfoURx8M3mnwBONzpAf0Sbtvw4FW/zSKTOw=;
        b=j6Mx8/dFbKSsYUz8c/8KOrRLuh4r4IQz/oBUZeiccaQVSB4Yz3SCvrLJQcUdcHSXoL
         /V4KOQIpKhXVnLCq/03t4YKRUnWa335769eEm2SJA84hqjrq7cBmKTEPFss97Nj7N6X5
         tALnxmlxR+NX4levhiS/bgc0y9JHOGDZp+IOXMpThX52+ECYohO+9xnNmw3HuPs1CzBN
         0AXDqWRBSyGP6AHB33p/axLMCBf45CvruSZ+mnti+ciYNrYwdpZ7BmfnYNY2ZG5KIOKH
         0x54oWeR9ZXXeV4HYp6p1JkR4ad8LuDu/Lu6gT/Ev7RRzUfdbi1QFGGbglg37IwPiL7o
         yuuQ==
X-Gm-Message-State: AAQBX9e+NXCJBFIIcTTb91+pIeye/mpKcloBB4IWu37n1iHPv06m3uJH
        SH8rjWk8s4q9wEHEYeZacAZKdPqMmTQ=
X-Google-Smtp-Source: AKy350YnTlka0bcTU0RKtykV/F5v449o4LL77KqLH6Q3VuPHp90P6xAOoKpCMm9SycClz+UembUKg7Mmil0=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:8051:0:b0:b92:40f8:a46f with SMTP id
 a17-20020a258051000000b00b9240f8a46fmr4360158ybn.2.1681782116629; Mon, 17 Apr
 2023 18:41:56 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:29 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-30-drosen@google.com>
Subject: [RFC PATCH v3 29/37] fuse-bpf: Export Functions
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions needed to be exported to build fuse as a module

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/bpf_struct_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index deb9eecaf1e4..0bf727996a08 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -745,6 +745,7 @@ bool bpf_struct_ops_get(const void *kdata)
 	map = __bpf_map_inc_not_zero(&st_map->map, false);
 	return !IS_ERR(map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
 
 void bpf_struct_ops_put(const void *kdata)
 {
@@ -756,6 +757,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
-- 
2.40.0.634.g4ca3ef3211-goog

