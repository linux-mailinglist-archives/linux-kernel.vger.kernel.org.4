Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330CE71A3C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjFAQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjFAQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2E186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685635553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xaF4LAIG2oh7wL99Qq3/230ZZVPiSunURcG7vN9wEJM=;
        b=KABWM3grHnlINgHy4yt65wruXh9kqxlc28Pund8/Q7DDhFi2TYljJadQMyLBvOQam4ghSl
        5yYPVlWl4k0sazeVSsLm4m8BlYCLyFm8F7A12SfXDSlq5tOjedTz3xOLQbl1YbZjoe+v9P
        eFAE5TXZdJsyh5utlcOAutqOf5/JN0g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Bp022dJnNxqRvvYjhAjQEA-1; Thu, 01 Jun 2023 12:05:51 -0400
X-MC-Unique: Bp022dJnNxqRvvYjhAjQEA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-96f6fee8123so71052366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635548; x=1688227548;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xaF4LAIG2oh7wL99Qq3/230ZZVPiSunURcG7vN9wEJM=;
        b=CqSCiwlfLXNPuEvtm9UMuZqEbV9f+H/pXcbDP8c6eT4Q8W89oRKVIgjZtNL60emo8l
         ttVt/d1bsDQAQ4g8Hpny+/ucT5IoxqPA0gNuph/JGm4r5Y/3pVrdlKmBJr71jtfyKiPB
         LKjEyG02WudKkKYL05sVG3RIhIJKgIxDD2AwACQKfw4IkpWkguNCHlGTm4z8yF1gws4m
         yFdaI32P0Nm2DB0MaIxlEysh/Da54ZwutUSDrOEV+PFYYm21r3Q0FUMsOOLkYoy2Hn4m
         l+CqoD4d5usVD+QG26YJD2rtLC/gxanBTE4pK/GnM+83rQ32Ly4Mo8dZaJ338PPuIWbu
         20QA==
X-Gm-Message-State: AC+VfDxG1phzv4QfyuXmckAOFORTXgvp6RTAQFDeNiQd58+SB83L2fU3
        +1ePHzEeTMpbrKJNLw798QifHSu4XSVe31QwzV/TB0SKSONyFIfanc631TuBjQG3hwjHdNxjav1
        qz0/kdjDMpC7BxX5YH/I/nUd5j29pIloceZm/TJ/X32yMUzBHxBMcqP9YbJEyWFgcZuR87jw2t5
        Z38hwZcS6NFA==
X-Received: by 2002:a17:907:da5:b0:973:ea41:3ef8 with SMTP id go37-20020a1709070da500b00973ea413ef8mr9118528ejc.35.1685635548354;
        Thu, 01 Jun 2023 09:05:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GEbYoaLH8nR2gIno0mTHMpUiTE8b+YcwJJ8T11rbucvlJZgqgJIYMM5a0gtgwd1t1ua/VlA==
X-Received: by 2002:a17:907:da5:b0:973:ea41:3ef8 with SMTP id go37-20020a1709070da500b00973ea413ef8mr9118493ejc.35.1685635548050;
        Thu, 01 Jun 2023 09:05:48 -0700 (PDT)
Received: from [192.168.0.224] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id la11-20020a170906ad8b00b00965f5d778e3sm10766381ejb.120.2023.06.01.09.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:05:42 -0700 (PDT)
Message-ID: <b20d1687-b808-2c63-d73d-c962456b3f56@redhat.com>
Date:   Thu, 1 Jun 2023 18:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCEMENT] Real-time Linux Summit 2023 at EOSS Prague
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Min Yu <myu@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Copperman, Elana (Mobileye)" <elana.copperman@mobileye.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Foundation Real-Time Linux (RTL) collaborative project
organizes the Real-Time Linux Summit at the Embedded Open Source
Summit 2023. The event is intended to gather developers and users
of Linux as a Real-Time Operating System. The main intent is to
provide room for discussion between developers, tooling experts,
and users, in a friendly environment.

The event will take place on June 26th afternoon.

Topics to be discussed include:

  - Debugging latencies with ftrace
  - Best practices of Linux on safety-critical systems
  - rtla timerlat auto-analysis
  - The famous Q&A with Thomas Gleixner

To learn more, visit the event Page [1]. Also, feel free to reach us out!

[1] https://events.linuxfoundation.org/embedded-open-source-summit/features/co-located-events/#real-time-linux-summit

-- Daniel

