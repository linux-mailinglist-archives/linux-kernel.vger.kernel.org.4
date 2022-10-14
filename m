Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2985FF2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJNRV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A4ED9B7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665768111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYMm/v2iwo92DvehuaGhWXJcbsxgFxkdEexWDGd3BS4=;
        b=O7Jc+7jAhu82xGm+ruzJ0gDUSSEePAeFW8SjMYd+a9h5z/TQHsXf8BF8e4bdJCCUj11UJi
        YQbzSeIqIM0AqlWZmYYJ+0FsM7EgxBafvhpCuGn0rHKk3j4iuBoCxzXZXi2JUQe6j5qoKZ
        PS2bE2EdR5QVKrNQjklSkR3+mjqboC0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-lwi9UjWwMqeJ_vn-Mb46sQ-1; Fri, 14 Oct 2022 13:21:50 -0400
X-MC-Unique: lwi9UjWwMqeJ_vn-Mb46sQ-1
Received: by mail-qt1-f200.google.com with SMTP id 17-20020ac85711000000b0039ccd4c9a37so4006744qtw.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYMm/v2iwo92DvehuaGhWXJcbsxgFxkdEexWDGd3BS4=;
        b=EufHWq6UXQtLmi3aYNbe4XNBLfdT+xoU3WULPdWehI1J4L+jEdyZ2JDlHxfLyRk2WG
         AOr2ViP6iqn6ujDJi92fgEsaxclUUn89llgJdIhuXNovbbma/uqKVyq6TibIU8PTs81z
         138LUfwnsxmFScmPFxuiEQssDp3bmgFH1LSbxo/lHo7XGxu0vfaYik5ID/H9RsPNbfss
         Rp2dH689nxdwldNsX/mMrrLIrL48D72MaGCMhJOQKjZX3v33U6GPfXgajmYzZ1UOMgQK
         2fi0ohdMTMYNwUjcQFqOsIuPeKx62wkESZ49KX+8vG6KRHx1tvy8k1HgICg537Ds+1l6
         cM3g==
X-Gm-Message-State: ACrzQf1I8gJinTJCKKQtWjS7XEsf0Bt29RIrADog5x2bvy3y/D8a4R2s
        4k1EzlU92b74BqW/52CC2vmyjSh34Xnm1PYfyqQXxRYhSBYBUiObnUOivjCMkg1QizmPfD9R3o/
        3Lje6HQWxbClMnACZ7NKwv5Af
X-Received: by 2002:a05:620a:410f:b0:6cf:c34b:3c64 with SMTP id j15-20020a05620a410f00b006cfc34b3c64mr4575814qko.52.1665768109104;
        Fri, 14 Oct 2022 10:21:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6rR2pUuu2NR1kZjkFRRx2GKr1LseLDRLnnGnaO7VXwIEjWI9JmSpSORUH3HAQ96hwhDX5iSw==
X-Received: by 2002:a05:620a:410f:b0:6cf:c34b:3c64 with SMTP id j15-20020a05620a410f00b006cfc34b3c64mr4575802qko.52.1665768108860;
        Fri, 14 Oct 2022 10:21:48 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id m6-20020aed27c6000000b0039cde2cd510sm75997qtg.28.2022.10.14.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:21:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Add __cpumask to denote a trace event field
 that is a cpumask_t
In-Reply-To: <20221014080456.1d32b989@rorschach.local.home>
References: <20221014080456.1d32b989@rorschach.local.home>
Date:   Fri, 14 Oct 2022 18:21:41 +0100
Message-ID: <xhsmh8rlixqvu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Douglas

On 14/10/22 08:04, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> The trace events have a __bitmask field that can be used for anything
> that requires bitmasks. Although currently it is only used for CPU
> masks, it could be used in the future for any type of bitmasks.
>
> There is some user space tooling that wants to know if a field is a CPU
> mask and not just some random unsigned long bitmask. Introduce
> "__cpumask()" helper functions that work the same as the current
> __bitmask() helpers but displays in the format file:
>
>   field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;
>
> Instead of:
>
>   field:__data_loc unsigned long[] mask;  offset:32;      size:4; signed:0;
>
> The main difference is the type. Instead of "unsigned long" it is
> "cpumask_t *". Note, this type field needs to be a real type in the
> __dynamic_array() logic that both __cpumask and__bitmask use, but the
> comparison field requires it to be a scalar type whereas cpumask_t is a
> structure (non-scalar). But everything works when making it a pointer.
>
> Requested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks for spinning this out so quickly! I gave it a test against my IPI
tracepoints, it's working OK with one (expected) change:

  [ipi:ipi_send_cpumask] function __get_cpumask not defined
  CPU 0 is empty
  CPU 1 is empty
  CPU 3 is empty
  cpus=4
            echo-173   [002]    11.859745: ipi_send_cpumask:     [FAILED TO PARSE] cpumask=ARRAY[02, 00, 00, 00, 00, 00, 00, 00] callsite=0xffffffff81121013

so libtraceevent is going to need updating - I'm happy to do that (if you
haven't done it already!)

Lastly, given all cpumasks have a (usable) size of nr_cpumask_bits, we can
factor out the size argument, see below. Regardless:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

---
diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index e1a9b8462b418..b6a9e60755fe0 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -33,7 +33,7 @@
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
 #undef __cpumask
-#define __cpumask(item, nr_bits) __dynamic_array(char, item, -1)
+#define __cpumask(item) __dynamic_array(char, item, -1)
 
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 4f096c30303b9..2c3838f5ee892 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -39,7 +39,7 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
 #undef __cpumask
-#define __cpumask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
 
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index 11cf5550494d2..52ccf0b9b1765 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -47,7 +47,7 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
 #undef __cpumask
-#define __cpumask(item, nr_bits) __dynamic_array(cpumask_t *, item, -1)
+#define __cpumask(item) __dynamic_array(cpumask_t *, item, -1)
 
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index 0d9386b0d320c..b3934b74c72d0 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -83,7 +83,7 @@
 					 __bitmask_size_in_longs(nr_bits))
 
 #undef __cpumask
-#define __cpumask(item, nr_bits) __bitmask(item, nr_bits)
+#define __cpumask(item) __bitmask(item, nr_cpumask_bits)
 
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 76774cb9acc89..e12e541fef42b 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -58,14 +58,14 @@
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
 #undef __cpumask
-#define __cpumask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
 
 #undef __get_cpumask
 #define __get_cpumask(field) (char *)__get_dynamic_array(field)
 
 #undef __assign_cpumask
-#define __assign_cpumask(dst, src, nr_bits)					\
-	memcpy(__get_cpumask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+#define __assign_cpumask(dst, src)					\
+	memcpy(__get_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
 
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)

