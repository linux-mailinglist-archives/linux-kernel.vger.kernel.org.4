Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFF666095
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjAKQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjAKQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:33:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48EB86;
        Wed, 11 Jan 2023 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XMF+LeDwuEJP2w3SL8oJxpqNjxtnGRPrPmivq/NK3Dc=; b=PmGF9AZcNMhaUvYUCXcIunoZim
        vruEM0eiCV6da15xCq/c6wWoSFSmxch6EuKsJ1gzAsIUYf6Yjy+E15JRom9APGCc+k2OueRPxBqkB
        eMBOq4s2YYyoj+iO/Tz15/s//H6Vp5iq2piuMNBo2yILWfhL/ks8sM8fLkTpkBVsyMxOdOJGKm9mq
        dc2umH3RamjYa+WHxtSnRE9KE2MKON2zaqqiu9aHuz59cHtd535M1daZeOFB4aVR2e4XuOZsr/rKX
        6pFAZA90ayXHThWW7qW0Q+OkbAC/gQ4Ek4XncQA3Uosk9P5ufDyF5MROnSWtuOLmOP5re2HhoFwN3
        6iR0id7g==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFe2g-00CBTi-C3; Wed, 11 Jan 2023 16:33:34 +0000
Message-ID: <50a3b4ab-781a-e37f-49ad-cb4bbfcb4eac@infradead.org>
Date:   Wed, 11 Jan 2023 08:33:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] tracing: Add creation of instances at boot command
 line
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
References: <20230111145636.450953217@goodmis.org>
 <20230111145842.376427803@goodmis.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230111145842.376427803@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 06:56, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add kernel command line to add tracing instances. This only creates
> instances at boot but still does not enable any events to them. Later
> changes will extend this command line to add enabling of events, filters,
> and triggers. As well as possibly redirecting trace_printk()!
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  kernel/trace/trace.c                          | 51 +++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..cec486217ccc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6272,6 +6272,12 @@
>  			comma-separated list of trace events to enable. See
>  			also Documentation/trace/events.rst
>  
> +	trace_instance=[instance-info]
> +			[FTRACE] Create an ring buffer instance early in boot up.

s/an/a/

> +			This will be listed in:
> +
> +				/sys/kernel/tracing/instances
> +
>  	trace_options=[option-list]
>  			[FTRACE] Enable or disable tracer options at boot.
>  			The option-list is a comma delimited list of options


-- 
~Randy
