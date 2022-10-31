Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59816133D2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJaKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJaKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB3F64E5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667212772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwQbr9BdK0i32s4Jk8bFMXecnhJpNw7OYks3hEFf7dM=;
        b=b6s6QAIPaptlfaxMkwMmoV18TArR0/u1rrAamK6aUiTNhkY09Uqle1dpiZw4+UZYy8reRS
        8JHylP08CYmTJKsxF6irHBNBwASVzBoS622Q91B9sukBnBJbjz3MnExQsurP7UGllwYdON
        e0nQ/GRyGw9DjfOQfGtG//tuvzOozSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-D8qLeGk7OeK4wjxl2GGgjQ-1; Mon, 31 Oct 2022 06:39:31 -0400
X-MC-Unique: D8qLeGk7OeK4wjxl2GGgjQ-1
Received: by mail-wr1-f70.google.com with SMTP id s11-20020adfbc0b000000b0023659af24a8so2936630wrg.14
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwQbr9BdK0i32s4Jk8bFMXecnhJpNw7OYks3hEFf7dM=;
        b=KjazTaW6fHdSI1H4ffFuYpTxhnDEhPhubEigRQn2bGYW07lQBFXyD0u7wcoRP64hKv
         8Fpg6dsY+R+BcDdrhelkFVAQ8XLNSpXvF4DRXKbwyJI4rtCOwT9/eDaR/t4SeE6Hl/gt
         wLK8d8tgmns0VGqaUzKDpHlSLl954gIUhAYMDzd/OyzpA1lknSP+ybBEmFKfV7n6OPql
         akNkFJz0oCzPhgt3KJeaxciY6AMYgEOaIJWcmOnM4Fc4G4mN2l6Z8HC6+ocfB0jgpAFp
         Jm4EghErQw9VxwoyrvWemdOf5Z/MGP4TzuYFuLRiX7YibXx+hUA5Ly0yED/egRYCx5p2
         26zQ==
X-Gm-Message-State: ACrzQf2nH5e4/QqaDKzmRM310I7WnKHCuYp6iZnSWsPf8Lye4nzIhpYV
        Mct/t4L80S9J0c3IdeGX7bQ5ZjoB9oiIyoXonyxDTflJpNB839aTRv+EubYJJobmpw/dIotRwfa
        QFpFES5IyAzQ70KNyLhcPbggn
X-Received: by 2002:adf:a31c:0:b0:236:ba0d:246b with SMTP id c28-20020adfa31c000000b00236ba0d246bmr5590714wrb.448.1667212769845;
        Mon, 31 Oct 2022 03:39:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5cDFBtGcZeB1gnxp+nZotPX4x5k2Z8WuRl89Ims68z4R+CyOU6lbl0i2nXWjP4Ua0Rj6KynA==
X-Received: by 2002:adf:a31c:0:b0:236:ba0d:246b with SMTP id c28-20020adfa31c000000b00236ba0d246bmr5590694wrb.448.1667212769517;
        Mon, 31 Oct 2022 03:39:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d? (p200300cbc705b300ab9a1f1fddaf3b1d.dip0.t-ipconnect.de. [2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b003cf7292c553sm2202193wmq.13.2022.10.31.03.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 03:39:29 -0700 (PDT)
Message-ID: <68bf7829-0e63-de97-c8f1-4f516c67912a@redhat.com>
Date:   Mon, 31 Oct 2022 11:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 3/5] memblock tests: add bottom-up NUMA tests for
 memblock_alloc_exact_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1666203642.git.remckee0@gmail.com>
 <3ff61f3f8ae28082e5d28e469040216e707e6690.1666203643.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3ff61f3f8ae28082e5d28e469040216e707e6690.1666203643.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.22 20:34, Rebecca Mckeever wrote:
> Add tests for memblock_alloc_exact_nid_raw() where the simulated physical
> memory is set up with multiple NUMA nodes. Additionally, all of these
> tests set nid != NUMA_NO_NODE. These tests are run with a bottom-up
> allocation direction.
> 
> The tested scenarios are:
> 
> Range unrestricted:
> - region can be allocated in the specific node requested:
>        + there are no previously reserved regions
>        + the requested node is partially reserved but has enough space
> 
> Range restricted:
> - region can be allocated in the specific node requested after dropping
>    min_addr:
>        + range partially overlaps with two different nodes, where the
>          first node is the requested node
>        + range partially overlaps with two different nodes, where the
>          requested node ends before min_addr
>        + range overlaps with multiple nodes along node boundaries, and
>          the requested node ends before min_addr
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

