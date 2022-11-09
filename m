Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297776235B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiKIVVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKIVVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:21:50 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB94331DDD;
        Wed,  9 Nov 2022 13:21:49 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3146751pjk.1;
        Wed, 09 Nov 2022 13:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/qpazwmHNb1kTavxxA7OmYcuZDUuXRfFRysZjv0UwI=;
        b=AKTW8VifZkD0+49wLulun6ko60soIh1NHBIS5qBL2HwaodzLKjpXsyTnB5F3ZWoJnC
         5ZM7/pShoAfHJJxMYd7Hep4j6LNFLBdxB4cYYjG0EuAsWpMkkHYX73aLic6aivL3FjZC
         dHQaJB3uWHZhxNPVIQ33Anm7A+2ktBVj/sZNXQWRlzLe3vACnUUF3y4LCOJWSkRvn1tA
         0Zy0JPTFt/swIALM4QJkUGcA+aMnO7yG2+fDhndc0GZTJE6GZSiG2YHdFW3h2v1c3nsO
         f2tIgeJyakx8TaxLWvyh4G6Fald23dmJsUr9X9fEa7VdG8ySYU1nes4Gdhe8eW4ZAUBP
         hl1w==
X-Gm-Message-State: ACrzQf1w+RFbEFCLpO3SIhaR8Pl4L7I7PvjCYhBf8d1BVPOf1qpzMkNp
        o4N0mEgXehPZZdHjAEAcv8zH8xYA0S8=
X-Google-Smtp-Source: AMsMyM4L14zVvKdVNiUfkyspdMfJgRrqXgmZ+nOVR19w4ggPBy84me+ST+Z6ND3YHbOat9b97SdiaA==
X-Received: by 2002:a17:902:d4c7:b0:186:8cda:c9c3 with SMTP id o7-20020a170902d4c700b001868cdac9c3mr60922535plg.154.1668028909066;
        Wed, 09 Nov 2022 13:21:49 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b00176e6f553efsm9629589plz.84.2022.11.09.13.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:21:48 -0800 (PST)
Message-ID: <2e3adf52-8d9f-bb6d-5f02-cc3032e9b1ab@acm.org>
Date:   Wed, 9 Nov 2022 13:21:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 06/16] ufs: core: mcq: Configure resource regions
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <1d571cf3e8d07933f7d6d1c0bfd30402f3a5abbf.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1d571cf3e8d07933f7d6d1c0bfd30402f3a5abbf.1668022680.git.quic_asutoshd@quicinc.com>
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

On 11/9/22 11:41, Asutosh Das wrote:
> +	/* Manually allocate MCQ resource from ufs_mem */

Manually -> explicitly? The meaning of "manually" is "by hand and not by 
machine". Software is always executed by a CPU (machine) so nothing 
happens manually in software.

> +	ret = insert_resource(&iomem_resource, res_mcq);
> +	if (ret) {
> +		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
> +			ret);
> +		devm_kfree(hba->dev, res_mcq);
> +		return ret;
> +	}
> +
> +	res->base = devm_ioremap_resource(hba->dev, res_mcq);
> +	if (IS_ERR(res->base)) {
> +		dev_err(hba->dev, "MCQ registers mapping failed, err=%d\n",
> +			(int)PTR_ERR(res->base));
> +		ret = PTR_ERR(res->base);
> +		res->base = NULL;
> +		remove_resource(res_mcq);
> +		devm_kfree(hba->dev, res_mcq);
> +		return ret;
> +	}

I see duplicated code in error paths. Please move the code for freeing 
resources past the "return 0" statement and use goto statements to jump 
to that code in case of an error.

Thanks,

Bart.
