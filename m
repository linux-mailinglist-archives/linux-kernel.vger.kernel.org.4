Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A70D610441
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiJ0VSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiJ0VSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:18:25 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F214E62C;
        Thu, 27 Oct 2022 14:18:24 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d10so2963226pfh.6;
        Thu, 27 Oct 2022 14:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=217TEmeRSkgT5FXJL3tI+C7Nv9uUKHWlPOhDk+RYVKc=;
        b=cQZAkfH+EhSOksqzJ89qdYiOaDAPZSSo4MyeoZ8M5s+ZO9HAj8TPcbjSTxIkFh4blk
         zp1gUohommt/jM2zJOB8j17QlSareIS6fV0l/2Cx4e45Kv6TQMpuQO/u/zFdrb5Ojo2E
         iaE1jHGyrYMqTqHRw1ptS/QSqs8LJSaGwRqBDyRQVcGdCkXZhWPsnTlWomfovWGnjjPw
         alAgrDrXL7+fpfpHKXjEaZEihL576hoqRmcpgntPrPjgOgW+Lyy+5TKn+wGCjKwmB6Ed
         0qKr3rPtJe8699xIPuuyAej6N8hgdS48QwVOoDYh5eqmYc8ZfFrZ6FrfugpHoxq88LeI
         8rKg==
X-Gm-Message-State: ACrzQf1g5zTBC4v4sDLu350lpirWWUdRHGk20WrTAO/yuW/aoVSYx+jK
        /597M6iMrbYjeT27DaP44V4=
X-Google-Smtp-Source: AMsMyM53gvpEmxUdREpf4JaDPlbW1SXiEFjZX4DyQbljNPr0+zkz4lIxFltKaHkBNLos8/97RllzHw==
X-Received: by 2002:a05:6a00:1912:b0:564:f6be:11fd with SMTP id y18-20020a056a00191200b00564f6be11fdmr50036558pfi.32.1666905503861;
        Thu, 27 Oct 2022 14:18:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090a011700b00208c58d5a0esm3004972pjb.40.2022.10.27.14.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:18:23 -0700 (PDT)
Message-ID: <b48a1556-d5bf-ea57-7f84-bdf55246a70f@acm.org>
Date:   Thu, 27 Oct 2022 14:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 04/17] ufs: core: Defer adding host to scsi if mcq is
 supported
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
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <052c9049e4f3f6dc60e1254fbc67ee374f28a621.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <052c9049e4f3f6dc60e1254fbc67ee374f28a621.1666288432.git.quic_asutoshd@quicinc.com>
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
> If MCQ support is present, then enabling it would need
> reallocating tags and memory. It would also free up the
> already allocated memory in Single Doorbell Mode.
> So defer invoking scsi_add_host() until MCQ is configured.

The above probably should be modified to improve clarity. How about 
changing "then enabling it would need" into "enabling it after MCQ 
support has been configured would require"? Otherwise this patch looks 
good to me.

Thanks,

Bart.

