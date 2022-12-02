Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ABD63FF89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLBElE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Dec 2022 23:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLBElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:41:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C690C9365;
        Thu,  1 Dec 2022 20:40:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B941B8203C;
        Fri,  2 Dec 2022 04:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07E9C433C1;
        Fri,  2 Dec 2022 04:40:55 +0000 (UTC)
Date:   Thu, 1 Dec 2022 23:40:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <20221201234052.35e5a001@gandalf.local.home>
In-Reply-To: <Y4lCLfQrjyRtLmDM@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-3-ira.weiny@intel.com>
        <20221201123849.0f7802ce@gandalf.local.home>
        <Y4lCLfQrjyRtLmDM@iweiny-desk3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 16:09:17 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Dropping that into cxlmem.h does not compile.  I've given it another go but
> because I use cxl_event_log_type_str() in a file where trace points are used
> CREATE_TRACE_POINTS is defined and I get the following error.
> 
> || drivers/cxl/core/mbox.c: In function ‘cxl_mem_get_records_log’:
> drivers/cxl/cxlmem.h|386 col 7| error: implicit declaration of function ‘__print_symbolic’; did you mean ‘sprint_symbol’?  [-Werror=implicit-function-declaration]                        
> ||   386 |       __print_symbolic(type,                            \
> ||       |       ^~~~~~~~~~~~~~~~
> 
> I got it to work with the patch below on top of this one.[3]  But it is kind of
> ugly.  The only way I could get __print_symbolic() to be defined was to
> redefine it in mbox.c.[1]  Then throw it in it's own header as in [3]

I played around a bit, and with the below patch, you can just have:


#define cxl_event_log_type_str(type)				\
	__print_symbolic(type,					\
		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
		{ CXL_EVENT_TYPE_FATAL, "Fatal" })

And everything else should "just work" :-)

I can work on a more formal patch if this works for you. And thinking about
this, perhaps we could add this throughout the kernel!

-- Steve

diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..ee41057674a2 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -132,4 +132,25 @@
 /* We may be processing more files */
 #define CREATE_TRACE_POINTS
 
+#ifndef __DEFINE_PRINT_SYMBOLIC_STR
+#define __DEFINE_PRINT_SYMBOLIC_STR
+static inline const char *
+__print_symbolic_str(int type, struct trace_print_flags *symbols)
+{
+	for (; symbols->name != NULL; symbols++) {
+		if (type == symbols->mask)
+			return symbols->name;
+	}
+	return "<invalid>";
+}
+#endif
+
+#undef __print_symbolic
+#define __print_symbolic(value, symbol_array...)			\
+	({								\
+		static const struct trace_print_flags symbols[] =	\
+			{ symbol_array, { -1, NULL }};			\
+		__print_symbolic_str(value, symbols);			\
+	})
+
 #endif /* CREATE_TRACE_POINTS */
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8a7ec24c246d..6fe83397f65d 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -6,7 +6,6 @@
 #define __entry REC
 
 #undef __print_flags
-#undef __print_symbolic
 #undef __print_hex
 #undef __print_hex_str
 #undef __get_dynamic_array
