Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2125FEEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJNNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJNNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6CC46DB9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665754814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97+yCsen+aZv3dzNcLFg5QyETWduzN4OK7Pj/5FTDqQ=;
        b=MWTxrli7/H07BBFXzfLebWGld62zCVqxiPfy9wgHV6YBf2bXQETJwaO8828gAQMtK2B1pI
        l7IiCMDkm/EUzb2XhAD598Rw1IwYpH8PBxcldCFU05YW2w8XDbfBPZxjqXD4HNvgEQo9xC
        cQOiSwg5Izyf04vI3ibdyHuxOUjefcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-kHqbliiBOVOIj1S1UXIo5g-1; Fri, 14 Oct 2022 09:40:13 -0400
X-MC-Unique: kHqbliiBOVOIj1S1UXIo5g-1
Received: by mail-wm1-f71.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso2199527wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97+yCsen+aZv3dzNcLFg5QyETWduzN4OK7Pj/5FTDqQ=;
        b=Gf9ApH212Jcj9Dyml7sryDYXcoQu3tkAMZXisvHLqFve+3QiyPMPOE5jtn0f9ASMHn
         gYHuzKzSmAeOHo2h+Rysys/HyXEFsNnOJ2mY+1rcci+JEy8gNQKlY8skQzX3LiqbFkfI
         UntyD1JRvjS302Txm/6cTCwRVVdLcskPcUpq4FaGGabopNU2rJ2uBFkjmTGDby/7C53V
         heMmyY0MMH2+5JU0frxHp2hmpirymC70wxWUTb3GwMsXXkJMyJiCaxTyDtBENhc5SEp6
         NRZ7yVJeEpV+eHr/iFbE2YMnafwPaKUDsG2PiQbAOf6eFAiYdGowRbpDuwHnbM17V8pJ
         2OuA==
X-Gm-Message-State: ACrzQf1zfT8Fff1nFGlgX6VsGL1xTdq/7+c+rdnKaF1GWpQC+yvd59SV
        RpxJkwvgeqk5ckS/ODcLAaZTy15sAiFR1Hy2anQeLl2PDdeTuwg/oSUMeo00o0Bf3Jkh/akqGSg
        VjlrwnBwheet1Vp5kJUMP57Zm
X-Received: by 2002:a05:6000:15ce:b0:230:a14d:997b with SMTP id y14-20020a05600015ce00b00230a14d997bmr3546836wry.370.1665754812066;
        Fri, 14 Oct 2022 06:40:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6P6KNGcmsIuEbmbLRw+AXx56k/GSatUv1GMsMmCBlacBtge5+MvT1KtuL8koG3QcJLq4g9eA==
X-Received: by 2002:a05:6000:15ce:b0:230:a14d:997b with SMTP id y14-20020a05600015ce00b00230a14d997bmr3546814wry.370.1665754811770;
        Fri, 14 Oct 2022 06:40:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8f00:9219:ab4c:826e:9646? (p200300cbc7048f009219ab4c826e9646.dip0.t-ipconnect.de. [2003:cb:c704:8f00:9219:ab4c:826e:9646])
        by smtp.gmail.com with ESMTPSA id y3-20020a7bcd83000000b003b492753826sm2038178wmj.43.2022.10.14.06.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 06:40:11 -0700 (PDT)
Message-ID: <7e6f2d09-e5cf-7f8d-965d-a39bfb0ea286@redhat.com>
Date:   Fri, 14 Oct 2022 15:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
 <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
 <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
 <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
 <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
 <5b1e0a13-8018-630d-d512-c3033db2f2e3@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5b1e0a13-8018-630d-d512-c3033db2f2e3@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> Other problem is that there are drivers that do not use
>>> adjust_managed_page_count().
>>
>> Which ones? Do we care?
> 
> VMWare and Virtio balloon drivers. I recently proposed to unify them and
> the objection was that it would break existing users - which is valid so
> we must care i guess.

I'm confused, I think we care about actual adjustment of the total pages 
available here, that we want to notify the system about. These 
approaches (vmware, virtio-balloon with deflate-on-oom) don't adjust 
totalpages, because the assumption is that we can get back the inflated 
memory any time we really need it automatically.

-- 
Thanks,

David / dhildenb

