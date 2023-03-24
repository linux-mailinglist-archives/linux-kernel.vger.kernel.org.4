Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6488C6C8232
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCXQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA8136DB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679674417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SZ/UgTQ/EPdrz/Txy99iCvW0qyOpe86roDGm7RsPj4A=;
        b=WIGaZ2drXgDaPVEDKlf8JVev0HcGmiqfZjaU0tFrWUE25mMTNltPtrfTx8vwX0e83Cw/y/
        jWjOIuDdEKK7a3gCSYjqpVxobNgHobMbSXPxvdstUK8ZZhstDO/eg0Fb6u0rin83dhJubz
        keT4yOjxSbkHnbNYfWpOZ3O1Qgks9XU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-ZP6qBUUZPYW7Hdf6qfw8og-1; Fri, 24 Mar 2023 12:13:36 -0400
X-MC-Unique: ZP6qBUUZPYW7Hdf6qfw8og-1
Received: by mail-ed1-f72.google.com with SMTP id f15-20020a50a6cf000000b0050050d2326aso3814005edc.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679674414;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZ/UgTQ/EPdrz/Txy99iCvW0qyOpe86roDGm7RsPj4A=;
        b=fxi+KmSFSGdYNcvvsvIM2c1BTWE2jZ7tnLD17WN0gg3SpeZjYeA/7Qj6xWjOd7kIy2
         BU+WQS8cUu7q9UXPbHCPPUxz3yr73iTldMa4xfWxTwR1HKapFALcNCyPeLRqeApFM3DH
         zuuQDhAy9ZocK4tVT6HPEKS/hAuVPSDiLImJJlmIXMDobvrQB8lR+N3MkcLvPGyhWsP/
         3pI2zGjXY/fvIPkS/aPEhm2INlE6NUW3T1bauwHEpUDpar2dcDlBKcWr/TODhhOSHLqA
         rPhcvMaa755ksoEXUOdirKaP9fRbvRgDuJIrHQwTCKURY+dS/GrMzorckJ1FvdzuPGkJ
         HVcA==
X-Gm-Message-State: AAQBX9diwRlHaBk4dZ7SBc6Kqy2MxJ0B1MxYHmHHuzt2lFVAiYncwpsF
        Zoa3BcBQO0Nx/FK6mrzNoxgdiZn7BGZxHg7Oitvgm+WnkKbHkheHpUG+EEaWFSsajTACZtpJN9m
        XxidP1O8bI50juPf2t4Y+j67/w93hvpTo
X-Received: by 2002:a17:906:174b:b0:929:7d80:3a37 with SMTP id d11-20020a170906174b00b009297d803a37mr3176506eje.37.1679674414109;
        Fri, 24 Mar 2023 09:13:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z3D+gQFDSt5EoI9IEb97lf2YRt6HhsL3ocTb4w5a8oRnkdtzkltb56R7XfNA57T78wyhUHYQ==
X-Received: by 2002:a17:906:174b:b0:929:7d80:3a37 with SMTP id d11-20020a170906174b00b009297d803a37mr3176491eje.37.1679674413867;
        Fri, 24 Mar 2023 09:13:33 -0700 (PDT)
Received: from [192.168.0.198] (host-87-3-200-174.retail.telecomitalia.it. [87.3.200.174])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090639d500b009332bb8b1f7sm9142319eje.66.2023.03.24.09.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:13:33 -0700 (PDT)
Message-ID: <ead16e4f-a05b-8b76-e1e6-52223effd6c5@redhat.com>
Date:   Fri, 24 Mar 2023 17:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Enable histograms for events/ftrace/timerlat and osnoise
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven

I would like to collect histograms from timerlat and osnoise tracers event,
but I cannot collect them because they are not tracepoints but... tracer
events. So...

  # ls /sys/kernel/tracing/events/ftrace/timerlat/
  format	hist

no hist, filter, trigger files...

How hard would it be to enable histograms to the ftrace/osnoise and
ftrace/timerlat events?

This will allow me to reduce the overhead of rtla timerlat and rtla osnoise
tools...

Thanks in advance, Stephen!
-- Denny

