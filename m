Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E967C0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjAYXgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAYXg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:36:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F35EF8B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4d5097a95f5so1714437b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6gsGOWqmWqPTUheNVBr3Q9nvHWl0lLSYR4b+5IyM2U=;
        b=A/+QvJNXy/d2vUI7IPHDHgHrWDO5jed44nN4fWVgpwvqVaJ31sqqH7bmSeeRmlNRUe
         R8yZL4gzTLe9/1VGW0HvHObu5bU15WhlNXVFuvCtXS1G895lG29e5Fcqxn2GSCvSAWbL
         a8+HubzPqRrnoptHqtaiUWYzGkX+Bc9oxqltwaro1OAtno0UicpOEKYTqlPtF+8tMqyj
         yl/bjmJVeg0LR1s+57cLzBKsRlrrNOMebK53a2LFqIWNe7pEp/2Pdvl38JYqyOXxSvMk
         fAnMfk21t3L3pUqNrcRKGWlBkL42c9QvZGZGpHK8jyyUU6ou7Oa+/eZkY6FyQAx511UH
         LrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6gsGOWqmWqPTUheNVBr3Q9nvHWl0lLSYR4b+5IyM2U=;
        b=o19gGwdfCKzoqf2Q7UZHSMJThxpjXgRF7jQ0bhwSUfhzHsYPAhbpzCQPwuI7JdqFv5
         FLmgeXUGkpxDfCURHzwQLd/E6AT0Ft/Vvsppbl+vRuvA9R+P5a02pG1MF5UUL68iEo0i
         KlK/WYhmSB2L5JnFS74/9F2L53R+Q3e3BJlAzqTktBCSMzq0Yq5b3p8AlpyJPrXjs2gG
         p8vCwenYKGufmcpPADK46PlkM511W0wPoUaHMABFdDKLDFutgNmOKlHYoN1P3fti0OEX
         un9bg7LIkRDKCXU/ZiDXPN20NOJvTM805poE/TXv9adp3qu3uqA9rdtHx56XJqNSd/9A
         87+w==
X-Gm-Message-State: AFqh2kpuu+RKO5pHXnP6Ew6HWWyULTBZB/zm7+MLSAGb1e5RnYsTtad8
        fRNtI/9FHSerdqpaY+OvQ0YIzQJ7iwg=
X-Google-Smtp-Source: AMrXdXu2jHtIhTXjXhL9uqm1GdxSUteqsFjlccKLo1OvqKsStZdC9fM8D9TZdXuT4x0gDFJ1URuxrGbnlWU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a05:6902:1148:b0:803:6201:640a with SMTP id
 p8-20020a056902114800b008036201640amr1801877ybu.141.1674689773846; Wed, 25
 Jan 2023 15:36:13 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:35:54 -0800
In-Reply-To: <20230125233554.153109-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125233554.153109-8-surenb@google.com>
Subject: [PATCH v3 7/7] mm: export dump_mm()
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_assert_write_locked() is used in vm_flags modifiers. Because
mmap_assert_write_locked() uses dump_mm() and vm_flags are sometimes
modified from inside a module, it's necessary to export dump_mm()
function.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug.c b/mm/debug.c
index 9d3d893dc7f4..96d594e16292 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -215,6 +215,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
-- 
2.39.1

