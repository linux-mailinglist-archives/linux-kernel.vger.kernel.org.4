Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4826C0EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCTK0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTK0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBD13D69
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679307948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FovOfEOpuOZL5itrLvWx74Ygi4oqdIMN2gegQwMT0Rw=;
        b=fSNF2jvT0YxRxLsAbvO26PXbnuuKpIbsZ41TMDHfGdNtGvN7fs0WRa+uir9FkwNCooG/rg
        ZOr/Xpchg74HZvIaQs4eAi3giCml/+HNsQpIk33lU7JNqj2NA4nMf9HL5QNOLr3UE3o66r
        SiwLHXxoLj0KLLzibqFn7QwmHv2WOV4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-Pd_zwJ4QOCmyZmotkFDZ2w-1; Mon, 20 Mar 2023 06:25:46 -0400
X-MC-Unique: Pd_zwJ4QOCmyZmotkFDZ2w-1
Received: by mail-wm1-f72.google.com with SMTP id p10-20020a05600c358a00b003edf7d484d4so787794wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307945;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FovOfEOpuOZL5itrLvWx74Ygi4oqdIMN2gegQwMT0Rw=;
        b=GAfT6IIo0kwozjXYVoLbJCsLJkXQrTVGQaFUmY3AfnZktZwGxxl9SMhcDrsioaqLqt
         FWmRNGPcjTauE0Sr48+cDmQsw5u6Hey07ViO32GHM3rm/bGsDeAi/RGw0qWV0yd+afG0
         ej5saTaD6ikpRo+PZpA+NAPMun0wsHeszut0s6myPlYxcZY5M+UcO/JfeuNC+C/bMJ3b
         y674n9I2kQPhTT+waXmy0BZIU8Lg5kDHOgRsljEJZnrpri1b4XDp5p/OJedlKyw2L3rI
         oFZqpl+QpxabK2HhJ0VTm/RTEneWAs+JbH2ZR0E5vE36URElrdU0dfdhMe5OXnqce7X+
         5E3Q==
X-Gm-Message-State: AO0yUKWFMqaLQQzlldnyqYZBTB12sgiNtYREqpU9cDLtDfu8wH2SUuMP
        z+yikTw4oWhRDC5nDQZnKi5UrHj3UNLhDl+MR55BYUvnP3Xip2TNNnvTBvLxuuXXEVGWZog8qoa
        uj5XmJoLBfiBg7yIp4ERyiIG0eCZ8izrL
X-Received: by 2002:a05:6000:14b:b0:2cb:9d29:7242 with SMTP id r11-20020a056000014b00b002cb9d297242mr12719406wrx.27.1679307945590;
        Mon, 20 Mar 2023 03:25:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set96fKEZIQf41YMG0JSWp35mbtllNHqd4n3a0BHrRb97FZpfKIOWiOEujkxHnE5Au6qgvaW8ew==
X-Received: by 2002:a05:6000:14b:b0:2cb:9d29:7242 with SMTP id r11-20020a056000014b00b002cb9d297242mr12719396wrx.27.1679307945295;
        Mon, 20 Mar 2023 03:25:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c22c100b003ede06f3178sm3967481wmg.31.2023.03.20.03.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:25:44 -0700 (PDT)
Message-ID: <4ab36009-51c0-6583-4948-b267f8fbf32a@redhat.com>
Date:   Mon, 20 Mar 2023 11:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/2] selftests/mm: Smoke test
 UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230309223711.823547-1-peterx@redhat.com>
 <20230309223711.823547-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230309223711.823547-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.23 23:37, Peter Xu wrote:
> Enable it by default on the stress test, and add some smoke tests for the
> pte markers on anonymous.

Would it make sense to make kernel support optional and test both paths 
-- once with the feature enabled (if available on the kernel we're 
testing) and once with the feature disabled?

-- 
Thanks,

David / dhildenb

