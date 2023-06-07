Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F104972695A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjFGTBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjFGTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:01:34 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4411BF5;
        Wed,  7 Jun 2023 12:01:33 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-256531ad335so6278335a91.0;
        Wed, 07 Jun 2023 12:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686164493; x=1688756493;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCQq6w9tCTxruq8TeYqlXmiFHaDLEPuIhfTxDFbYYTc=;
        b=D9tsg7eYz9LA0t/XxCoAGHrSqjx+QOZPpP2nMESXzVBmndmajRqJ7sXkbcGKZ0A+F9
         H3oEatV+ihAVLusDq979XheOCes12jkTrYwwKGRPGcG6SRJkFh5y9oC6jrt+CZP9g5xS
         Zfxvbf/MZdsR6bQ94TQReGYDU/++QKpXXvAgk9/v70K96z1zgXa9lQWllN7uI9M4j4gg
         btsWpbFFe1fvjYSVkO4tLJhhQCA7FpgPYV3zbHMcLAxVpZpUmVRv0dd4IWpRPd7cDebN
         PnE045GlE9TbEpM9WTZ5NKBP4Fnha3tUdU0s+sC90zBo7we4e2+M3WRh0pTiiWoW8csv
         xeNw==
X-Gm-Message-State: AC+VfDy8xEWdGG2caUBSCY6hA3OlrVjm+S0VhC75VFzVlStijegt+i8z
        kp0KqFrRq/Y783ziWPKSz+0=
X-Google-Smtp-Source: ACHHUZ4qE8S8kRcHpYdvqrqxt90mHEl/0I3nOB5vucdJRUzg00YMqmvTsBjdgsTA6SxJB6vhamNuGQ==
X-Received: by 2002:a17:90a:1996:b0:255:c061:9e5b with SMTP id 22-20020a17090a199600b00255c0619e5bmr5778380pji.37.1686164492844;
        Wed, 07 Jun 2023 12:01:32 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090ae00a00b00256bbfbabcfsm1696996pjy.48.2023.06.07.12.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 12:01:32 -0700 (PDT)
Message-ID: <4eda6575-c124-3ca3-e772-567a7014d895@acm.org>
Date:   Wed, 7 Jun 2023 12:01:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] ufs: poll pmc until another pa request is
 completed
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
References: <cover.1685927620.git.kwmad.kim@samsung.com>
 <CGME20230605012508epcas2p140e42906361b870e20b1e734e9e4df06@epcas2p1.samsung.com>
 <67ce698df39ca0c277c078dca729d7f607b9feb2.1685927620.git.kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <67ce698df39ca0c277c078dca729d7f607b9feb2.1685927620.git.kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/4/23 18:15, Kiwoong Kim wrote:
> v2 -> v3
> 1) check time in the loop with jiffies, instead of miliseconds.
> 2) change a variable's name and fix a typo and wrong alignment.
> 
> v1 -> v2
> 1) remove clearing hba->active_uic_cmd at the end of __ufshcd_poll_uic_pwr
> 2) change commit message on the cited clause: 5.7.12.11 -> 5.7.12.1.1
> 3) add mdelay to avoid too many issueing
> 4) change the timeout for the polling to 100ms because I found it
> sometimes takes much longer than expected.

A change history like the above should either occur below the "---" 
separator or in a cover letter instead of in the patch description.

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
[ ... ]

There are two changes in this patch: the introduction of the 
__ufshcd_poll_uic_pwr() helper function and also the introduction of a 
wait loop. Please split this patch into two patches - one patch that 
introduces the helper function and a second patch that introduces the 
wait loop. That will make this patch series easier to review.

Thanks,

Bart.
