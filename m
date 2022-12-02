Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B991263FFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiLBFBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiLBFBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:01:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D097CAFBE;
        Thu,  1 Dec 2022 21:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9870B820F0;
        Fri,  2 Dec 2022 05:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC16C433D7;
        Fri,  2 Dec 2022 05:01:02 +0000 (UTC)
Date:   Fri, 2 Dec 2022 00:00:59 -0500
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
Message-ID: <20221202000059.50d4961e@gandalf.local.home>
In-Reply-To: <20221201234052.35e5a001@gandalf.local.home>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-3-ira.weiny@intel.com>
        <20221201123849.0f7802ce@gandalf.local.home>
        <Y4lCLfQrjyRtLmDM@iweiny-desk3>
        <20221201234052.35e5a001@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 23:40:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +#undef __print_symbolic
> +#define __print_symbolic(value, symbol_array...)			\
> +	({								\
> +		static const struct trace_print_flags symbols[] =	\
> +			{ symbol_array, { -1, NULL }};			\
> +		__print_symbolic_str(value, symbols);			\
> +	})
> +
>  #endif /* CREATE_TRACE_POINTS */

Bah, I want this outside that #ifdef

> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> index 8a7ec24c246d..6fe83397f65d 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -6,7 +6,6 @@

I also don't think I need to touch stage7.

New patch:

diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..9d665f634614 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -133,3 +133,24 @@
 #define CREATE_TRACE_POINTS
 
 #endif /* CREATE_TRACE_POINTS */
+
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
