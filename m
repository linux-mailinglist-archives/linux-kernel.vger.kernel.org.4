Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC69A6133BF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJaKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJaKhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFBAC77F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667212609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+yJAhJlKIwyVObb3U5f1g0DHLdpQkw0AnrikR08iAw=;
        b=U4YM5+DGpVSIqfnwmcM1H4J+z1Poh0inU8lv8isKLGEAgya/LbmjuV/tQiMLj0y79g23PF
        Beh5nwP8rTL1q94jVYKejRMDwBB21oTVplBvwN1Xqu4bUOZ6tvJOlKNfhgfpYe87YCrMQy
        jBFSQ3pIbo2VP4QOVb0uWYwSD/eims8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-F5QYUk7mNhWuVlMY4LrhyQ-1; Mon, 31 Oct 2022 06:36:48 -0400
X-MC-Unique: F5QYUk7mNhWuVlMY4LrhyQ-1
Received: by mail-wr1-f71.google.com with SMTP id m24-20020adfa3d8000000b00236774fd74aso2901583wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+yJAhJlKIwyVObb3U5f1g0DHLdpQkw0AnrikR08iAw=;
        b=Vzs0gNQ+7gRE3wQD9ImaImCnLpC8An+71jdG7MDiO5AC/2ErVtFOlmKwPoF8P0bhPS
         unX2ZA/ijm//aT4Gb5xu20tBOzyTvv2EiPuOc86SWWwCJzsNH8P4TVPCIeQgkPvlJ4wI
         mQ8jZfwTHQO9r1ICYbqzEtiwf7elPj97AZ1ZWTNwwjiDtMvlRDqLw09V4tDd8LbfGMkl
         Zt2DWlhkcMSm3OfkNDVsy/gMcCmif/6nVfIDEqufe8aL8WLAK15ws4DojT0TPD0qJEXI
         6MzAsiMEKHfkT8oPqBZ3JoKdYA9aztppX2uPN+UYvyvcuwRkiN1HJUereHpqc58CETvf
         43Tg==
X-Gm-Message-State: ACrzQf1gkIBK/y7AEF4mDt7Fd4ABVO7UPH/haO5WrB8VdWs32K4vwJx5
        wFQtPf0xc97akKkvZA4TKy/V2GE5ufI15e8dN2+iWRhiVef+RpPfi6FL2Ny+YCi8PhxuW3pY1vj
        HaXkp3wN9OuSibK81VsV7byWt
X-Received: by 2002:a5d:498f:0:b0:236:55e9:6c16 with SMTP id r15-20020a5d498f000000b0023655e96c16mr7720329wrq.331.1667212607245;
        Mon, 31 Oct 2022 03:36:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4fWxZ8BrrJ+vmNkW0YIEyt96wS3ci6OrS8H1P0VFZX+HDXkI4lCRe5RGwRESBJ8B+kgY/IZw==
X-Received: by 2002:a5d:498f:0:b0:236:55e9:6c16 with SMTP id r15-20020a5d498f000000b0023655e96c16mr7720311wrq.331.1667212606927;
        Mon, 31 Oct 2022 03:36:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d? (p200300cbc705b300ab9a1f1fddaf3b1d.dip0.t-ipconnect.de. [2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d])
        by smtp.gmail.com with ESMTPSA id e7-20020adff347000000b00226dba960b4sm6797609wrp.3.2022.10.31.03.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 03:36:46 -0700 (PDT)
Message-ID: <c9a2f7a6-f121-8cf0-4624-b02deccdaead@redhat.com>
Date:   Mon, 31 Oct 2022 11:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1666203642.git.remckee0@gmail.com>
 <cf1f686743ff8f1da9618088b7f0ea0ba4ebaecb.1666203643.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/5] memblock tests: add top-down NUMA tests for
 memblock_alloc_exact_nid_raw
In-Reply-To: <cf1f686743ff8f1da9618088b7f0ea0ba4ebaecb.1666203643.git.remckee0@gmail.com>
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
> tests set nid != NUMA_NO_NODE. These tests are run with a top-down
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

