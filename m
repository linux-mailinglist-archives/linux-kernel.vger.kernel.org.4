Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498C8615F68
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKBJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiKBJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D08B29374
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667380520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSXLOldyONaY9cgEaRNbBHRAqu0Rs7Nl/7vgOG7kHn8=;
        b=OvCzHDNq81nOx2xQl2oVvvy29EaPkgcFh3+Ozt0aLT6tyAPEtvxFsGVg/GFlHWo144VyJo
        Z8ov3Np6fvzZjklstcJLGg0EBnE5Ev+n4Z/7Zdqmck+OQ9X9tiGVv3cbOEeKF+pHmz0fZd
        gPg/ZUFPxgblcc6TTVeoXpnHDL26/pc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-4-HQS9-nPCSA0ZmLMuDu5w-1; Wed, 02 Nov 2022 05:15:19 -0400
X-MC-Unique: 4-HQS9-nPCSA0ZmLMuDu5w-1
Received: by mail-wr1-f69.google.com with SMTP id s11-20020adfbc0b000000b0023659af24a8so4628920wrg.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSXLOldyONaY9cgEaRNbBHRAqu0Rs7Nl/7vgOG7kHn8=;
        b=pdPW5BKTGvRthqo7ZO035j/G6Z3z/x4U1AxVRUdlk5OayXir2H3fqhnU9XbBv+IHLX
         Zed11Zz51RLpEArvtXi5g5DQJFEmQUh0I1lx8NcUSoKXNwopgDsC6g11VidH8EhT7rbE
         pRQOe5c9KW8w/yWB+kwz7w0xelNwxFQZZkmPROmAUBCZTtOkzwdthspDLDjTGXvfjkSs
         mYi+lBI2duaRmyN7c8N1qGI3d+b9WQVBfFp7duVi4VltFic4/wyVF8o8grnPjOhPg6gE
         IjuKx/3dGigxvtl2cAlxZWMltaDghDLOIfgZU2073saWNy/z012cjbqh184ofN3Vjsh0
         chtg==
X-Gm-Message-State: ACrzQf3uVdtdksJylL+QumTebk/mDKDenw4slA1rfJfdYm03d0fOpXtJ
        XHdGhfIZJo2A6SYs0fq1hLJjfelT3sAnzUU3cj4VYx0TINYWwltmSzGbjPDmYf6FJgiU/J2BD69
        fYmN4Euah3xzvadEDFi+7SXqs
X-Received: by 2002:a5d:5711:0:b0:236:598d:83ed with SMTP id a17-20020a5d5711000000b00236598d83edmr15064122wrv.190.1667380518043;
        Wed, 02 Nov 2022 02:15:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4NLqhgOBH5rAwKqrA++LABLCwVsBqlTSy014nXaNbwCsf7Tiv8YjUWY90ar+xjYkYcX/LddA==
X-Received: by 2002:a5d:5711:0:b0:236:598d:83ed with SMTP id a17-20020a5d5711000000b00236598d83edmr15064095wrv.190.1667380517747;
        Wed, 02 Nov 2022 02:15:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f100:af38:1d1f:66f4:48c7? (p200300cbc705f100af381d1f66f448c7.dip0.t-ipconnect.de. [2003:cb:c705:f100:af38:1d1f:66f4:48c7])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003cf6c2f9513sm1462650wmb.2.2022.11.02.02.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:15:17 -0700 (PDT)
Message-ID: <d8c18628-4ef0-ae99-799b-dfe1543c9047@redhat.com>
Date:   Wed, 2 Nov 2022 10:15:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] mm: Always compile in pte markers
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221030214151.402274-1-peterx@redhat.com>
 <20221030214151.402274-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221030214151.402274-2-peterx@redhat.com>
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

On 30.10.22 22:41, Peter Xu wrote:
> The PTE markers code is tiny and now it's enabled for most of the
> distributions.  It's fine to keep it as-is, but to make a broader use of
> it (e.g. replacing read error swap entry) it needs to be there always
> otherwise we need special code path to take care of !PTE_MARKER case.
> 
> It'll be easier just make pte marker always exist.  Use this chance to
> extend its usage to anonymous too by simply touching up some of the old
> comments, because it'll be used for anonymous pages in the follow up
> patches.
> 
> Reviewed-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

