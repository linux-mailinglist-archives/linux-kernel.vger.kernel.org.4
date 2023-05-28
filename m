Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CBE714029
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 22:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjE1UaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE1UaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 16:30:04 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F52AF;
        Sun, 28 May 2023 13:30:03 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b04706c974so946405ad.2;
        Sun, 28 May 2023 13:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685305802; x=1687897802;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3c7ui0/0zw8IQNoKpfcjNz481KA4SVJAj1O/dOTWz+I=;
        b=Eawk4uMKEv96dj2SZoPKpvgEqfju/75vrNvdDte68yrUoO4jEd3cZ2PPKeSGVrHavK
         F+Byo2ekaEvHGZMojcE56c5dQP38cAcfZKQCeDm06K966EYoVis2XFDfgSRlNcrjspGc
         IkaXqNcEk5lZYkLZYekJaF/usCn/END1Q3A6nfgIhqEDiJMUIL19FHKi/k7K+l7UvxEj
         diG9FWZHijgY26WL/ecgmmQrg0dfXeYHFe9iYc7U8HK93zNo7u8pDDQmFBUQz3HqX0bC
         f4vCdXRdVGoJIxV7pRy625NiY+u8/pUqXscZPxJs3zqXuWoZihJAV089r2RbFDWF8U9N
         IWng==
X-Gm-Message-State: AC+VfDwyLW+wYL5dXN3gUopQ0L7iTglI1UNwlGLEXpSiEd0QANpw2uQE
        ZjyvreaAbnv40NBZ5Nnha8sYXG4faDg=
X-Google-Smtp-Source: ACHHUZ72JUTyDD3Z/8V2/4u60WttgODbYdRvA0+Cr7LqFxCiOzY4TKJqg0d4xnI/MlCQ9cZwrO009g==
X-Received: by 2002:a17:903:2442:b0:1af:bbfd:1c07 with SMTP id l2-20020a170903244200b001afbbfd1c07mr9906437pls.57.1685305801890;
        Sun, 28 May 2023 13:30:01 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d68200b001b03842ab78sm1453118ply.89.2023.05.28.13.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 13:30:01 -0700 (PDT)
Message-ID: <c86f90b4-458a-3066-4a8e-6e510a41a37d@acm.org>
Date:   Sun, 28 May 2023 13:30:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: scsi/stex time_after() build warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <89df78d0-fb52-9045-2074-1d6f0afae4d9@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <89df78d0-fb52-9045-2074-1d6f0afae4d9@infradead.org>
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

On 5/27/23 16:08, Randy Dunlap wrote:
> When I build stex.o for i386, I see these build warnings:

Are you perhaps using gcc 13?

Has the following alternative patch been considered? I think this patch 
is lower risk than the patch in the original email:

diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 5b230e149c3d..8ffb75be99bc 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -109,7 +109,9 @@ enum {
  	TASK_ATTRIBUTE_HEADOFQUEUE		= 0x1,
  	TASK_ATTRIBUTE_ORDERED			= 0x2,
  	TASK_ATTRIBUTE_ACA			= 0x4,
+};

+enum {
  	SS_STS_NORMAL				= 0x80000000,
  	SS_STS_DONE				= 0x40000000,
  	SS_STS_HANDSHAKE			= 0x20000000,
@@ -121,7 +123,9 @@ enum {
  	SS_I2H_REQUEST_RESET			= 0x2000,

  	SS_MU_OPERATIONAL			= 0x80000000,
+};

+enum {
  	STEX_CDB_LENGTH				= 16,
  	STATUS_VAR_LEN				= 128,


Thanks,

Bart.
