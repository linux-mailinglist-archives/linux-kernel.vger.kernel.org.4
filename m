Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8D70A10E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjESUym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjESUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD3137
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-757756e2eefso200267385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529678; x=1687121678;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EftTN48XIscLx2uPCkmTyhD/m2bm/FDn6sy7vahCgjE=;
        b=T7FKOsXM1ouz72HThuuahoyILhW+FggCWQ0iUHvRy8NX46GoZO1s1XPgTMD5+zu8yW
         H8gd+7zo2OMD0QOAtOZUJRfxtC3qvcCU4fHiqXCWGLATXerO86WECoCIcyVV3WYjBYMA
         Ar4QUVBJY+kZVggbjC2kTWOLtwA14A0xp2txTBgBzH0/TIATr4dz5NYHOPtmtmMMZrdT
         hwUhCyxerV44prjl1aOLDuao9IXmhbj2vbnG2RlNvW1w+65GgO1KcKI0p5TdE8p23Irq
         ftdl+yICQ4jqVm4f6dRhcODUemWe/hn8o61kZBSS/VuymVpryo0fwpX3zhZLJiLiqLw4
         vnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529678; x=1687121678;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EftTN48XIscLx2uPCkmTyhD/m2bm/FDn6sy7vahCgjE=;
        b=ZnkNbCihq2JMrXbr3Qre0IWBwyH07hOagTr1nPDe/79Vs/KsgMN9ObtWyLXZaaGnD8
         77lcU3ALfrTdCLl1aw06uqHzLLyYQC+YFuEZCrGUHNgr7Khb+9BpEL80GzR2IDEYz2fI
         t6uOe+yNaWtcm8Zi1GnAdw4gSTa0TSbJ3OaDbEF+24YJP0GWK4Vw1ynQDEKoSZKOAqgS
         0lul72w4kTpCQtPLT/K1hPSnG7GipV6oBVNDAVcaxZXc7yLXlTiIgVeNdmah9QlrKmyc
         dxQFRurFiEQrvZqp6w0X+YOO55pqmFxZ3QET+wNTHKVio9xGwIl2qa6UXHPFwF5xRRsb
         3Yfw==
X-Gm-Message-State: AC+VfDwkRxTNj+dDddgwSWWoC88SImComwOZJJSBnwJkrCIpAWJDbDH8
        SsDDWuvqMQnbTjjvlY/ncRQ0
X-Google-Smtp-Source: ACHHUZ68wdbTYWzckk23nVLTX5UsgqPNSlaIiYcdUsFAJJ5/q/X/NUngCpJuNjGWGwrpc6B8K/Chsg==
X-Received: by 2002:a05:622a:4ca:b0:3f2:1778:813c with SMTP id q10-20020a05622a04ca00b003f21778813cmr5339882qtx.31.1684529678042;
        Fri, 19 May 2023 13:54:38 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84688000000b003e3918f350dsm123813qto.25.2023.05.19.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:37 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:36 -0400
Message-ID: <1be99c1ede70b5c385acc16b59347d02.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 1/5] audit: refactor queue full checks
References: <20230511052116.19452-2-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-2-eiichi.tsukata@nutanix.com>
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
> Currently audit queue full checks are done in multiple places.
> Consolidate them into one audit_queue_full().
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..c15694e1a76b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
>  	return retval;
>  }
>  
> +static inline int audit_queue_full(const struct sk_buff_head *queue)
> +{
> +	return audit_backlog_limit &&
> +	       (skb_queue_len(queue) > audit_backlog_limit);
> +}

Regardless of the other patches in this series, this seems like a
good candidate to merge, but could you make it return a 'bool'
instead of an 'int'?

--
paul-moore.com
