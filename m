Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFF16FC880
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjEIOEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEIOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:04:32 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035D4EE4;
        Tue,  9 May 2023 07:04:17 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6439d505274so3311094b3a.0;
        Tue, 09 May 2023 07:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683641047; x=1686233047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iYEfFTtNREDQTvxRbwhudL5byolCTLR+oROEUU0XWk=;
        b=cXaFOb3TYm5YAVgKvsnr+fUF4OGMyXeTAB54Q6bGl/cDQHuldc8pgDLD5HROtP1/1T
         LEG0iT1eOCymhxVDu+868sJeLalHO5o0v0KS6ROjhOtBL/iaDlo+V5Rdovvsf4oKqJkG
         bScaGifYEM+1JuGB2IFe4AAFrWWm0WvjV7xIZdTbFVy1WOihBauaxNhLppjipfjQ2Sc5
         anvlw1jI3zSNGHwuO1P2/J/1qvrBaTkGulZWnTBU3ttms9LjvE2nY2Ldu5BXr4aAupY0
         zZLlBqbU9sgqPFNf0TSDUMQiveGVJ9tQIwDwNzoPWu45JSrg9x0bTjS8QG6LvhVnlMl4
         DRjw==
X-Gm-Message-State: AC+VfDzJT2kpZ10Fqd4ReBCshqxheXefKT1gZV52twwNcR5OWWXR8s/3
        EyJ3lDmxjrdPeR+s+B8BXXw=
X-Google-Smtp-Source: ACHHUZ7bmLHWSD/owi64qe/gcPVVP1QwblzeAhOQrZYE11UgsG7VHYh36OLy+DLbg3Mw0K08Knb3Iw==
X-Received: by 2002:a05:6a20:244a:b0:100:5222:7c0d with SMTP id t10-20020a056a20244a00b0010052227c0dmr10023694pzc.52.1683641047080;
        Tue, 09 May 2023 07:04:07 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b0063d63d48215sm1842392pfn.3.2023.05.09.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 07:04:06 -0700 (PDT)
Message-ID: <dcfae203-005f-928b-37d6-7ee5bb4e2971@acm.org>
Date:   Tue, 9 May 2023 07:04:06 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575753742F933DE192E7325FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 01:03, Avri Altman wrote:
> However, I think the decision of that should be of the platform owner,
> And not in the core driver.

Hi Avri,

I don't see any use case in which performance of a UFS device would be improved
by leaving QUEUE_FLAG_FAIR_TAG_SHARING enabled. Are you perhaps aware of such a
use case?

Thanks,

Bart.
