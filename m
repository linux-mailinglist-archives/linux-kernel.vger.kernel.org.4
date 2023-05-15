Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCC703CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbjEOScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjEOScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0AC18C8D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684175480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MOj6t1AMbPCvGUuEBcmtwWAQ86XL4E71akbkpHomH5I=;
        b=TBAqVaqaBxXm/Zv27rpmhyGJgPBSVaHigovM3fvqYvg867mMxccOdhUzfH6j5cCmFbpI8+
        2N+4Ltem/wEH5Ku2PGZMR9Cq83b3d3HTnkJgxIhX8o7wgTP5yBhxevDOUv8KvjN39TdwxL
        As1dmf7bD3zMGwNW5yW8Rjp+aI4l8Bs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-vLCJX4f6M_mACQiA1D_b6A-1; Mon, 15 May 2023 14:31:19 -0400
X-MC-Unique: vLCJX4f6M_mACQiA1D_b6A-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1877e4dff8aso8561506fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175479; x=1686767479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOj6t1AMbPCvGUuEBcmtwWAQ86XL4E71akbkpHomH5I=;
        b=YNUFrQX4BjG7Qgd5YOc+b5xhOtL10VKV6k15F9Ej8xptffDAoN9eOnU7/bP6fc9SxF
         UsTWj8IWxbArfZIetAlqti/crz0zo/mL8zfhc96tWdy8dAVt4767moEQjvDh6rIVXcvm
         QSLy8tYgIF4iIZyXNfzR0c2DLAqRkCW53p0QvuzTXZa6Pig+QqPOyU/tV2/aKpq3RY1E
         bjLY9Oo3kV59Q38W3Wq9uj2QlWqgl6yAdzNP3kohQ2uOIRuyrxrVIwTlPgmqksheCZ16
         zzbeuBX3R3XwPARhLTgNmYHHm4qtH8w1RHnjMpSTZ1Vo4BqKSt5ftKDLWYjFalthIl7A
         LBIQ==
X-Gm-Message-State: AC+VfDzeXS204+mtcP0CsPUJTis12TI5YTqDMw4z/q9HSHZxj8ItmocM
        +hjdi66fmzxbY5PiPxUvy8FacikbnNk006eWTSE19n1QzArqctK8s0oZrHeoyM0ls45ktGoealh
        ApzGFeh0btE0kw9m0+ZIgRoyy
X-Received: by 2002:a05:6870:6255:b0:195:fe38:3b91 with SMTP id r21-20020a056870625500b00195fe383b91mr12443389oak.40.1684175479079;
        Mon, 15 May 2023 11:31:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ442pvdikS2ZMXzMgyzrVm2wRGicD8EmqCx96Wc9UrLDq3ZNgPqozxnFHfDNm2b2bXgWuUKqA==
X-Received: by 2002:a05:6870:6255:b0:195:fe38:3b91 with SMTP id r21-20020a056870625500b00195fe383b91mr12443378oak.40.1684175478802;
        Mon, 15 May 2023 11:31:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id ea20-20020a056870071400b001964dc3dadesm6094075oab.45.2023.05.15.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:31:18 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
Date:   Mon, 15 May 2023 15:30:44 -0300
Message-Id: <20230515183045.654199-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFCv3:
- Split the patch in 2: entry/exit and queue
- Fix 'struct __call_single_data' & call_single_data_t alignment issue
- Made all TP_printk follow the same pattern

Changes since RFCv2:
- Fixed some spacing issues and trace calls

Changes since RFCv1:
- Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
- Using EVENT_CLASS in order to avoid duplication
- Introduced new helper: csd_do_func()
- Name change from smp_call_function_* to csd_function_*
- Rebased on top of torvalds/master

Leonardo Bras (2):
  trace,smp: Add tracepoints around remotelly called functions
  trace,smp: Add tracepoints for scheduling remotelly called functions

 include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 41 +++++++++++++---------
 2 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 include/trace/events/smp.h

-- 
2.40.1

