Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7135E71A06D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjFAOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjFAOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:39:11 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9611AE;
        Thu,  1 Jun 2023 07:38:51 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso1664693a12.1;
        Thu, 01 Jun 2023 07:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630331; x=1688222331;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXHq1UONbnZiz36F4lxFd4Y3lZ4zBSqIvo4+1HlfBRI=;
        b=KIEJgAczmje8pviilWN4jpZDXAGsdugi5D8+rBUSantm+994urueieLjvjHBmtqSzQ
         gGRVdnJzwN/88TxySXhrPUKUEqxkLfH2cdG02cd4W0ry10FhG0xZ8Y42pwIjcRI2YL+S
         M8s3GlhsIZdNF+J2De1ae2BUrDySPZgBP4lIPhDOHjee9fZnnrcHudN0QeTbbURrV+Wj
         2m0vx76cCQFmH9/A0x8YB8pDjzZUPE7z1dg7Q7sf9JWLisq2NC7vNVrJb7y9FjIZAyVn
         299EhL1flHbBUeaGeyKtMxPRl7gAtAEYbYXUz13yzKHgEtoADflAp2WJykV4IiuXA9iu
         45UQ==
X-Gm-Message-State: AC+VfDwS3KHZzVghZbiwKPDcvHPOnuKvIlFUGAj7MIMp2/Xb3iBX0Mhx
        wLqsUqzAyViUoLe9fmowKyQk537Cc+0=
X-Google-Smtp-Source: ACHHUZ5zBhzSMBxdcBSPgIJ+gpOms+7QsXzG8xr+P5SVzyzxvrL8VPh8md7dtAuE77q15BErprIWow==
X-Received: by 2002:a17:903:449:b0:1b0:3d03:4179 with SMTP id iw9-20020a170903044900b001b03d034179mr2055861plb.6.1685630330637;
        Thu, 01 Jun 2023 07:38:50 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001ac381f1ce9sm3575354plq.185.2023.06.01.07.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:38:49 -0700 (PDT)
Message-ID: <4f092b70-bfaf-8c6a-9f30-cd7b797ba2db@acm.org>
Date:   Thu, 1 Jun 2023 07:38:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] ufs: core: Remove the nolock version of
 ufshcd_mcq_poll_cqe()
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
References: <20230601090202.27035-1-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230601090202.27035-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 02:02, Stanley Chu wrote:
> Since ufshcd_mcq_poll_cqe_nolock() is no longer used by any users,
> it should be removed.

This description is not correct. ufshcd_mcq_poll_cqe_nolock() is called
by ufshcd_mcq_poll_cqe_lock().

Bart.

