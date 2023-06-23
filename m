Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6773BD02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjFWQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjFWQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1E271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687538845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UT25gWFOeZcYmyA4boqdjMakUtDcuMgwh+wST0DBOXc=;
        b=RXXPqsbegKRZnlBCZpkytWtDIrPqSKPY0s4mUmeGkTCw0h9sVuXGsBTM7QJcrot6JFRR6R
        fVwl5yAP42d3RWiJTlysfAS8AVCv/Nxnl0TDHp8gH/qtJEQRs4ofnmiHo4LWa47Tandm+o
        9qA0fNAUhYJ16isGE+Md9W9CIJ9ciB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-hERHwfvlNMeV20DvhAh4mQ-1; Fri, 23 Jun 2023 12:47:23 -0400
X-MC-Unique: hERHwfvlNMeV20DvhAh4mQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa7a851dadso5067895e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538827; x=1690130827;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UT25gWFOeZcYmyA4boqdjMakUtDcuMgwh+wST0DBOXc=;
        b=G9sj6xXhy757zC2Gqg2ckhN2yFV09q1nPlLsUthzrkT62SBYMHC5At3vpu2hDRzA02
         fOkvYSXAqUoLX6PTk//VM3/FQS35LQNHpsvgDBy19Zfgjc7rw5rV46CIV5evePl0C12/
         ivRP+AAvGTutpiyXyd9Ou46YHEjhB29H0A7CThjD1MfvTkCgtYh/w9YSRQjH8D9zIkCJ
         ndDK1N7gmXGmDKmE/ao5c4Q07rp2ZS1JyA3uvQHKrm739pdZDGMu6AQ2MqbkROs41Dxa
         JgdDdiro2JNXg9ikeZ0TOJXQrneuu5uDl+BeRqwyf4N6Q1CrvovTgxHeMdxbe+dCyJL3
         HEdw==
X-Gm-Message-State: AC+VfDxdSIbAHglb3QJQyz9mHtbXiIL456hwdt4Jf4N2wcoPSeCXTBQS
        Bl7HjrhEkJT59Qn0LbDZgfivEqc4NXMMqarFwUh4ZG7OLHY4Oqk+fJHJDsDR5vLnqmulifrPgIy
        3nU13N9dy0LadX0sfZnRwoS5/
X-Received: by 2002:a7b:ce09:0:b0:3f6:536:a4b2 with SMTP id m9-20020a7bce09000000b003f60536a4b2mr17647192wmc.27.1687538826966;
        Fri, 23 Jun 2023 09:47:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EJk9dhev1qoAdmKkeWVaIhOgbkHJ+sXvtznIihjEJxvNuyEvMO1hdLFmvBFjIOnGCvqA7ZQ==
X-Received: by 2002:a7b:ce09:0:b0:3f6:536:a4b2 with SMTP id m9-20020a7bce09000000b003f60536a4b2mr17647184wmc.27.1687538826642;
        Fri, 23 Jun 2023 09:47:06 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003f604793989sm2791348wmj.18.2023.06.23.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:47:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [RFC PATCH V3 4/6] sched/deadline: Introduce deadline servers
In-Reply-To: <e08a76013ff2b6a83028e8fdf3b8a6a0aa677d58.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <e08a76013ff2b6a83028e8fdf3b8a6a0aa677d58.1686239016.git.bristot@kernel.org>
Date:   Fri, 23 Jun 2023 17:47:05 +0100
Message-ID: <xhsmhpm5mw2gm.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
> @@ -2033,9 +2147,20 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>  	struct task_struct *p;
>  
>  	p = pick_task_dl(rq);
> -	if (p)
> +	if (!p)
> +		return p;
> +
> +	/*
> +	 * XXX: re-check !dl_server, changed from v2 because of
> +	 * pick_next_task_dl change
> +	 */
> +	if (!dl_server(&p->dl))
>  		set_next_task_dl(rq, p, true);
>

Should this be

       if (!p->server)

instead? AFAICT dl_server(&p->dl) can never be true since there's no
pi_se-like link to the server via the dl_se, only via the task_struct, and
the server pick cannot return the server itself (as it's a pure sched_entity).

> +	/* XXX not quite right */
> +	if (hrtick_enabled(rq))
> +		start_hrtick_dl(rq, &p->dl);
> +

IIUC that got hauled out of set_next_task_dl() to cover the case where we
pick the server (+ the server pick) and want to more thoroughly enforce the
server's bandwidth. If so, what's the issue with starting the hrtick here?

>  	return p;
>  }
>  

