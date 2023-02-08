Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F768F021
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBHNsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBHNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:48:15 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A7A7ED7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1675864089; bh=V74iFXKF/omacLYhrYBZwlx5iN04Z6Zve9ftByeokoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rDx88nTpiIImPV6haP/ykLRVMi1AlS9/izi5ZoPv2+IGq1Z9r4iGaVRDDL/Yo2Ahs
         GigKvfnxFvtWphWPNRM1H2wTT0pJzd2PjBZyB2UIZatUYBy1y15GsaVExIoN41KOgH
         hLTpM1HbajomtksE88dGJzz7LlAOXUgYXmwoIPfY=
Received: from [100.100.35.204] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 6311C6015B;
        Wed,  8 Feb 2023 21:48:09 +0800 (CST)
Message-ID: <5b3c9b61-7fd5-f50c-32ba-e857090b71bc@xen0n.name>
Date:   Wed, 8 Feb 2023 21:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Firefox/111.0 Thunderbird/111.0a1
Subject: Re: [PATCH] LoongArch: add checksum optimization for 64-bit system
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Bibo Mao' <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230207040148.1801169-1-maobibo@loongson.cn>
 <8fa91bca5e624861b190917933951c7e@AcuMS.aculab.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <8fa91bca5e624861b190917933951c7e@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/8 21:12, David Laight wrote:
> From: Bibo Mao
>> Sent: 07 February 2023 04:02
>>
>> loongArch platform is 64-bit system, which supports 8 bytes memory
>> accessing, generic checksum function uses 4 byte memory access.
>> This patch adds 8-bytes memory access optimization for checksum
>> function on loongArch. And the code comes from arm64 system.
>>
>> When network hw checksum is disabled, iperf performance improves
>> about 10% with this patch.
>>
> ...
>> +static inline __sum16 csum_fold(__wsum csum)
>> +{
>> +	u32 sum = (__force u32)csum;
>> +
>> +	sum += (sum >> 16) | (sum << 16);
>> +	return ~(__force __sum16)(sum >> 16);
>> +}
> 
> Does LoongArch have a rotate instruction?
> But for everything except arm (which has a rotate+add instruction)
> the best is (probably):
> 	(~sum - rol32(sum, 16)) >> 16
> 
> To the point where it is worth killing all the asm
> versions and just using that one.

Yeah LoongArch can do rotates, and your suggestion can indeed reduce one 
insn from every invocation of csum_fold.

 From this:

000000000000096c <csum_fold>:
         sum += (sum >> 16) | (sum << 16);
  96c:   004cc08c        rotri.w         $t0, $a0, 0x10
  970:   00101184        add.w           $a0, $t0, $a0
         return ~(__force __sum16)(sum >> 16);
  974:   0044c084        srli.w          $a0, $a0, 0x10
  978:   00141004        nor             $a0, $zero, $a0
}
  97c:   006f8084        bstrpick.w      $a0, $a0, 0xf, 0x0
  980:   4c000020        jirl            $zero, $ra, 0

To:

0000000000000984 <csum_fold2>:
         return (~sum - rol32(sum, 16)) >> 16;
  984:   0014100c        nor             $t0, $zero, $a0
         return (x << amt) | (x >> (32 - amt));
  988:   004cc084        rotri.w         $a0, $a0, 0x10
         return (~sum - rol32(sum, 16)) >> 16;
  98c:   00111184        sub.w           $a0, $t0, $a0
}
  990:   00df4084        bstrpick.d      $a0, $a0, 0x1f, 0x10
  994:   4c000020        jirl            $zero, $ra, 0

I guess Bibo would take this suggestion and check the other arches 
afterwards, okay? ;-)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

