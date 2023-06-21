Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D7737DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFUIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B5BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687335890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUccefOuSwG5NnSN4ddLna/NjIQ7wL0BEwFtqmuNSfE=;
        b=XEiPlw5rCfU7gHm4NE9NZpGHl+osbHL1dsRnupQeTNv5/oZPtnAfYBRv/3z1WtwTYJILoe
        gjwMlWd7c7cjQfRTdu7HFEFfDQbpMyq2auFE4GBswlhHSySLv8U5Z0P+AAoQotICyHzTOW
        hRIMEIsTC40gPdrHEFaQYX9SCr3zVXE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Ed0Fh2SCOY6uEcNi_fYlzQ-1; Wed, 21 Jun 2023 04:24:48 -0400
X-MC-Unique: Ed0Fh2SCOY6uEcNi_fYlzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9456dd899so18909035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335887; x=1689927887;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUccefOuSwG5NnSN4ddLna/NjIQ7wL0BEwFtqmuNSfE=;
        b=Kv0K1bMgaEgH9JsCyrD8cEOwOvkK/cJyru3malM8+BTEwhFgi/KiXx8iwAwuVozdke
         1dJGC+8NduivFsgyLq4bh8DdTh1wLva+xq5hg+MNqZ41Tr2AWVr7HG9VUHLx+oDaU383
         zxFOEXlASi3cSTVhU6oL3yW5VFjHP4xO/kA4M4WalrbTQJTlL3Gyp+Bt7kVh6OMfuadf
         CbTrszEya74gC7/xlPbsOvGYzv/2dIBl0n6m1YBd1/y5Ixm7VxeNqUoOHoF8dTsHo4U3
         V05GkojH6YmqngcU/AfFQcCU0dUdAlY/1741BzdSfQ3XTi/QsrIoSsl9DK/hEWqjC5Wo
         tR7w==
X-Gm-Message-State: AC+VfDwsTtFvcaSHav6wuCgpNJQlJt18v3+CAwebaxryGkaGti/ge5pe
        UL+tzp7OmfEaT7psr5nBu7c/8tHFm2tBPfM/+7WIHib/nqhJCFWwvq0AZZgBQ+1WhLKveI6JKN8
        NJ+8t8qYXV7eNf8aWPHiTCtwZsf/+u8vK
X-Received: by 2002:a5d:6a4b:0:b0:311:f8f:64da with SMTP id t11-20020a5d6a4b000000b003110f8f64damr13842454wrw.12.1687335887398;
        Wed, 21 Jun 2023 01:24:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ntl5FD/2rvVaTufr6bnzeX+WCLFXklw1uXom0fMAPZuQ+RRkStwBK9UEGiLvc2Cg5gAQZcg==
X-Received: by 2002:a5d:6a4b:0:b0:311:f8f:64da with SMTP id t11-20020a5d6a4b000000b003110f8f64damr13842438wrw.12.1687335887040;
        Wed, 21 Jun 2023 01:24:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef? (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de. [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
        by smtp.gmail.com with ESMTPSA id f2-20020a056000128200b003062c0ef959sm3824392wrx.69.2023.06.21.01.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:24:46 -0700 (PDT)
Message-ID: <c3c6e8bf-e8cd-7e33-5193-c1f78b8bbef4@redhat.com>
Date:   Wed, 21 Jun 2023 10:24:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/memory_hotplug.c: don't fail hot unplug quite so
 eagerly
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20230620011719.155379-1-jhubbard@nvidia.com>
 <ed83df65-f785-7077-ddd0-4e53d6fa6056@redhat.com>
 <80e01fa9-28c0-37e8-57f8-5bb4ce9a9db7@nvidia.com>
 <83689f25-ca50-7ece-45f0-a936e704df7d@redhat.com>
Organization: Red Hat
In-Reply-To: <83689f25-ca50-7ece-45f0-a936e704df7d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> 
> There is still arch/powerpc/platforms/pseries/hotplug-memory.c that calls
> device_offline() and would fail on signals (not sure if relevant, like for virtio-mem it
> shouldn't be that relevant).

Oh, and of course the ACPI-triggered device_offline().

-- 
Cheers,

David / dhildenb

