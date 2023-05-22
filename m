Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860270CE53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjEVWuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjEVWt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:49:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB59C171C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:49:13 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 28D223F22B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684795752;
        bh=w6LBF4xkFc2OoIdapGt5yBGTv2AuIt1KhXDhRU5a+6k=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vdLscKfs4JmBf3tGm7FcKfnF67+Vkho5JjyRJWngbgzIRn7VZlIawXFbFq1nzcWTq
         50dJaZbvcYYR9JvZLOkH7/V01zKSVcHepZkrB80o4cKL0JwfKlMKhHJpGcvRNwB6PL
         x7OiEl+TyXYABJgV+fOUuj87MdQmWODluI8NTNETaAp0MiDrm5z/pwMSIQXqiaLNDs
         +12NHIVEUzDu1lNojzYFeVzvIqwixoNzqaC7ngkm4lBPxD3SRuRYClUKWbMVIum1ja
         1n7Z7O4SOFltdX9QB0SN4TiltJvLkw8Gjm+G/PVnS44CTM4u/LALtxkT9udrdNCHBD
         uLdaUVmovfmMw==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bf847b267so207397a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684795752; x=1687387752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6LBF4xkFc2OoIdapGt5yBGTv2AuIt1KhXDhRU5a+6k=;
        b=NVhBSPP/d1DuUE4c5e10cy5B8mM+h5CPka0y3hDmT4R5CbbSBgNynLg18ca96REpd4
         TSwKMeM0cx6dLOivB71giYcKDlYVpK8WWjmeK7Se6Gtykuwg7LD0gFbsXektAXjrLMZc
         ETl4pa/gmgtvtyGfILuNqtuvj4GVCSRefSnVeFBIrz9j9tR4FaiRstdyCPWujA/X+0gO
         hni0mjXyRW4apzCQHZaAQ5WL7p68LpqXkPHh0xaGU2lh255cywGcZ938XusrBlZCrkTT
         Piv7HgKHUH2FWejEVS3uRGIT6oubCOIemVPnKTFdV88r8bRjIc02+/nNx6sERSErLNE6
         qXsQ==
X-Gm-Message-State: AC+VfDxRhLk2qEikVpcyQzwHVhkELO6V4LPpEWc6Hf18B23H6fPbTKag
        P65IF+dMonZDJeSyv9k+ZbWDkS8iQBVfyieuiRqAh/pL2w/LH2DFBzUZJGobcbRi4x2sSy23TOP
        uczZBcnFdOFqFh+xCfxZ2X2zYyu1zL42rONsarNzylL+49KAO1A==
X-Received: by 2002:aa7:d146:0:b0:50b:cadd:21e6 with SMTP id r6-20020aa7d146000000b0050bcadd21e6mr10873095edo.8.1684795751922;
        Mon, 22 May 2023 15:49:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63MnW+rYe1R0AZYx0Mu6CR6Cy0/gy7HtlZZ7Uk2W7bAJ8AyDR0EinlvDH4CVEQ6H44YcYvpA==
X-Received: by 2002:aa7:d146:0:b0:50b:cadd:21e6 with SMTP id r6-20020aa7d146000000b0050bcadd21e6mr10873086edo.8.1684795751568;
        Mon, 22 May 2023 15:49:11 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050daa883545sm3473583edb.64.2023.05.22.15.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 15:49:11 -0700 (PDT)
Message-ID: <892c7de5-d257-d4d6-2bfc-62f543965cff@canonical.com>
Date:   Tue, 23 May 2023 00:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH 1/1] block: fix conversion of GPT partition name to 7-bit
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Olivier Gayot <olivier.gayot@canonical.com>,
        Daniel Bungert <daniel.bungert@canonical.com>
References: <4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
