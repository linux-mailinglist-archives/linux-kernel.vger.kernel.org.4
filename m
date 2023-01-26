Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9167D9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAZXqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjAZXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26E9EC9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674776739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDPidku7XYmtarp/AVuc4betwoJhftsFOw1T5iwHCJo=;
        b=XnUFKjgDH0EC22ftJntI62LvXlvrdwDh+LM++rynAcVu+EkGXeLo+YrCz8uUDOl/wf00Vv
        ftDxQvMu7t7ctRA7dPiNO70FjCyJ5xrlj4oQj9/zy0RW1WTOxChlDvCl8W6FZin44+Q3mL
        9sv3riPiyCTK2w+6EjCsWwNcA8OtcV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-0rsT1iWoMM-otOlsxx0dQQ-1; Thu, 26 Jan 2023 18:45:38 -0500
X-MC-Unique: 0rsT1iWoMM-otOlsxx0dQQ-1
Received: by mail-wm1-f72.google.com with SMTP id 12-20020a05600c228c00b003db09699216so833413wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDPidku7XYmtarp/AVuc4betwoJhftsFOw1T5iwHCJo=;
        b=YUs+suSEzfdnv4NYJeRlkwerAnkU4Nq+B068eXYhY6C5tFMD/QqNntS+z5ddlCpTz7
         Oul0aKxikiTufjfZmodgfDYPD39ii29jaseEM1y12IJP/lKSE8mNNtP/XI2VJDFriAd2
         ovn2oz09p7CzNTJCWG6+0j+9gR8CgPHavZc1x2HCqWwndOVhSLFJk+7o1d6BXao7oc9p
         cEMBon7znUx8NLfYfR0c68BO4Yucq91xWDoDCzYcA2f4+b/a90eYb1BHYRjm4DOTlGDq
         L7YqmEyP2OUVcnKBJdTxxanCqhW/eqCsA1Py1ehxRfszYfsswqpS30zmL8S2JSkTMBv6
         Vlgw==
X-Gm-Message-State: AFqh2kotljhTGOifCCzL2dzKYPWjv7d5j4flgoPxTUtDk2H5AfKxSV4P
        QIcn+cxcmhcKoqD1R2xLeUoqT/eeW6fsuFmKbI1URdtcEo2I2DD4+jlAnLyRdJ1JOj4U0OBLXtm
        A2zUEydU8/drcyEuBkKp/aYqt
X-Received: by 2002:a05:6000:1049:b0:2bb:ee8a:4282 with SMTP id c9-20020a056000104900b002bbee8a4282mr31802020wrx.34.1674776737005;
        Thu, 26 Jan 2023 15:45:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuhVMC6HMmdj7izpzyhUASFO5g0VF0QIXfsOyqbgQyokValMXycp+aM8dqC3EF6J/Z4LUfi0A==
X-Received: by 2002:a05:6000:1049:b0:2bb:ee8a:4282 with SMTP id c9-20020a056000104900b002bbee8a4282mr31802010wrx.34.1674776736691;
        Thu, 26 Jan 2023 15:45:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5e00:9e97:86d:5ed5:bb95? (p200300cbc7075e009e97086d5ed5bb95.dip0.t-ipconnect.de. [2003:cb:c707:5e00:9e97:86d:5ed5:bb95])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b002bc6c180738sm2925652wry.90.2023.01.26.15.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:45:36 -0800 (PST)
Message-ID: <7622ebe2-7405-ce4f-6bae-2d51dc8bf929@redhat.com>
Date:   Fri, 27 Jan 2023 00:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 1/8] iov_iter: Define flags to qualify page
 extraction.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-2-dhowells@redhat.com> <Y9L2iFZlC4CFwN4t@ZenIV>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9L2iFZlC4CFwN4t@ZenIV>
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

On 26.01.23 22:54, Al Viro wrote:
> On Thu, Jan 26, 2023 at 02:16:19PM +0000, David Howells wrote:
> 
>> +typedef unsigned int iov_iter_extraction_t;
> 
>> +/* Flags for iov_iter_get/extract_pages*() */
>> +/* Allow P2PDMA on the extracted pages */
>> +#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)
> 
> That __force makes sense only if you make it a bitwise type -
> otherwise it's meaningless.  IOW, either turn the typedef into
> 
> typedef unsigned int __bitwise iov_iter_extraction_t;
> 
> or lose __force in the cast...
> 

Well spotted, iov_iter_extraction_t is missing __bitwise.

-- 
Thanks,

David / dhildenb

