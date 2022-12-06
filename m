Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F946447B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiLFPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiLFPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:11:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233131208
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670339300; x=1701875300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vbNLnP7/re/Ow5iv7l3uOs46lA73kfK1Y2eH0t8Nfl0=;
  b=LI5KctzxS3ak3sMDjsNMJ3RwPj8o13N4VPyRlWgKJWmSD5XO2+t26nL2
   QyhwpQ82xmPjsaN8U+9LPSif+P5ck2QNDmNUspCiFE5hkL5qtfrTtBkKx
   SlbZYsoi8fJz9V3UiPkPVG4LHNAXA1lJUVxaI9hm2qYfD6DYZJyNzCgaV
   QpoZ/GUtliN70vdjrEEcyNKtcX2fOFa8RRIw+7F1aESBqltBjFfJxSOtA
   6660ZnSm0uKDPizN2eUMCY9GTJqPSbhQx2GCs2tw7w975BWj7dXX1qCnA
   A8pCPY1+ys593uaRYwHK3Mzamnwj4O7T8+Gu456lLASANl+MdGcVmnweg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="318501051"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="318501051"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 07:07:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891409743"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="891409743"
Received: from cjian12x-mobl.amr.corp.intel.com (HELO [10.212.125.207]) ([10.212.125.207])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 07:07:24 -0800
Message-ID: <d6da4f2f-d6d8-bab6-66f0-a4b2486d1922@linux.intel.com>
Date:   Tue, 6 Dec 2022 09:07:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ALSA: compress: Add AC3, EAC3, TrueHD, DTS, MPEG-H 3D
 Audio Stream (MHAS)
Content-Language: en-US
To:     Carlos Rafael Giani <crg7475@mailbox.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221206145317.99934-1-crg7475@mailbox.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221206145317.99934-1-crg7475@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/22 08:53, Carlos Rafael Giani wrote:
> These audio codecs are used in sound bars and digital TVs, and benefit
> from off-loading to a DSP. In particular, Dolby Atmos and MPEG-H 3D audio
> spatialization is done in dedicated DSPs. Thus, adding these codecs  to
> the Compress-Offload API makes sense.

The question is "how is the stream transported". In most implementations
for these formats, the DSP is on the receiver side and the transport
happens with an IEC61937 format - which does not require the use of the
compressed API.

> Signed-off-by: Carlos Rafael Giani <crg7475@mailbox.org>
> ---
>  include/uapi/sound/compress_params.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
> index ddc77322d571..7a58e2026be3 100644
> --- a/include/uapi/sound/compress_params.h
> +++ b/include/uapi/sound/compress_params.h
> @@ -43,7 +43,13 @@
>  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
> +#define SND_AUDIOCODEC_AC3                   ((__u32) 0x00000011)
> +#define SND_AUDIOCODEC_EAC3                  ((__u32) 0x00000012)
> +#define SND_AUDIOCODEC_TRUEHD                ((__u32) 0x00000013)
> +#define SND_AUDIOCODEC_DTS                   ((__u32) 0x00000014)

IIRC there are multiple flavors of DTS, off the top of my head DTS-ES,
96, HD, Master Audio. "DTS" only doesn't even begin to describe the
possible variants.

> +/* MPEG-H 3D Audio Stream (MHAS) as defined in ISO/IEC 23008-3 */
> +#define SND_AUDIOCODEC_MHAS                  ((__u32) 0x00000015)

Doesn't this need the definition of profiles and various types of
formats - classic problem with designed-by-committee MPEG codecs.

> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_MHAS


>  /*
>   * Profile and modes are listed with bit masks. This allows for a
