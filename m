Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34A16DED16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDLH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDLH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28883138
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681286298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjQ1TJWbIPwilwTgfQ/RtAH10ukmLWPiORRxbKkLh3A=;
        b=ZNYsyT5tD5ciNAfytDiJZNeFoF4uDLDeO/FFvlCB9m6y9cKY/fXNfAGdQvoSDdbBVdgcOn
        caz9LFoJhk/quxZbFEqDZtlCFzUb2f09HLet05CFBubRbJszPndCeZqFOM8S1zOknNnygG
        Sk1/pLnxREBB6s0CkSH0YEo6dXqBd3M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ykc-yXxMPZWLK0l7iYrS1Q-1; Wed, 12 Apr 2023 03:58:17 -0400
X-MC-Unique: ykc-yXxMPZWLK0l7iYrS1Q-1
Received: by mail-wr1-f71.google.com with SMTP id j6-20020adfa546000000b002d58b4b7698so1581723wrb.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681286296; x=1683878296;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjQ1TJWbIPwilwTgfQ/RtAH10ukmLWPiORRxbKkLh3A=;
        b=K3M91erL4pjHEJQ9jJyXGebiOBw3s12e1PKW9Dijye3Z98avUfFfCLOnJtZ0S1t2jk
         bZqgVIcN1lP5EtS+hVY2W9atN4WoUvphZBRcgGXXZP8M/vQdoqtbmu701EGvptE59OGf
         R1l/L9KAU/xG1QmkLxMHeYUrpIZlqV6we/h5t2yZnFph3mMwm5PHotjn/zj3xYglOACZ
         jKVSs+ZHBKORSBDzeL43OeOlXZ1+dJKKa53Dx6mQqfARZkw0Qqyz+fOZ/UNmX/DxDNVY
         BaAo6Q9UB2aY/5Ur9Agk/KX0FJVVn5k5rLAovwfFbTJ17KW7UfiXS78CeHgeYrwBPXDY
         voyQ==
X-Gm-Message-State: AAQBX9fpwwEOk4sk11JoXPdCyWour8aREMjPYONiBp51WQZ8C2Avnk7/
        eSVqUQ1URjqh+nJggQbEnOMAT6RK30Z92zea76s4XYdCcBqWC6aLCivmsZ1pdyZ7YOfeaY4W5kG
        XGDMPHYvqoTDjEjih8obZMB3gdmneWaiR
X-Received: by 2002:adf:f28f:0:b0:2d1:9c50:5746 with SMTP id k15-20020adff28f000000b002d19c505746mr3807989wro.12.1681286296161;
        Wed, 12 Apr 2023 00:58:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350a8RtnbnqlJPtjhTYzbkGi+1dUdGHSmBOkt5INe/PdMi75idUMdVkOgACCGhJCtvZtIy+ZIYw==
X-Received: by 2002:adf:f28f:0:b0:2d1:9c50:5746 with SMTP id k15-20020adff28f000000b002d19c505746mr3807980wro.12.1681286295853;
        Wed, 12 Apr 2023 00:58:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id a15-20020a5d4d4f000000b002cfe685bfd6sm16548101wru.108.2023.04.12.00.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:58:15 -0700 (PDT)
Message-ID: <34202ae5-efee-9345-c3de-544304d1ebb4@redhat.com>
Date:   Wed, 12 Apr 2023 09:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RESEND] mm/vmscan: simplify shrink_node()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230411061757.12041-1-haifeng.xu@shopee.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230411061757.12041-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.23 08:17, Haifeng Xu wrote:
> The difference between sc->nr_reclaimed and nr_reclaimed is computed
> three times. Introduce a new variable to record the value, so it only
> needs to be computed once.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

