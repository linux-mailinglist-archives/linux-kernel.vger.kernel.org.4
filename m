Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7D460325B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJRSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJRSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:23:56 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F58262F;
        Tue, 18 Oct 2022 11:23:54 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id h13so14904105pfr.7;
        Tue, 18 Oct 2022 11:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwZlsskLTT5GYX2e0o85RZ1hXTLVToD4VwKwKxi37tQ=;
        b=b8BTNgeE0lpFa/tOzi/dn2RZEjc45RUl7nW0t70oOl2VYZH0R/kElqSylhgtJtKt1F
         0jkOcGF2VaIbBk5EbV68OF49/jnaBrSO5Bbh0HbD4EQn2EB/LR4Jo/DjKGeOmneBP85+
         BoRW6Doj08XDPk+nH2+agzqTsA//vpnh1Xyaf9FAf+xbDbjlh2wQr8KjUH2j9uic7sme
         EQU+rxcef80pHSqgPM23rzi/zNJJ/RPpRHIImI9YmcxrBtR6PrrBBj5PkH2/o4B4+vtu
         u+DvsDww5yrl7+lELic3IinttkH5fQtQOrVfjDRQ1ajlIaO4ajEnxaMbeYP+u8ilgkHG
         YecA==
X-Gm-Message-State: ACrzQf0D9t5C01ykNIO+iVGJKmB4ncFzIkbrm1b0PTWzpzqPtJg8FMEU
        idhIhtXGknu5/a+AAnMO2Fw=
X-Google-Smtp-Source: AMsMyM4PCzstgeCURld+oc9VnSIugbawgOsMP4ssutj0hm9hSDj6WnuPhRatclW/xN3bcLhkOLSKKA==
X-Received: by 2002:a63:7e4d:0:b0:43c:8ce9:2a9f with SMTP id o13-20020a637e4d000000b0043c8ce92a9fmr3676574pgn.528.1666117433753;
        Tue, 18 Oct 2022 11:23:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:522b:67a3:58b:5d29? ([2620:15c:211:201:522b:67a3:58b:5d29])
        by smtp.gmail.com with ESMTPSA id e19-20020aa79813000000b005636d8aa98dsm9911968pfl.141.2022.10.18.11.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:23:53 -0700 (PDT)
Message-ID: <2495df25-c64c-443b-d9b1-258246a36b37@acm.org>
Date:   Tue, 18 Oct 2022 11:23:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] scsi: ufs: core: Use is_visible to control UFS
 unit descriptor sysfs nodes
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com, huobean@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018181627.326657-1-beanhuo@iokpp.de>
 <20221018181627.326657-4-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221018181627.326657-4-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 11:16, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> UFS Boot and Device W-LUs do not have unit descriptors, and PRMB does not
                                                               ^^^^
                                                               RPMB?
> support WB, we can use is_visible() to control which nodes are visible
> and which are not.

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
