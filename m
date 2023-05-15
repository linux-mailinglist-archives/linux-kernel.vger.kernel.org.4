Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5D703251
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbjEOQII convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbjEOQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:08:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A008B2D73
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:07:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-uRU4qE7IPxOBaj4CStDw6Q-1; Mon, 15 May 2023 17:07:06 +0100
X-MC-Unique: uRU4qE7IPxOBaj4CStDw6Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 May
 2023 17:07:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 15 May 2023 17:07:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ruihan Li' <lrh2000@pku.edu.cn>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] usb: usbfs: Use consistent mmap functions
Thread-Topic: [PATCH v2 2/4] usb: usbfs: Use consistent mmap functions
Thread-Index: AQHZhy64xAEf6PI6fk2CO41aswORIq9be+FQ
Date:   Mon, 15 May 2023 16:07:01 +0000
Message-ID: <2b6cb73d2cd14a46b7e4553566030b22@AcuMS.aculab.com>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-3-lrh2000@pku.edu.cn>
In-Reply-To: <20230515130958.32471-3-lrh2000@pku.edu.cn>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruihan Li
> Sent: 15 May 2023 14:10
> 
> When hcd->localmem_pool is non-null, localmem_pool is used to allocate
> DMA memory. In this case, the dma address will be properly returned (in
> dma_handle), and dma_mmap_coherent should be used to map this memory
> into the user space. However, the current implementation uses
> pfn_remap_range, which is supposed to map normal pages.

I've an (out of tree) driver that does the same.
Am I right in thinking that this does still work?

I can't change the driver to use dma_map_coherent() because it
doesn't let me mmap from a page offset within a 16k allocation.

In this case the memory area is an 8MB shared transfer area to an
FPGA PCIe target sparsely filled with 16kB allocation (max 512 allocs).
The discontinuous physical memory blocks appear as logically
contiguous to both the FPGA logic and when mapped to userspace.
(But not to driver code.)

I don't really want to expose the 16k allocation size to userspace.
If we need more than 8MB then the allocation size would need
changing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

