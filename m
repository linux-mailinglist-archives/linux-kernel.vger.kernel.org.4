Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2111270A10F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjESUyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjESUyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23B319A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f3faefc92cso32858251cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529679; x=1687121679;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzlWC7dAzjYNe5HJnuzDcoPTa8yc00sc5tGQHofbAVc=;
        b=IOYphj01/ARZ7d53DwuUocdpRtuyLcnHOP9GAFyIL1C7BAt2TDK3QBfct1Lccdu2s3
         iRqbFEPQ4QnO3EBQ5dyxhvJ+WsR1R/u3RNGbWl5VJQzmOr2+onFOdRcjnuJ/j8/vTP4Y
         yOUCzsN4aUgDAOOjWfqiSOTqOKyZslXS7ZecOrdcaoddatZ0jw0mADB4tK1+7c3ndIpK
         GCgH+OwZEC5XJplC9OqpQYf+/2CRH29yY88qZqnhEOIRAT0U1FF97uoJ5Ue9iDJzuyFU
         eJGqJnl3e43AiW9q3wgwPDTxLl5xWxJP/ljDyJD4it1bugwbU6fmG2F0ED831+ErMm9L
         vHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529679; x=1687121679;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzlWC7dAzjYNe5HJnuzDcoPTa8yc00sc5tGQHofbAVc=;
        b=Qg2DbRWNnIvIZCyZ+0CBfYd4Ksk4sA3zWncWPVCP1IdAJBCbuMCXU42dbAHweRhGi4
         E4tw2qLYDNzjEIj9ccpShXmAUzeImmzq8u4q9/gKaytLbbjQT2HXVMrEvxLVFN+LMEai
         GSVOraCyCzi4bBtHDNPVy8GbUaxXJiwNOUI4pv6xr2alRlZzd4XGQyoc1cL+cuu/7N7f
         lqayBkO8GqRY9tNzZn/0RNml8kw9vYajmroRxblcrsK++JJcXVUVwUDZrvpCS9tceiB1
         HqQ3ttfxXuTiLsdFSpaZLNanLGSxM9jnhN3nA6bQu+7ikM/auC9Nn+WouRh37iSArNuy
         P01w==
X-Gm-Message-State: AC+VfDwfj4IQEG5AF/8JULt24ly7AopYAzI7cZr9smt5kKw/jyZH1iDM
        HLpuhTaWlU0Rgtto4TPPWikV
X-Google-Smtp-Source: ACHHUZ4rV+JfmsdbKgf61M4OssP9KFuyzftAuT5Tk2VchdQNNhPf5CgmbI29Rp0LAYdeawg8vSYu/w==
X-Received: by 2002:a05:622a:4c:b0:3f6:9cfd:ca49 with SMTP id y12-20020a05622a004c00b003f69cfdca49mr352906qtw.58.1684529678989;
        Fri, 19 May 2023 13:54:38 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id b14-20020ac8540e000000b003f38f55e71asm120255qtq.47.2023.05.19.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:38 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:38 -0400
Message-ID: <18aac53d73e41b33b71d9e5d0f5d4286.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 2/5] audit: account backlog waiting time in  audit_receive()
References: <20230511052116.19452-3-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-3-eiichi.tsukata@nutanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> Currently backlog waiting time in audit_receive() is not accounted as
> audit_backlog_wait_time_actual. Accounts it as well.
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)

The audit_receive() wait is different from that in audit_log_start()
as processes calling into audit_receive() are performing an explicit
audit operation whereas those processes calling audit_log_start() are
likely doing something else, e.g. opening a file, that happens to
result in an audit record being generated.  The fact that the
audit_receive() accounting logic, as well as the timeout calculation
used, is different from audit_log_start() is intentional.

--
paul-moore.com
