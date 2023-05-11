Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6EF6FF5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbjEKPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjEKPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:30:04 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE9FDC;
        Thu, 11 May 2023 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683819000;
        bh=ybI9etnYDeQic3cNfT+50TmyK07V19yIie3KtQzWR4A=;
        h=From:To:Cc:Subject:Date:From;
        b=c9Xgxsa0UI0aFCduuDQWO5g3Suvys5yNjo8BCOvUcuQNxymsfIN3iK8tUZwOrxiGx
         T6eRyt0F424ckJ8v/42zzZ+MWAKJCM+prqoMgbdmbtUpa57nP9fMDxx8/4N4+Pg0AS
         fxEHGF7Wqpa339aX+iEBueklxuCizMsdaOTwbf+e/Z7V/3M0/+9AC21UN/Yl2H4GTR
         y1ETkmZ56PX3g6cAwTsYYP4s8g4WQgoPsjW0bj70YWsyUH8CIgLOHU6iab4uPn4+fw
         tf3J6FEbSu38efZKRg0BCRTu1zRzc9V33t2MMU25arAkKLeR56mn8rDLXUm/+DGQkG
         xw5i0qOjJxwPg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QHG6c2HJXz12TM;
        Thu, 11 May 2023 11:30:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [RFC PATCH] Documentation: Document macro coding style
Date:   Thu, 11 May 2023 11:29:51 -0400
Message-Id: <20230511152951.1970870-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the kernel coding style for macros with parameters.

The purpose of this text is to be used as a reference to gradually
transition towards macros with a more consistent style, and eliminate
subtle bugs that can creep up due to missing parentheses, and generally
remove the need to think and argue about C operator precedence.

This is based on a mailing list discussion with Linus.

Link: https://lore.kernel.org/lkml/CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/process/coding-style.rst | 152 ++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 6db37a46d305..3cf62c91d91c 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -819,10 +819,160 @@ Macros with multiple statements should be enclosed in a do - while block:
 
 	#define macrofun(a, b, c)			\
 		do {					\
-			if (a == 5)			\
+			if ((a) == 5)			\
 				do_this(b, c);		\
 		} while (0)
 
+Always use parentheses around macro arguments, except for the situations listed
+below.
+
+Examples where parentheses are required around macro arguments:
+
+.. code-block:: c
+
+	#define foo(a, b)				\
+		do {					\
+			(a) = (b);			\
+		} while (0)
+
+.. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			(a)++;				\
+		} while (0)
+
+.. code-block:: c
+
+	#define cmp_gt(a, b)			((a) > (b))
+
+.. code-block:: c
+
+	#define foo(a)				do_this(!(a))
+
+.. code-block:: c
+
+	#define foo(a)				do_this(*(a))
+
+.. code-block:: c
+
+	#define foo(a)				do_this(&(a))
+
+.. code-block:: c
+
+	#define get_member(struct_var)		do_this((struct_var).member)
+
+.. code-block:: c
+
+	#define deref_member(struct_ptr)	do_this((struct_ptr)->member)
+
+Situations where parentheses should not be added around arguments, when:
+
+* they are used as a full expression:
+
+  * as an initializer:
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			int __m_var = a;		\
+		} while (0)
+
+  * as an expression statement:
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			a;				\
+		} while (0)
+
+  * as the controlling expression of a selection statement (``if`` or ``switch``):
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			if (a)				\
+				do_this();		\
+		} while (0)
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			switch (a) {			\
+			case 1:	do_this();		\
+				break;			\
+			}				\
+		} while (0)
+
+  * as the controlling expression of a ``while`` or ``do`` statement:
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			while (a)			\
+				do_this();		\
+		} while (0)
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			do_this();			\
+		} while (a)
+
+  * as any of the expressions of a ``for`` statement:
+
+    .. code-block:: c
+
+	#define foo(a, b, c)				\
+		do {					\
+			for (a; b; c)			\
+				do_this();		\
+		} while (0)
+
+  * as the expression in a return statement (note that use of return
+    statements in macros is strongly discouraged because it affects the control
+    flow),
+
+    .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			return a;			\
+		} while (0)
+
+* they are used as expression within an array subscript operator "[]":
+
+  .. code-block:: c
+
+	#define foo(a)					\
+		do {					\
+			if (array[a] == 1)		\
+				do_this();		\
+		} while (0)
+
+* they are used as arguments to functions or other macros:
+
+  .. code-block:: c
+
+	#define foo(a)		do_this(a)
+
+  .. code-block:: c
+
+	#define foo(a, b, c)	do_this(a, b, c)
+
+* there is some syntax reason why adding the parentheses would not work, e.g.
+  the ``member`` argument:
+
+  .. code-block:: c
+
+	#define foo(struct_p, member)	do_this((struct_p)->member)
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.25.1

