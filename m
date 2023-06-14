Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9472F915
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbjFNJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbjFNJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8338DE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686734831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XA4bJtbX8lGVNErXmlyMvuG2dmyejsrqojE7AOdIYt8=;
        b=VzpX4wTA/Y04UkXpFEwg6i0nbx/6sPSZNxaIdZJr9bhbbtpsSQDe4G8HFfrs/g94sj6Vr0
        cXunq6p2PQlF58aFHFz0FMKUWFUjiACTfCfI6XcAvlek7xNCMjTlibmw5jprEYLXm/xGYx
        cl/Gh80ilfn5+JrRA460/wRv+HzctCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JLU_Y2-aPF-S5AmYy4vONQ-1; Wed, 14 Jun 2023 05:27:10 -0400
X-MC-Unique: JLU_Y2-aPF-S5AmYy4vONQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so2358155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734829; x=1689326829;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA4bJtbX8lGVNErXmlyMvuG2dmyejsrqojE7AOdIYt8=;
        b=GU7namhIKdDFZoIW+2Tj9D0bffHYQeCBve7oqD0ZBC6Y1UCoj3cOL+B6ip9MNs2+sr
         9sI0Qjq+l5DB9KEXGL2FC69cK5RwY/OonUMB76dBPY+5ijq+hFo8VfUJ7A+C92ORrC/c
         8/Rx1zvWKeE2+iAT7N7zAXm9yZVeH7WLh1ffj8fakPJVaqeggI/H/Zryw+nVom2mH3Lg
         27OUsP3VNV/1tRGwUSKGk+DBpxfpT/j0m5rYY7HmDto47p4MNcoVhZs7xtLCLkPObeli
         lo5aixDIfsVpQj+75BumlBb0eLuhoMvRHAXc2EBXgQRogsqUA1PDYDMuBwMfi7MTu66m
         AVUA==
X-Gm-Message-State: AC+VfDx6ovaFwvMrFzCMu6w6WVLOJGy9iyWNDdXq0JpveUVXYQZ4bUz3
        Bf9z80wlZoXy//VX/lyz/lVAz3QsALNDrjF8yzxzfvp2jBuVsbeMcM7T2/gf6+RvbFr3iAKc5DS
        cc63k6R28OMeZDGFUyOimCSmX
X-Received: by 2002:a05:600c:881b:b0:3f7:408c:ad39 with SMTP id gy27-20020a05600c881b00b003f7408cad39mr890283wmb.14.1686734829224;
        Wed, 14 Jun 2023 02:27:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57gLxcK2TJrQrk+pqDItthTRyV3M0raBHWhZZfDu285V1WlTgB1ai1sMxtysg0YYQuJLH8Dg==
X-Received: by 2002:a05:600c:881b:b0:3f7:408c:ad39 with SMTP id gy27-20020a05600c881b00b003f7408cad39mr890268wmb.14.1686734828974;
        Wed, 14 Jun 2023 02:27:08 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f819faff25sm9574216wml.13.2023.06.14.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 02:27:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
In-Reply-To: <CAJ6HWG4sRHCTtkxe8G2csjBhJxeJZcO=cQ9Reb1cJrN2VA1nzg@mail.gmail.com>
References: <20230515183045.654199-1-leobras@redhat.com>
 <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
 <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
 <CAJ6HWG4sRHCTtkxe8G2csjBhJxeJZcO=cQ9Reb1cJrN2VA1nzg@mail.gmail.com>
Date:   Wed, 14 Jun 2023 10:27:07 +0100
Message-ID: <xhsmhcz1yxul0.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/23 02:16, Leonardo Bras Soares Passos wrote:
> On Wed, Jun 14, 2023 at 1:14=E2=80=AFAM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
>>
>> On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@red=
hat.com> wrote:
>> >
>> > On 15/05/23 15:30, Leonardo Bras wrote:
>> > > Changes since RFCv3:
>> > > - Split the patch in 2: entry/exit and queue
>> > > - Fix 'struct __call_single_data' & call_single_data_t alignment iss=
ue
>> > > - Made all TP_printk follow the same pattern
>> > >
>> >
>> > One bikeshedding nit I have is I'd prefer to see the csd_* events in a=
 csd
>> > trace system, to have a sane nomenclature.
>>
>> Oh, here you mean the file name? (ie: trace/events/smp.h -> trace/events=
/csd.h)
>
> Or just
> -#define TRACE_SYSTEM smp
> +#define TRACE_SYSTEM csd
> ?
>

At the very least this yes, and making the file name match that probably
wouldn't hurt.

