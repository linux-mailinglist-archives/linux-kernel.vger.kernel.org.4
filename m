Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AD61945E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiKDKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiKDKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:20:40 -0400
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Nov 2022 03:20:35 PDT
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net [46.105.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B3625E9B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:20:35 -0700 (PDT)
Received: from player726.ha.ovh.net (unknown [10.110.115.67])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 9243D255CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:05:01 +0000 (UTC)
Received: from RCM-web3.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id 422C230557BA7;
        Fri,  4 Nov 2022 10:04:57 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 04 Nov 2022 11:04:57 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        gregkh@linuxfoundation.org, a.fatoum@pengutronix.de
Subject: Re: [PATCH v1] nvmem: address crc32 check on redundant-layout powerpc
 machines
In-Reply-To: <41e7ab94800b4a9aef73e212464bd94117429bec.1667555240.git.chunkeey@gmail.com>
References: <41e7ab94800b4a9aef73e212464bd94117429bec.1667555240.git.chunkeey@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e22067325dffb02739a7bd7c20419b43@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16414776219705846715
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefgueelueetteefueehhffhgfetvdegjeefleffuedvhfeuffdvheegueevuefhleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-04 10:47, Christian Lamparter wrote:
> The Western Digital MyBook Live (PowerPC 464/APM82181)
> has a set of redundant u-boot-env. Loading up the driver
> causes it to error out with:
> 
> | u_boot_env: Invalid calculated CRC32: 0x4f8f2c86 (expected: 
> 0x98b14514)
> | u_boot_env: probe of partition@1e000 failed with error -22
> 
> Looking up the userspace libubootenv utilities source [0],
> it looks like the "mark" or "flag" is not part of the
> crc32 sum... which is unfortunate :(
> 
> |static int libuboot_load(struct uboot_ctx *ctx)
> |{
> |[...]
> |       if (ctx->redundant) {
> |		[...]
> |               offsetdata = offsetof(struct uboot_env_redund, data);
> |		[...]
> |       }
> |       usable_envsize = ctx->size - offsetdata;
> |       buf[0] = malloc(bufsize);
> |[...]
> |	for (i = 0; i < copies; i++) {
> |		data = (uint8_t *)(buf[i] + offsetdata);
> |               uint32_t crc;
> |
> |		ret = devread(ctx, i, buf[i]);
> |		[...]
> |		crc = *(uint32_t *)(buf[i] + offsetcrc);
> |               dev->crc = crc32(0, (uint8_t *)data, usable_envsize);
> |

Thanks for the fix, it may be I didn't actually test that code.

That change has nothing to do with byte swapping so I' suggest TWO
separated patches.


> Now, this alone didn't fully fix the kernel's uboot-env nvmem
> driver. The driver then ran into an endian error on the
> big-endian powerpc device:
> 
> | u_boot_env: Invalid calculated CRC32: 0x1445b198 (expected: 
> 0x98b14514)
> 
> however the __le32 type for the crc32 value is justified because the
> the crc32() is just a macro for crc32_le(). So, to side-step that
> problem, the crc32 check gets extended to also accept a byteswapped
> crc32.

Can you try this pending patch, please?
[PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
https://lore.kernel.org/lkml/20221012155133.287-1-musashino.open@gmail.com/
