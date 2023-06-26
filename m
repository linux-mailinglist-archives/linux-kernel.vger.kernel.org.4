Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CAD73D940
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFZILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFZILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826E52101
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687767030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5RgipMs2QNRwrDwP1+AYISiKEXaCi8Y3rMMEhdUsrBU=;
        b=iVzX5yBoSleiurXDpfLNOSNNWlM9M5BOYRyULU+yLtqXOtRTZ0Jj4shBX1PjRhtQrgf4/9
        bCGuICPp/GE2nGc9r9VYFH3Z28m459yMjJSZPiYpRs5gxQI2xF2BYph3azJ4GAnZrAT0w1
        E4KKaCZplXY1m4dp4zz7X4hCnO4JtzM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-d_Jm8n2kO2ewqQiTFfAMuQ-1; Mon, 26 Jun 2023 04:10:29 -0400
X-MC-Unique: d_Jm8n2kO2ewqQiTFfAMuQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313f59eba37so107510f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687767028; x=1690359028;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RgipMs2QNRwrDwP1+AYISiKEXaCi8Y3rMMEhdUsrBU=;
        b=baaOEix+eXuIOpq0YuZ7VEJKB0ilVoyBICdYyMWv+QLrLhYXjvPq/zHxWsfYphnhGk
         UMkez83YmydanIz9FuWonQJo/2M9itXH+reBDflSkYCbMFM4vdoecLBFifWP/E2TV/I6
         vBSebhZMtSGrNtPaI7HoFwdlFOjzxpQPL5j5SmzhKViTyYg00NxskUv3tK/8JGHusSj7
         QOks0omEeJlPUhHZYTvTomYcS5T8TwZoprKjvsISF1fuU0vxCGNEjlwLQLvnRpdOefyo
         CL4iEfTeyHpRr1baENKa0dr5uY7GCzW2Zx8U3mUd0xBaWRQMMghReCtX9aWjtLOf0kBQ
         T37g==
X-Gm-Message-State: AC+VfDx54ebw8gnmRF0FdOfcHoT+83W17TVDGxvHlYI/R5BqoCgdDAPE
        MXROyXAyIrFuQbP96sJo0OdrWqSaNr1/DmOH1CgWh0XZQ2XS31ypGjjj/JbDStaQ+3pQ4fB6qyN
        wSj/kxQ/8qTa1N7+41YxP02ll
X-Received: by 2002:a5d:608f:0:b0:313:f157:7d56 with SMTP id w15-20020a5d608f000000b00313f1577d56mr1136958wrt.30.1687767027957;
        Mon, 26 Jun 2023 01:10:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wB14MWsdDFj2VS6mKBjZ6mqz1J6Y46vrzsW+wHvF+lBxDI0rff1rB7+CdMq/wIMfnSNfU1g==
X-Received: by 2002:a5d:608f:0:b0:313:f157:7d56 with SMTP id w15-20020a5d608f000000b00313f1577d56mr1136945wrt.30.1687767027583;
        Mon, 26 Jun 2023 01:10:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498? (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de. [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
        by smtp.gmail.com with ESMTPSA id l1-20020adff481000000b003113ed02080sm6512838wro.95.2023.06.26.01.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:10:27 -0700 (PDT)
Message-ID: <1f81260b-f569-87b9-a100-f6cd65ee5a5f@redhat.com>
Date:   Mon, 26 Jun 2023 10:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 7/8] selftests/mm: Add -a to run_vmtests.sh
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-8-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623142936.268456-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 16:29, Peter Xu wrote:
> Allows to specify optional tests in run_vmtests.sh, where we can run time
> consuming test matrix only when user specified "-a".

I'd have used something like "-e: extended tests that might be more 
time-consuming".

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

