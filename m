Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5552E5F3A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJDAYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:24:07 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C2252B7;
        Mon,  3 Oct 2022 17:24:06 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id n7so11155807plp.1;
        Mon, 03 Oct 2022 17:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZlIEylRGLBdWzVOp9/7uT68mfePWL3R9HT/LBHC0RSk=;
        b=rXVsLNWeDEkK0hkqyYFKy8w8ommLTLIAl6au+GPL9NJwwW9zENh80F9YHFrTMgwdcW
         BKLbC7hYQr0I9SZDCSyP/jSai4gVF+aWZiHQwjS2/YAtLS+4dLu6zwH4V/TVdjbjiIjr
         2dDiy5PX9LRccYVpkRZUBRS5kVltawTZ7CKvNiOpCZfc5fQ3x3znWKB+XtAyO3OKEx/H
         7fz5v3yG5SfgZ2y5R3n6sDA8sGprwziDx/X6pXe004MpTd/VyPohAW/+KzQVGlp+6flv
         W6wyAyWLurxnqYvMlk7/2E2CM2qaGMeRj9VaGl6k5rETaLLUtNcw04qtyO3+P6DIpehA
         hWxQ==
X-Gm-Message-State: ACrzQf2WXJrhl4u+mjqPT9+7YL8RXTYiREUegaTBSmvW9RXvIx0ktxSr
        zqYscRf4wX0qoT19GDEVqNA=
X-Google-Smtp-Source: AMsMyM4ww3P9R1BBmvg/a2newHXvdFWHzuvV0JG7sF2Yjly01BtaIMSCGTYeCJ4scPy6hGdvU5yCZA==
X-Received: by 2002:a17:90b:1a89:b0:20a:a3d8:b05a with SMTP id ng9-20020a17090b1a8900b0020aa3d8b05amr7362421pjb.224.1664843046134;
        Mon, 03 Oct 2022 17:24:06 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d17-20020aa797b1000000b0054a1534516dsm8221618pfq.97.2022.10.03.17.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:24:05 -0700 (PDT)
Message-ID: <d87e5f8c-c221-f5cb-0ae7-969867fbc9b5@acm.org>
Date:   Mon, 3 Oct 2022 17:24:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org>
 <a4084b27-dd2d-10df-493c-35998eed664c@acm.org>
 <YzOPJHSQsPtc5o0Y@bombadil.infradead.org>
 <33ee1c3a-d37a-b81f-68be-d1901c7dd6e8@acm.org>
 <YzdF72yRae7lnZAy@bombadil.infradead.org>
 <Yzt2upqiG2i/eHnV@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yzt2upqiG2i/eHnV@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 16:56, Luis Chamberlain wrote:
> Yeah I've gone ahead and re-read your original patch again the issue
> with that is it waits *once* for the refcnt to go to 0, but that does
> not forbit it from going back up, at which point you have a race which
> can still create the situation. Every subsystem is different, but for
> instance simply running a loop opening a device block file should
> suffice to bump the refcnt of a respective block driver module. So
> at least the patch itself won't ultimately address this issue I'm
> afraid.

Hi Luis,

Thanks for the feedback. I will try to find a solution that does not 
require to modify the kernel module code.

Bart.

