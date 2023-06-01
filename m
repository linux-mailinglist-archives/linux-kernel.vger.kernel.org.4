Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C582719FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjFAOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjFAOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:23:45 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC231FC;
        Thu,  1 Jun 2023 07:23:44 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b0218c979cso4715885ad.3;
        Thu, 01 Jun 2023 07:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685629424; x=1688221424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhsrhrqIeqPr3ExRU8r0xtf++kKW8doMcoMqRSUUN8Q=;
        b=Zzj+fxaBjl+WbMhlCEyEznRB+Rr875B0/vYO9jg1sV8Mhr6ih8udf4GmRiVhpK2e0E
         6gD8EqhD12G8zOBl5YaNILvOn8Axb4wdvim+961aDs3GilPidqm6fwGEyo2MNp7Mg9z3
         xneYgAfxd84ZzPzJA/Rz3izKigrYjDWNjnBqwOhO9G+JKx5FT+CGOs+Vt0cyTgo6Gnfq
         Xot58w7bRy+T1Lvln+eG+t5+t54lr/bPp/jjeRfBMvG3Hi9XaS3X0hQjetCmGnzvEk3+
         Mi35CJX/SN3CkGvDoiSQvUCXsZxol+C56FGhl9+yqOdUR6dk0XVlYjSz8VNj63DHer3R
         EKMw==
X-Gm-Message-State: AC+VfDzVkhTnERzpMMoOh+JZpnue3Ws1U5oqZYPehqrebQCY6XCuXqF+
        Dv/OoSPL8lLtyj99DtVsGKk=
X-Google-Smtp-Source: ACHHUZ5mcym6G1j1+2kPrrHLCN8HX/Oa2eNbTlDZ1np2rvThUuhej8W26v0jWfskDo64l5S1V8M8yA==
X-Received: by 2002:a17:903:2285:b0:1af:ccc3:25d1 with SMTP id b5-20020a170903228500b001afccc325d1mr8091853plh.62.1685629424240;
        Thu, 01 Jun 2023 07:23:44 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001affb590696sm3519890plk.216.2023.06.01.07.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:23:43 -0700 (PDT)
Message-ID: <4ea8427d-8b09-d35f-0e2c-2df486b79692@acm.org>
Date:   Thu, 1 Jun 2023 07:23:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Content-Language: en-US
To:     =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        "chu.stanley@gmail.com" <chu.stanley@gmail.com>
Cc:     =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-2-powen.kao@mediatek.com>
 <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
 <CAGaU9a9TsoaUtoMX8cNmAhfBnCddRtWYEG8ACdRNJfri+sdasg@mail.gmail.com>
 <ec9c378c-fedd-5a90-bb12-085395e0d22e@acm.org>
 <fd0fceb04efa34e6d86f09c5554746cfcc5c993f.camel@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fd0fceb04efa34e6d86f09c5554746cfcc5c993f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 03:25, Powen Kao (高伯文) wrote:
> According to spec, driver is free to assign any SQ to CQ mapping. I am
> not sure if it's ideal to constrain mapping to specific kind.

As has been made clear several times recently during discussions around
LSF/MM topics, implementing all features of a standard is *not* one of the
goals of the Linux kernel. Whether a feature is defined in the NVMe, a SCSI
or the UFS standard, we (Linux kernel community) only support those features
that we consider useful and that can be implemented with a reasonable effort.
An example of a feature that probably will never be supported by the Linux
kernel is the "domains and realms" functionality from ZBC-2.

> Yes, please refer to
> "[PATCH v2 3/3] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
> platform"
> 
> +static int ufs_mtk_config_cqid(struct ufs_hba *hba)
> +{
> +       struct ufs_hw_queue *hwq;
> +       int i;
> +
> +       for (i = 0; i < hba->nr_hw_queues; i++) {
> +               hwq = &hba->uhq[i];
> +               hwq->cqid = 3;
> +       }
> +
> +       return 0;
> +}

Thanks, I had overlooked this. Do you agree that the above shows that the
flag I proposed in my previous email (UFSHCD_CAP_SINGLE_CQ) is sufficient
to support the MediaTek use case? I want to keep the SQ-CQ association code
in the UFS driver core because the next step will probably to switch from
one CQ per SQ to one CQ per CPU core for UFS controllers that support
multiple completion interrupts.

Thanks,

Bart.

