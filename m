Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20D6136CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJaMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiJaMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13234FD03
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667220229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NU6w0Zq7bJpYRDIr2hMwDV/4fb9dExLwNxcTsilt98=;
        b=Xg7EsVsyWuhUiYnf8Ax/RPPCRHu5IjF+OJ85qj5GTh3oqGG43BzZZAA55lJpClWpN6omjd
        ue8dpeyjf03K4W4+Y1OM0PB/r9uotOmblN+1Zm8iH+0ZcTE50ZjhmtVZV9M1hyZK66u4hM
        g2+ny/qNTXo/s3WmsZYyqc+JRhE0t2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-0DzCghNAMwyTJjr_uIfXyw-1; Mon, 31 Oct 2022 08:43:47 -0400
X-MC-Unique: 0DzCghNAMwyTJjr_uIfXyw-1
Received: by mail-wm1-f69.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso2567990wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NU6w0Zq7bJpYRDIr2hMwDV/4fb9dExLwNxcTsilt98=;
        b=d03saW8H4O4XmX5jlX0J6/0ur02/dzcumQgh25d/Dq0xfTWa021/DU/juBNLosjBQf
         ejQ0W+oGZiurtg2I1rIOIO/YEsmMX9Ignl43BzEkRp38uXhpFORciA5fb570OQESm2XE
         Zcds3Qhp7VqwplFcRRp2Mt2PMX87kb+K4SsNupVwDNEiXED4Y2PHGSAQeY3FiFJFGyge
         amYIvI0Jahw+s0S1yZJn2h2wXsmzuOkOI/zdH9N/+w+TQbHv2FiDTbh3kBrOnffT/M/r
         tqz/Isky/13Ln+ALhp7tBnuEa/JyjUhPVTf/NNOcle23VtbZvDq3P3aymVQSoOvU8WFp
         /yGg==
X-Gm-Message-State: ACrzQf0F6svBxTbv3cAP+Scqmf80UxCtd23EaTXPROoRedbPR8LZp9JV
        Og083hGNhRf58VjoF+pJ/oEb0CgIUtrZJUZkcxemK9rPeeKddL3OABU71LiTTIm8MSkEh2G9JHx
        DQ5MLhRFm+e5435/UQ0aQSqSV
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id u12-20020a05600c19cc00b003c6fbb9caabmr18061207wmq.182.1667220226529;
        Mon, 31 Oct 2022 05:43:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM55t4jw876dVQ2fTQwaKIB+9L/V0hADp4V2uq5ADgTD93s52dR/eW9qPadDJ0TvoYHO+DuySQ==
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id u12-20020a05600c19cc00b003c6fbb9caabmr18061191wmq.182.1667220226267;
        Mon, 31 Oct 2022 05:43:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d? (p200300cbc705b300ab9a1f1fddaf3b1d.dip0.t-ipconnect.de. [2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0022b315b4649sm7025952wru.26.2022.10.31.05.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:43:45 -0700 (PDT)
Message-ID: <6bd3d2df-8a21-40df-08c3-e9eaaa5000fe@redhat.com>
Date:   Mon, 31 Oct 2022 13:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 0/5] memblock tests: add tests for
 memblock_alloc_exact_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1666203642.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1666203642.git.remckee0@gmail.com>
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
> These patches add tests for memblock_alloc_exact_nid_raw(). There are two
> sets of tests: range tests and NUMA tests. The range tests use a normal
> (i.e., UMA) simulated physical memory and set the nid to NUMA_NO_NODE. The
> NUMA tests use a simulated physical memory that is set up with multiple
> NUMA nodes. Additionally, most of the NUMA tests set nid != NUMA_NO_NODE.
> 
> For the range tests, the TEST_F_EXACT flag is used to run the same set of
> range tests used for memblock_alloc_try_nid_raw(). The NUMA tests have the
> same setup as the corresponding test for memblock_alloc_try_nid_raw(), but
> several of the memblock_alloc_exact_nid_raw() tests fail to allocate
> memory in setups where the memblock_alloc_try_nid_raw() test would
> allocate memory. Also, some memblock_alloc_exact_nid_raw() tests drop the
> lower limit of the requested range in order to allocate within the
> requested node, but the same setup in a memblock_alloc_try_nid_raw() test
> allocates within the requested range.

Thanks a lot Rebecca for moving forward with these changes even after 
your Outreachy internship ended!

-- 
Thanks,

David / dhildenb

