Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0C6A15B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBXEBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBXEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:01:01 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644D51FBD;
        Thu, 23 Feb 2023 20:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=zkYsf7JBSZv/sXOMDMBwHcxliwl6peLQurvQ5+qR8Us=; b=QbviJzG+kaRduJTBnTKv+ZuBt5
        2GJKnind+1FHlNSbGTdUd+V7Zl5udVrtQAC5RjUxTTsgn+wtxH3XMZeSAzoFzgxB10sEEYHLilQfa
        Rn827U/yx7P2H7/FmcbOtMSETVCpg5Ix7ODm4O88ZtSjuAwuTxqfSVmQVhoNCDz2hKlk76qZjN5EQ
        +ZdxBk9ATjsBdaz/kvIaWdPOm40JYA6H7Higdzd2rMkAAEXEnMkv06LcfJA87vWAWy00O95GNjl1X
        70wX7bLTeea1k+6sJ4R8UMCEzYAO9LVw2Yjd194cKLeOn8aTfciXY9FwC0gN77xOxmK8WegLsEEcV
        6/8MUUXg==;
Received: from [187.10.60.249] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pVPGM-00D84f-2z; Fri, 24 Feb 2023 05:00:50 +0100
Message-ID: <290b055f-9fc1-2580-244f-24663fba171f@igalia.com>
Date:   Fri, 24 Feb 2023 01:00:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] pstore/ram: Fix crash when setting number of cpus
 to an odd number
Content-Language: en-US
To:     Weichen Chen <weichen.chen@mediatek.com>,
        linux-hardening@vger.kernel.org
References: <20230224023632.6840-1-weichen.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, yt.shen@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tony.luck@intel.com, keescook@chromium.org,
        darren.chen@mediatek.com
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230224023632.6840-1-weichen.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 23:36, Weichen Chen wrote:
> When the number of cpu cores is adjusted to 7 or other odd numbers,
> the zone size will become an odd number.
> The address of the zone will become:
>     addr of zone0 = BASE
>     addr of zone1 = BASE + zone_size
>     addr of zone2 = BASE + zone_size*2
>     ...
> The address of zone1/3/5/7 will be mapped to non-alignment va.
> Eventually crashes will occur when accessing these va.
> 
> So, use ALIGN_DOWN() to make sure the zone size is even
> to avoid this bug.
> 
> Signed-off-by: Weichen Chen <weichen.chen@mediatek.com>
> ---
>  fs/pstore/ram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66dbe5f39..fc57ac97e506 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -528,6 +528,7 @@ static int ramoops_init_przs(const char *name,
>  	}
>  
>  	zone_sz = mem_sz / *cnt;
> +	zone_sz = ALIGN_DOWN(zone_sz, 2);
>  	if (!zone_sz) {
>  		dev_err(dev, "%s zone size == 0\n", name);
>  		goto fail;

Thanks for resending! Feel free to add my:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Cheers,


Guilherme
