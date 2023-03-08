Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA7F6B1172
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCHSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCHSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:53:32 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264DB53C4;
        Wed,  8 Mar 2023 10:53:26 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id a2so18614545plm.4;
        Wed, 08 Mar 2023 10:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo5iZIVCpsc6WipDqKqc0Cf6s6LcIC4WeUZ0sxhn9MM=;
        b=5VLECZFa76LVLXmT3/vzjysiEJTAWuRXWRuoCqtOdz4A2OvpnaURlW73Vl/KL6/1TE
         54EgS+NIw/z7RNKOXegKLfVRziiS3oZS5tRG4nMTFLs6ubPNnqdRwk6jrt6B2C09YdPV
         FWWx+8qT2yasrQK3csUdfq8rPzKVUIsQHqAnbJQWKo9985HxAj65cIxsmPQA3ZvhxPfg
         OFLc4WSX6S8OivAc+owIaDl7Tt9e5Js8n76eO/sZCRzjSrnmbJu8eBwkFob7MCNhjyv1
         Y2h5xgvi8dYXae+/uyoh9ZN28XmMJoNUWvl2/Wm6jEj3/dKmrA9J9nrOq1exNWhXpsML
         bn0g==
X-Gm-Message-State: AO0yUKUFIqqq+LAy/c84/bhZUZiRprdWzbP0oe1ucg+l+SbFi/ug6j2x
        4SDnD4YSzydThgi6GfBPQl8=
X-Google-Smtp-Source: AK7set9ev5koA42vJU8VZ8pRd7u19QyKlDCpnRlLuQ2Xyr12DiulyGAHiVCrQSHI7uTVkfysbf6iyA==
X-Received: by 2002:a17:90b:3907:b0:234:b964:5703 with SMTP id ob7-20020a17090b390700b00234b9645703mr20265178pjb.18.1678301605462;
        Wed, 08 Mar 2023 10:53:25 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id kz5-20020a170902f9c500b00196025a34b9sm10117371plb.159.2023.03.08.10.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:53:24 -0800 (PST)
Message-ID: <30fea558-75bd-8d5c-b981-079fca5c1bf5@acm.org>
Date:   Wed, 8 Mar 2023 10:53:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1 3/4] ufs: mcq: Add support for clean up mcq
 resources
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <392b790072c2307d366ac80b7552d5f09ae25dfc.1678247309.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <392b790072c2307d366ac80b7552d5f09ae25dfc.1678247309.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 20:01, Bao D. Nguyen wrote:
>   static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
>   {
>   	unsigned long flags;
> +	int err, result, tag;
>   
> +	if (is_mcq_enabled(hba)) {
> +		/*
> +		 * MCQ mode. Clean up the MCQ resources similar to
> +		 * what the ufshcd_utrl_clear() does for SDB mode.
> +		 */
> +		flags = (unsigned long)mask;
> +		for_each_set_bit(tag, &flags, hba->nutrs) {
> +			err = ufshcd_mcq_sq_cleanup(hba, tag, &result);
> +			if (err || result) {
> +				dev_err(hba->dev, "%s: failed tag=%d. err=%d, result=%d\n",
> +					__func__, tag, err, result);
> +				return FAILED;
> +			}
> +		}
> +		return 0;
> +	}

Please change the type of the 'mask' argument from u32 into unsigned 
long such that the assignment of 'mask' to 'flags' can be removed.

Thanks,

Bart.
