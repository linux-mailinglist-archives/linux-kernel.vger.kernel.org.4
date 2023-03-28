Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB26CC025
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC1NHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjC1NHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:07:42 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46662AD30
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:07:02 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7EE3A5FD14;
        Tue, 28 Mar 2023 16:06:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680008819;
        bh=5rDfZC8d79blVeGeWpEEZesfjJmirAJLjs3jHC7svIM=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=CKz8G7ntT/IDl4V17xoe7K5oRh5pQHZZOXaACv0B3yrhmXE87VuXtR3z5qhar9XuO
         Lv0W3HgEzNelk9ZQLg3Lv2oGKq0+VH1xBrlLKGL02x7wpT8+JzWCM3nFD4X4NMq0vc
         v8iqCXkKtX1L5+AzvcIhfPQfLtDnCkrHXaPIVLrQazW5uRqv2iFERwOhoYJJEUuONy
         CmanQVulOCsVYWkFfAVE6jvIuYYX6SlF7bqeyPywlkaXRuIk0GmTrKSYwXqspLywBj
         0RnXyCmmzKmulsOE1urqdqpdWfWbAzNMXxGGaIBkUksEIUh7USCcoi+0jyhUhjwF8z
         ih3m20ummXwlg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 28 Mar 2023 16:06:57 +0300 (MSK)
Message-ID: <0c18b3b7-b890-e029-2f67-d0b7df545ad4@sberdevices.ru>
Date:   Tue, 28 Mar 2023 16:06:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] mtd: spinand: add support for ESMT F50x1G41LB
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Chuanhong Guo <gch981213@gmail.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Felix Matouschek <felix@matouschek.org>, <kernel@kempniu.pl>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
References: <20230322151625.791131-1-mmkurbanov@sberdevices.ru>
 <20230328145639.1aef44e2@xps-13>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <20230328145639.1aef44e2@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/28 06:38:00 #21021220
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel,

On 28.03.2023 15:56, Miquel Raynal wrote:
> I was about to merge this patch but it turns out there are conflicts in
> the tree. Can you please rebase on top of nand/next and send a v4?

Ack

-- 
Best Regards,
Martin Kurbanov
