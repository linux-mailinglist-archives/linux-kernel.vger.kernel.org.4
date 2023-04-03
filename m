Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F46D3E77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDCHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjDCHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D83E6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqywKGaZP1hghCygKvoVHuVg30WO/VF5yVgd/DhHO60=;
        b=BPQSaRHOkKSrkVZ29wuBqwHLjtQ/NTbQggftpEGu7NtYv4edp0QrdkJ9KSEQUUC6fHZGzT
        HeTGU23hqLYJpO+i09Dm00Gmt275KyYM21Dydz3B/rxsxXcBUGTdvyTcNCnFro9KyVf+3P
        sW3Z+BXpclC6mrhhQS5dB3w+dwOnKPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-c3GQac22MzuxEXiQaVRoyg-1; Mon, 03 Apr 2023 03:53:51 -0400
X-MC-Unique: c3GQac22MzuxEXiQaVRoyg-1
Received: by mail-wm1-f70.google.com with SMTP id m7-20020a05600c4f4700b003ee7e120bdfso14118697wmq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508430;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqywKGaZP1hghCygKvoVHuVg30WO/VF5yVgd/DhHO60=;
        b=I6gbGGm8QyaHxHnzHLvkVxwRsRchJ3YuqY4aWmSwPJDulZC/CF4vaGFp7d4PvmqdSa
         5+44kuOPUBzyJFHmpTqwoD6y4a76onz3wmQptizkkQO/cf2lv6bFwDNKG2aiETb2Um8q
         Ud/7FVyscmaU01V6jN2L9XorZVBTpFw68L1eCAMwp/GPA2Bvq5avxr4iMvsFrYg23GHZ
         irxefRB30uHQsjmORPwPVa/z6cZn45ltuZCP3yPzi18RcDSGYmgbPBh5tRBdtY2IM4su
         ZqqHuCE/UKl1BNpawk+mOYIj6NRtR3NahnzqOAK+ITRTpKkdjwhvqkopsiy4bxMzLHVo
         4pew==
X-Gm-Message-State: AAQBX9f4pTVSh5Iep27pObK2d+7/ZFuscHI7Py5FGP9le0sRV+v46p6d
        oxqP9Jyj8NoY50foMWX+oaTo/qNv97z/kZbi9WXWAZw0sY0tZFwksFuyxtRQrLgckgSy4RLJJkv
        1QRpxnjbZl736zRf5DnfjHyrZ
X-Received: by 2002:adf:f4d2:0:b0:2d4:a2c5:9f80 with SMTP id h18-20020adff4d2000000b002d4a2c59f80mr26883429wrp.23.1680508430177;
        Mon, 03 Apr 2023 00:53:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350al+Hdh1mZBqFbtrje/j/H7CDtkWdiOKBlNX7DXp4s3eab9/g7cYefIJ2g4a6++xptVNfuNIQ==
X-Received: by 2002:adf:f4d2:0:b0:2d4:a2c5:9f80 with SMTP id h18-20020adff4d2000000b002d4a2c59f80mr26883406wrp.23.1680508429848;
        Mon, 03 Apr 2023 00:53:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id y11-20020adfd08b000000b002c55b0e6ef1sm9140684wrh.4.2023.04.03.00.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:53:49 -0700 (PDT)
Message-ID: <427e10fa-b58a-8afa-4db9-9f8321803fba@redhat.com>
Date:   Mon, 3 Apr 2023 09:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/29] selftests/mm: Use PM_* macros in vm_utils.h
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160708.3106977-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160708.3106977-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:07, Peter Xu wrote:
> We've got the macros in uffd-stress.c, move it over and use it in
> vm_util.h.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

