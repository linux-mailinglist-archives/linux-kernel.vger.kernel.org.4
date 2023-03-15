Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434596BB8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjCOP6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjCOP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:57:58 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D08F510;
        Wed, 15 Mar 2023 08:57:23 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id v21so10409731ple.9;
        Wed, 15 Mar 2023 08:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUQ8BcfnpLEcrlJdnAlkJ5rcaTKkeVtp7YAX904kG6c=;
        b=6K7FlUGxDn58X1830EZa7kfEXIqlLuEOLbU5sz+M2+N4BsYeta/PPpFpdUrr2AnXLE
         p+8Gt8ZDcnqgqy1UmxBTmopwWbpu0edXPRxYdSmu92ToUYq/38QABzBs29a/R1TE0RXY
         vh4hmH9fAAkJUK+bqizboglxfNWii/MfZBJxXWyL2mR2lT2f83MuZ37ivZuZ2yYYo642
         +faf9vmhHsuskzNvekUuXD5Evib37qbEcquAMjXvQfjJKVOiB6Zx72FUOlv4EdTJNxpF
         EUeAaByL0lU7rqWNcsVRUZAONIk0Wj/TS8DxZWVfBzIKlQdE7s8BkOawUEZs1it/We+H
         RAGw==
X-Gm-Message-State: AO0yUKUQtJ5YWVE47eiNzEA5FORKiheZZFoYltZTF/nVu6k/U2f9D5pG
        RMFex9JJBhP2L2/C1ykWhFE=
X-Google-Smtp-Source: AK7set8nweHQba5xfZ2tvJLUHP7QoWF79dvQ0iuX0TpW4JhE1AM28DCcxyuZzNG8k4C/TGwhjui+vQ==
X-Received: by 2002:a17:90b:3b4e:b0:23b:4c0a:edb1 with SMTP id ot14-20020a17090b3b4e00b0023b4c0aedb1mr297708pjb.15.1678895835815;
        Wed, 15 Mar 2023 08:57:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:558a:e74:a7b9:2212? ([2620:15c:211:201:558a:e74:a7b9:2212])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a910300b00233b196fe30sm1555290pjo.20.2023.03.15.08.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:57:15 -0700 (PDT)
Message-ID: <d530ba29-9170-0bc0-6313-4c51de8b354d@acm.org>
Date:   Wed, 15 Mar 2023 08:57:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] scsi: ufs: core: print trs for pending requests in MCQ
 mode
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1678865517-43139-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1678865517-43139-1-git-send-email-quic_ziqichen@quicinc.com>
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

On 3/15/23 00:31, Ziqi Chen wrote:
> We don't have outstanding_reqs bitmap in MCQ mode. And in consideration
> of the queue depth may increase beyond 64 in the future, we reworked
> ufshcd_print_trs() to get rid of usage of bitmap so that we can print
> trs for pending requests in both SDB and MCQ mode.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
