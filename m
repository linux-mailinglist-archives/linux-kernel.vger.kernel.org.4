Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5991B70A2F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjESWxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjESWxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:53:10 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C911BD;
        Fri, 19 May 2023 15:53:09 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64d2467d640so2559834b3a.1;
        Fri, 19 May 2023 15:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536789; x=1687128789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6DvZRhRSgpFSsqZJXPLzouaL3pfMhi0ojIdoZK57HM=;
        b=kAqMdv4SmjW9ae4KS4CJ45U+JcI1S67ifn1DYRFXkiofbItbQY0fv0b2HiShplrrZ7
         dENCL56qNt2S3B1MGkWaknp7Aqu+B7Xpgqy23CMgiKREvYSPqigu/72kJ8BgnaAQZ/lo
         ccWcHA8DIEoBmokJ+uwccgp6InG0/Vn8+z9pRUeoYbwMd0cu1rZUUn5fbfdWFJ2MDC8/
         87IheThk3R59Xlumey+QtckrpmNFRgctdVHPsjfc+9lsZ0hM1wGDa4hIwB9GJKjzWRif
         GkV+vM7XXzdiDKmGG4jBmpudhQ7tM44QRTafD6dVnyYEKk3Vs6oKPtOx1x8tli0qKjUj
         IoKA==
X-Gm-Message-State: AC+VfDz/xAhpIPQDXgINLbhvtm9hGaxj2SD0pKea6RJptUiYHg4NzxMO
        tt9n7KE8Tqdnlz69l24EOiSri4QyEC8=
X-Google-Smtp-Source: ACHHUZ5r5G3UFYDG2bKUkHedq0WIDJFGTUiH+tZEZXjuMVhiTZPbHTqusv8qSED9BHtqMooGP4+Zrg==
X-Received: by 2002:a05:6a00:15c7:b0:62d:d045:392 with SMTP id o7-20020a056a0015c700b0062dd0450392mr5151989pfu.32.1684536788813;
        Fri, 19 May 2023 15:53:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78d50000000b005aa60d8545esm187968pfe.61.2023.05.19.15.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:53:08 -0700 (PDT)
Message-ID: <72c3d1b1-69de-b91b-09e4-08875a3602d9@acm.org>
Date:   Fri, 19 May 2023 15:53:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/7] ufs: core: Update the ufshcd_clear_cmds()
 functionality
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <91bddbc5945a7a651bb1edc35ac5ff54a20bf6c1.1683872601.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <91bddbc5945a7a651bb1edc35ac5ff54a20bf6c1.1683872601.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 23:28, Bao D. Nguyen wrote:
> In the ufshcd_clear_cmds(), the 2nd pamameter would be the
> bit mask of the command to be cleared in the transfer request
> door bell register. This bit mask mechanism does not scale well in
> mcq mode when the queue depth becomes much greater than 64. Change the
> 2nd parameter to the function to be the task_tag number of the
> corresponding bit to be cleared in the door bell register.
> By doing so, mcq mode with a large queue depth can reuse this function.
> 
> Since the behavior of this function is changed from handling
> multiple commands into a single command, rename ufshcd_clear_cmds()
> into ufshcd_clear_cmd().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

