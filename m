Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F58722048
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjFEH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFEH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:56:17 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFA1A7;
        Mon,  5 Jun 2023 00:55:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C8F7C5FD07;
        Mon,  5 Jun 2023 10:55:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685951751;
        bh=v35VHrPiHrTfFH+00gjiQ0HIyOyZOmrhP7Fi3iTpy8c=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=EjY2upZMsXHLjiIYHr4srpXaFota4+Vad2lVnZ6qA/jOHuVTqRPG647OSFEvl+aAY
         pbaQfRVMNNrtY1of4WSMVE9ehShKtUc2QjGyiD11VA4TAz/gVr843h5ZdnHYwMMO6B
         b3GXPX7MVHs7seRG/p4ai+UYPc4dm3ckjk1ysyFNUp5yRMGEvNly4+VTwWw0l/Mmk/
         AqgrrA8IxJeHI8wv2hNf67NtmKVLwVEGNfH3CtztOIipsUmVaNZWFyoRYX8ecKgxZF
         vnjQC4vWHRzPhbJn7wjVrQP9MPeN0DDubMQE1aCibKxv8VZCNx8O1npWwxB7HTl3E/
         OfpKRHxFBsKAg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  5 Jun 2023 10:55:50 +0300 (MSK)
Message-ID: <2edc0c89-5c93-e1c6-5567-ac0d94a60fbc@sberdevices.ru>
Date:   Mon, 5 Jun 2023 10:50:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix ready/busy command
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <stable@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
 <2023060556-monetary-browsing-536b@gregkh>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <2023060556-monetary-browsing-536b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/05 04:52:00 #21434197
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems this fix is not full, pls ignore it

Thanks, Arseniy

On 05.06.2023 10:05, Greg KH wrote:
> On Mon, Jun 05, 2023 at 09:10:48AM +0300, Arseniy Krasnov wrote:
>> Fix the ready/busy command value.
> 
> "Fix" it in what way?  Please provide more information, this does not
> explain what is happening here at all.
> 
> greg k-h
