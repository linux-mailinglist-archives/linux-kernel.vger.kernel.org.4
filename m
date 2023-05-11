Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DE6FF247
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjEKNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbjEKNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:12:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A4665B9;
        Thu, 11 May 2023 06:12:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ab1a0985eeso2231135a34.1;
        Thu, 11 May 2023 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683810732; x=1686402732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsHw8MmpWhGTKPANkioLZenQtgHbgTZPvM2AI2tSR54=;
        b=StiKqPvEVK5g/eOL+9md4q8J2mKaij4oilBRW92uw+aG9WEFVO3yQsITQvWtBQvOic
         AAuW4Aw+31aNEeIqgUlOn9igvpKodykrWCSk5KY39iW9aaTk8+Jzzb40PxG7OGO4hun9
         VksXQPtDExaenqxrPYLxYOInIf0OF+N0spKSBpUH1bUlZarnzIOLc17rIP9d9Jc5QDkR
         CjMDxNrw544Kn7kEeEzpQGaVgYnaDdrF4FNvdsxu6DEMwTa3dzf/vtNKof0TVj+e5Dr1
         XSuCV0Ic5Nwl+hoi6RVy3cX75+dEz9N/FFLlG11K3mTbr2loqWsB9ZKySEL4M8IvjObt
         5MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810732; x=1686402732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsHw8MmpWhGTKPANkioLZenQtgHbgTZPvM2AI2tSR54=;
        b=M5zAXi+XLrsWqPUuOP0JOKrcSKvosIxhdCS8mg+I5K1tRW/OTw7vZ+YWgFRXtRqTAE
         rHdMdfB4XsvvF6Oh2pQjS0IGzRhJAgs7/6ihtDJMjxBMYiLoYtN7VigKP3z1uGlmcG4d
         B+f+5+CYRGeAQnfnF82ExzBRhHaGArL4PovsMowhwdkrD8rYzZZLzSXIBRFfTtFIRu/r
         hsN1GI7RD6y34/f8d8CVD45x0Or3iAxLBQ7R6VQPNMc/+oekDp+mY1iz3GXur394SGYT
         I6Hd9m7kR68zbdZTqrcf+/82x3905gMJVCOptqoPXryQ8+pAmurqjs4Fas8YX9M4istG
         bHVg==
X-Gm-Message-State: AC+VfDxNKRP7Envz7DlSuSmx4UKiPXsO5x4oADmisjxfVOUKrEQ0tscX
        46k6qpRewQbQDBxPqjzFGJk=
X-Google-Smtp-Source: ACHHUZ5SpLR73m5bbG4rgCGh6QROQEk1Iv0KftS87eDX62/a6xQ2jFuFE5dNGE5w++q0X8NW3/EeNQ==
X-Received: by 2002:a9d:6b05:0:b0:6ab:1ede:f859 with SMTP id g5-20020a9d6b05000000b006ab1edef859mr3985675otp.23.1683810732393;
        Thu, 11 May 2023 06:12:12 -0700 (PDT)
Received: from t14s.localdomain ([2001:1284:f013:8be1:a329:8f7b:38d:7b0a])
        by smtp.gmail.com with ESMTPSA id n17-20020a9d7411000000b006ab0981ef17sm3789336otk.64.2023.05.11.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:12:11 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id C4DE861707B; Thu, 11 May 2023 10:12:09 -0300 (-03)
Date:   Thu, 11 May 2023 10:12:09 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     nhorman@tuxdriver.com, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] sctp: add bpf_bypass_getsockopt proto
 callback
Message-ID: <ZFzpqZCV6V+hwKjI@t14s.localdomain>
References: <20230511123148.332043-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511123148.332043-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two things:

On Thu, May 11, 2023 at 02:31:48PM +0200, Alexander Mikhalitsyn wrote:
> Add bpf_bypass_getsockopt proto callback and filter out
> SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
> from running eBPF hook on them.
> 
> These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
> hook returns an error after success of the original handler
> sctp_getsockopt(...), userspace will receive an error from getsockopt
> syscall and will be not aware that fd was successfully installed into fdtable.
> 
> This patch was born as a result of discussion around a new SCM_PIDFD interface:
> https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/

Cool, but the description is mentioning the CONNECTX3 sockopt.

> 
> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Neil Horman <nhorman@tuxdriver.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: linux-sctp@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  net/sctp/socket.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index cda8c2874691..a211a203003c 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -8281,6 +8281,35 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
>  	return retval;
>  }
>  
> +static bool sctp_bpf_bypass_getsockopt(int level, int optname)
> +{
> +	if (level == SOL_SCTP) {
> +		switch (optname) {
> +		/*
> +		 * These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
> +		 * hook returns an error after success of the original handler
> +		 * sctp_getsockopt(...), userspace will receive an error from getsockopt
> +		 * syscall and will be not aware that fd was successfully installed into fdtable.
> +		 *
> +		 * Let's prevent bpf cgroup hook from running on them.
> +		 */

This and..

> +		case SCTP_SOCKOPT_PEELOFF:
> +		case SCTP_SOCKOPT_PEELOFF_FLAGS:
> +		/*
> +		 * As pointed by Marcelo Ricardo Leitner it seems reasonable to skip
> +		 * bpf getsockopt hook for this sockopt too. Because internaly, it
> +		 * triggers connect() and if error will be masked userspace can be confused.
> +		 */

..this comments can be removed, as they are easily visible on the
description later on for who is interested on why such lines were
added.

Thanks,
Marcelo

> +		case SCTP_SOCKOPT_CONNECTX3:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int sctp_hash(struct sock *sk)
>  {
>  	/* STUB */
> @@ -9650,6 +9679,7 @@ struct proto sctp_prot = {
>  	.shutdown    =	sctp_shutdown,
>  	.setsockopt  =	sctp_setsockopt,
>  	.getsockopt  =	sctp_getsockopt,
> +	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
>  	.sendmsg     =	sctp_sendmsg,
>  	.recvmsg     =	sctp_recvmsg,
>  	.bind        =	sctp_bind,
> @@ -9705,6 +9735,7 @@ struct proto sctpv6_prot = {
>  	.shutdown	= sctp_shutdown,
>  	.setsockopt	= sctp_setsockopt,
>  	.getsockopt	= sctp_getsockopt,
> +	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
>  	.sendmsg	= sctp_sendmsg,
>  	.recvmsg	= sctp_recvmsg,
>  	.bind		= sctp_bind,
> -- 
> 2.34.1
> 
