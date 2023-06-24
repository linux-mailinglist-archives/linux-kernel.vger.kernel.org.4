Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712473CA1E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjFXJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjFXJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:28:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213C26A8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:28:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094910b150so1707433f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687598887; x=1690190887;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yALLPmOE7+hISGtYfMqKGpt/k5yG5q3Ed3XuC87leZ8=;
        b=Qv1Ua19tBkqyWfEwzA5JBVMzDRypzLj5juPHXL9MXlsxlPXF+KUNdGNDgktJlSrrTY
         0uUhXsfhl7DT+xVr7gb5ezCgaLruQC8cSfGL0mSvEzc+qr7S+JFU40WMbb2bl9TRwARX
         1ilpKnmsf105pKf+wJr3h9nsLH6kiCqFkud69H0mDwaB0ua0WTRnEnpGDZeb7War868m
         YprPYPiWM5MPAulDrmbxAOJcdh/SzuU4jL6hiTIE+hdqHOJmHR6DFGzz5FaP/44hcPM8
         jLnr6pYgF0jSh5Bdla2vC727/GtxmPoV0YvDpU9iuyQPkS/y2szdsUA1sgV+jnU+CXH0
         QQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687598887; x=1690190887;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yALLPmOE7+hISGtYfMqKGpt/k5yG5q3Ed3XuC87leZ8=;
        b=gcAr4xyKPyL5LM33RzZEq4qe4sxl6iZ/sHsNyCXmzeLyBMqbJ7ADzfF+PjrNkbMiMG
         R85gtgO5oYbDcR3Z/sX6Tbm49r7jo6GYkhdmueN8XcLPkr2x0AQIfGqsqMqd8xdyjXSu
         ZRbuRedlHg3gGTt6AfQ2LoLpClzDSdYEWnnrnA14am5yimW33Hv+XvIq5P+ZKRDx6TyF
         AP4DizGS3sQxujvdDah4vSrRCIwY539XnDdc+nSR53X196+049Id1REgfieeYGdFSaYp
         cIdIlf5nff+TsCmCg8Xh/ZfeHiWp4wsJy5TulDgFnvhrgXSajAX5iZHmymmKC7Fl4yMV
         FqfA==
X-Gm-Message-State: AC+VfDx1Guu8d4rxgNrbSUlmWo+yaudWYst7eh0IRfInQT3Hw3kuKtY2
        G80INkjQp84gBuEjZ5HF17Y1iQ==
X-Google-Smtp-Source: ACHHUZ7UZ43FKF6Jax69cdaAZdJa6U/q1U7TusiAstVCGhkk0TjGj6cLc/jLumslzqFBTp16WULcow==
X-Received: by 2002:a5d:6ad1:0:b0:2f5:d3d7:7af4 with SMTP id u17-20020a5d6ad1000000b002f5d3d77af4mr18514644wrw.63.1687598887140;
        Sat, 24 Jun 2023 02:28:07 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:8011:e80c:0:9f:41d5:6eae:4002])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b0030647d1f34bsm1652247wrt.1.2023.06.24.02.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:28:06 -0700 (PDT)
Date:   Sat, 24 Jun 2023 10:28:05 +0100
From:   Quentin Monnet <quentin@isovalent.com>
To:     Fangrui Song <maskray@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Yonghong Song <yhs@fb.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_bpf=3A_Replace_depreca?= =?US-ASCII?Q?ted_-target_with_--target=3D_for_Clang?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230624001856.1903733-1-maskray@google.com>
References: <20230624001856.1903733-1-maskray@google.com>
Message-ID: <A886FC2C-35BE-4215-B9FD-61B62EC56ACC@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 June 2023 01:18:56 BST, Fangrui Song <maskray@google=2Ecom> wrote:
>-target has been deprecated since Clang 3=2E4 in 2013=2E Use the preferre=
d
>--target=3Dbpf form instead=2E This matches how we use --target=3D in
>scripts/Makefile=2Eclang=2E
>
>Link: https://github=2Ecom/llvm/llvm-project/commit/274b6f0c87a6a1798de0a=
68135afc7f95def6277
>Signed-off-by: Fangrui Song <maskray@google=2Ecom>
>Acked-by: Yonghong Song <yhs@fb=2Ecom>

Acked-by: Quentin Monnet <quentin@isovalent=2Ecom>
