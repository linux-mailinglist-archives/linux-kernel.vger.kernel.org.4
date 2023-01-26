Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669667D9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjAZXps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjAZXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AE49011
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674776653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI+Jsv2TxAR9Abf8MJO7xLLwXDlmnNTYN30oeKtKeeI=;
        b=dIlMMFkFEBFWOVxwhIoC9pT29F+Cz5bsCiPvddrNLaoujetSHGdEIoqPFrlE5+sXfFC2sN
        5OVmZK11uqE981VTIFapTGuMXSeyVrA4slHX+W5mtZkOQQkGWaEA+f2L55+/+rq34YXuXB
        wKL4tHICrbE8lF0PvAPq7RzOvmLy6HU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-_vysCVSeNuegdZni7qAqMQ-1; Thu, 26 Jan 2023 18:44:11 -0500
X-MC-Unique: _vysCVSeNuegdZni7qAqMQ-1
Received: by mail-wm1-f71.google.com with SMTP id p1-20020a05600c1d8100b003daff82f5edso1824979wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PI+Jsv2TxAR9Abf8MJO7xLLwXDlmnNTYN30oeKtKeeI=;
        b=m5c+u6lbtFb0hcUCdWHxIdqDuJ0ovUcx0HGNC6d9vcbFfYQt5eZlHT19iRpyCCz5Wc
         K6NIfAbAl80JmtMKuP5fDHWAvRJS+xm9n4gQX4dBpC29C2vhdxC0U9AE/UwQMJU0/rBX
         FkkGhPMHU62zqenQg1nG4Ze5P/+PTH38fgbaNzQDQPE5VhSscNosAfxRPsqusoKimFds
         pFFHEWV7MUNZLffiFAZA9wUhq4T1kwoSJC+FN9nbBCI7shid4pCUYRiPzos2vWv9GrUL
         DFFKbGuaHQzyZVKWbZzALMNO8AlYm63wjhfWsSnMmMV2f3oHf2x/1f0utDe1B4L3hEkM
         9aQQ==
X-Gm-Message-State: AFqh2kqoCNZFS+ROSPdf3lapJcq5Sbz5iBXhwkgoWKLOd/u6MgdmAJU9
        Wapgli2hWyVS+wJYPanXHfXDkl0/nL7qEL7hgwGXE3D/jqSa+rNF49qpRr8crNL0wo8/5DmUBqi
        m+X+n9XEzcBVhnfNfCPJbBFfi
X-Received: by 2002:a05:6000:12cb:b0:2bd:bf44:2427 with SMTP id l11-20020a05600012cb00b002bdbf442427mr35492170wrx.42.1674776650687;
        Thu, 26 Jan 2023 15:44:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuYtrgOl2m3LqcTWZWXs2ZqSVi93PYCMVoVdhFMM1NnPQJAUnmGCmIU/Ns6kWli+3InjkeYcQ==
X-Received: by 2002:a05:6000:12cb:b0:2bd:bf44:2427 with SMTP id l11-20020a05600012cb00b002bdbf442427mr35492148wrx.42.1674776650370;
        Thu, 26 Jan 2023 15:44:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5e00:9e97:86d:5ed5:bb95? (p200300cbc7075e009e97086d5ed5bb95.dip0.t-ipconnect.de. [2003:cb:c707:5e00:9e97:86d:5ed5:bb95])
        by smtp.gmail.com with ESMTPSA id d3-20020adfe2c3000000b002bc7fcf08ddsm2385220wrj.103.2023.01.26.15.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:44:09 -0800 (PST)
Message-ID: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
Date:   Fri, 27 Jan 2023 00:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
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
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9MAbYt6DIRFm954@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.23 23:36, Al Viro wrote:
> On Thu, Jan 26, 2023 at 09:59:36PM +0000, Al Viro wrote:
>> On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:
>>
>>> +/**
>>> + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
>>> + * @iter: The iterator
>>> + *
>>> + * Examine the iterator and indicate by returning true or false as to how, if
>>> + * at all, pages extracted from the iterator will be retained by the extraction
>>> + * function.
>>> + *
>>> + * %true indicates that the pages will have a pin placed in them that the
>>> + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
>>> + * to forcibly copy a page for the child (the parent must retain the original
>>> + * page).
>>> + *
>>> + * %false indicates that no measures are taken and that it's up to the caller
>>> + * to retain the pages.
>>> + */
>>> +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
>>> +{
>>> +	return user_backed_iter(iter);
>>> +}
>>> +
>>
>> Wait a sec; why would we want a pin for pages we won't be modifying?
>> A reference - sure, but...
> 
> After having looked through the earlier iterations of the patchset -
> sorry, but that won't fly for (at least) vmsplice().  There we can't
> pin those suckers; 

We'll need a way to pass FOLL_LONGTERM to pin_user_pages_fast() to 
handle such long-term pinning as vmsplice() needs. But the release path 
(unpin) will be the same.

-- 
Thanks,

David / dhildenb

