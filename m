Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49E703CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbjEOSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbjEOSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCC14923
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684176481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hqIAn873QsCpWU5fVaK4Ln/oVmQG1LGyWmBLtBWvnQ=;
        b=L4v1e4yKg6zYLYbEh+cqzFf48V8cN8hE5s7zjGTcSJV5tNJTcXv27Q4WOZbquAujgj9QOf
        3jz7AfNPfhzYSLaY2jiPGwUjtbDWGnUki+roE3uxFmdxt93DL8yXLSuB+Q7DUXJ130NHVy
        WuBf+yqzGnCUUph62OGaJMw/DFP+SqM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-e2UIXAz_OAaWQ3m6SdL2zQ-1; Mon, 15 May 2023 14:47:57 -0400
X-MC-Unique: e2UIXAz_OAaWQ3m6SdL2zQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ab1bcd8c8bso5414842a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684176477; x=1686768477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hqIAn873QsCpWU5fVaK4Ln/oVmQG1LGyWmBLtBWvnQ=;
        b=PgixC48XdeDSfFBKIw3sWGpfPW3kEC1frulGAo7lu67/gNjYX3vBlacglkfBn76lsk
         L8JkOEeJgNUuiJ0ztJ89S6Q5yow45kVlE+a4vS0E4BTXK2VvGP9g/z7Tz4QnXnzoCoXC
         LGtER7x5v81dDE8tTKrfKHvuR0ygcxkd4MuSjvNE/H7c/KQOeCZzigGsR7ZEIReAXSXF
         GAjJ/XJFkRYzBqsvCzVLBPsSBJz4mv3lXEFnEDfJgBN/7xaEXTudHQ1tJB7BrsyA2MBN
         zZAtovt6gP6Bm71eZ7FggcsPPJn/qW8eL9iHU99uQrMHxPf6Ki5fVe37O+PUCAvgBlwS
         PhNg==
X-Gm-Message-State: AC+VfDwh64GV6UKozxy+Aa+yU/jAqNmu+fgPx1fqOugJKskW/CiG/7TB
        UBGHVXl4YI8zsvewQUjEiVBldktdiFPtjTPu3dSWmlNHpzhELC+gIDfthkxWlLaLw1xKQTDOeWa
        +KgFuRQ9IdUtzqBPiH7Iu0Is8
X-Received: by 2002:a9d:6c05:0:b0:6aa:f9c8:42ee with SMTP id f5-20020a9d6c05000000b006aaf9c842eemr11342146otq.38.1684176477142;
        Mon, 15 May 2023 11:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7w8rqRjYuIs5zI+oXDDwHSM39djcYXopSet1+cG56krvnX1VIMPKmnMOQaeweOUPK8LYIxHg==
X-Received: by 2002:a9d:6c05:0:b0:6aa:f9c8:42ee with SMTP id f5-20020a9d6c05000000b006aaf9c842eemr11342139otq.38.1684176476861;
        Mon, 15 May 2023 11:47:56 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3? ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a6558ef17fsm11450965otl.30.2023.05.15.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:47:56 -0700 (PDT)
Message-ID: <cefdad7f7154155f69d9613efe53f9cbbea2ed20.camel@redhat.com>
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 15:47:51 -0300
In-Reply-To: <20230515183045.654199-1-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-15 at 15:30 -0300, Leonardo Bras wrote:
> Changes since RFCv3:
> - Split the patch in 2: entry/exit and queue
> - Fix 'struct __call_single_data' & call_single_data_t alignment issue
> - Made all TP_printk follow the same pattern
>=20
> Changes since RFCv2:
> - Fixed some spacing issues and trace calls
>=20
> Changes since RFCv1:
> - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> - Using EVENT_CLASS in order to avoid duplication
> - Introduced new helper: csd_do_func()
> - Name change from smp_call_function_* to csd_function_*
> - Rebased on top of torvalds/master
>=20
> Leonardo Bras (2):
>   trace,smp: Add tracepoints around remotelly called functions
>   trace,smp: Add tracepoints for scheduling remotelly called functions
>=20
>  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  kernel/smp.c               | 41 +++++++++++++---------
>  2 files changed, 96 insertions(+), 17 deletions(-)
>  create mode 100644 include/trace/events/smp.h
>=20

argh, almost sure some llvm build will output some alignment warning becaus=
e
csd_do_func() has an=C2=A0'struct __call_single_data' argument while the tr=
acepoints
have call_single_data_t arguments.

Other than that, it should be fine.
I will collect other suggestions before sending a v5 with this fix.

Leo

