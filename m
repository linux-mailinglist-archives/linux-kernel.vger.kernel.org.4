Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71666136C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiJaMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiJaMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23667673
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667220166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wDzFFCX7T53AVS+iS04+j76XbFvyz6+QHrgDDxDK7A=;
        b=bIo9beT/Voxh886N+P9usdbfS5IsUxOuZSPkgtWq8O0r54rx7TcBIiqhXaheaLyIcMCUKS
        XCYNLH1Z1ya1zC2r9muGyFgpQJdTwPtCBGPq/pGJhN9o2tomojq9+AqYq9FPPt0STLaY69
        J34KnxTl4iiV5F/fYlvTajyIPOUcq8A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-mxOfnPbFOyW-8-_qR-zv8g-1; Mon, 31 Oct 2022 08:42:44 -0400
X-MC-Unique: mxOfnPbFOyW-8-_qR-zv8g-1
Received: by mail-wm1-f72.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso2567158wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wDzFFCX7T53AVS+iS04+j76XbFvyz6+QHrgDDxDK7A=;
        b=LxYvfFyDkekvxOcfiT7AzHxQh9mlICYywlFFd5IPOoM6rfKoq+y3Ek7zip13hZbB1O
         CddeV9Sg5GGCYBHw8KBLlxvU3FtDNifqWVgvzYhM0SkiXGQOZwpPk9cnY40j6yTSFaXm
         kU6+f06bp8W02LNyxO6j63dd7whQ17s/Lb5qLfBn36xZhrl6CY8YDEhfGch5czgEjPru
         tLnT6TilS+5iKFozLDeWp2g6sl4RZJU72p2kl9Tqn/yNW2YvnFrE1ML048xMPLh+eWod
         kY9d0zFfWsEkkaAjkdH4GosciXDI7R9Bvf9VPTCUnuALAySprVzEIuTr0o4UdhT6JkbN
         vEkA==
X-Gm-Message-State: ACrzQf3qCyue4+Pn/TQhutMH/q0i7z6Fok4sNPlIzMkcncA0RMHWqi/2
        1IRD75OSrPDRXyTclmc0mLCuYOIRYiGY3uuG2jk/sby1OwoFSpFhy7nlC9mBRAZMZzFDIMctrDt
        Os8bPx5xKB4Bi3ThJRhHFhQzy
X-Received: by 2002:adf:e196:0:b0:236:740f:f234 with SMTP id az22-20020adfe196000000b00236740ff234mr8016262wrb.518.1667220163232;
        Mon, 31 Oct 2022 05:42:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4vyJJNUOEecPJDnCq4lzj4NoVTRhfPhVGMJVfMry+82FAMpSstoJIr9mqo8PZRfvMyTSo4sQ==
X-Received: by 2002:adf:e196:0:b0:236:740f:f234 with SMTP id az22-20020adfe196000000b00236740ff234mr8016254wrb.518.1667220162966;
        Mon, 31 Oct 2022 05:42:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d? (p200300cbc705b300ab9a1f1fddaf3b1d.dip0.t-ipconnect.de. [2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d])
        by smtp.gmail.com with ESMTPSA id ay19-20020a5d6f13000000b00236b2804d79sm7194145wrb.2.2022.10.31.05.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:42:42 -0700 (PDT)
Message-ID: <22a8dc6e-2955-9b5e-7b9b-5f31625fe057@redhat.com>
Date:   Mon, 31 Oct 2022 13:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 4/5] memblock tests: add generic NUMA tests for
 memblock_alloc_exact_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1666203642.git.remckee0@gmail.com>
 <44611cd9c0939cdf2e3f232298b547efee4d772a.1666203644.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <44611cd9c0939cdf2e3f232298b547efee4d772a.1666203644.git.remckee0@gmail.com>
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
> memory is set up with multiple NUMA nodes. Additionally, all but one of
> these tests set nid != NUMA_NO_NODE. All tests are run for both top-down
> and bottom-up allocation directions.
> 
> The tested scenarios are:
> 
> Range unrestricted:
> - region cannot be allocated:
>        + there are no previously reserved regions, but requested node is
>          too small
>        + the requested node is fully reserved
>        + the requested node is partially reserved and does not have
>          enough space
>        + none of the nodes have enough memory to allocate the region
> 
> Range restricted:
> - region can be allocated in the specific node requested without
>    dropping min_addr:
>        + the range fully overlaps with the node, and there are adjacent
>          reserved regions
> - region cannot be allocated:
>        + range partially overlaps with two different nodes, where the
>          second node is the requested node
>        + range overlaps with multiple nodes along node boundaries, and
>          the requested node starts after max_addr
>        + nid is set to NUMA_NO_NODE and the total range can fit the
>          region, but the range is split between two nodes and everything
>          else is reserved
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

