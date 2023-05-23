Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7570D652
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbjEWH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjEWH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:56:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140610EF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:55 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 890E141271
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684828500;
        bh=qtqNtwIvHhIeqkZGLNoRzzzucpyk3+iXCeDnt3ORDmY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VrkZ4bEeF39LPrEFDUT+X00Shpf49MeKvy9eDTqAkqTvbGtKbgoRor28Ya4JvdK95
         zhHnkv/kFMiPLv6ghYRombKvRJSoEsJArnFNvqq0sf6zpWq/yWcWEdBxnvu0Dpqgfu
         5XEz5um9+b+cHM2I4ZlH8YzldC4kjhtBMsloYMkGPcnf40WCEdVmzdSxydX2v+opej
         ytwu3AcuedT0Uxs0ioD9NxZC/2DlTOi+HnK4aLwu7qlDOZfKYK0r+ulXlq6VhyCkNo
         +SpvIW05cYMZs0QS8/SFhXr4cg7rtY9kEqUXjl8gQj38KVomVLtWpgAJg8h+TcQ1vS
         njjAWwSyU99Lg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a341efd9aso904100266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828500; x=1687420500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtqNtwIvHhIeqkZGLNoRzzzucpyk3+iXCeDnt3ORDmY=;
        b=A0QyCKizKFC1YKi+QpxCheq6oNBHEZ8O1u6wBtai+F7MkfNPnN//bzdoz0XVmpS3Kq
         JDUSBKNq4e6zs68X9dnHoGPj1iB8mVLhVlOD3KkKKSxn7NBPDGtucwc8azanVyoXW8FW
         qOEX5dbAEP+Xwj+tNwQ+p2A4Mux9tijiWdW/q7GjgPE1MCXr6/MO942NuXQRA/P0a3US
         qoPcV8/VcTofJZvVXlv8KLr1Vtpj6vLe26FkF65w93Id2pWGVSo9BuIjq+wXTw1jzrgJ
         enaCr+C7QfSiOHXqVXofZvzoJa6Au40B+perSdqrTVZSr4DnLNhrrKCT+a5PTPHnrfLw
         baaQ==
X-Gm-Message-State: AC+VfDxKxSDzDlDZ7V9Q0uGowUrwwn97DVGwMMXQrJWcHJ+e9WbCj3ef
        ijXOrt69KuyikicwrLuKn63Rod3deTp7loiBPic6GvIGVtAQWLZy5Z6vw1tipQqWeJ00z5zfBCZ
        2jLlY0y6kj7PVO6AzTiigyjel7osiL0jKO6S2+ZGEJwXVf7V9euJG
X-Received: by 2002:a17:906:9b84:b0:968:2b4a:aba3 with SMTP id dd4-20020a1709069b8400b009682b4aaba3mr16313190ejc.5.1684828500276;
        Tue, 23 May 2023 00:55:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fSgDV8mfBBEU3q/qNohso/VI8Hks7zkK0UCj0MoQ5SQcWGXBW8Ig3nAJC1XyBZ6Nwic+v7A==
X-Received: by 2002:a17:906:9b84:b0:968:2b4a:aba3 with SMTP id dd4-20020a1709069b8400b009682b4aaba3mr16313166ejc.5.1684828499996;
        Tue, 23 May 2023 00:54:59 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090657ca00b00960005e09a3sm4106862ejr.61.2023.05.23.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:54:59 -0700 (PDT)
Message-ID: <e16bcbb5-c2fe-f168-410b-824358f0a48e@canonical.com>
Date:   Tue, 23 May 2023 09:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v2 1/1] block: fix conversion of GPT partition name to 7-bit
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bungert <daniel.bungert@canonical.com>,
        Olivier Gayot <olivier.gayot@canonical.com>
References: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utf16_le_to_7bit function claims to, naively, convert a UTF-16
string to a 7-bit ASCII string. By naively, we mean that it:
 * drops the first byte of every character in the original UTF-16 string
 * checks if all characters are printable, and otherwise replaces them
   by exclamation mark "!".

This means that theoretically, all characters outside the 7-bit ASCII
range should be replaced by another character. Examples:

 * lower-case alpha (ɒ) 0x0252 becomes 0x52 (R)
 * ligature OE (œ) 0x0153 becomes 0x53 (S)
 * hangul letter pieup (ㅂ) 0x3142 becomes 0x42 (B)
 * upper-case gamma (Ɣ) 0x0194 becomes 0x94 (not printable) so gets
   replaced by "!"

The result of this conversion for the GPT partition name is passed to
user-space as PARTNAME via udev, which is confusing and feels questionable.

However, there is a flaw in the conversion function itself. By dropping
one byte of each character and using isprint() to check if the remaining
byte corresponds to a printable character, we do not actually guarantee
that the resulting character is 7-bit ASCII.

This happens because we pass 8-bit characters to isprint(), which
in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.

This results in many values which should be replaced by "!" to be kept
as-is, despite not being valid 7-bit ASCII. Examples:

 * e with acute accent (é) 0x00E9 becomes 0xE9 - kept as-is because
   isprint(0xE9) returns 1.
 * euro sign (€) 0x20AC becomes 0xAC - kept as-is because isprint(0xAC)
   returns 1.

Fixed by using a mask of 7 bits instead of 8 bits before calling
isprint.

Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
---
 V1 -> V2: No change - resubmitted with subsystem maintainers in CC

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';

