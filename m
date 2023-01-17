Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F666E240
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjAQPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAQPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057093FF3D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673969622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpLspA5PSonBw/vmV1OrZLpzelfm/8/OIBNoQk0pktg=;
        b=hNE1TdEODVWWcrs1HEKXztfpVRqkoVW2v1HY8bb/T4hs5J44YY4DnLtOzM7IEajEdffqDz
        UvTpGPDwJDiatSJTs4kNuIHESsjQU782KPKPr2AHoIWVTQkViqpL0UbH6+CiBqF587KeeN
        xrHJGcRsl5g5+4ea4FaLbqNgXnK5ZiE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-LCmo7bwSMB23qfbEPRx3rw-1; Tue, 17 Jan 2023 10:33:19 -0500
X-MC-Unique: LCmo7bwSMB23qfbEPRx3rw-1
Received: by mail-wm1-f69.google.com with SMTP id p1-20020a05600c1d8100b003daff82f5edso2305422wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpLspA5PSonBw/vmV1OrZLpzelfm/8/OIBNoQk0pktg=;
        b=RYOC2+nlVwpXSAiyKsf1+yEkW105X8SmvWzsJe+/haR6181Jms91IDTzzpMgpBSL4I
         joHaIVnSNzStPwolg6Q60Bp6CXuFrvu2XQyvO7M6ntse99a92d50WAsgCOkNjjiBs2lM
         zK7nXSfnl6yTbPVcwPZI+3U2c/Rus8e28xpr+gju73RC4bJquWpn7gBXjrvLx2YEUpCH
         sSwWloC1hwx9f+esmRAcTORfJ+wC4pQYWJ8vKz+mNno+e6JiPSyfbXWmHpMLG2PTff1p
         t5uHKTbNvrZ40imFEMNmzVs179A0JHv8ttdY35rQDF0f7NYoH5qEmL4laGY05ZLwSk7e
         L+nQ==
X-Gm-Message-State: AFqh2krdd1dCc4tdWyv27pUePlT9FfvfL6ZnNt2+F8SX9jb5I7t+JY8Q
        e81zauyMTfOlWNfoIVANAI+omniCMcOHtJg7XOYK8dmdxBfVIuqhueRDr5YnFinsqxRjgaKkAoS
        Van9tU/46T0VN1xWQdQnM1Pyr
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id g3-20020a05600c308300b003da0e4de6bamr3462881wmn.14.1673969584683;
        Tue, 17 Jan 2023 07:33:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCh6pUXHdET5pfuUv9PvBeMbDsI9H3dt7KkiP1Worcaf06CcwLqp9GwiSRlxDjBnrsjANXng==
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id g3-20020a05600c308300b003da0e4de6bamr3462862wmn.14.1673969584377;
        Tue, 17 Jan 2023 07:33:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:f00:323e:5956:8da1:9237? (p200300cbc7080f00323e59568da19237.dip0.t-ipconnect.de. [2003:cb:c708:f00:323e:5956:8da1:9237])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05600c3d8600b003d9df9e59c4sm34116110wmb.37.2023.01.17.07.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:33:03 -0800 (PST)
Message-ID: <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
Date:   Tue, 17 Jan 2023 16:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Cc:     "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>,
        "Sukadev Bhattiprolu (QUIC)" <quic_sukadev@quicinc.com>,
        "Srivatsa Vaddagiri (QUIC)" <quic_svaddagi@quicinc.com>,
        "Patrick Daly (QUIC)" <quic_pdaly@quicinc.com>
References: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
In-Reply-To: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.23 04:57, Sudarshan Rajagopalan wrote:
> Hello all,
> 

Hi,

I'll focus on the virtio-mem side of things :)

> We’re from the Linux memory team here at Qualcomm. We are currently
> devising a VM memory resizing feature where we dynamically inflate or
> deflate the Linux VM based on ongoing memory demands in the VM. We
> wanted to propose few details about this userspace daemon in form of RFC
> and wanted to know the upstream’s opinion. Here are few details –

I'd avoid using the terminology of inflating/deflating VM memory when 
talking about virtio-mem. Just call it "dynamically resizing VM memory". 
virtio-mem is one way of doing it using memory devices.

Inflation/deflation, in contrast, reminds one of a traditional balloon 
driver, along the lines of virtio-balloon.

> 
> 1. This will be a native userspace daemon that will be running only in
> the Linux VM which will use virtio-mem driver that uses memory hotplug
> to add/remove memory. The VM (aka Secondary VM, SVM) will request for
> memory from the host which is Primary VM, PVM via the backend hypervisor
> which takes care of cross-VM communication.
> 
> 2. This will be guest driver. This daemon will use PSI mechanism to
> monitor memory pressure to keep track of memory demands in the system.
> It will register to few memory pressure events and make an educated
> guess on when demand for memory in system is increasing.

Is that running in the primary or the secondary VM?

> 
> 3. Currently, min PSI window size is 500ms, so PSI monitor sampling
> period will be 50ms. In order to get quick response time from PSI, we’ve
> reduced the min window size to 50ms so that as small as 5ms increase in
> memory pressure can be reported to userspace by PSI.
> 
> /* PSI trigger definitions */
> -#define WINDOW_MIN_US 500000   /* Min window size is 500ms */
> +#define WINDOW_MIN_US 50000    /* Min window size is 50ms */
> 
> 4. Detecting increase in memory demand – when a certain usecase starts
> in VM that does memory allocations, it will stall causing PSI mechanism
> to generate a memory pressure event to userspace. To simply put, when
> pressure increases certain set threshold, it can make educated guess
> that a memory requiring usecase has ran and VM system needs memory to be
> added.
> 
> 5. Detecting decrease in memory pressure – the reverse part where we
> give back memory to PVM when memory is no longer needed is bit tricky.
> We look for pressure decay and see if PSI averages (avg10, avg60,
> avg300) go down, and along with other memory stats (such as free memory
> etc) we make an educated guess that usecase has ended and memory has
> been free’ed by the usecase, and this memory can be given back to PVM
> when its no longer needed.
> 
> 6. I’m skimming much on the logic and intelligence but the daemon relies
> on PSI mechanism to know when memory demand is going up and down, and
> communicates with virtio-mem driver for hot-plugging/unplugging memory.

For now, the hypervisor is in charge of triggering a virtio-mem device 
resize request. Will the Linux VM expose a virtio-mem device to the SVM 
and request to resize the SVM memory via that virtio-mem device?

> We also factor in the latency involved with roundtrips between SVM<->PVM
> so we size the memory chuck that needs to be plugged-in accordingly.
> 
> 7. The whole purpose of daemon using PSI mechanism is to make this si
> guest driven rather than host driven, which currently is the case mostly
> with virtio-mem users. The memory pressure and usage monitoring happens
> inside the SVM and the SVM makes the decisions to request for memory
> from PVM. This avoids any intervention such as admin in PVM to monitor
> and control the knobs. We have also set max limit of how much SVMs can
> grow interms of memory, so that a rouge VM would not abuse this scheme.

Something I envisioned at some point is to
1) Have a virtio-mem guest driver to request a size change. The
    hypervisor will react accordingly by adjusting the requested size.

    Such a driver<->device request could be communicated via any other
    communication mechanism to the hypervisor, but it already came up a
    couple of times to do it via the virtio-mem protocol directly.

2) Configure the hypervisor to have a lower/upper range. Within that
    range, resize requests by the driver can be granted. The current
    values of these properties can be exposed via the device to the
    driver as well.

Is that what you also proposing here? If so, great.

> 
> This daemon is currently in just Beta stage now and we have basic
> functionality running. We are yet to add more flesh to this scheme to

Good to hear that the basics are running with virtio-mem (I assume :) ).

> make sure any potential risks or security concerns are taken care as well.

It would be great to draw/explain the architecture in more detail.

-- 
Thanks,

David / dhildenb

