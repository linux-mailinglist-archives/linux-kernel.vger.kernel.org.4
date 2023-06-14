Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB172F367
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbjFNELJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbjFNELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7DF1BC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686715822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apBkNGMEYE+N3GwoyYOeikY/4uKgz9iLGzWWWnCUdRs=;
        b=PjA5W1FftvO5apfRiJVmVGNd2ghB7zz2M2HWQcYQ3hTOSGIZAib+X8hgp/wimm9c7v+1y6
        od0eoyMNb5i2GuuFgZNiFbBeFO+IG+VqJPlmZG50gkMkoD61ChSjWw3C+NMnnok/sdgbiJ
        pyBrQSUPM4RfWmRJ+9p6jclfAcJKR60=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-5i9I5qENPvW7OHnstWknvg-1; Wed, 14 Jun 2023 00:10:19 -0400
X-MC-Unique: 5i9I5qENPvW7OHnstWknvg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f9d61c0990so21657101cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686715819; x=1689307819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apBkNGMEYE+N3GwoyYOeikY/4uKgz9iLGzWWWnCUdRs=;
        b=ittYcjy6fM3Xu0hN2X5ouJX5xvLcZI1O1ePJFccpS0A7yb66Y1I4nA6dmvHA/WrTBD
         SivbsbxjDe3m+xgJaNT6Y/rSx3QrZ+dzIi2/KpJ2veP2DQrn0URTuVXnMJ6Kk8sagUvx
         71XpzgEH894fHeQmRYgC/HNqlza+7yYBg+VkuZaRKlEzYiKYd1OJbaFi9nR3fdYe6Rvi
         BjpfZUyZw1rfGD4cNev7Le9JCfB0mRHxpBI40Wi3cZK8ulQl3qSjFAwIGzQcfAjsNuXn
         k3AGKvw7Zl2rAN9i7D2nRIKnB0kD50nCaCaYMjmM/GXVuJUWKxRXnzpxgjjb9cIZt2sZ
         ySaw==
X-Gm-Message-State: AC+VfDy3xCQ3sDjSeHsBE/KVDsdmQfgMKtvhNZW2IYonCEAA5Lx/8orv
        EomSVBSQvGI70fbteFxnVEREC/JVyl5kH8mUAU2/TawNck7i2HptG3qF5TwSn8vtarw97kHy8EU
        0CBvk2mWUV5GO6iJlzDxzJybmDw6ijJOwYwR9nIqC
X-Received: by 2002:a05:622a:130e:b0:3f8:6eaa:dcce with SMTP id v14-20020a05622a130e00b003f86eaadccemr1040077qtk.27.1686715819028;
        Tue, 13 Jun 2023 21:10:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sRQ8XUksUCnGvFQNbEecZBTDO2TVo8cHS+eoF0AFJEddvKBtc5OUH1TSB1de8EDJyszhrISLyLKeiWdmwefY=
X-Received: by 2002:a05:622a:130e:b0:3f8:6eaa:dcce with SMTP id
 v14-20020a05622a130e00b003f86eaadccemr1040063qtk.27.1686715818834; Tue, 13
 Jun 2023 21:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230515183045.654199-1-leobras@redhat.com> <20230515183045.654199-2-leobras@redhat.com>
 <xhsmh353ep0m7.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmh353ep0m7.mognet@vschneid.remote.csb>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 14 Jun 2023 01:10:08 -0300
Message-ID: <CAJ6HWG6x4WgLtr3RGNar4jFoccD4bCocid-_WzSFofDRP8+2gA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] trace,smp: Add tracepoints around remotelly
 called functions
To:     Valentin Schneider <vschneid@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Valentin, thanks for the feedback!

On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 15/05/23 15:30, Leonardo Bras wrote:
> > @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, call_single=
_data_t *csd)
> >               csd_lock_record(csd);
> >               csd_unlock(csd);
> >               local_irq_save(flags);
> > -             func(info);
> > +             csd_do_func(func, info, csd);
>
> I'd suggest making this match the local case of
> smp_call_function_many_cond(), IOW pass NULL as the csd when executing
> locally.

Sure, done!

>
> IMO this is required for postprocessing with e.g. synthetic events for CS=
D
> delivery measurement, otherwise we'll try to match this execution with a
> previous CSD enqueue.
>
> >               csd_lock_record(NULL);
> >               local_irq_restore(flags);
> >               return 0;
>

