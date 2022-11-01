Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4486D614F35
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKAQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKAQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:30:03 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABA1CB2E;
        Tue,  1 Nov 2022 09:30:03 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id k7so4321503pll.6;
        Tue, 01 Nov 2022 09:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2GHjD229JwzIH1zM0q8wr8h+WcU6euFtyspK/NJZCk=;
        b=FXXiFLu6gb+JV/Ee+BzfC8boz4HQ/x6SkTq0L9o5h+233Luy+bpn8b27Of+R4nhTQu
         votzVWOXfauA7cPHz4dQc1tzbexo3qyQ/WCLbV9TC7zUfj654L6UtY5BFKYaIPzMji2y
         A1CeHA1sV0AI4IXUsBUaaucCd3gnbY0MfYUfqSEqwQHWs317CQhQSo3fXiljowrrRm9b
         Q/maZbNbClv/BxBBqaZ2WrBL8jyazUtoEl7bZG74iYSmWPWz2wJD5sIqFOOLoPCJlStq
         80h+AMXLn0mIWfFsSGIv0JWOo2KeNhfRphvs1y/I1s/2RpxwPLIUN0ddbKd3L6cHbSlm
         aRZg==
X-Gm-Message-State: ACrzQf0EhJg92Euw+ysj3UkNpqCDOfwdFN9JjBa09HtELOEOz/WWmvHF
        +TaZT4TKyYCHPLAGnl733wc=
X-Google-Smtp-Source: AMsMyM5NUmhbJYKYslY7dTDp55y9CBju7lTDRo+4rfia1Mw9t+3EfaL7U0OSsGJQADU3+yAwVK1bdA==
X-Received: by 2002:a17:903:2284:b0:187:2989:b7ed with SMTP id b4-20020a170903228400b001872989b7edmr8591622plh.120.1667320202459;
        Tue, 01 Nov 2022 09:30:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8574:e82f:b860:3ad0? ([2620:15c:211:201:8574:e82f:b860:3ad0])
        by smtp.gmail.com with ESMTPSA id x29-20020aa7941d000000b0056bc31f4f9fsm6698486pfo.65.2022.11.01.09.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 09:30:01 -0700 (PDT)
Message-ID: <bb9c46b0-1c6e-2dd9-c820-9e419ee9d44f@acm.org>
Date:   Tue, 1 Nov 2022 09:29:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 10/17] ufs: core: mcq: Use shared tags for MCQ mode
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <2fea9d4f0b8dfc2e2c82d176f0c928b0525d8110.1666288432.git.quic_asutoshd@quicinc.com>
 <DM6PR04MB6575F436DDB2AFE5500BF0A8FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575F436DDB2AFE5500BF0A8FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 06:06, Avri Altman wrote:
>>   static int ufshcd_map_queues(struct Scsi_Host *shost)
> This seems like an old version of ufshcd_map_queues - returns void now.
> Needs rebase?

Hi Asutosh,

Please use the for-next branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/ when 
preparing SCSI patches for the next merge window.

Thanks,

Bart.

