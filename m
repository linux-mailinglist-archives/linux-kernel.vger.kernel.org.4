Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878596CA433
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjC0MiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjC0MiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84841E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679920636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwkLY4b4p76UXCTQe7OXiyXDn5gp03Jdta7HbcGMDWc=;
        b=KR2kTn0hqOabj4rsQobxXL5duP+fvpt9ETp9BLhkSZl+xIeqmCfYk1/sw54WJ9to1zaoEJ
        4yke4ocoCrc5DJGGwBprvnvDsEg7vxnf8FB+0K3/XthdBbB1wGfS6ZA3ZpUkKi+HhzDoMj
        MTqy/5kRTwglgLdvX6UZpe1nI4GJ9Kk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-MzcyhqhBP8uNE2c6mfeD2w-1; Mon, 27 Mar 2023 08:37:15 -0400
X-MC-Unique: MzcyhqhBP8uNE2c6mfeD2w-1
Received: by mail-ed1-f72.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so12249519edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679920634;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwkLY4b4p76UXCTQe7OXiyXDn5gp03Jdta7HbcGMDWc=;
        b=NpYOQ5FDgXIkot4ua2yZcWhbevzGAPpVZ2pDgqv1eQe+YwCpTxlOU4OVrq7MSfvAts
         o4kfpQosDEkETrnQG4coxPpC2OZIBhx70MhtJ4R4b7iCBga5/Mk1ypP3KvE+VrNfa1wy
         BbL37iJ+C+2KoRFgmv8JYNfgkVmaTuLXRlG5wi3HZx71Avw7W31bXFx2dvUBOH2uyyyk
         JOJ4m48URRhQjweb184wpQnvDqj3Ob10YveRyxtP2QO6AET0AadtXd0I7Gbka+U1SuP+
         GjUO0Vzd+LbxtUVs07zJH+QSlV+bT5tV/VkHKzAFjCI6IlqC3CfXu2f8sHGps0mm1dyf
         iwWw==
X-Gm-Message-State: AAQBX9egxoijqdBCM1KHi7RRSo45YEfXVMgJLcUsfGOcp/WSXd/dvxg2
        frUTLitA3l+U90sWXzNpqIzuA8earjRPXFlWeZTvdkpNEqUGevZj7CHcsBPsVxcRG1XokKM4yoL
        X7JfGjdcV3/DNXUai/ltOsmiX
X-Received: by 2002:a50:fb91:0:b0:502:2148:2980 with SMTP id e17-20020a50fb91000000b0050221482980mr9128501edq.30.1679920634194;
        Mon, 27 Mar 2023 05:37:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350aD/rtvoov+uwOeEV9k3kkiGYFSZdbxavDEcs2ocYYpNy0RL4Gfnxmoo1WdG+jwOFcpanm4hQ==
X-Received: by 2002:a50:fb91:0:b0:502:2148:2980 with SMTP id e17-20020a50fb91000000b0050221482980mr9128486edq.30.1679920633882;
        Mon, 27 Mar 2023 05:37:13 -0700 (PDT)
Received: from [192.168.0.198] (host-87-3-200-174.retail.telecomitalia.it. [87.3.200.174])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b004fe924d16cfsm14761513edj.31.2023.03.27.05.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 05:37:12 -0700 (PDT)
Message-ID: <9a1bb631-587c-9771-99b7-55623c67bb83@redhat.com>
Date:   Mon, 27 Mar 2023 14:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Enable histograms for events/ftrace/timerlat and osnoise
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ead16e4f-a05b-8b76-e1e6-52223effd6c5@redhat.com>
In-Reply-To: <ead16e4f-a05b-8b76-e1e6-52223effd6c5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 17:13, Daniel Bristot de Oliveira wrote:
> Hi Steven
> 
> I would like to collect histograms from timerlat and osnoise tracers event,
> but I cannot collect them because they are not tracepoints but... tracer
> events. So...
> 
>   # ls /sys/kernel/tracing/events/ftrace/timerlat/
>   format	hist
> 
> no hist, filter, trigger files...

Ooop, the hist file exists, what is missing is the trigger file, which is
used to enable the histogram...

it seems that the "limitation" is around TRACE_EVENT_FL_IGNORE_ENABLE flag, and
the fact that ftrace events cannot be enabled/disabled... 

but wait, as the hist file exist, is there any other way to enable
the histogram? (or should we disable hist files for !TRACE_EVENT_FL_IGNORE_ENABLE)?

am I missing something?

> How hard would it be to enable histograms to the ftrace/osnoise and
> ftrace/timerlat events?
> 
> This will allow me to reduce the overhead of rtla timerlat and rtla osnoise
> tools...
> 
> Thanks in advance, Stephen!
> -- Denny

