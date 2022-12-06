Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE386447D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiLFPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiLFPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:18:37 -0500
X-Greylist: delayed 1379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 07:16:35 PST
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E893AE6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:16:34 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4NRPBn45zJz9sRf;
        Tue,  6 Dec 2022 16:16:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1670339777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2tn+THhDzeDHl34Ye809whLfPYSKOZ/DaLoqsuH3gk=;
        b=CcH/ZPCBwWHTCNc5diUTO2FLKkq9Jh92haUiNwm2C6BQVS8fM/HdtepOJ1Rzjq3/mDfLTa
        gm/uXrAvsReXdL/F2SVxR3R0JY3D86V6TWwhxe3WdifxbQSFxX15WCaV7z/FLn+lrozhRh
        lS3sSSePXlXPH2fJmKM2KHEzeB0jxTqbbXac7t2nxSxV1yW+pM2Z2lRujJh2iaRZ+xoNWs
        tdA7oLuiSGicwOqQr8H4/ofsv6vrXEznaVHRnw+ANy8ORZTj6P1r/Quhj0+tXKhC791nQR
        Zn2nW0GqAJpDbPBDT0vkIrZ4C9cLY9py6gy/LsbhxzIax9Nebugviu6XgJIYWQ==
Message-ID: <cdee3f7d-3f98-02dc-9fc6-18ffc489c6f8@mailbox.org>
Date:   Tue, 6 Dec 2022 16:16:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: compress: Add AC3, EAC3, TrueHD, DTS, MPEG-H 3D
 Audio Stream (MHAS)
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221206145317.99934-1-crg7475@mailbox.org>
 <d6da4f2f-d6d8-bab6-66f0-a4b2486d1922@linux.intel.com>
From:   Carlos Rafael Giani <crg7475@mailbox.org>
In-Reply-To: <d6da4f2f-d6d8-bab6-66f0-a4b2486d1922@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b032ba1a2d024997665
X-MBO-RS-META: sbrie75jug1xf9sa1fagpt9h1dw636p5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IEC61937 is quite commonly used, yes. However, I have been working with 
a commercial system that is getting support for these formats 
implemented via compress-offload. Since these formats aren't exactly 
uncommon, I figured that adding these could be useful, especially since 
only the #defines need to be added, nothing else.

On 06.12.22 16:07, Pierre-Louis Bossart wrote:
>
> On 12/6/22 08:53, Carlos Rafael Giani wrote:
>> These audio codecs are used in sound bars and digital TVs, and benefit
>> from off-loading to a DSP. In particular, Dolby Atmos and MPEG-H 3D audio
>> spatialization is done in dedicated DSPs. Thus, adding these codecs  to
>> the Compress-Offload API makes sense.
> The question is "how is the stream transported". In most implementations
> for these formats, the DSP is on the receiver side and the transport
> happens with an IEC61937 format - which does not require the use of the
> compressed API.
>
>> Signed-off-by: Carlos Rafael Giani <crg7475@mailbox.org>
>> ---
>>   include/uapi/sound/compress_params.h | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
>> index ddc77322d571..7a58e2026be3 100644
>> --- a/include/uapi/sound/compress_params.h
>> +++ b/include/uapi/sound/compress_params.h
>> @@ -43,7 +43,13 @@
>>   #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>>   #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>>   #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
>> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
>> +#define SND_AUDIOCODEC_AC3                   ((__u32) 0x00000011)
>> +#define SND_AUDIOCODEC_EAC3                  ((__u32) 0x00000012)
>> +#define SND_AUDIOCODEC_TRUEHD                ((__u32) 0x00000013)
>> +#define SND_AUDIOCODEC_DTS                   ((__u32) 0x00000014)
> IIRC there are multiple flavors of DTS, off the top of my head DTS-ES,
> 96, HD, Master Audio. "DTS" only doesn't even begin to describe the
> possible variants.
>
>> +/* MPEG-H 3D Audio Stream (MHAS) as defined in ISO/IEC 23008-3 */
>> +#define SND_AUDIOCODEC_MHAS                  ((__u32) 0x00000015)
> Doesn't this need the definition of profiles and various types of
> formats - classic problem with designed-by-committee MPEG codecs.
>
>> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_MHAS
>
>>   /*
>>    * Profile and modes are listed with bit masks. This allows for a
