Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F360113D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiJQOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:38:07 -0400
X-Greylist: delayed 20835 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 07:38:04 PDT
Received: from 16.mo550.mail-out.ovh.net (16.mo550.mail-out.ovh.net [178.33.104.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13BF659C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:38:04 -0700 (PDT)
Received: from player715.ha.ovh.net (unknown [10.108.1.121])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id E522525237
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:43:38 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 76A492F9C120F;
        Mon, 17 Oct 2022 08:43:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S004ec95ac2e-c881-47a8-ae74-8219bca6a23c,
                    FF0B1D635228C6B078EFA7CC0635FA60C13E13FA) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <1a25d042-994d-40e3-b46e-b052a8ee37c4@milecki.pl>
Date:   Mon, 17 Oct 2022 10:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20221012155133.287-1-musashino.open@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <20221012155133.287-1-musashino.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1565563823855610843
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepueeltedugfekveffgfegffevveeluedtkeekjeeukeevveethffhgeevgeeghfdunecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2022 17:51, INAGAKI Hiroshi wrote:
> This patch fixes crc32 error on Big-Endianness system by conversion of
> calculated crc32 value.
> 
> Little-Endianness system:
> 
>    obtained crc32: Little
> calculated crc32: Little
> 
> Big-Endianness system:
> 
>    obtained crc32: Little
> calculated crc32: Big
> 
> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
> 
> [    8.570000] u_boot_env 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> [    8.580000] u_boot_env: probe of 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
> 
> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment variables")
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
