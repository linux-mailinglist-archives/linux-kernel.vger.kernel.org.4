Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A740F64BB74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiLMR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiLMR60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:58:26 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF820362
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:58:25 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id q2-20020a4a8e02000000b004a0236114ecso2490418ook.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iam0SRV7ItknkUquUWujqPV80reUUNpRqwJZW39TTFM=;
        b=IZVHwdLrXF+PyrQctfWEs/jPHJI7SmRRQKluwe+7kmaLuONkoS+CSRNy59Q3xn7Tqe
         lUY4SCmpW5y6HpyEHXpAC4YckcoBbCrcbI2N4fMiNIVsjabC0qD5pQr+AnIKEnc/JGt7
         OvcvtUZFLRumjJaZgLgz1hAqAwYzFdjTKKDhzHQ+fbTDjsvXGMyAdW4T4iGibndCLvyX
         dD0+Eex/DAGeg/ioDIzwZi+fVe18JK+rS+Bdd7wbPoFPOydddxukQZ//+VaV1VvvRWNn
         9VxpshdE3OPVeZ0F0jsM4Idid/Z/vAA5LzYiL1UCI/a8Zdz5B9NNynllHWl/ZAGGuLmq
         4jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iam0SRV7ItknkUquUWujqPV80reUUNpRqwJZW39TTFM=;
        b=QoHRrvg8loViJg0By2KIONmSS0FzG6fgCF60FPTOUvuGA3k4hCzjDGotCAGA176fyx
         knBXtBXFmQHPOB147m0eneV1AgCnZdcS79ITFQau4QQZqEGQx8refXnf35HIGOu8K1JE
         pY2KsnHbdmxYEWO05z+nDBrhjCsccHRUWYwPGbb8ZmadQ3/R2zqJ/C4kiJrvmgoM/98X
         s/qvGru+wXzpS0QZ0Ma5zduiibJOCVT5mJ59ilYAG0/JpYk1AuCvoxckKKwvB720bOqC
         jGnWWOSFCtBrDIq3VagI3Clau/asJs9pX8AFyMbMTl+bXi9aTNjAMt8aqskmL1k6qg0L
         5fkg==
X-Gm-Message-State: ANoB5pmXFnCWv8q4x0E6XYokrmLuIvzATTxA7Nn5E9T/i9plBb6XbhNg
        0zTsJneJvzY146XQIjY3B0O15Q==
X-Google-Smtp-Source: AA0mqf6jYTnicbPwkAItFGPdAfJfKF38sl1E3IwiTyQVQZrxi5uhRCCmqvJcjKnjBH/O+PSP7Q+sAA==
X-Received: by 2002:a4a:41:0:b0:4a5:5dbc:811c with SMTP id 62-20020a4a0041000000b004a55dbc811cmr33473ooh.3.1670954305075;
        Tue, 13 Dec 2022 09:58:25 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:6bf9:9d04:960d:7436])
        by smtp.gmail.com with ESMTPSA id s21-20020a4ac815000000b004a0aac2d28fsm1367756ooq.35.2022.12.13.09.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:58:24 -0800 (PST)
From:   Milan Landaverde <milan@mdaverde.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, Milan Landaverde <milan@mdaverde.com>
Subject: [PATCH bpf-next] bpf: prevent leak of lsm program after failed attach
Date:   Tue, 13 Dec 2022 12:57:14 -0500
Message-Id: <20221213175714.31963-1-milan@mdaverde.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [0], we added the ability to bpf_prog_attach LSM programs to cgroups,
but in our validation to make sure the prog is meant to be attached to
BPF_LSM_CGROUP, we return too early if the check fails. This results in
lack of decrementing prog's refcnt (through bpf_prog_put)
leaving the LSM program alive past the point of the expected lifecycle.
This fix allows for the decrement to take place.

[0] https://lore.kernel.org/all/20220628174314.1216643-4-sdf@google.com/

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 kernel/bpf/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..64131f88c553 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3518,9 +3518,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LSM:
 		if (ptype == BPF_PROG_TYPE_LSM &&
 		    prog->expected_attach_type != BPF_LSM_CGROUP)
-			return -EINVAL;
-
-		ret = cgroup_bpf_prog_attach(attr, ptype, prog);
+			ret = -EINVAL;
+		else
+			ret = cgroup_bpf_prog_attach(attr, ptype, prog);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.34.1

