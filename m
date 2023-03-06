Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BA6AC1D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCFNu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCFNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B02D6F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678110577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cP7M7fJa+CiXjUaB/Z/GeLdvX1vVsRhtfliOYgNW40=;
        b=RQdyC697M75posHTSa8s4Mf6VkQx/1sZ85SPOh/opPAOyvPMtf8iRyjNXmePg2/eGx5wIV
        /l8PhJZR8+iimOmrlUk3QrjWKpH+IL3V75LDS7tMIMQ21Mo4EKsmhVQfsazD78vlj2yZTC
        kMouzEj7tR4rVCpAvCTSnx7gdtCYlg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-W-_i396-MNaxrssePkJW2A-1; Mon, 06 Mar 2023 08:49:36 -0500
X-MC-Unique: W-_i396-MNaxrssePkJW2A-1
Received: by mail-wm1-f69.google.com with SMTP id e22-20020a05600c219600b003e000facbb1so6761131wme.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110575;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cP7M7fJa+CiXjUaB/Z/GeLdvX1vVsRhtfliOYgNW40=;
        b=lEJburE1H9xob8y/nomV7iLl6JTkOxKGK29A4WwB3Jb4gJF16t9RteJYpzn7zs245m
         OFPBbrrEMNAKByYlIKCa/rKv0F0WKAGIm3j+H4Pn2uu1bPzMvSEcNraPwHMxcRB7uKsK
         o+Tz1Kkpy2S5giisF8nWBiGEUqDuHz1n4V3Jo/MSxg4w5gWGmIWblSDWYf8H/z1kav6M
         Xt3UD77ZQG7gBJwoTpyp+BN4oFzEu5t1XvHjMiL26jiBoby79k6FXjglOCmqfgV5nymY
         7/xav0uK8QTDisvdpMg0qm0IlISflARbvI8/uADfryvPkVLPio8BWayHE8dSs/ZYL6Qa
         TBow==
X-Gm-Message-State: AO0yUKWMT4DixsTifbNMUiHE2lRTH8vWpDE+UziUXrgEZvqdrVT+x+Fh
        zPU8FsfFHyjlaq1GAo1HA2U7kiqXxcHmPKGtiAPY7G8sL4wx/A0XdD/CkTMB3bavfLp4oMA6tq8
        Fs0tBpbE6XrGayMtBnPtddCE9
X-Received: by 2002:a05:600c:a05:b0:3dc:42d2:aee4 with SMTP id z5-20020a05600c0a0500b003dc42d2aee4mr8471198wmp.25.1678110575712;
        Mon, 06 Mar 2023 05:49:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/V0qYAHNZZr8AnPKR/CcJ+o9o9/kovvogYCJVbCzpbcLU9tlAyaT2cAzLtC+FSfpsmzbHjqQ==
X-Received: by 2002:a05:600c:a05:b0:3dc:42d2:aee4 with SMTP id z5-20020a05600c0a0500b003dc42d2aee4mr8471179wmp.25.1678110575407;
        Mon, 06 Mar 2023 05:49:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id z1-20020adff1c1000000b002c70c99db74sm9950215wro.86.2023.03.06.05.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 05:49:35 -0800 (PST)
Message-ID: <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
Date:   Mon, 6 Mar 2023 14:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230306024959.131468-1-haifeng.xu@shopee.com>
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

On 06.03.23 03:49, Haifeng Xu wrote:
> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
> set or not, so remove the check in handle_mm_fault().

"mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom 
is not set, so remove the check from handle_mm_fault()".

However, that requires now always an indirect function call -- do we 
care about dropping that optimization?


-- 
Thanks,

David / dhildenb

