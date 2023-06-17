Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F712734221
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjFQQOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052410E0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687018405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vohTZOhneh/Z735yZQIJNbji5u3c6RxaFCGzdDERCaE=;
        b=SjBj3qTBQ+0ibQxC5KKP6b+HCzA+MDEdKUL43lrEKqjkWCb7XoWFdWWCipTmzipml2RU0R
        Z2AgMftDmZP3/nyme5gf1+575DZjew3CgpxpDV7ZSK9Sm+/CrFS4ju/wIO4kSnb68J2OA/
        uz9IjnJg/Fizu5UBloinjsdex9Ok3cc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-21hKs1fEO1ODjEqbn8eGbA-1; Sat, 17 Jun 2023 12:13:23 -0400
X-MC-Unique: 21hKs1fEO1ODjEqbn8eGbA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7e7cfcae4so8610075e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687018402; x=1689610402;
        h=in-reply-to:references:to:from:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vohTZOhneh/Z735yZQIJNbji5u3c6RxaFCGzdDERCaE=;
        b=DRLlEu3J9NFQHhckxe2X+JhqzF4ok7wmycg/rKZYMM5DLHdNLeiQCx97Nea18y2AFD
         aYqrP3u3aebHP7lJMFC55PSMYUUAFgwZov0DU3SAtJScGTVDBKT+I0CxY+pbVsyofTKS
         uieIBA7dGfeYrS7ac/ccaYdk8xodFRMRG0F53GXbF4Uv9UcphYHQQwGcxDjjXeWzHymQ
         anYU/UhVEwxt6YU8vJ40C44Oe6S0uFvu4xT2e41uf4GQ0zIuvQQXF8RvUJFLdT+nfWN5
         IgNfk1Meob6qMNQCqZL/WhJkNGjIveoThngcKohIHdSBoMfoAbqDgZfw6hC7qLd12NBK
         7/ww==
X-Gm-Message-State: AC+VfDwPiixjmsulgSLalWq4CrvPWRIkOvpZfgbYDsNiy2bNd7Mt/Q+i
        sSgwwLqDZpvuH5cmE1LFgPBodnUW+gJR5icfFnnWy2JDhmkQbhwYOGkgxW6C8uxh2e/avz2TC0M
        3ZGMosiW0JyYF12F9sMB4LClI
X-Received: by 2002:a05:600c:378b:b0:3f8:d0e7:daed with SMTP id o11-20020a05600c378b00b003f8d0e7daedmr5307704wmr.19.1687018402363;
        Sat, 17 Jun 2023 09:13:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6LqY5Wf9FaG5P+SyLWThEV/+w581nqDDToSDW3GAOUuMFuPoptxdQkl8HmWw41eCdTW82zPQ==
X-Received: by 2002:a05:600c:378b:b0:3f8:d0e7:daed with SMTP id o11-20020a05600c378b00b003f8d0e7daedmr5307684wmr.19.1687018401997;
        Sat, 17 Jun 2023 09:13:21 -0700 (PDT)
Received: from localhost (2a01cb000f8b970084d0c0d672c3677c.ipv6.abo.wanadoo.fr. [2a01:cb00:f8b:9700:84d0:c0d6:72c3:677c])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b003f7f475c3bcsm12936700wmo.1.2023.06.17.09.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 09:13:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 17 Jun 2023 18:13:20 +0200
Message-Id: <CTF24276X8IG.39QXKZJJRLM12@ringo>
Subject: Re: [PATCH 0/5] x86/speculation: Disable IBRS when idle
Cc:     "Waiman Long" <longman@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H . Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org> 
        , Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
        <pawan.kumar.gupta@linux.intel.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
        <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
        Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
        Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider" 
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, "Joe Mario" <jmario@redhat.com>
From:   "Robin Jarry" <rjarry@redhat.com>
To:     "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc/0.15.2-49-gd17c48e2f3c0-dirty
References: <20230616200003.745742-1-longman@redhat.com>
 <CTECMFWMMST3.9FTWRDG7FFKQ@ringo>
 <20230617122115.GA1830050@hirez.programming.kicks-ass.net>
In-Reply-To: <20230617122115.GA1830050@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra, Jun 17, 2023 at 14:21:
> I can't see the patches -- they didn't arrive in my mailbox nor can I
> find them in the archive, in fact this here mail is the only evidence
> they exist at all.

I was also looking at them on the public archives but only found my own
reply. Maybe something got wrong with Red Hat internal SMTP.

