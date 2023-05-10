Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484456FE1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjEJP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjEJP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:56:19 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF36EA1;
        Wed, 10 May 2023 08:56:18 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-643a1656b79so5010738b3a.3;
        Wed, 10 May 2023 08:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683734178; x=1686326178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXBPb0T0axiCTL0oMtUP2eFXZZ+7E7iyDGsMoIo5xLg=;
        b=Z1KMFY+Uy2ParN7MmgohHDniiIX7Z7SrJ0E9sldzA+kDt34hT1GgwTqn5nplQTppO5
         hyuOgEuWaecDCWoz/C44IShtSIkAii/b1A7yH+oKg9rF3h4p2eUT94ntZH2aq2Zpwzaz
         C1fcPQ+W3+OvwhdDL2uTltSJ1JQpWgbykfZjgZsQmxbp1kkEeny7aoIMpBf+JHb5lGBt
         NXigEirO0x/89y8pxGB1h9vT9H1DFX7ArBJujBe+NDzEzt8p4givboeEJM5RwfW7Cv9u
         v6RdPLMCAOFJx2cdTBqyMdFI4mOchBrAYGqKuwH8WXAR/CGZHu59nGnOmF/Qcd7xLs6G
         mYeQ==
X-Gm-Message-State: AC+VfDwi1EDFZvWfUiirz4Ssxyrr4r81uZMnhZQ95jjiC9zZxECsqXvw
        KP9XpQiVPhTcGMvhgmyU0Fs=
X-Google-Smtp-Source: ACHHUZ4jAmb3ZAKDgW/JSwT3hbLErDK8VFH/SqJrjFHj7Uk+rZBbni5StqhaUujw2nmb2aTyt4kfDA==
X-Received: by 2002:a05:6a20:432a:b0:100:5a09:4524 with SMTP id h42-20020a056a20432a00b001005a094524mr13881691pzk.31.1683734177883;
        Wed, 10 May 2023 08:56:17 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:5242:f5e6:864f:4fb2? ([2001:4958:15a0:30:5242:f5e6:864f:4fb2])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b0064550f76efesm3741316pfa.29.2023.05.10.08.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 08:56:17 -0700 (PDT)
Message-ID: <31af3339-d90e-f0bd-4c9e-0da9f8728ce4@acm.org>
Date:   Wed, 10 May 2023 08:56:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Ed Tsai <ed.tsai@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "alice.chao@mediatek.com" <alice.chao@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "naomi.chu@mediatek.com" <naomi.chu@mediatek.com>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <DM6PR04MB6575753742F933DE192E7325FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dcfae203-005f-928b-37d6-7ee5bb4e2971@acm.org>
 <DM6PR04MB6575F344EF2D962103888A56FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
 <6192fa07-ec6f-0464-deb6-c3e9f69f6ebf@acm.org>
 <BL0PR04MB6564242D93EE6826CF1F6747FC779@BL0PR04MB6564.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BL0PR04MB6564242D93EE6826CF1F6747FC779@BL0PR04MB6564.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 22:21, Avri Altman wrote:
> Why it was needed to invent a new flag instead of  just clear 
> BLK_MQ_F_TAG_QUEUE_SHARED?

Hi Avri,

The meaning of BLK_MQ_F_TAG_QUEUE_SHARED is "the tag set is shared
across multiple request queues". Clearing BLK_MQ_F_TAG_QUEUE_SHARED if
the tag set is shared would be wrong: it would break all the code
outside the tag allocation code that tests this flag.

Thanks,

Bart.
