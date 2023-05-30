Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DFF715BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjE3KhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE3KhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE911B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685442980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0YHytPvfnkeWnuCkOajf7O+c3bYpxCqL4BosxRYRJEM=;
        b=SeXGtftpG1Rhx3S9XIvKkcdxR62EvUqn2P9wdh1HCMRhH83lIReV5080CqOUTIuoCor39C
        shJklLXgwqKgGoi/q75EaEZsbT+4CgPDMXjUERrc+B/M3eyWzL330x1gd0gd2i0neVF4o6
        qNF1q4wIcWStMGrnic7/OAmK7/iJgaM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-65DZw_rrMuuNvMJT1VvrQA-1; Tue, 30 May 2023 06:36:18 -0400
X-MC-Unique: 65DZw_rrMuuNvMJT1VvrQA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6089a9689so27015305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442977; x=1688034977;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YHytPvfnkeWnuCkOajf7O+c3bYpxCqL4BosxRYRJEM=;
        b=IB4OgtP2NLMEn+xhGAMruS55rozk46ycupSOcNnWKQ3uFjseiNwGceL5QXAB/PJtV7
         lJYvNQlPRV+MoPbXKj7TAXlZ8+vMkaUrXjL+J2XMqEOLurP9oJbGqx1h55ZtJxGVs3JT
         zSbwtIXRUU5Cpg7K7R4ePSBXL2iZJs1X5GuRRlr1kHbFUUVElZI4jIfI3UEHbbPTZrCN
         Gh+uNl25KG5eJJSwNxLxSlsjcKXlfJzxSWokgQhzPboDaArhWxAPA8ERJlu7BAk8RN4x
         FzGj8Awj9vj3W75xG7GtCfHMWAEAjJ682edfMbETeUMFG2hASEEXSKZ55T+WppnxQe6r
         iiKg==
X-Gm-Message-State: AC+VfDzGaltW1b1kS5LULiRwJ6KCM59iMezdWPZ+VPJT3oIle9BXdDPP
        xKUq3r9Q9OY/qhRTZ6kUdmKla8pM0rQ+ux0Dcp+TGwAmZOZXg7mKEe6qcR7s5UdVHRnXAx2bjRT
        P/UMK06efnAzUn/Jn17dbxXR1trv8VVhiiaY=
X-Received: by 2002:a05:600c:2304:b0:3f5:6e5:1688 with SMTP id 4-20020a05600c230400b003f506e51688mr1284637wmo.2.1685442977659;
        Tue, 30 May 2023 03:36:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51yjtghwN6gnYHTSu1gfgT6ds7TGsfgQyKhlxCFVUa1ZeeG1wFOCBXeSxRJeHuGZegDSuPiQ==
X-Received: by 2002:a05:600c:2304:b0:3f5:6e5:1688 with SMTP id 4-20020a05600c230400b003f506e51688mr1284614wmo.2.1685442977398;
        Tue, 30 May 2023 03:36:17 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b003f606869603sm20588191wmi.6.2023.05.30.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:36:16 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] trace,smp: Add tracepoints around remotelly
 called functions
In-Reply-To: <20230515183045.654199-2-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
 <20230515183045.654199-2-leobras@redhat.com>
Date:   Tue, 30 May 2023 11:36:16 +0100
Message-ID: <xhsmh353ep0m7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/23 15:30, Leonardo Bras wrote:
> @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
>               csd_lock_record(csd);
>               csd_unlock(csd);
>               local_irq_save(flags);
> -		func(info);
> +		csd_do_func(func, info, csd);

I'd suggest making this match the local case of
smp_call_function_many_cond(), IOW pass NULL as the csd when executing
locally.

IMO this is required for postprocessing with e.g. synthetic events for CSD
delivery measurement, otherwise we'll try to match this execution with a
previous CSD enqueue.

>               csd_lock_record(NULL);
>               local_irq_restore(flags);
>               return 0;

