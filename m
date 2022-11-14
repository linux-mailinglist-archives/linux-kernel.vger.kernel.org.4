Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AC628702
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiKNRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiKNRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:25:24 -0500
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7E1B79F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:25:23 -0800 (PST)
Received: by mail-oo1-xc49.google.com with SMTP id x6-20020a4a2a46000000b0049ca27b1507so4057539oox.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMSoXnkMTNYPAcTxJbcWFU+9FOt6c27vKUx+SzYvFGg=;
        b=iRaY2GvzNUxrHIZ4j8Y/wvNGPVTIUCenaJgyQnp0UT3EQ5qjojKuuwvWrIyLToCPVh
         t1y/cpuR/ZQpXhXFCtw5IjpZhEvSPnmwmN4yrIZxWPjmSS0Ua5c3hcmz+C6nxZMDm4yq
         J7bvA5lCVdiQyDavRkT7US9d9/BOCWNnC/8eB8hXV39wcQ3T8FryY7gsZbwJ0dYq6wyS
         8bpYSiwGNZh+Hf4PlykwPz32JB/myNiCfuj3FtoFG/75Y4lS+c+siU5O2Kk6HNUNyxFb
         rgpQKSZji0xGtlI59N/eQVNU5gbcjmbcyrVcZaYnSecuqoVjc7zueM5MmtM2fIndKsC3
         vdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMSoXnkMTNYPAcTxJbcWFU+9FOt6c27vKUx+SzYvFGg=;
        b=Z4jwPsPGcXCr2xHcqEj7WG7u3GSm44TMZ/jz5ehTkVCuVfpvwlsR6aknEoJIEzBs8A
         JmDVgT9X+Zd4wUNg4EsYrJHKl2nBH/5HcrbapM3S0QNC++rVsLlv7SqSEIZsJQp6KTOb
         sV9yN1oM/iDb2ZmMy1BJEWMlYUbhyKDxy63N5zf6s4HNCJOFtmVUpBTdQmT6eYlHmriz
         rjTxzHeqFXMD/emzU680LJ2/LuVZVGSNaXG2fZagpa9WhEyz/cX35tIZGf4r+H999OT7
         Tk9u9YXf/ueZLIj4ibkIbL+iNQ7IyEBT1FmGCGvfbs/gdOAqz+u0KaEJiFfYogRDzXCE
         6fEA==
X-Gm-Message-State: ANoB5pkdUi3UfdVPkhTc6zsIyDr5Sx5BptaFf/4eDmLIYZU8K9qVAI5f
        uXvonEDtesdjTmma6Zpn0flmhAg=
X-Google-Smtp-Source: AA0mqf6vd/+7WnucheABsBp22lIcDhlkqFk+r3DZdShB3wq/dxeZiCuhAvb5Olvtn51LnaLwcH3q32Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6808:17a1:b0:355:51ec:36c9 with SMTP id
 bg33-20020a05680817a100b0035551ec36c9mr6468076oib.245.1668446723015; Mon, 14
 Nov 2022 09:25:23 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:25:21 -0800
In-Reply-To: <1668396484-4596-2-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
References: <1668396484-4596-1-git-send-email-yangtiezhu@loongson.cn> <1668396484-4596-2-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <Y3J6AXOFcoGg7p8/@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Use strcmp() instead of is_prefix()
 to check parameters
From:   sdf@google.com
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14, Tiezhu Yang wrote:
> In the current code, the parameters check of bpftool seems not correct,
> for example, "bpftool batch file FILE" is the expected command format,
> but "bpftool b f FILE" is recognized as valid, so use strcmp() instead
> of is_prefix() to check parameters.

That's by design and is similar to what iproute2 commands are doing.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/bpf/bpftool/main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 741e50e..4ef87c2 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -200,7 +200,7 @@ int cmd_select(const struct cmd *cmds, int argc, char  
> **argv,
>   		return cmds[0].func(argc, argv);

>   	for (i = 0; cmds[i].cmd; i++) {
> -		if (is_prefix(*argv, cmds[i].cmd)) {
> +		if (!strcmp(*argv, cmds[i].cmd)) {
>   			if (!cmds[i].func) {
>   				p_err("command '%s' is not supported in bootstrap mode",
>   				      cmds[i].cmd);
> @@ -337,7 +337,7 @@ static int do_batch(int argc, char **argv)
>   	if (argc < 2) {
>   		p_err("too few parameters for batch");
>   		return -1;
> -	} else if (!is_prefix(*argv, "file")) {
> +	} else if (strcmp(*argv, "file")) {
>   		p_err("expected 'file', got: %s", *argv);
>   		return -1;
>   	} else if (argc > 2) {
> --
> 2.1.0

