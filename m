Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5860482D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiJSNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiJSNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:50:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334510B4A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EB84B82318
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E258C433C1;
        Wed, 19 Oct 2022 13:34:14 +0000 (UTC)
Date:   Wed, 19 Oct 2022 09:34:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: kernel/trace/trace_events_synth.c:436:68: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <20221019093416.1155d790@gandalf.local.home>
In-Reply-To: <202210191111.XTgMRb3E-lkp@intel.com>
References: <202210191111.XTgMRb3E-lkp@intel.com>
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

On Wed, 19 Oct 2022 11:43:54 +0800
kernel test robot <lkp@intel.com> wrote:

> sparse warnings: (new ones prefixed by >>)
> >> kernel/trace/trace_events_synth.c:436:68: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *unsafe_addr @@     got char *str_val @@  
>    kernel/trace/trace_events_synth.c:436:68: sparse:     expected void const [noderef] __user *unsafe_addr
>    kernel/trace/trace_events_synth.c:436:68: sparse:     got char *str_val
> 
> vim +436 kernel/trace/trace_events_synth.c
> 
>    404	
>    405	static unsigned int trace_string(struct synth_trace_event *entry,
>    406					 struct synth_event *event,
>    407					 char *str_val,
>    408					 bool is_dynamic,
>    409					 unsigned int data_size,
>    410					 unsigned int *n_u64)
>    411	{
>    412		unsigned int len = 0;
>    413		char *str_field;
>    414		int ret;
>    415	
>    416		if (is_dynamic) {
>    417			u32 data_offset;
>    418	
>    419			data_offset = offsetof(typeof(*entry), fields);
>    420			data_offset += event->n_u64 * sizeof(u64);
>    421			data_offset += data_size;
>    422	
>    423			len = kern_fetch_store_strlen((unsigned long)str_val);
>    424	
>    425			data_offset |= len << 16;
>    426			*(u32 *)&entry->fields[*n_u64] = data_offset;
>    427	
>    428			ret = kern_fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
>    429	
>    430			(*n_u64)++;
>    431		} else {
>    432			str_field = (char *)&entry->fields[*n_u64];
>    433	
>    434	#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>    435			if ((unsigned long)str_val < TASK_SIZE)
>  > 436				ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);  
>    437			else
>    438	#endif
>    439				ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
>    440	


Does this fix it?

-- Steve

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e310052dc83c..2562d7522999 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -433,7 +433,8 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
-			ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
+			ret = strncpy_from_user_nofault(str_field,
+				(__force const void __user *)str_val, STR_VAR_LEN_MAX);
 		else
 #endif
 			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
