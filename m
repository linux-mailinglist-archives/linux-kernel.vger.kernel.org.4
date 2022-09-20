Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA95BDFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiITISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiITIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14496526D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663661706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZY1YavaFvCQO8tOgPzXe0UBwQkGNW34ROeeUBFifyI=;
        b=bnbXqrexHF6ZFVLwzCA5gNxmsOXcwWWvWfHVRVV2xdqU0DW+uOEKWiOJYrtHfrR5YTGUDD
        cT+LsqRHrt+gM53LUWPfloLjHaJ+evjOCwA7mnVHVxaLXHR9ZNEPr0WJNOUIrOpu+qv4HN
        0rL69Q49SFXAXm4jEy0patXHjSElXfw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-hSbfo87KMTaF3-PjgFBzJA-1; Tue, 20 Sep 2022 04:14:59 -0400
X-MC-Unique: hSbfo87KMTaF3-PjgFBzJA-1
Received: by mail-wr1-f70.google.com with SMTP id g19-20020adfa493000000b0022a2ee64216so832750wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=IZY1YavaFvCQO8tOgPzXe0UBwQkGNW34ROeeUBFifyI=;
        b=uN/bQ9LOIkWcYohUiLvCKwC6xkTxBL1KPXmDIUx1XF91MZz7G1fnqqLoyUYRIB7X+2
         xSQPBTIkEEIzRXD8Kng7LpHym76vwXGhPp9q/kEEwVb2qpVIF4tTvhMaWPTujuwuE61L
         elHD0xofnGxWZ+doMCK5sImSJ6X4BF+V4V852A2a0vJmzqT5C9m5xl5SuclO5AVmw+RX
         jfbhd66YBWMmyApJFKpqRoxrfhtzA9bpPevS68tX3d/L5EJqxHcb1Jyy9k03pTcw5H9h
         YfAPp+z+Xl/TzFKQN67IU5tl9NF+i6siVdBKjF6kvmmENmS+P4/YabM3KTpot6YYGRGT
         km3w==
X-Gm-Message-State: ACrzQf3Ia2LkFqGzEWslrdOrb+3zAWc1teOaEuQe/DIO6OAbVNBqvk6S
        9r1phtDVcbZn0Cz7kMNxse8EpQqikLEQLMTgyE/DV0G+NFz+nmwDKyKN4OLMFw3flQZ6gSfTGK8
        pqovrDPb2cMttCKgH6HV3YW9v
X-Received: by 2002:a05:600c:502c:b0:3a8:41e9:cd32 with SMTP id n44-20020a05600c502c00b003a841e9cd32mr1390986wmr.177.1663661698499;
        Tue, 20 Sep 2022 01:14:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66+NV0/AY2AzFAp6F92Em689IXLMoLrKqSW9fGLIpywepwzilF5sHgjwovliPmjN35Y1UA+w==
X-Received: by 2002:a05:600c:502c:b0:3a8:41e9:cd32 with SMTP id n44-20020a05600c502c00b003a841e9cd32mr1390961wmr.177.1663661698255;
        Tue, 20 Sep 2022 01:14:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b0022ac13aa98fsm889374wro.97.2022.09.20.01.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:14:57 -0700 (PDT)
Message-ID: <08572e43-5de6-9bca-54ab-1779aeb54c25@redhat.com>
Date:   Tue, 20 Sep 2022 10:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Akinobu Mita <akinobu.mita@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        corbet@lwn.net, osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
 <20220919172418.45257-2-akinobu.mita@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed
 value
In-Reply-To: <20220919172418.45257-2-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.22 19:24, Akinobu Mita wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), so we have to use a 64-bit value to write a
> negative value.
> 
> This adds DEFINE_SIMPLE_ATTRIBUTE_SIGNED for a signed value.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")

This patch itself isn't a fix. The fixes tags belong to the other 
patches that make use of this.

> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

