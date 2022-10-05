Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C205F532F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJELNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJELNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1AF58153
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664968401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4j6hFk+14cB0RrW5xvRDBfo+I3awEsUnodYOqlNbaXY=;
        b=hB4+/8y2nE7IUXoNzW+PDFPlOhcHtOIF1aajZceZt8pMG/vIPEiN/XgUs3HBp686D9HGvo
        cdUtllfdTTtFwHnrsU+ry9JOUUKSsv4FBuxvNcy0Xbn6r9YAa/VFcBkHHz43+mQy5nHzWi
        QtgMuw+igIRhtAU/EWsh62c6peb/qY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-30-JBiSdMaYOJmQeBGZLEd4RA-1; Wed, 05 Oct 2022 07:13:20 -0400
X-MC-Unique: JBiSdMaYOJmQeBGZLEd4RA-1
Received: by mail-wm1-f70.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so793432wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 04:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4j6hFk+14cB0RrW5xvRDBfo+I3awEsUnodYOqlNbaXY=;
        b=b//XFG6WIRxYzzWdpYswIC/3wtoDytWsLCFAPwIeF/rrpJnQ80RuJbwVaXBTdHoHms
         cGyVLh5in3eGQMZ8Th0vow7A7lS/+bed8EjfbkOhBSVXBHG91FPj3vMr4Ouge7VqwVfp
         0iV3Vlj6Z1ROXnRCr9umiYasKDKbb6LBNU3Ytw7j+t3/2kebVdqLsRw1mTvc0D/ZKXO2
         sDVxBT4EGWVhSFiBYec5UOjuIxStTEMRabfg1jEwUEjan/TeM/ZFhfCf9OHHvzGai6je
         AouFiASPickwnahPZoFQEz6KAY3e7efQ1oQQ9YjdtoEJWEhWDZaqyxSmVifANnpXF9zq
         9feQ==
X-Gm-Message-State: ACrzQf3OAt6b4J2hVBLKK8Smk0iBjcUcoE03ZE8xrew2wX2tQ3rjoid1
        AK7O1n7pZVcebfHVBUOdP/WiRP7GcUPfu7kuIpgHzhCR8Mt3qQMdYoADt0GQx52UlcB6SrJfWHN
        B2ujFBBAlTVZyLhJx1PYXciLE
X-Received: by 2002:a5d:6442:0:b0:22e:2c71:fdac with SMTP id d2-20020a5d6442000000b0022e2c71fdacmr12139390wrw.243.1664968399326;
        Wed, 05 Oct 2022 04:13:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM537zceMdjiIGb5BchXxVLco7NaLmYG+9gPd9tisY4R0/U1nN/mGLTijIaXh4JkjVyy0gskjQ==
X-Received: by 2002:a5d:6442:0:b0:22e:2c71:fdac with SMTP id d2-20020a5d6442000000b0022e2c71fdacmr12139377wrw.243.1664968399139;
        Wed, 05 Oct 2022 04:13:19 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d5148000000b0022e04bfa661sm13565402wrt.59.2022.10.05.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:13:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 4/4] workqueue: Unbind workers before sending them to
 exit()
In-Reply-To: <20221005010832.1934-1-hdanton@sina.com>
References: <20221004150521.822266-1-vschneid@redhat.com>
 <20221005010832.1934-1-hdanton@sina.com>
Date:   Wed, 05 Oct 2022 12:13:17 +0100
Message-ID: <xhsmhczb634mq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/22 09:08, Hillf Danton wrote:
> On 4 Oct 2022 16:05:21 +0100 Valentin Schneider <vschneid@redhat.com>
>> It has been reported that isolated CPUs can suffer from interference due to
>> per-CPU kworkers waking up just to die.
>>
>> A surge of workqueue activity during initial setup of a latency-sensitive
>> application (refresh_vm_stats() being one of the culprits) can cause extra
>> per-CPU kworkers to be spawned. Then, said latency-sensitive task can be
>> running merrily on an isolated CPU only to be interrupted sometime later by
>> a kworker marked for death (cf. IDLE_WORKER_TIMEOUT, 5 minutes after last
>> kworker activity).
>>
> Is tick stopped on the isolated CPU? If tick can hit it then it can accept
> more than exiting kworker.

From what I've seen in the scenarios where that happens, yes. The
pool->idle_timer gets queued from an isolated CPU and ends up on a
housekeeping CPU (cf. get_target_base()).


> Another option is exclude isolated CPUs from
> active CPUs because workqueue has other works to do than isolating CPUs.
>

With nohz_full on the cmdline, wq_unbound_cpumask already excludes isolated
CPU, but that doesn't apply to per-CPU kworkers. Or did you mean some other
mechanism?

>> Prevent this by affining kworkers to the wq_unbound_cpumask (which doesn't
>> contain isolated CPUs, cf. HK_TYPE_WQ) before waking them up after marking
>> them with WORKER_DIE.
>>

