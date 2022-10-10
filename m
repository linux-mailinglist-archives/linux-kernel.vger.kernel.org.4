Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E15F9B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiJJJHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJJJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A434622E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665392866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBRPl8lSVuAs/tnWahBNmIErNUttoHAValk8cie4CaU=;
        b=Xy0/fC1gD8vq8RiSvVq9MC3cfFqfy4h8rOzSe72O6UaWzWu6DRbvTwPmcNbkD4geLAdxov
        YRoLMX25653lJd4zmF7decVJvDTEzBmsJtCTwoPnt8k8w7ur7X5KJx5Zud9MaUDB65CAn/
        Hl1ze2JXux3tXXmCjF09EqlL3dW9VYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-ABHp_HQ-NICTvnJj49VJXQ-1; Mon, 10 Oct 2022 05:07:44 -0400
X-MC-Unique: ABHp_HQ-NICTvnJj49VJXQ-1
Received: by mail-wm1-f69.google.com with SMTP id 2-20020a05600c268200b003c4290989e1so1406011wmt.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBRPl8lSVuAs/tnWahBNmIErNUttoHAValk8cie4CaU=;
        b=Oy1lNyv8qfDANr2U5Eauel8VOytD9jMbi3sTD+FWiOGLEAW7kgUUeeedZkHkmmyv6G
         w/lvH8iqF7F2hDv4pp2llDojhoanbA2+RrAPxCc7uf6IzArm1uhwemQai1jBKuT5r/Z0
         cyASi7rEBRhiZMstTg1Sc9s1nHb0b/HndA44avtCbu3G7j4OFpxHveYdTQoBkluyH7eK
         qbI74D8b56f66IeekT5jz9tOmOVBQj3KR9oj0tXVZ9o+pFP2I1yuP/QucpiwJ/9JrbW4
         i9peCtJS/TSs+ujFfVDx97e2ZvhBby1yJOz0OTkHX15gn0lvVsTKqKazp0xlTj5JrFn7
         bqTw==
X-Gm-Message-State: ACrzQf288GEtHSfLNYl6eVqX4ZY1HglcwxY0osqkM+QhIKDhL7esoiy/
        d0T/ZUvQg26PW9GO9xIALRNI9qHkjHEUMkxPOcWJh73AeueTQcyaf4BQPFmWB4SoEVcrnxVZRow
        vuNWVkdwC3mBE9waL+RlasJwr
X-Received: by 2002:a5d:4647:0:b0:22e:3608:aff5 with SMTP id j7-20020a5d4647000000b0022e3608aff5mr10491971wrs.162.1665392863052;
        Mon, 10 Oct 2022 02:07:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oAf6TPUVwfNyx0GF5hL2CYN/agKXaoeo93Eyy6JqVbwHMyHPDEMQBgQcAG4eHXjncUKJj4Q==
X-Received: by 2002:a5d:4647:0:b0:22e:3608:aff5 with SMTP id j7-20020a5d4647000000b0022e3608aff5mr10491948wrs.162.1665392862795;
        Mon, 10 Oct 2022 02:07:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:e600:3a4a:f000:b085:4839? (p200300cbc704e6003a4af000b0854839.dip0.t-ipconnect.de. [2003:cb:c704:e600:3a4a:f000:b085:4839])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b4c40378casm16568853wmb.39.2022.10.10.02.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:07:42 -0700 (PDT)
Message-ID: <c9d57f67-45d0-8356-76cc-bfd4eebbca2f@redhat.com>
Date:   Mon, 10 Oct 2022 11:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 5/5] memblock tests: remove completed TODO item
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1664753534.git.remckee0@gmail.com>
 <5df0bb56e4f32ae2734b7a74c65530d84012b4de.1664753535.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5df0bb56e4f32ae2734b7a74c65530d84012b4de.1664753535.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.22 01:41, Rebecca Mckeever wrote:
> Remove completed item from TODO list.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

