Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA35731005
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbjFOHBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbjFOHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A0DF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686812421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OThjLmbvI6Zpg0mK9QSJewa4TGDoveYEJmGg/Gpz19Y=;
        b=M7r9zG6T9jmhXaAmPLWKf35+xqxqk/NZB63pl/iZDzrebJ9h6zeT75Sr2HK76P/CzCNjBg
        6BPGUgRNQ2g8JQnVGAO/t4PohyKMXpaNjK3j1R5h7ZiLMvP8r/S2WhDEaprIMCPzC5p7ju
        FU5m+NXHYm5QxYsUgr9flAe4+9IurYs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-ygQ5WXGBOK-4N9NzXXV4Gg-1; Thu, 15 Jun 2023 03:00:17 -0400
X-MC-Unique: ygQ5WXGBOK-4N9NzXXV4Gg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b29839730bso378099a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686812417; x=1689404417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OThjLmbvI6Zpg0mK9QSJewa4TGDoveYEJmGg/Gpz19Y=;
        b=DfGYMWDiaWJKsO8HoU0g+mh6vSKmeGvt6GGCTy3NW3DDmFJGjtrDkxsrhiRCugiWnx
         vYykZRuysLufpIZ6Bj2bIrB/gKzyysWlAp1hAlpwrd2r9I0DJ3r0GiImdbUKB5DffpzZ
         IPrEyMaMK5nuc1rtnB1u9Zp5hbCJXYPQ1ZdsPGxwau0YCNGu3EG64VIjJNrReiyjhX83
         8sj1OS/Sm1ppk0nhddiH7Ac6yF/JQd3nzfoSvyRBuFE4aaaQAs6CByrwyzoD2BWkgH7t
         wHNe0BjGZ+HlH25fKkJQwYJPs1EpZo3z95DEbOaR01k/PesjaIvFEU7Cb0Z6k4zIxjrE
         pPPg==
X-Gm-Message-State: AC+VfDweh+3kyqs6r8K0D1oSyBTnPPfCphgDUVEIEOz3Esrf0zm/NYeI
        w5yAPM4SAeKxvFO7ranQ56mhiRjUFT5lp4W1b5IrVV861e08U4SCegxz2aqfZauKAvxLRbWo6Gu
        P5WQqkKhaI77Wv9IQWDKFbWdW
X-Received: by 2002:a05:6830:4865:b0:6b4:39e7:578e with SMTP id dx5-20020a056830486500b006b439e7578emr375178otb.6.1686812417229;
        Thu, 15 Jun 2023 00:00:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7JFZym9YWY4SWWz2Zn7e4z04gbS62xCM/8gAHNSJXHNpERTLzqrjaJyctqTIs9qYe8XmHn1g==
X-Received: by 2002:a05:6830:4865:b0:6b4:39e7:578e with SMTP id dx5-20020a056830486500b006b439e7578emr375165otb.6.1686812416876;
        Thu, 15 Jun 2023 00:00:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:60ac:48e:4eb0:11b4:f1e8])
        by smtp.gmail.com with ESMTPSA id d4-20020a0568301b6400b006b2b51fd2ebsm6472317ote.81.2023.06.15.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:00:16 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v5 0/2] trace,smp: Add tracepoints for csd
Date:   Thu, 15 Jun 2023 03:59:43 -0300
Message-ID: <20230615065944.188876-3-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFCv4:
- Moved from trace/events/smp.h to trace/events/csd.h
- Using TRACE_SYSTEM csd, instead of smp
- generic_exec_single() trace uses NULL instead of csd for current cpu.
- Trace function csd type moved from call_single_data_t to 
  struct __call_single_data to avoid alignment errors on blk code.

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

 include/trace/events/csd.h | 72 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 41 +++++++++++++---------
 2 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 include/trace/events/csd.h

-- 
2.41.0

