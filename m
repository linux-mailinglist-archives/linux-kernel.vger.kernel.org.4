Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F46FF2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjEKNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbjEKNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:34:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA98693EB;
        Thu, 11 May 2023 06:33:53 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ab174bb726so1378416a34.1;
        Thu, 11 May 2023 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683812033; x=1686404033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m2aglLzj59IDe2YRddHUMhQ3rLFV7cQYGKs/XvBV6DE=;
        b=SYbnTuuQhgUEC4Q3WnfSFm+++sjbH4Y3ztp0dplhFsGdflL5axk1g6hS8thDmGwbdl
         h57NgrdSWyktyx6TOpnykYGVFkFrRdnwNn01mb2+JLzeIUSV2Js/4nDwKzW9j3z0Waa7
         /s7tyNkP1PWkKprL79GkslJNU5GeUadPfM/IT2KzfW8zom293/E9g/xO/noQJKmvTdtf
         iY7buVV/BpyX6+9Tj2S4b43ArOi0rVmeiiSgBUuA2u+I+hBAGDGab3hCTiQHUabvInu3
         LHwVaC3r+H8qDHAenDb//pphexidJclxuM61dYYFwSSAmZkuKRdv0aQkFdinNDQUHLTB
         eFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812033; x=1686404033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2aglLzj59IDe2YRddHUMhQ3rLFV7cQYGKs/XvBV6DE=;
        b=gmrJojkU7AE6qlA1l2ScHYQnG+5WkUf+y22vC0sKorsWSkuVLfFAvKWeZBhdkYxXuY
         QaPaYDU1NpbWzUb6XcCCOZdcZW+giGJM65T2K9zsejkjZPcs7bR6JhV3yizH0KjfgWoe
         WsBvOhD8eQR366A+YlsRgTmHfzrlCLQ/6pdGBOtQ1px5cqBzTJqtePA1OveORXzhdV/J
         31NUH0Wg0u+8GpsdkNM9L8fTsalGxBaEZFmIUwis38Xc5CjTGapiRk/M/yA5yla/Sp0e
         7fT6uu8lV9hxmtl0mkbCJ1Wov94BuUvdzF/TS3WC/BvUB7yhUHDQETUsRCVq9JJvRHP4
         E4IQ==
X-Gm-Message-State: AC+VfDweBNPDjBg9QCBrCgIDHLLlIHstNn2lJEg9I9xLOO5Qz3SIucxj
        LowB1xFM/23aPacerEAIngk=
X-Google-Smtp-Source: ACHHUZ7zwI6yG6sQ5EMAu2KfQoaWJVphXKBxOkJXxnlQxDn2BG223j6PB82IC/MJO6NcpeFd90gooA==
X-Received: by 2002:aca:d15:0:b0:38c:25e3:d9d2 with SMTP id 21-20020aca0d15000000b0038c25e3d9d2mr3889379oin.57.1683812030923;
        Thu, 11 May 2023 06:33:50 -0700 (PDT)
Received: from t14s.localdomain ([177.220.174.87])
        by smtp.gmail.com with ESMTPSA id j4-20020a4aea44000000b00549f2828585sm142645ooe.33.2023.05.11.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:33:50 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 5AE10617084; Thu, 11 May 2023 10:33:48 -0300 (-03)
Date:   Thu, 11 May 2023 10:33:48 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     nhorman@tuxdriver.com, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] sctp: add bpf_bypass_getsockopt proto
 callback
Message-ID: <ZFzuvDopKWB9wmQf@t14s.localdomain>
References: <20230511132506.379102-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511132506.379102-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 03:25:06PM +0200, Alexander Mikhalitsyn wrote:
> Implement ->bpf_bypass_getsockopt proto callback and filter out
> SCTP_SOCKOPT_PEELOFF, SCTP_SOCKOPT_PEELOFF_FLAGS and SCTP_SOCKOPT_CONNECTX3
> socket options from running eBPF hook on them.
> 
> SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS options do fd_install(),
> and if BPF_CGROUP_RUN_PROG_GETSOCKOPT hook returns an error after success of
> the original handler sctp_getsockopt(...), userspace will receive an error
> from getsockopt syscall and will be not aware that fd was successfully
> installed into a fdtable.
> 
> As pointed by Marcelo Ricardo Leitner it seems reasonable to skip
> bpf getsockopt hook for SCTP_SOCKOPT_CONNECTX3 sockopt too.
> Because internaly, it triggers connect() and if error is masked
> then userspace will be confused.
> 
> This patch was born as a result of discussion around a new SCM_PIDFD interface:
> https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/
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

Thx!

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
