Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D454860328D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJRScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJRSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:32:49 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B1B691BB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:32:48 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mp3-20020a17090b190300b0020af8232049so6354639pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pScL4HsKSlGXXrCDAO9SW0fhqoUdP+2XbMXTHRrK8TE=;
        b=LM9JAFVF44F8UppjyXfB0lky34OVy+clbEjC7DJB3r88sBTbKEv97oKIiA1IsKFfVD
         7pe8/v+RGDpnZFWPDoXWtwS3KtF23/iaHNQ/5HEsFosSxPyq6YvVQuXzgif/HsNm9ON2
         ZNk3piPjd2+l9SG85FgVBGdeHr2hwQ7jvL+gkQa6gvLijEpR5GVnvgT+YZZicCYIgszn
         jw3nnC1WmO29rKPnbZw25ol4zIMBSx4+FTaq4Qr5acMh/uw/VHz1r6LmlRR2lbU/GN11
         kX1j+q2x8hkv1/s+Ab1xof00JKN7CSL2nZOF3jZWPwIit1umjBaumNsWm+prQeORLHRW
         clGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pScL4HsKSlGXXrCDAO9SW0fhqoUdP+2XbMXTHRrK8TE=;
        b=VSO1vHvPfUEAmBaBO2UHC6e/5NI0v8OYjpU1eXg8WtV2RCV4hx+mIaSUshlgahPc5g
         uAzuQDDAmcKcZqVniJuajEnGygM2GJLUXeZz8orGQv9x17Uyh9EuooNEvOXMpauiuPSn
         +NSm2cfVb4TtmadQO+k4KK70AAd8sgOjJ02YhMsLGZSUvWfz0UeNqeOkZRHdzhek1TLv
         W69A5bV4h2bhYMPOVwXjpj7RZDvTKrPsZATG+SlHvotZGRAdTmLutRI5B33u1wW7ANa0
         P2WZWPbi5l4NQRLRduGkvnD5jggyhPSFM9lwbmuiNuSAEIqShP35eeqhSMRVJo1a3wrl
         kVZQ==
X-Gm-Message-State: ACrzQf0y2z5UdN0W6P9ethkK8iA+OUnPbdvZFD5G0cVLNnJ4fw4oVPSW
        80Ys2CVWIo5VpwOJRCSHOTn5DIY=
X-Google-Smtp-Source: AMsMyM712u96NyjOP2AVqntvtVSu2Ssn5/WDnERwMtc9crslzRd9xK7v8pJj47g0ZeOlSkNSpmiViBg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:b794:b0:20a:eab5:cf39 with SMTP id
 m20-20020a17090ab79400b0020aeab5cf39mr1832310pjr.1.1666117967753; Tue, 18 Oct
 2022 11:32:47 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:32:46 -0700
In-Reply-To: <20221018145538.2046842-1-xukuohai@huaweicloud.com>
Mime-Version: 1.0
References: <20221018145538.2046842-1-xukuohai@huaweicloud.com>
Message-ID: <Y07xTsStxyzZzxQZ@google.com>
Subject: Re: [PATCH] libbpf: Avoid allocating reg_name with sscanf in parse_usdt_arg()
From:   sdf@google.com
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>

> The reg_name in parse_usdt_arg() is used to hold register name, which
> is short enough to be held in a 16-byte array, so we could define
> reg_name as char reg_name[16] to avoid dynamically allocating reg_name
> with sscanf.

> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Addresses Andrii's suggestion from the following:

https://lore.kernel.org/bpf/86c88c01-22eb-b7f8-9c65-0faf97b4096b@huawei.com/

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/lib/bpf/usdt.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 49f3c3b7f609..28fa1b2283de 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1225,26 +1225,24 @@ static int calc_pt_regs_off(const char *reg_name)

>   static int parse_usdt_arg(const char *arg_str, int arg_num, struct  
> usdt_arg_spec *arg)
>   {
> -	char *reg_name = NULL;
> +	char reg_name[16];
>   	int arg_sz, len, reg_off;
>   	long off;

> -	if (sscanf(arg_str, " %d @ %ld ( %%%m[^)] ) %n", &arg_sz, &off,  
> &reg_name, &len) == 3) {
> +	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", &arg_sz, &off,  
> reg_name, &len) == 3) {
>   		/* Memory dereference case, e.g., -4@-20(%rbp) */
>   		arg->arg_type = USDT_ARG_REG_DEREF;
>   		arg->val_off = off;
>   		reg_off = calc_pt_regs_off(reg_name);
> -		free(reg_name);
>   		if (reg_off < 0)
>   			return reg_off;
>   		arg->reg_off = reg_off;
> -	} else if (sscanf(arg_str, " %d @ %%%ms %n", &arg_sz, &reg_name, &len)  
> == 2) {
> +	} else if (sscanf(arg_str, " %d @ %%%15s %n", &arg_sz, reg_name, &len)  
> == 2) {
>   		/* Register read case, e.g., -4@%eax */
>   		arg->arg_type = USDT_ARG_REG;
>   		arg->val_off = 0;

>   		reg_off = calc_pt_regs_off(reg_name);
> -		free(reg_name);
>   		if (reg_off < 0)
>   			return reg_off;
>   		arg->reg_off = reg_off;
> @@ -1456,16 +1454,15 @@ static int calc_pt_regs_off(const char *reg_name)

>   static int parse_usdt_arg(const char *arg_str, int arg_num, struct  
> usdt_arg_spec *arg)
>   {
> -	char *reg_name = NULL;
> +	char reg_name[16];
>   	int arg_sz, len, reg_off;
>   	long off;

> -	if (sscanf(arg_str, " %d @ %ld ( %m[a-z0-9] ) %n", &arg_sz, &off,  
> &reg_name, &len) == 3) {
> +	if (sscanf(arg_str, " %d @ %ld ( %15[a-z0-9] ) %n", &arg_sz, &off,  
> reg_name, &len) == 3) {
>   		/* Memory dereference case, e.g., -8@-88(s0) */
>   		arg->arg_type = USDT_ARG_REG_DEREF;
>   		arg->val_off = off;
>   		reg_off = calc_pt_regs_off(reg_name);
> -		free(reg_name);
>   		if (reg_off < 0)
>   			return reg_off;
>   		arg->reg_off = reg_off;
> @@ -1474,12 +1471,11 @@ static int parse_usdt_arg(const char *arg_str,  
> int arg_num, struct usdt_arg_spec
>   		arg->arg_type = USDT_ARG_CONST;
>   		arg->val_off = off;
>   		arg->reg_off = 0;
> -	} else if (sscanf(arg_str, " %d @ %m[a-z0-9] %n", &arg_sz, &reg_name,  
> &len) == 2) {
> +	} else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_name,  
> &len) == 2) {
>   		/* Register read case, e.g., -8@a1 */
>   		arg->arg_type = USDT_ARG_REG;
>   		arg->val_off = 0;
>   		reg_off = calc_pt_regs_off(reg_name);
> -		free(reg_name);
>   		if (reg_off < 0)
>   			return reg_off;
>   		arg->reg_off = reg_off;
> --
> 2.30.2

