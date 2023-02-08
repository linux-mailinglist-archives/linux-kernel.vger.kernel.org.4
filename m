Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667F68EF93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBHNMz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 08:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBHNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:12:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD42460AF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:12:51 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-270-BBR2dVL9Mgyb8fRo4ZZDyQ-1; Wed, 08 Feb 2023 13:12:48 +0000
X-MC-Unique: BBR2dVL9Mgyb8fRo4ZZDyQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 13:12:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 13:12:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bibo Mao' <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] LoongArch: add checksum optimization for 64-bit system
Thread-Topic: [PATCH] LoongArch: add checksum optimization for 64-bit system
Thread-Index: AQHZOqjw3I588J9fP0akyPjC04Hova7FBpIA
Date:   Wed, 8 Feb 2023 13:12:47 +0000
Message-ID: <8fa91bca5e624861b190917933951c7e@AcuMS.aculab.com>
References: <20230207040148.1801169-1-maobibo@loongson.cn>
In-Reply-To: <20230207040148.1801169-1-maobibo@loongson.cn>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibo Mao
> Sent: 07 February 2023 04:02
> 
> loongArch platform is 64-bit system, which supports 8 bytes memory
> accessing, generic checksum function uses 4 byte memory access.
> This patch adds 8-bytes memory access optimization for checksum
> function on loongArch. And the code comes from arm64 system.
> 
> When network hw checksum is disabled, iperf performance improves
> about 10% with this patch.
> 
...
> +static inline __sum16 csum_fold(__wsum csum)
> +{
> +	u32 sum = (__force u32)csum;
> +
> +	sum += (sum >> 16) | (sum << 16);
> +	return ~(__force __sum16)(sum >> 16);
> +}

Does LoongArch have a rotate instruction?
But for everything except arm (which has a rotate+add instruction)
the best is (probably):
	(~sum - rol32(sum, 16)) >> 16

To the point where it is worth killing all the asm
versions and just using that one.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

