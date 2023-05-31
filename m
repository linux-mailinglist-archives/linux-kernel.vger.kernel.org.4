Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D90718054
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjEaMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjEaMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:49:24 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89910C6;
        Wed, 31 May 2023 05:48:53 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77496b0b345so150008439f.3;
        Wed, 31 May 2023 05:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685537309; x=1688129309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqGnCPChL19fXfFgwza4KZGrYtNeSBi3Wbd7oMZ8AFA=;
        b=JxzsD3gmjS9QfK89JENp4pLAKtR3Cl9RqvjfLqmvJHDUUhFJhOiCm6Z/DmxRSYdXUo
         vtwSdFuAqoH74xfd+ZHLcnWrSl6qqNiIvrkQHT1vTXVYI5mx+lcLmJT59JZXJ70c+Rdp
         oa5nrvvzOmIA1+g3IN9WBro2W4O3yBNJSOyXAxRaKE20hSRfHzgZ/smzMzGs56eOD98q
         2TKbQ8pvNWZ+z/204CDzDRW3m5hWt5QyCu6eQWJE3aT/PqopGs0nVPL8oZKhKbcG0Slp
         m4jBX0vlNZ5UJj5dKWfIhelcCEkUCJLXf/V+Qaq6dVdcCxZTtdNGo7XG1Uhgo3oL44fF
         9hoA==
X-Gm-Message-State: AC+VfDyGZgxpefHh+NahFUxmzi14Pnqc53LeC646yzkbRvZDLynnNUtg
        0NedC6dhUJhSmHm6T9Otf+U=
X-Google-Smtp-Source: ACHHUZ4R4uX8mr/AZ2HXFs3fevTI77W0Xf8YIKy1DNJDCRdolpMdohmafLKGMFXSOzxIB2JLuXEyKQ==
X-Received: by 2002:a6b:d914:0:b0:769:a826:2818 with SMTP id r20-20020a6bd914000000b00769a8262818mr4531978ioc.16.1685537308401;
        Wed, 31 May 2023 05:48:28 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7880c000000b00646ebc77b1fsm3295119pfo.75.2023.05.31.05.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 05:48:28 -0700 (PDT)
Message-ID: <ec9c378c-fedd-5a90-bb12-085395e0d22e@acm.org>
Date:   Wed, 31 May 2023 05:48:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
Cc:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-2-powen.kao@mediatek.com>
 <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
 <CAGaU9a9TsoaUtoMX8cNmAhfBnCddRtWYEG8ACdRNJfri+sdasg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGaU9a9TsoaUtoMX8cNmAhfBnCddRtWYEG8ACdRNJfri+sdasg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 18:54, Stanley Chu wrote:
> In addition, some benchmark data shows that the performance can be
> improved by using fewer CQs to aggregate the interrupt handling of
> completion requests.

What has been measured? IOPS only or both IOPS and latency?

How big is the difference? A few percent or more?

For which number of SQs and which number of CQs has performance data 
been measured?

Would the following work instead of introducing a new vop?
- Introduce a new capability flag, e.g. UFSHCD_CAP_SINGLE_CQ.
- Set that flag from inside ufs_mtk_init().
- Modify the UFS core driver such that the number of completion queues
   depends on the UFSHCD_CAP_SINGLE_CQ flag.

> Therefore, we would like to introduce a vop to allow the host to
> configure it accordingly.

We do not accept new vops upstream without a user. Where is the 
implementation of the new .config_cqid() callback?

Thanks,

Bart.

