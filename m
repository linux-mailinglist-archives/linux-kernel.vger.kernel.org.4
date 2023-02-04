Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD47468A88A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 07:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjBDGTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 01:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 01:19:01 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE332761C5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 22:18:59 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4P82R54Ksxz4y3Zn;
        Sat,  4 Feb 2023 14:18:57 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl1.zte.com.cn with SMTP id 3145WsHw015648;
        Sat, 4 Feb 2023 14:18:33 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 4 Feb 2023 14:18:35 +0800 (CST)
Date:   Sat, 4 Feb 2023 14:18:35 +0800 (CST)
X-Zmail-TransId: 2b0363ddf8bbffffffffaca1c72a
X-Mailer: Zmail v1.0
Message-ID: <202302041418359766772@zte.com.cn>
In-Reply-To: <60125c55-9ab7-7531-e124-cb676943fea6@redhat.com>
References: 202212300913573751808@zte.com.cn,60125c55-9ab7-7531-e124-cb676943fea6@redhat.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <david@redhat.com>
Cc:     <akpm@linux-foundation.org>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAyLzZdIGtzbTogc3VwcG9ydCB1bnNoYXJpbmcgemVybyBwYWdlcyBwbGFjZWQgYnkgS1NN?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3145WsHw015648
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63DDF8D1.000/4P82R54Ksxz4y3Zn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why use flags if they both conditions are mutually exclusive?

Just to make the return value of break_ksm_pmd_entry() more expressive and
understandable. because break_ksm_pmd_entry have three types of returned
values (0, 1, 2).

> MADV_UNMERGEABLE -> unmerge_ksm_pages() will never unshare the shared 
> zeropage? I thought the patch description mentions that that is one of 
> the goals?

No, MADV_UNMERGEABLE will trigger KSM to unshare the shared zeropages in the
context of "get_next_rmap_item() -> unshare_zero_pages(), but not directly in the
context of " madvise()-> unmerge_ksm_pages() ". The reason for this is to avoid
increasing long delays of madvise() calling on unsharing zero pages.
