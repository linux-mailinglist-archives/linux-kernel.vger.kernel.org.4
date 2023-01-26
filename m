Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E473067CEB0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjAZOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAZOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F46AF4B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674744425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=juveI51IvAYqxoBddz1bu2B+lEpKNxVGshv31YwhktY=;
        b=JRp4fT9P+51d+T1wnosetlItKY3TCznZjNAH8ZPlRsTiLBnF+TTRUpBz/ufOS8/utYLCsT
        TTUS49pWosmlfPx9irTo53OFRN4/MENMLFoNdVT76OWsXgOImSJT76kjEHSYLXfx8buJcH
        yRrG0pXtXEHc5my+woMp8I7EhV+Eb9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-FCLVdyUMNY22izFLgZwZ6w-1; Thu, 26 Jan 2023 09:47:01 -0500
X-MC-Unique: FCLVdyUMNY22izFLgZwZ6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545C1802D19;
        Thu, 26 Jan 2023 14:47:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-60.brq.redhat.com [10.40.194.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE7FE2166B26;
        Thu, 26 Jan 2023 14:46:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jan 2023 15:46:58 +0100 (CET)
Date:   Thu, 26 Jan 2023 15:46:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20230126144655.GA4069@redhat.com>
References: <20230112112411.813356-1-dvyukov@google.com>
 <20230126105128.2249938-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126105128.2249938-1-dvyukov@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26, Dmitry Vyukov wrote:
>
>  	t = pid_task(pid, type);
> +	if (t && type != PIDTYPE_PID && same_thread_group(t, current))
> +		t = current;
>  	if (!t || !likely(lock_task_sighand(t, &flags)))
>  		goto ret;

Feel free to ignore, this is cosmetic/subjective, but

	t = pid_task(pid, type);
	if (!t)
		goto ret;
	if (type == PIDTYPE_TGID && same_thread_group(t, current))
		t = current;
	if (!likely(lock_task_sighand(t, &flags)))
		goto ret;

looks a bit more readable/clean to me.

LGTM. Lets wait for Thomas verdict.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

