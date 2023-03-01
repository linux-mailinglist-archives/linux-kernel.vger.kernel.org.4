Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315AC6A73D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCASvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCASuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:50:55 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8644DE0A;
        Wed,  1 Mar 2023 10:50:46 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id oj5so10352704pjb.5;
        Wed, 01 Mar 2023 10:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zg98MgWwNc6aZh94xCdr9oJM0+ApGLWaqsOAQluX6tU=;
        b=S8jHp2fBWD83v51sWBrHZBdrc4qlWFO4tN2oTKW8rO8p7dflF060VHLPHn1f4Vzp/M
         yGVm/ErBK6YCJ3lVK/t0Zk1Xbnjdwdv9X2oCoJhica2ZaLQI4UWjLrOcX/P4a5TrHmkA
         6gyFb6olW4LCcQhiZ3p9cxvcbJ8x0buMWcYk4JzueCAxwuelW1GmdD2hC8wej377k6+2
         AHfiLNV0RyUN9+NBSo50/K5s7ViIu2pMtlbH2o/UNhkn9aJYBDJ9PvDiBhaCdFUpbSag
         xihktIodQOmxCoqw1hN5wF6I+5jKAckKJ0t+kPKlOhvGYXlxg1G/7OCw/9BcGCtS1YF2
         uq0w==
X-Gm-Message-State: AO0yUKX2EnIjL1g5zM4ISWqT5AGo6MuSYUGaGsts1xfd4Dj24TpQL/0Z
        EtTd5nX/64GrxQdHj9gdh5I=
X-Google-Smtp-Source: AK7set9u+NzbfYeo686zDMAFl04xD8Pph/E1g7L9BlqRFstkRybhM7M2i5bRLPKRUnTneqBFFO5e4Q==
X-Received: by 2002:a17:902:e886:b0:19d:b02:cca5 with SMTP id w6-20020a170902e88600b0019d0b02cca5mr7772883plg.12.1677696646037;
        Wed, 01 Mar 2023 10:50:46 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:e8e:76a3:8425:6d37? ([2620:15c:211:201:e8e:76a3:8425:6d37])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b00194c1281ca9sm8778424plb.166.2023.03.01.10.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:50:45 -0800 (PST)
Message-ID: <db9031f6-f0cd-fc79-a00d-c1f52abc286f@acm.org>
Date:   Wed, 1 Mar 2023 10:50:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Content-Language: en-US
To:     =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-5-powen.kao@mediatek.com>
 <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
 <74bedcff32df0c93c14b004814017f3344247528.camel@mediatek.com>
 <0c17dd26-b1aa-54b0-6dc4-561cd996cead@quicinc.com>
 <76f74b86-8ff1-2346-4f5e-0048543bd8b0@quicinc.com>
 <f629f1b72e4859d79aac279ef3327715000e3210.camel@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f629f1b72e4859d79aac279ef3327715000e3210.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 18:17, Powen Kao (高伯文) wrote:
> Sure, we can first integrate ur patch and see if anything is missing
> that need further upstream. Due to comapct schedule, I would kindly ask
> if it will be ready by the end of this week? :) Thanks

Please trim e-mails before replying and please reply below the original 
text instead of above. From https://en.wikipedia.org/wiki/Posting_style:

Because it messes up the order in which people normally read text.
Why is top-posting such a bad thing?
Top-posting.
What is the most annoying thing in e-mail?

Thanks,

Bart.
