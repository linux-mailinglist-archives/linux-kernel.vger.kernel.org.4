Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5A6104C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiJ0VwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiJ0VwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:52:12 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E88870B6;
        Thu, 27 Oct 2022 14:52:07 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id pb15so2923991pjb.5;
        Thu, 27 Oct 2022 14:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X93ycM+kLxHErIWtURA8L8exeaHt9regQ5pDIAbzkS0=;
        b=GXeMbffaMFuykrzvitrGEe2rO/secFaM5iEgWmx/dfZvy9pQCilLme3JkT08GdyxCB
         h9vuRbs7RKRHJx+kY0mPp6s93Z7AtwgZ9s6wjuYGUK0ma7OenSRcujnawJM3qxKr6Op0
         z/rMWyCC8CUpxLoPKp60xEZW0VXrJpGTH5WRI75o8X0n9r0/eeR7WH7tqqRmh0PkTctI
         nFT+DFlPkEBsJxBp1jvwouEfjAx6h1cRkNOnN1EcL0XsQgzJ6zjGZaLAv16O03JbibzQ
         +X4KZQIzbxJBF0d8eJ6JqPTt6gK+hIkNY0NdZJVre8wXL7hMTxi4lsLQRz8NlXDL9a/N
         Edxw==
X-Gm-Message-State: ACrzQf0oc4HgLyyPnTCgPYtr+29JGMMqfbEMZxllhdDoKyefquTQsPDO
        auUNJ2U+zrEimUfhMAIecL4=
X-Google-Smtp-Source: AMsMyM4/J1Mgt0PgewEVAt/TRafibQip+YEIMiITVhdtcYAPhTb/TWZOSky5J8YGz+kUFDtm6qjb9A==
X-Received: by 2002:a17:90b:4ac5:b0:20a:de32:366b with SMTP id mh5-20020a17090b4ac500b0020ade32366bmr12307796pjb.197.1666907526977;
        Thu, 27 Oct 2022 14:52:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id d18-20020a17090ab31200b002005fcd2cb4sm3133963pjr.2.2022.10.27.14.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:52:06 -0700 (PDT)
Message-ID: <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
Date:   Thu, 27 Oct 2022 14:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> +u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
> +{
> +	u32 qd, val;
> +	int mac;
> +
> +	mac = ufshcd_mcq_vops_get_hba_mac(hba);
> +	if (mac < 0) {
> +		val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> +		mac = FIELD_GET(MCQ_CFG_MAC_MASK, val);
> +	}

According to the UFSHCI 4.0 specification the MAC value is set by the 
host. Can the above code read the MAC value from the host controller 
before it has been set by the host? If so, how about leaving out the 
code that reads the MAC value from the controller and making it 
mandatory to implement the new get_hba_mac vop?

> +
> +	/*  MAC is a 0 based value. */
> +	mac += 1;
> +	/* max. value of bqueuedepth = 256, mac is host dependent */

host dependent -> defined by the host controller?

> +	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
> +	if (!qd)
> +		qd = mac;

How about using min_not_zero() instead of open-coding it?

Thanks,

Bart.
