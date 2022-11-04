Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA5619DCD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKDQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiKDQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:51:48 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Nov 2022 09:50:13 PDT
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [IPv6:2001:7c0:2041:24::a:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76445D76
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:50:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id B58C7601D8;
        Fri,  4 Nov 2022 17:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
         h=content-transfer-encoding:content-type:content-type
        :in-reply-to:organization:from:from:references:content-language
        :subject:subject:user-agent:mime-version:date:date:message-id;
         s=dkim; i=@isd.uni-stuttgart.de; t=1667580214; x=1669319015;
         bh=pj277RfjavgOMXxkxmgYdkXpZpHKvXQ7aiX3sWgAewI=; b=GFmSKFotmghm
        p1/X/kmJnEXB0AqTkQ7zhONNg5HF2zQ8GJGrAjz9IVuTmLYq/aT5sLz9FuGfJYYk
        nlFK9bL+ptTcnHh9oYaHZy5DpDjjcjwnyqX7PousUSq5nXGm5iMo+au180EMyky3
        iSAgz7uKYxv1gGM/3ilfrPR1Cyr0Xtw5sGXy/Tc01HqSiM6K7xcfBtVieYQ3daZC
        puxM6jDQt9AFSzPyxFcnzp4zHZ24YRo08USjtXjRrPgKLLJh7vxmnUy7GQsV0FRZ
        SK39HEbEfq0hodhsUordLxZwTAXybOzTG0mEYU6Yn/yNJJdKZjH6ayaanLwZ4vKT
        AUpKovWT/w==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
        by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10031)
        with ESMTP id LIaqnECUk69N; Fri,  4 Nov 2022 17:43:34 +0100 (CET)
Received: from authenticated client
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Message-ID: <e7ebabf9-a7b2-6155-cdd0-5dafb6bb2a7a@isd.uni-stuttgart.de>
Date:   Fri, 4 Nov 2022 17:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
Content-Language: de-DE
To:     INAGAKI Hiroshi <musashino.open@gmail.com>, rafal@milecki.pl,
        srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20221012155133.287-1-musashino.open@gmail.com>
From:   Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>
Organization: Universitaet Stuttgart - ISD
In-Reply-To: <20221012155133.287-1-musashino.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 17:51, INAGAKI Hiroshi wrote:
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

Tested-by: Christian Lamparter <chunkeey@gmail.com> # PowerPC/MyBookLive
