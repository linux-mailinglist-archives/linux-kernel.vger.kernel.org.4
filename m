Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A30704C29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjEPLTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjEPLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:19:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC255BBF;
        Tue, 16 May 2023 04:18:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so99879295ad.0;
        Tue, 16 May 2023 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684235911; x=1686827911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPg0ep6G8/5e19PZD/WE6OkgyECU4hB9NkOdRxOFcvg=;
        b=B9yH26LwTE3zxqdgFANeBqWDb7Z3umtlY8ntgnC9EqhKQ2qR+dlh39USmAbpW2lWOA
         jHnG52/gUYbddZEWI9zcb553NxTFiWz0Fs228ASt3/2hNuoShjYdtCY1UYAd67j7ainK
         VorhP+3T2fx//k3Tb8PhvoGwioPAaw1LyAOOtnPU72MbiBlwBcy1FfalirROQlyUjbCG
         6Chw5z9HcA8boJzajPS4wf1I7L7qB6OXHmspq/twUlCml0/cPL9TDGISnYNpKtsGqBqk
         h0T2fLATtD4ZL+B+OUhj+ctQOGQqukIVX3Q4FO5w58Vtz6ShDrLd6SJ0RvfNHemXsGAF
         2AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235911; x=1686827911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPg0ep6G8/5e19PZD/WE6OkgyECU4hB9NkOdRxOFcvg=;
        b=itv1vWdLiaQgXWbxIP3nH+/SS/0iR6Ce3xmM611PMuTLJDtaMrWVKcMbIVdVb9oMkI
         POIXnnFCLzkoPsk+71XZO30XEWUxsOXfTlnrqhmC3m3D78i16BkuKcwJCqz9+u69rIv7
         s5zM4D+CjNDAPb7k/Hqsay2vWmDYcvUC0sQXCauFdCWO3KTEpCmdjN1alXASwfuwyifV
         Yv4u4lIAOyyQMVCGCnseH0dtTedIQarZr1rC0V/V3lLbBVgNVTt+81KDG5GUQ9DHNCSz
         vR0gspjoXMp43cAs47qjaPc44ZgOJCdmlXD6N+zPNBEYUjvdopgQeCrQJw+8BckaWO1o
         +owQ==
X-Gm-Message-State: AC+VfDyoUPI6bYL8j3khbiHQRzhLOLtsOIbVgwb0aqE/svy4I3bBAAyJ
        U9M2pWtxb29EAzXvVs59Png=
X-Google-Smtp-Source: ACHHUZ6IdEkzdFsx2MXAlbq7sWRdsYHgB4BklRNwbqrrX/U7FV/xiwpCz6FdE6Zv26rppBqWSgR8Nw==
X-Received: by 2002:a17:902:bf0b:b0:1ac:3780:3a76 with SMTP id bi11-20020a170902bf0b00b001ac37803a76mr32015321plb.4.1684235910863;
        Tue, 16 May 2023 04:18:30 -0700 (PDT)
Received: from localhost.localdomain ([106.39.42.1])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm15207821plt.290.2023.05.16.04.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 04:18:30 -0700 (PDT)
From:   starmiku1207184332@gmail.com
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Teng Qi <starmiku1207184332@gmail.com>
Subject: [bug] kernel: bpf: syscall: a possible sleep-in-atomic bug in __bpf_prog_put()
Date:   Tue, 16 May 2023 11:18:23 +0000
Message-Id: <20230516111823.2103536-1-starmiku1207184332@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teng Qi <starmiku1207184332@gmail.com>

Hi, bpf developers,

We are developing a static tool to check the matching between helpers and the
context of hooks. During our analysis, we have discovered some important
findings that we would like to report.

‘kernel/bpf/syscall.c: 2097 __bpf_prog_put()’ shows that function
bpf_prog_put_deferred() won`t be called in the condition of
‘in_irq() || irqs_disabled()’.
if (in_irq() || irqs_disabled()) {
    INIT_WORK(&aux->work, bpf_prog_put_deferred);
    schedule_work(&aux->work);
} else {

    bpf_prog_put_deferred(&aux->work);
}

We suspect this condition exists because there might be sleepable operations
in the callees of the bpf_prog_put_deferred() function:
kernel/bpf/syscall.c: 2097 __bpf_prog_put()
kernel/bpf/syscall.c: 2084 bpf_prog_put_deferred()
kernel/bpf/syscall.c: 2063 __bpf_prog_put_noref()
kvfree(prog->aux->jited_linfo);
kvfree(prog->aux->linfo);

Additionally, we found that array prog->aux->jited_linfo is initialized in
‘kernel/bpf/core.c: 157 bpf_prog_alloc_jited_linfo()’:
prog->aux->jited_linfo = kvcalloc(prog->aux->nr_linfo,
  sizeof(*prog->aux->jited_linfo), bpf_memcg_flags(GFP_KERNEL | __GFP_NOWARN));

Our question is whether the condition 'in_irq() || irqs_disabled() == false' is
sufficient for calling 'kvfree'. We are aware that calling 'kvfree' within the
context of a spin lock or an RCU lock is unsafe.

Therefore, we propose modifying the condition to include in_atomic(). Could we
update the condition as follows: "in_irq() || irqs_disabled() || in_atomic()"?

Thank you! We look forward to your feedback.

Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>
