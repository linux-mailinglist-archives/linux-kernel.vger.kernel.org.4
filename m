Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3186571487F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjE2L0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE2L0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C6CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685359527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiP7BFxT10yGcr7FtZErZq6l5Z39ttes77bUh96OvFU=;
        b=DEEdHbnHYfpehB9CbTzuMQbo+a74WTpqUgRhuIR7siehFmX4ER/2+cztzVZBho7/imPdmS
        HyMrT4K0IDeQ0wJQAh5833rwhpc5ORPnTrErkcNsHloOvGmoxd4/fsGmJqPgeeXn3CIUB9
        /X84l/+XtCcr+/shwrFD08SqptpfQEs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-b7hvtt7PPg-DJivVGAdfSg-1; Mon, 29 May 2023 07:25:25 -0400
X-MC-Unique: b7hvtt7PPg-DJivVGAdfSg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-513e916ed47so2627231a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685359524; x=1687951524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiP7BFxT10yGcr7FtZErZq6l5Z39ttes77bUh96OvFU=;
        b=k3DbF3BRipWWx9Tt5K0CtO1svRuq29aGWIv8k1rqJnX4Kleu5mQm08s/8IUh7lnF6E
         N7lmCxSFvLOF4OvtYBm2JQhyft1OqT/nsvSPzl7gluBTpDf98bfww6d/0XY6kz5GnEDY
         dOn7Scv86P4AVGIUzVo8MYBGJwJ4aikiyxYJaoB5jgWHk4amp5VH0qJxOCA65ToYmtkR
         atIuv1BBb4d0fteI0gwyLQnVKdF3BZHIrI8WX9owiCyNJs63ZVFu67MW/TUOW+ECteVT
         /C4bpKFgjFD+vMIht3WLv/L9VJ4uOLy/3Vb6y0P17RkytC+KzCHGtM9CRvcVOXR9wfOg
         liLA==
X-Gm-Message-State: AC+VfDwhJ35AJJ7oDuVyQegiIFNucXO2pHYliN1JuHrMUUieCjRYYu8P
        tfQatkKFvQmgKpQMOPV9gnQaCKschRHiGR3jwrW21pctv3GufZ7+qCtDpMxSIDGfxHnCLea72xn
        sbeXXyOvDEs80hUoizTb75YEq
X-Received: by 2002:aa7:d3cb:0:b0:510:e80f:fa4e with SMTP id o11-20020aa7d3cb000000b00510e80ffa4emr7110189edr.1.1685359524528;
        Mon, 29 May 2023 04:25:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lK/aT5tTJA1o7fgmWGbF8O1nXzHMpx1okbozAGeSsnjjVzV4LPS1NMpynZaWFt7VVuEoigQ==
X-Received: by 2002:aa7:d3cb:0:b0:510:e80f:fa4e with SMTP id o11-20020aa7d3cb000000b00510e80ffa4emr7110168edr.1.1685359524190;
        Mon, 29 May 2023 04:25:24 -0700 (PDT)
Received: from [192.168.0.46] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b0050690bc07a3sm3050803edv.18.2023.05.29.04.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:25:23 -0700 (PDT)
Message-ID: <13f35387-6a8d-5c97-06bb-c09e74a37657@redhat.com>
Date:   Mon, 29 May 2023 13:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tracing/rv/rtla: Update MAINTAINERS file to point to
 proper mailing list
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230529044002.0481452b@rorschach.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230529044002.0481452b@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 10:40, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The mailing list that goes to linux-trace-devel is for the tracing
> libraries, and the patchwork associated to the tracing libraries keys
> off of that mailing list.
> 
> For anything that lives in the Linux kernel proper (including the tools
> directory) must go through linux-trace-kernel, as the patchwork to that
> list keys off of the Linux kernel proper.
> 
> Update the MAINTAINERS file to reflect the proper mailing lists.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..5bb6dccd6ea3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17808,7 +17808,7 @@ F:	tools/testing/selftests/rtc/
>  Real-time Linux Analysis (RTLA) tools
>  M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -L:	linux-trace-devel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/tools/rtla/
>  F:	tools/tracing/rtla/
> @@ -18370,7 +18370,7 @@ F:	drivers/infiniband/ulp/rtrs/
>  RUNTIME VERIFICATION (RV)
>  M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -L:	linux-trace-devel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/trace/rv/
>  F:	include/linux/rv.h

