Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1132367B12C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjAYL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjAYL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:28:14 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C44244B5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:28:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so21438362eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ2qvsZFtZbznyL4NAzkdHqHDIounrfneCwEpUTaLts=;
        b=C8kh0L8haDEnHJCrwJBb7vis7NDU/CmV11fhutGJFP3bjRLtb06Nr57D8JMlaPGmap
         loWbih3wMbonQBWs6aERv3oO+wtIr920HFIugmrLL8ZyCB+EiP9yoW617twgZO+G+OlE
         /Jan1o/xUtShX94FCR+dXdYDHisfkpq92mNwVOPuRaQlGQz7LcpM7XnjrjD+djp1l25r
         2Kl1JRRCUHNHFB/Fzv8n+ONzmqxsxH/0Af4IMsPfnQT53Wxeai9CUsUuVW5e8UhL9ONp
         V9eoAYSS537Fj8LJRKz0dclo/TL1iw7XQ2NLDSuYUkl6CzswOk35vfRWxTHsfI5Sp+2c
         PJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ2qvsZFtZbznyL4NAzkdHqHDIounrfneCwEpUTaLts=;
        b=1BHA7wrTmQTa2DHVxJGzM9uuFKofUBx6muXuIC9Fv5G7C59+RfYEAJfEvFTT2XAWHA
         kOhywwCRk9btwkTyOfHlZDzc/Y6Q3Yuzao2DiQDCP/bT7jFv/ODH0bklwGU2MMFK4gQD
         sS6iR9FVUUq07Wg79mxVgpTUwKViK+sKd8j4VXbd19zPcimei3fe6j9grJojMJIMLTTl
         rVbi5AIo0/mPK8X8EsPzNZ81xD/yuBjQGfUifg5dFdzmxpMSRu1IRrJpMa7j0C/Sl10V
         2U2Rsru3Xs4scdXe25tRZNGN9mMPgSKkJUe/2cMWqK4e6UqxMw4rYCQ3B4rR2vMfSBFp
         wl2Q==
X-Gm-Message-State: AFqh2kqBkG/dcw6VlvJhNC2bR/LbOw9tdMthrBK0qv9bXCaRYQnMDT52
        gzT9+9PrSnAFPAFaT65niQSm+20+zDY=
X-Google-Smtp-Source: AMrXdXsM2anlbRQknWcNitNcgwy8aU8Hrzk3+g39WrL34xbsB0oyZtnrNeuDAvscxNAzncy4x4/V9A==
X-Received: by 2002:a05:6402:2405:b0:49d:1a59:176b with SMTP id t5-20020a056402240500b0049d1a59176bmr37928651eda.30.1674646091446;
        Wed, 25 Jan 2023 03:28:11 -0800 (PST)
Received: from gmail.com (1F2EF55F.nat.pool.telekom.hu. [31.46.245.95])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c582000000b0047a3a407b49sm2243667edq.43.2023.01.25.03.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:28:10 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 25 Jan 2023 12:28:07 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/platform/uv: UV support for sub-NUMA clustering
Message-ID: <Y9ESRzbzM0e8Kr1M@gmail.com>
References: <20230123221812.3970769-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123221812.3970769-1-steve.wahl@hpe.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steve Wahl <steve.wahl@hpe.com> wrote:

> +static int __init alloc_conv_table(int num_elem, unsigned short **table)
> +{
> +	int i;
> +	size_t bytes;
> +
> +	bytes = num_elem * sizeof(*table[0]);
> +	*table = kmalloc(bytes, GFP_KERNEL);
> +	WARN_ON_ONCE(!*table);
> +	if (!*table)
> +		return -ENOMEM;

WARN_ON_ONCE() is pass-through on the condition, so you can write this in a 
shorter form:

	if (!WARN_ON_ONCE(!*table))
		return -ENOMEM;

> +	uv_hub_info_list_blade = kzalloc(bytes, GFP_KERNEL);
> +	WARN_ON_ONCE(!uv_hub_info_list_blade);
> +	if (!uv_hub_info_list_blade)
> +		return;

Ditto.

> +		WARN_ON_ONCE(!new_hub);
> +		if (!new_hub)
> +			return;

Same. Also a memory leak of at least uv_hub_info_list_blade?

> +	WARN_ON_ONCE(!__uv_hub_info_list);
> +	if (!__uv_hub_info_list)
> +		return;

Same.

> +
> +	for_each_node(nodeid) {
> +		__uv_hub_info_list[nodeid] = uv_hub_info_list_blade[uv_node_to_blade_id(nodeid)];
> +	}

Unnecessary curly braces.

Looks good otherwise - presumably it's both tested and backwards compatible 
with older UV hardware?

Thanks,

	Ingo
