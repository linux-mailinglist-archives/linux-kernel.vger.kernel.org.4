Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5484B715BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjE3Kh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE3Khy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC493
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685443029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLqwsPXYX0iDPr0qf3f1ojIJFMqD6WOSnvvW6FW4y68=;
        b=D5JyvAVXMP9lDE56Ccn9/tQ78L4eF4agD3DQ2OiC1ujah0vnhhwbBttf1Y/WiooeRjd40z
        +MQaVynrja5kz5basPxw9iWCXHv0ciPDN5kqUT68HyBpnxWa+21nnsX87cZnlRzGNOQJKX
        q+NEqunYLD7u8yRgdK+jNIHoakgtT/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-QVXHWd1eMU-kFBoZ6osOYA-1; Tue, 30 May 2023 06:36:21 -0400
X-MC-Unique: QVXHWd1eMU-kFBoZ6osOYA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso18609315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442980; x=1688034980;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLqwsPXYX0iDPr0qf3f1ojIJFMqD6WOSnvvW6FW4y68=;
        b=DHHNsGtjXf227/z2iE8NHkBPg5ToWNqSOqQA2XguQY0MPo9FN9Wj46Ww3nCAWlKF4q
         jVn1goXgnxZeaF8dS4e4XlNQ3g7M+nAp67EGwa/Oqk1UZmFWsffuzl0xrkGg0FGZfz3X
         3RFyKR85MNu+WzfDM5xJ9nXQ6gqhd72lWA61olFTFIbTql++X+LK/6IgiqCYCcXwibsE
         3nzh+ZkGumSGEegN1By0CEDFvZmZOR0iZQKunu3GZugG3qw70D3QNYU5xGbQkmK2C83M
         sXXaaqh0ZLY8xleD9XUewPW2SVsvNF7Q7DxKt+wJYfPb0a7FH05/xqpOuV2DHXNEWY62
         Qc3g==
X-Gm-Message-State: AC+VfDzLa91e2jrJ7FyYAChuBBVXCkgOR12HMyZ9Rjpm++b02MfiCkIV
        SEiIKDiDpc3mQ7GoWHhn82IUPTidgOL+zKHJeRg5S5qRRJtxz7U/hhetwuT4082lBEjSNTlumk7
        8tU2xlvl7jXAOEHDiyBNaxm/D
X-Received: by 2002:a7b:c40a:0:b0:3f6:82a:5d1b with SMTP id k10-20020a7bc40a000000b003f6082a5d1bmr1401674wmi.34.1685442980522;
        Tue, 30 May 2023 03:36:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZpxW6peHXfHC1gcVcWekJmGV2Eu3/iAvrk2Tsb6d1qChMCTBEWj+yJqOW+Sz+rrpveCHoZw==
X-Received: by 2002:a7b:c40a:0:b0:3f6:82a:5d1b with SMTP id k10-20020a7bc40a000000b003f6082a5d1bmr1401662wmi.34.1685442980332;
        Tue, 30 May 2023 03:36:20 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id i16-20020adfded0000000b003077f3dfcc8sm2918026wrn.32.2023.05.30.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:36:19 -0700 (PDT)
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
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
In-Reply-To: <20230515183045.654199-1-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
Date:   Tue, 30 May 2023 11:36:18 +0100
Message-ID: <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
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
> Changes since RFCv3:
> - Split the patch in 2: entry/exit and queue
> - Fix 'struct __call_single_data' & call_single_data_t alignment issue
> - Made all TP_printk follow the same pattern
>

One bikeshedding nit I have is I'd prefer to see the csd_* events in a csd
trace system, to have a sane nomenclature.

Other than that and the other comment on csd_do_func(), this LGTM.

> Changes since RFCv2:
> - Fixed some spacing issues and trace calls
>
> Changes since RFCv1:
> - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> - Using EVENT_CLASS in order to avoid duplication
> - Introduced new helper: csd_do_func()
> - Name change from smp_call_function_* to csd_function_*
> - Rebased on top of torvalds/master
>
> Leonardo Bras (2):
>   trace,smp: Add tracepoints around remotelly called functions
>   trace,smp: Add tracepoints for scheduling remotelly called functions
>
>  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  kernel/smp.c               | 41 +++++++++++++---------
>  2 files changed, 96 insertions(+), 17 deletions(-)
>  create mode 100644 include/trace/events/smp.h
>
> --
> 2.40.1

