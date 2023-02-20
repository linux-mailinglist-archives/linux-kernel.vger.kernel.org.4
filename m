Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1467F69C667
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBTIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBTIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:17:12 -0500
X-Greylist: delayed 929 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 00:17:09 PST
Received: from 5.mo560.mail-out.ovh.net (5.mo560.mail-out.ovh.net [87.98.181.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3412063
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:17:09 -0800 (PST)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.1.121])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 2BC1A20BB6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:01:38 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-b5gl9 (unknown [10.110.103.34])
        by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 460391FEB7;
        Mon, 20 Feb 2023 08:01:37 +0000 (UTC)
Received: from milecki.pl ([37.59.142.97])
        by ghost-submission-6684bf9d7b-b5gl9 with ESMTPSA
        id RQ+QBuEo82NWsBMAbEMOzw
        (envelope-from <rafal@milecki.pl>); Mon, 20 Feb 2023 08:01:37 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-97G00236d10b2f-d027-4f6b-9238-bcc4db552a7c,
                    EFA20DE6CD4C4DB577D33D0A6633E50025442685) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <724bcb6f-775d-a7be-d47c-447dc8ac4c19@milecki.pl>
Date:   Mon, 20 Feb 2023 09:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        srinivas.kandagatla@linaro.org
Cc:     chunkeey@gmail.com, linux-kernel@vger.kernel.org
References: <20230213132351.837-1-musashino.open@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <20230213132351.837-1-musashino.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2945635633656343515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpedtgeetheeutddvudekuddtkeetveehteegleehffetkeehjeetfffgveegkeefueenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2023 14:23, INAGAKI Hiroshi wrote:
> @@ -117,8 +117,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>   	size_t crc32_offset;
>   	size_t data_offset;
>   	size_t data_len;
> -	uint32_t crc32;
> -	uint32_t calc;
> +	__le32 crc32;
> +	__le32 calc;
>   	size_t bytes;
>   	uint8_t *buf;
>   	int err;
> @@ -152,11 +152,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>   		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>   		break;
>   	}
> -	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
> +	crc32 = cpu_to_le32(*(uint32_t *)(buf + crc32_offset));
>   	crc32_data_len = priv->mtd->size - crc32_data_offset;
>   	data_len = priv->mtd->size - data_offset;
>   
> -	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
> +	calc = cpu_to_le32(crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L);

Can you see what happens on BE device if instead of this whole patch you
just replace crc32() in above line with crc32_le()?


>   	if (calc != crc32) {
>   		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
>   		err = -EINVAL;
