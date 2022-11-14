Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F2628DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiKOAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKOAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:00:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7D8117B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:00:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b17-20020a25b851000000b006e32b877068so2151303ybm.16
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTXyaPlrsDzres2FCTdJTcvC4C+KFBXkzFkp9RWefPg=;
        b=LHh23LxIF21u9K8O8n+AjbzCMLLDfL8wdy+9uiVd0b/Y0eU/604r++Zdj1SsvRTql3
         SqYo8r5fkCTP4wGECqEI3uzT2FrOtJMmawiQk8sQX0GQYINlWMc5dr0TshqJbkaZ7vdf
         aoENPupUueCm1qxNxObaJz1UlWl2gbtZyAWcUdXL5AR2Qd+uqRXdkFCo5g1/rDCJayVO
         DRHTqVhCcR4plTX00IHWoWr+/Qijy0oa2oszZlFV113eSxHlvpD1gbfdNxzxVUpKThi9
         LJEsZ5MIVy46S24Iuys4g/fog7te3A86yMYSRDWRIb89pzn9qQl59S2I07KLld8Il1v1
         GtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTXyaPlrsDzres2FCTdJTcvC4C+KFBXkzFkp9RWefPg=;
        b=Hbql1imRs884gSW9bTL47eilKqyePCjbD79qlYp/2ZwPKNUBj7Sq5alwYPpzTAPd/b
         6ly39A5Xa+dF+W8plwSdlOV5yrOQ6shbvL2KAuOHx9l5XHR/51ngZdW8x+dWT1INUaIp
         fjth4JIQ+fC2OC9FVBDMQYJX0jdCLp1qnZcy3fvFfbXuiw/WyVSQip1/XOBGr2o2jOeM
         yg5kw9w9S+d6r2Vng1VUfYd7iQyBm9KHYpjF9UfKbGYXA2sI9JXXWI101O2J4qHH7G+E
         I1raac3Kp/PTH8FkSWVzLN8S4yV7CTvQzCV8z87hLXocj7puVQul/eVfh2Lc8ACFSFdj
         h26w==
X-Gm-Message-State: ANoB5pmhQQIWmupDI8jyHzf5Js85O2TjjPvWodTfsZSdOBg05U8qSqoK
        KpHEE5aMjc+fht1/AsV+TSp2rjfPghYVock=
X-Google-Smtp-Source: AA0mqf5sElOlRFzCQvmLJ74LLB1MHk/+ss7NBmO/yEQL4KaYGpWEyGEwwkCnbt8Cx4VdjuTTb1ybE1iQ55aOxY0=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:b18b:0:b0:6de:113d:fd91 with SMTP id
 h11-20020a25b18b000000b006de113dfd91mr1321947ybj.272.1668470402277; Mon, 14
 Nov 2022 16:00:02 -0800 (PST)
Date:   Mon, 14 Nov 2022 23:59:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221114235949.201749-1-tjmercier@google.com>
Subject: [PATCH] mm: shrinkers: Add missing includes for undeclared types
From:   "T.J. Mercier" <tjmercier@google.com>
To:     android-mm@google.com,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "T.J. Mercier" <tjmercier@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shrinker.h header depends on a user including other headers before
it for types used by shrinker.h. Fix this by including the appropriate
headers in shrinker.h.

./include/linux/shrinker.h:13:9: error: unknown type name =E2=80=98gfp_t=E2=
=80=99
   13 |         gfp_t gfp_mask;
      |         ^~~~~
./include/linux/shrinker.h:71:26: error: field =E2=80=98list=E2=80=99 has i=
ncomplete type
   71 |         struct list_head list;
      |                          ^~~~
./include/linux/shrinker.h:82:9: error: unknown type name =E2=80=98atomic_l=
ong_t=E2=80=99
   82 |         atomic_long_t *nr_deferred;
      |

Fixes: 83aeeada7c69 ("vmscan: use atomic-long for shrinker batching")
Fixes: b0d40c92adaf ("superblock: introduce per-sb cache shrinker infrastru=
cture")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 include/linux/shrinker.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 08e6054e061f..71310efe2fab 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_SHRINKER_H
 #define _LINUX_SHRINKER_H
=20
+#include <linux/atomic.h>
+#include <linux/types.h>
+
 /*
  * This struct is used to pass information from page reclaim to the shrink=
ers.
  * We consolidate the values for easier extension later.
--=20
2.38.1.493.g58b659f92b-goog

