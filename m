Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5135D6ACA1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCFR0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCFR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:26:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B5664ED;
        Mon,  6 Mar 2023 09:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAE4FB80FED;
        Mon,  6 Mar 2023 17:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03D8C433D2;
        Mon,  6 Mar 2023 17:25:30 +0000 (UTC)
Date:   Mon, 6 Mar 2023 12:25:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
Message-ID: <20230306122529.44e8d566@gandalf.local.home>
In-Reply-To: <20230306111513.2aa49b1a@gandalf.local.home>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
        <20230306111513.2aa49b1a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 11:15:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index 31d994e6b4ca..8d053838d6cf 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
> >  	TP_STRUCT__entry(
> >  		__field(dev_t,	dev)
> >  		__field(ino_t,	ino)
> > -		__field(nid_t,	nid[3])  
> 
> That should not have even compiled. I'll see if I can add some tricks to
> make that fail.

And this patch makes that happen!

-- Steve

diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index ac5c24d3beeb..e30a13be46ba 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -9,17 +9,30 @@
 #undef __entry
 #define __entry entry
 
+/*
+ * Fields should never declare an array: i.e. __field(int, arr[5])
+ * If they do, it will cause issues in parsing and possibly corrupt the
+ * events. To prevent that from happening, test the sizeof() a fictitious
+ * type called "struct _test_no_array_##item" which will fail if "item"
+ * contains array elements (like "arr[5]").
+ *
+ * If you hit this, use __array(int, arr, 5) instead.
+ */
 #undef __field
-#define __field(type, item)
+#define __field(type, item)					\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_ext
-#define __field_ext(type, item, filter_type)
+#define __field_ext(type, item, filter_type)			\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_struct
-#define __field_struct(type, item)
+#define __field_struct(type, item)				\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)
+#define __field_struct_ext(type, item, filter_type)		\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __array
 #define __array(type, item, len)
