Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2202635A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiKWKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiKWKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAD12D0F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669199424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPrWVsTAz7lannbrpuD3KngMgRbJ/nxBMhiEI9k+UNw=;
        b=VI/qzutQjwDbZYEexcaPUP9CCMifFrjuVUABJ7lOuktT/uTnwfPlPQNG/js6cDT/GgaHM9
        2sm+yX9ojdbGUA3VN2PoeUFESm5I8sC7qnH8kfGY+yzJSMxhHDepoY/huu0ct94IZbHKu9
        syxu1JZ6yKAOuy//memTID6PnJem7rE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-n8z4BTzXP9OknZa4u6sw6w-1; Wed, 23 Nov 2022 05:30:21 -0500
X-MC-Unique: n8z4BTzXP9OknZa4u6sw6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9096B101A54E;
        Wed, 23 Nov 2022 10:30:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-238.brq.redhat.com [10.40.194.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id B95C4C15E76;
        Wed, 23 Nov 2022 10:30:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Nov 2022 11:30:20 +0100 (CET)
Date:   Wed, 23 Nov 2022 11:30:17 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Petr Skocik <pskocik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix kill(-1,s) returning 0 on 0 kills
Message-ID: <20221123103016.GA32207@redhat.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
 <20221122161240.137570-2-pskocik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122161240.137570-2-pskocik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22, Petr Skocik wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1600,20 +1600,18 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>  		ret = __kill_pgrp_info(sig, info,
>  				pid ? find_vpid(-pid) : task_pgrp(current));
>  	} else {
> -		int retval = 0, count = 0;
>  		struct task_struct * p;
>  
> +		ret = -ESRCH;
>  		for_each_process(p) {
>  			if (task_pid_vnr(p) > 1 &&
>  					!same_thread_group(p, current)) {
>  				int err = group_send_sig_info(sig, info, p,
>  							      PIDTYPE_MAX);
> -				++count;
>  				if (err != -EPERM)
> -					retval = err;
> +					ret = err; /*either all 0 or all -EINVAL*/

The patch looks good to me, and it also simplifies the code.

But I fail to understand the /*either all 0 or all -EINVAL*/ comment above..

Oleg.

