Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1612F5BA1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIOT45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIOT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:56:55 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459895AF5;
        Thu, 15 Sep 2022 12:56:53 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so14008917pjk.4;
        Thu, 15 Sep 2022 12:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gyQyTPpOZ8LGCjvpI2ddL5xmk77BHkTjwD50wytUqtQ=;
        b=6yHX4yM+QXfnxcWc58gXRzr4muqzLMtQepRBP2l4MeU2r3rPoJGtDbZT+E225w1Avq
         tGgCHC0NG6UcFHpDrS3FXlgwbI8ldBKKkXkk2cMoa23avO6rtf4mGoaZNKWJyIO6btr7
         gy9SyID2VeQzVrV5kAPyXs95z00CVK0Rkfvn9e7JXtplW9D7CGWtP/sPe6zfCoQJstdQ
         OpTiHOT/JzZsv2cEd8VsvGzYfarU6GVWcnscuSY/xkfiVv2O4CKEeAlv3Y3k+3KvM3Dv
         tK79UXl/383k50t9eGIxN9sx+8OliTfJ7Ww0uyUe6v6lWDF/yNePmnvmBueiI1aWdWWq
         7LgA==
X-Gm-Message-State: ACrzQf1VFENR78Zym9ULarKIKvk+2LneS04OnEZvXxG8ldQi/RdRODNl
        LwBDLUMcDb1h5TCAMDC5aq8=
X-Google-Smtp-Source: AMsMyM55hVXIV0ScNgLxoKaWpwj9fO2GuHp8i0aZm9VTfQfTRzkCbTSBYnXjvmPe+MZlBs1DbfaF4w==
X-Received: by 2002:a17:902:8301:b0:178:7a61:c01e with SMTP id bd1-20020a170902830100b001787a61c01emr1239258plb.90.1663271812660;
        Thu, 15 Sep 2022 12:56:52 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c3e3:32a8:d0fd:8248? ([2620:15c:211:201:c3e3:32a8:d0fd:8248])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0017849a2b56asm6881371plf.46.2022.09.15.12.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 12:56:51 -0700 (PDT)
Message-ID: <df1b5b6e-5a98-00b3-0e23-6048463480a9@acm.org>
Date:   Thu, 15 Sep 2022 12:56:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Content-Language: en-US
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
References: <sc.suh@samsung.com; hy50.seo@samsung.com;>
 <CGME20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3@epcas2p1.samsung.com>
 <20220912193703.102267-1-hy50.seo@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220912193703.102267-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 12:37, SEO HOYOUNG wrote:
> Add ufs_hba_variant_ops about vendor error in check_error.
> It need to reset when occurred ah8 related error.
> At that time could not recovery with pwr cmd.
> So add vendor error check function at ufs_hba_variant_ops.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
