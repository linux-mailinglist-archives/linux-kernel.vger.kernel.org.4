Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC37F6B8408
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCMVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:36:32 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD7898D1;
        Mon, 13 Mar 2023 14:36:31 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id y11so14521301plg.1;
        Mon, 13 Mar 2023 14:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678743391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dZytMHjh8b67xix8O8bZdnN1Cx47vlb8v10mIqLg8o=;
        b=KHjxi/Cg9cur6Nsd2pX5mgSv3/r8NaXgoCm39cU71V7gBTII0iGbOL8cUTUnxLlioT
         noBHtT6ltrjuNT6p5waY75+qH3tvS8KkmnBDSZvWKMhteUq4z60PA89SFWzvt9ff0X+q
         PXN5ZE65+vuus13o2w6jX4mR5ozSU203mIcdSYRZGARAwfyzYLE1p7/XfUaNfMIM57il
         n2wzYLHkRg1YLUKuLDxo43ektKuh0/3GiXkQ2+OM5X5eWJzuqzEQIcxQ6Bm9L5mXFKiQ
         dhpN7/cFkqvUaBKdXNTo4JzJB86mr1RYvIdjU39Ye5+jkRYOt2uSaAZnzVC2iTi2A4EE
         JrlA==
X-Gm-Message-State: AO0yUKWk4IGdMU9d4Ll6p7rwPpm/RzvcyOhNlW2cWoAIP36zUHoxX5FR
        ZPRUqoat3P1/Jw/+Ijm69hScKo0aIPw=
X-Google-Smtp-Source: AK7set95DQi/rzm/uIe/p/jfOg3q8h1plmMCNBcRUGzfD97ucntNbYRG/dNYXe96dkgT9h0Tp7WxCA==
X-Received: by 2002:a05:6a20:7f8c:b0:d0:36d5:cf1f with SMTP id d12-20020a056a207f8c00b000d036d5cf1fmr12093386pzj.5.1678743391250;
        Mon, 13 Mar 2023 14:36:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cdb:df66:226e:e52a? ([2620:15c:211:201:9cdb:df66:226e:e52a])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b006247123adf1sm172621pfi.143.2023.03.13.14.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 14:36:30 -0700 (PDT)
Message-ID: <5d317f56-b1ba-e35a-a558-e462a70a4717@acm.org>
Date:   Mon, 13 Mar 2023 14:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 5/5] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com, mason.zhang@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20230307065448.15279-1-powen.kao@mediatek.com>
 <20230307065448.15279-6-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230307065448.15279-6-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 22:54, Po-Wen Kao wrote:
> +static unsigned int mtk_mcq_irq[UFSHCD_MAX_Q_NR];

Shouldn't there be one instance of this array per controller such that 
this driver can support multiple host controllers instead of only one?

> -	err = ufshcd_make_hba_operational(hba);
> +	if (!hba->mcq_enabled) {
> +		err = ufshcd_make_hba_operational(hba);
> +	} else {
> +		ufs_mtk_config_mcq(hba, false);
> +		ufshcd_mcq_make_queues_operational(hba);
> +		ufshcd_mcq_config_mac(hba, hba->nutrs);
> +		ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
> +			      REG_UFS_MEM_CFG);
> +	}

ufshcd_config_mcq() in the UFSHCD core already calls 
ufshcd_mcq_config_mac(). Why is there another call to 
ufshcd_mcq_config_mac() in the MediaTek driver?

> +	/*
> +	 * Disable MCQ_CQ_EVENT interrupt.
> +	 * Use CQ Tail Entry Push Status instead.
> +	 */
> +	ufshcd_disable_intr(hba, MCQ_CQ_EVENT_STATUS);

UFS host controller drivers should not call ufshcd_disable_intr().

 From the UFSHCI 4.0 specification: "MCQ CQ Event Status (CQES): This 
bit is transparent and becomes ‘1’ when all of the following conditions 
are met:
• Controller is operating in MCQ mode (Config.QT=1)
• ESI is not enabled (Config.ESIE=0)
• CQES set only for Events in Queues that do not have interrupt 
aggregation enabled or the Events that do not belong to MCQIACRy.IACTH 
counter operation criteria.
• At least one bit in CQISy is set and associated bit in CQIEy is set. 
y=0..31"

Is there perhaps a bug in the MediaTek controller that causes the MCQ CQ 
Event Status to be set in ESI mode? If not, can the above 
ufshcd_disable_intr() call be left out?

Thanks,

Bart.

