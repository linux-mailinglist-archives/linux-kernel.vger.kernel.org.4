Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B666FEE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjEKJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjEKJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FAB2107
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683795565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sCGS8g+MdKX57yXJGIoLC1S6g4uvx8ZDn5dLzJJFmk=;
        b=T0xWzBNcPGShQGV3lMZAXPKf69PMXZ0DS2LP1iTbrXmtxvHwISAWuUyMhLlzLzQg+NCmQG
        +TK/MNeQRdBgyr7s0PQ7QW42ud9oauYgiZKcBpoBT05I1cSgvmGAYW99yX2pCpCmWI74+J
        B3mSmRRE0KPKbGaCN/GQiX072vHxWD0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vO9_5naOOMGLpH8XFPyEEw-1; Thu, 11 May 2023 04:59:24 -0400
X-MC-Unique: vO9_5naOOMGLpH8XFPyEEw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ab22da39d6so1992960a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795564; x=1686387564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sCGS8g+MdKX57yXJGIoLC1S6g4uvx8ZDn5dLzJJFmk=;
        b=PKfIeZ6F4p3SjYYwFuluG38tpH7S6K/9voeoSLTq0bp390TGqQUXsU2iRLjd+QRqmR
         rJy4qepM4xK/v0QZvqGghgTlardkF2NB7ooFT4jc+w6gOuAAxjBNL67buN6bryrfuAKh
         VVNeG2ZFzH5BCz3soD1R2HuU8Abu+kkCvs+VzYCpwVcnT8EAmhH9Qt/I5m+WzG/Lj4SP
         SHHcMlFNAz5+hUVV+kplaqeYf1HO2F7+P+tjrPNujUGK/mqtGk/iwOOXnJ3f7lalLXAb
         zrrL73SURFdJplxobvoOZpNZU3IzdnJMP9lV0x91UcJgyQkgoYeoPqlVLME9/8quxNCo
         rsZg==
X-Gm-Message-State: AC+VfDze29Q/bgWuMpPs4DxiPM1PzrbQXIR9mtDIsucf5Lj9548qovm/
        EWDEezBDYJRcDgDTOIv+jnvj2ekov2hRoNuou3clHaqvTFGwd06ePzIvHklNkRE/YdzOeaTxU5b
        z+np1toMFn5nFlxB8p2MqcwJJ
X-Received: by 2002:a9d:6253:0:b0:6ab:2a4e:164d with SMTP id i19-20020a9d6253000000b006ab2a4e164dmr2972815otk.4.1683795564076;
        Thu, 11 May 2023 01:59:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5K7n/kGTL09SDaGzXNLPi5EchgQfhVFLgmK4OjwoScZX8Az3coqnQpGqPw2Qy2DCKRtGbUnA==
X-Received: by 2002:a9d:6253:0:b0:6ab:2a4e:164d with SMTP id i19-20020a9d6253000000b006ab2a4e164dmr2972805otk.4.1683795563887;
        Thu, 11 May 2023 01:59:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:3602:abec:117:3c19:43b8])
        by smtp.gmail.com with ESMTPSA id d1-20020a056830004100b006a42e87aee4sm1039300otp.32.2023.05.11.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:59:23 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] smp: Change signatures to use call_single_data_t
Date:   Thu, 11 May 2023 05:58:38 -0300
Message-Id: <20230511085836.579679-2-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511085836.579679-1-leobras@redhat.com>
References: <20230511085836.579679-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of smp_call_function_single_async() now makes use
of call_single_data_t, which is a size-aligned typedef of
struct __call_single_data.

Changing smp_call_function_single_async() csd parameter to
call_single_data_t makes possible to warn future callers if they
are using an unaligned csd, which can cause it to be split between 2
cachelines, which is usually bad for performance.

Also, for the same reason, change generic_exec_single().

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..919387be6d4e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -361,7 +361,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -645,7 +645,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * Return: %0 on success or negative errno value on error
  */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	int err = 0;
 
-- 
2.40.1

