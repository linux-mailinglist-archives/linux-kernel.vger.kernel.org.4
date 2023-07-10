Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36674CE97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGJHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGJHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07CF1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688974599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULJanH9OHF7ZIdaWHkxUYmoRNQco7TUqMsPXZi3/w/Y=;
        b=bqEs0vS9fLxelZBFigtroWJJ1sHNKSG7DpZVpS+rUQW46AvvKKFXC2hsx2lDSsE1WlIqRI
        YoDJY4zjpSUBs/w8iqCMId5fgPnTm5e/Mq1/tgwp5YHxz9eB2kR4c0N71i5xH87wvtDNFw
        415pF1zUEwHAiUz75G0HB/5BIxgV8u8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-A9FZdPZgMH69F1OGMSLk3g-1; Mon, 10 Jul 2023 03:36:37 -0400
X-MC-Unique: A9FZdPZgMH69F1OGMSLk3g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765986c0568so639901085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974597; x=1691566597;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULJanH9OHF7ZIdaWHkxUYmoRNQco7TUqMsPXZi3/w/Y=;
        b=LdC6Eaz4UxJRMQpW2dsNSCBOZcVkKxEJlhOhqI3FsP1h/LObNyuJvB6JkK52SOHUWE
         U6ZUGBRnRLmh13Xz8mTafxy5w2ugqD69m8NBDPr+YeDVK6nZuH8qu+3KGRh/n10ut6zX
         tv0ENg+932sXGTwtshF1W4Jkc2ATGcWX6NVtQ3wKpYfvrNVAtcANX8+wTv/Rif0oBRcx
         9qUhRjMsXDHgQf2JMcEGSnJdW1RRiNlxgF1Jnp1cG+JG+iQsUrJahUBzXRMj2SCnzuaT
         EceK2r4kRfedMJ7rwivw+jToJp7M7gXQ8yE51JVVqGcvJhy1HlylPU/EtMvmRGmGbqlq
         j8mg==
X-Gm-Message-State: ABy/qLY5ouMlDZ+cQgZ2S/sweCrKFeQQbr2wVlTxTJJw5TMoKUCOTbyB
        a/xe9wNb2whAMnHNEInXgMvXhRSSu//S+cYqX34Yg0b6MCjJbMyt+iw7lXSswjPTz2puLxju6+B
        h8E101UItC6tX+HOBdv/kji+y
X-Received: by 2002:ac8:7f89:0:b0:403:b119:e012 with SMTP id z9-20020ac87f89000000b00403b119e012mr1780744qtj.20.1688974597055;
        Mon, 10 Jul 2023 00:36:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFF/Vek9WHQs90ANcQvflXBjKkp+kfsi8cYYEW7we7zqpw9O8Vfi3L57GEw7rxMaqBCrtebbA==
X-Received: by 2002:ac8:7f89:0:b0:403:b119:e012 with SMTP id z9-20020ac87f89000000b00403b119e012mr1780736qtj.20.1688974596878;
        Mon, 10 Jul 2023 00:36:36 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id n14-20020a0ce48e000000b006375f9fd170sm5293827qvl.34.2023.07.10.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:36:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH] cpu/SMT: Fix cpu_smt_possible() comment
In-Reply-To: <20230710032121.8341-1-rui.zhang@intel.com>
References: <20230710032121.8341-1-rui.zhang@intel.com>
Date:   Mon, 10 Jul 2023 09:36:33 +0200
Message-ID: <878rbo5ibi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Rui <rui.zhang@intel.com> writes:

> The comment of cpu_smt_possible() is not aligned with the changelog of
> commit e1572f1d08be ("cpu/SMT: create and export cpu_smt_possible()"),
> and it is wrong.
>
> Fix cpu_smt_possible() comment.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 7e8f1b044772..f6811c857102 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -676,7 +676,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
>  	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
>  }
>  
> -/* Returns true if SMT is not supported of forcefully (irreversibly) disabled */
> +/* Returns true if SMT is supported and not forcefully (irreversibly) disabled */
>  bool cpu_smt_possible(void)
>  {
>  	return cpu_smt_control != CPU_SMT_FORCE_DISABLED &&

The function must've had a different name in an earlier version of the
patch...

Thanks for catching this!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

