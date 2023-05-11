Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38A96FF43C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjEKO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbjEKO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:26:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E15106E2;
        Thu, 11 May 2023 07:26:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9659c5b14d8so1430154166b.3;
        Thu, 11 May 2023 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815201; x=1686407201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX1eGa2B4zwlKeG6BlsmclZE212qcwapZaeSouPQJvk=;
        b=eXB5yE1v2WQ0PSpMfBeBo/WdgEpufMgmK/+iTeF5dgyEMjqGCtqfLLroXENpZ/Nnga
         2gftvlN2sPWKeyAUul+z/Y0ktcMv4EXx4DJuQZ4+GY6vFD9ZwnfL0Aw5beQJZUJSrbtP
         Bn1w65DqCBQGjie3s35YNzURxW5H2DD90Ocfu2YioDvQmPGLozIsqhW/akKi0SnUIfi+
         feOJUy4uJXjRqE6TxzYSbMjHOd8mWE9zhZZJ5xHgL5+48m5I4tUIc+1I16/MRAcn2Y+u
         To/boRZtv3+EcXS/bZv19RvBO59u3dTZTDeuK85XLNe/JwrmkknGA2ypOEZoMBlscFET
         TMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815201; x=1686407201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX1eGa2B4zwlKeG6BlsmclZE212qcwapZaeSouPQJvk=;
        b=Uedu4RxLhqELAmG6r//nVcqoyP87eVGb1BbzmIc2fYCneVWSq/qVxpIvB64ioCYDsa
         KL4ZtTJZLmTrWvVuxuWXusDYfR7QBhpuDbahG1Ql8mnmOjgHndTeCq5h/UbwOhMtZcf1
         lAcIPDGJL5Ug3nHLFIEDvTmty12ky2V8831GnnFNC/m4dt1xELXhorzcaniyCVUmR8OD
         Dadv4oDDpjyQAP38VV6lT46IJU5ajoBkzCyhGSAAIx2XzA+7ycRcQsAPZtcHO9hPntqE
         Kj8GZic2F+hH0uuX3Ihl3DHxEZy3lgphqMPHewkCMzd5TtraV6VdGc4ukt/TZr9WgtSx
         +GSA==
X-Gm-Message-State: AC+VfDxHh0byo8z9J94RXfRA+4rDHHCyvGS5BE2V5YXmzR55eB/Ib6Xa
        VouHedFZPHCTZcIHdjYA5Vpmz3nqkQrioQ==
X-Google-Smtp-Source: ACHHUZ4eZN+kVDghwgVHKj9kmpXT5KmdDvT0TAbfmOiIA8WZvEH6Oxt0iW38Cfgvex39a+c8cRM4rQ==
X-Received: by 2002:a17:907:26c1:b0:965:eef3:f9b9 with SMTP id bp1-20020a17090726c100b00965eef3f9b9mr18589768ejc.29.1683815201440;
        Thu, 11 May 2023 07:26:41 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] bpf: use new capable_any functionality
Date:   Thu, 11 May 2023 16:25:31 +0200
Message-Id: <20230511142535.732324-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573e..1bd50da05a22 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2539,7 +2539,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
+	if (is_net_admin_prog_type(type) && !capable_any(CAP_NET_ADMIN, CAP_SYS_ADMIN))
 		return -EPERM;
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
-- 
2.40.1

