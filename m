Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D34694785
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBMN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:56:39 -0500
X-Greylist: delayed 1173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 05:56:37 PST
Received: from 4.mo560.mail-out.ovh.net (4.mo560.mail-out.ovh.net [87.98.172.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E184ECF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:56:37 -0800 (PST)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.20.144])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 3FCE8205F4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:37:02 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dhg5x (unknown [10.110.171.76])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 080351FE0E;
        Mon, 13 Feb 2023 13:37:02 +0000 (UTC)
Received: from RCM-web6.webmail.mail.ovh.net ([151.80.29.20])
        by ghost-submission-6684bf9d7b-dhg5x with ESMTPSA
        id SLZVAf486mOMBQAAsqmxVA
        (envelope-from <rafal@milecki.pl>); Mon, 13 Feb 2023 13:37:02 +0000
MIME-Version: 1.0
Date:   Mon, 13 Feb 2023 14:37:01 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     INAGAKI Hiroshi <musashino.open@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, chunkeey@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
In-Reply-To: <20230213132351.837-1-musashino.open@gmail.com>
References: <20230213132351.837-1-musashino.open@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d8e6135f837462a7f7cdf59e20bfc449@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4394950287709023195
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiuddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthejjhdttdervdenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepteehleefgfejuddtiedvuddvtefhhfehudelgfegiedtjeduhfekteejkeeijefgnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudehuddrkedtrddvledrvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 14:23, INAGAKI Hiroshi wrote:
> This patch fixes crc32 error on Big-Endianness system by conversion of
> calculated crc32 value.
> 
> Little-Endianness system:
> 
>   obtained crc32: Little
> calculated crc32: Little
> 
> Big-Endianness system:
> 
>   obtained crc32: Little
> calculated crc32: Big
> 
> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
> 
> [    8.570000] u_boot_env
> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated
> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> [    8.580000] u_boot_env: probe of
> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
> 
> Fixes: f955dc144506 ("nvmem: add driver handling U-Boot environment 
> variables")
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---
> v2 -> v3
> 
> - fix sparse warning by using __le32 type and cpu_to_le32
> - fix character length of the short commit hash in "Fixes:" tag
> 
> v1 -> v2
> 
> - wrong fix for sparse warning due to misunderstanding
> - add missing "Fixes:" tag
> 
>  drivers/nvmem/u-boot-env.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index 29b1d87a3c51..164bb04dfc3b 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -117,8 +117,8 @@ static int u_boot_env_parse(struct u_boot_env 
> *priv)
>  	size_t crc32_offset;
>  	size_t data_offset;
>  	size_t data_len;
> -	uint32_t crc32;
> -	uint32_t calc;
> +	__le32 crc32;
> +	__le32 calc;
>  	size_t bytes;
>  	uint8_t *buf;
>  	int err;

This looks counter-intuitive to me, to store values on host system in
specified endianness. I'd say we should use __le32 type only to
represent numbers in device stored data (e.g. structs as processed by
device).

My suggesion: leave uint32_t for local variables and use le32_to_cpu().
