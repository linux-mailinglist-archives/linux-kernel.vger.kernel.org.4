Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308A963842F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKYG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKYG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:58:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD72C103;
        Thu, 24 Nov 2022 22:58:51 -0800 (PST)
X-UUID: d0004f24bf564171b745ae1e82239b96-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=v7todQfX6Ph8p4yEF3wKv+qG8KQC8f/WWrCxdxR5F/4=;
        b=FaW3unWrBRFho0t5JnZP41cUHhltosUmWlaD7wPXItIJwzy7D3uTBFGAd4yF2VLjM//jsbfg3oJtD+axvBshthS21fkG0GUR649xT/L2QTSluY8NUJa4HgjbIBN/gvJBOPjVvKycUb68DC+LY4W55FInur0EpEnJSKxxBJB4dyk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ee6fd5e3-6269-43a4-9f3a-5524d4f24c4f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:d4afcd2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d0004f24bf564171b745ae1e82239b96-20221125
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1828604238; Fri, 25 Nov 2022 14:58:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 25 Nov 2022 14:58:44 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Nov 2022 14:58:44 +0800
Message-ID: <2ca334b5-292c-bb31-f21e-a25579c6edd7@mediatek.com>
Date:   Fri, 25 Nov 2022 14:58:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
Content-Language: en-US
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ethan Hsieh <ethan.hsieh@canonical.com>,
        Jason Yen <jason.yen@canonical.com>,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
References: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
 <a384d15d-c1df-160c-030b-fddd5d965996@linux.intel.com>
 <02552cc60b3aae16b2c2e9717b42c800180e3a87.camel@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <02552cc60b3aae16b2c2e9717b42c800180e3a87.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/22 18:38, Chunfeng Yun (云春峰) wrote:
> On Wed, 2022-11-23 at 13:10 +0200, Mathias Nyman wrote:
>> On 18.11.2022 13.01, Chunfeng Yun wrote:
>>> There is error log when add a usb3 root hub without ports:
>>> "hub 4-0:1.0: config failed, hub doesn't have any ports! (err -19)"
>>>
>>> so omit the shared hcd if either of the root hubs has no ports, but
>>> usually there is no usb3 port.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>>    drivers/usb/host/xhci-mtk.c | 72 +++++++++++++++++++++++---------

[deleted...]

Dear Chunfeng,

Since this issue has been reported by Canonical as a ticket
on launchpad (sorry, it has been reported as a private ticket...),
could you please to check if add "Cc: stable@vger.kernel.org" and 
"Fixes:" tags are valid?

If it is possible, please help to list dependent patches to backport
to stable tree also. Is it possible to include this patch in recent LTS 
tree?

Thanks
Macpaul Lin
