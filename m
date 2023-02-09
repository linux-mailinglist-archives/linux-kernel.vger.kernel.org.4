Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE84690836
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBIMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBIMJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:09:02 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A620D1D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:02:08 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PCFpl3DPwz4xVnD;
        Thu,  9 Feb 2023 20:02:07 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 319C1sZu014759;
        Thu, 9 Feb 2023 20:01:54 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 9 Feb 2023 20:01:57 +0800 (CST)
Date:   Thu, 9 Feb 2023 20:01:57 +0800 (CST)
X-Zmail-TransId: 2b0363e4e0b50a6650e6
X-Mailer: Zmail v1.0
Message-ID: <202302092001576896055@zte.com.cn>
In-Reply-To: <305a756b-b977-8d08-fd7c-d41ec5dfe5d1@redhat.com>
References: 202212300915147801864@zte.com.cn,305a756b-b977-8d08-fd7c-d41ec5dfe5d1@redhat.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <david@redhat.com>
Cc:     <akpm@linux-foundation.org>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAzLzZdIGtzbTogY291bnQgYWxsIHplcm8gcGFnZXMgcGxhY2VkIGJ5IEtTTQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 319C1sZu014759
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E4E0BF.000 by FangMail milter!
X-FangMail-Envelope: 1675944127/4PCFpl3DPwz4xVnD/63E4E0BF.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E4E0BF.000/4PCFpl3DPwz4xVnD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 652c088f9786..72c0722be280 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -276,6 +276,9 @@ static unsigned int zero_checksum __read_mostly;
> >   /* Whether to merge empty (zeroed) pages with actual zero pages */
> >   static bool ksm_use_zero_pages __read_mostly;
> > 
> > +/* The number of zero pages placed by KSM use_zero_pages */
> > +static unsigned long ksm_zero_pages_sharing;
> 
> Does this count how many zero pages are currently placed or how many 
> rmap items with ZERO_PAGE_FLAG are in the system?

Yes, it counts how many ksm zero pages are currently placed. and we use
rmap items with ZERO_PAGE_FLAG to record these zero page, similar to 
ksm_pages_sharing and ksm_pages_shared which are recorded by the rmap_items
with STABLE_FLAG.

> 
> IOW, if someone triggers MADV_DONTNEED on such a zeropage, the counter 
> will not get updated, correct?

Well, the counter can get updated as someone triggers MADV_DONTNEED on such
a zeropage. You might write a simple code to test it.
