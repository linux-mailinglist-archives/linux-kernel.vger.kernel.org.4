Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78770A2FD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjESW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjESW46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:56:58 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D5101;
        Fri, 19 May 2023 15:56:56 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2533a03388dso2688045a91.2;
        Fri, 19 May 2023 15:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537016; x=1687129016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XhktrS4pjZiSF5CEkm3e0GzTVsAdSXWeFoG2dQLx48=;
        b=CC2W9orn6ZvkLghjBRJdudFMsMIP3IWBex/mnJqNA4H546+BeSYM2lI5UB78CCqxo1
         47X4K08QRWqbjnBlwJ/nDmPK+5Dp3i93eVgcU7AqT+/7yiSpv00D2JQMKS7xIgaA3H2I
         jGASFgr2NgoJyknrq1rugtbFVVPjh150be+gDYFFfibFxYQxDzxUaLaroFao/0wvNmrG
         2vpc3cOfKgSY+JbHV0QQDB225ldMJ3BRAxPuct26sIvU+ENY1IY/AMGtStJmCSikxSew
         8i+2iYEw2rhdQvY/+JzbeNBlUkiZ4/LkXSNRtSyX044G1HGDHgmvv1n9qHK9P/XDVf3i
         09aw==
X-Gm-Message-State: AC+VfDyXtrgr6tRGpiNuyvLK0/QH5AhTpgLOQp+b97uWXhrBgE+443TK
        1TGY5C/KX2RN+VBzhuHhf7GbTgmzlwc=
X-Google-Smtp-Source: ACHHUZ5RNlOvKy/+siOiFnOai/5TiFKjqwC0RcKJx8TBxt/xuO0VfDShkEj+HZKyRGNVfJ0jZX5n2A==
X-Received: by 2002:a17:90a:5792:b0:24d:f2f5:f571 with SMTP id g18-20020a17090a579200b0024df2f5f571mr3586528pji.36.1684537015922;
        Fri, 19 May 2023 15:56:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a4a0400b00250cf4e7d25sm1915151pjh.41.2023.05.19.15.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:56:55 -0700 (PDT)
Message-ID: <7c1dd111-e1cf-e806-7d74-f65138e8fca3@acm.org>
Date:   Fri, 19 May 2023 15:56:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/7] ufs: mcq: Add supporting functions for mcq abort
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <e95d40f2d9e473b809d6aa54cfa85b9d1a2e8b15.1683872601.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e95d40f2d9e473b809d6aa54cfa85b9d1a2e8b15.1683872601.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 23:28, Bao D. Nguyen wrote:
> Add supporting functions to handle ufs abort in mcq mode.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


