Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA786CF4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC2Usc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjC2UsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:48:22 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9844B8;
        Wed, 29 Mar 2023 13:48:22 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id b7so1038187pfv.2;
        Wed, 29 Mar 2023 13:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680122902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzpgvE6nKQNuR4O/KkAOD/tL9byNb1qJHAAmJlyDmXs=;
        b=XEx9li+LOz+eBHn0gDdwnF/1MApOjVSzol7kkYjRzAxEhXqMwUhuWLj3HNoyDfMslF
         5D5+/tWhYsn8nVJSFgiKWIbHy7RBPudDteg6tseVbDxqhi+3cTZtuZYNDKHMLVAxG9H0
         EYSd1oI8e+up3PpWf7+4UqTSztPR8764d/W3FzDDjhsvuhyQLopkKOPj3/uwJ873rYpa
         jK7b2z/Jc7PpS7DVTkZ+sMlp97HrC/OVMQylq3G3djwtCQiLgxIGb7KuTSA2uF8ipzoq
         FWh/D4rg5GNiN10zDOT22ZrX9XILOvL8jILwkwHY0uwot8DuccjsATQkWcTOzOS7+XDL
         xaGw==
X-Gm-Message-State: AAQBX9ew3JYsFruCwqDmq+JhY/G3UgX1X6hgqgBWhw0kiZln5preOim8
        +PWoD5FOXBmo41VJxBEDw0c=
X-Google-Smtp-Source: AKy350bbqWlYjE+fXIlgWV7IZ86U6AitGIoUAUVrIh21So7TSrCV9nr+UuZrx6rHfXtVafWgqnhmHw==
X-Received: by 2002:aa7:9908:0:b0:5a8:a0df:a624 with SMTP id z8-20020aa79908000000b005a8a0dfa624mr18118299pff.22.1680122901632;
        Wed, 29 Mar 2023 13:48:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c058:cec1:e4c9:184e? ([2620:15c:211:201:c058:cec1:e4c9:184e])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b005a9cb8edee3sm23352538pfo.85.2023.03.29.13.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 13:48:21 -0700 (PDT)
Message-ID: <c3860fdc-9018-bb8b-e1e7-def3da77dc42@acm.org>
Date:   Wed, 29 Mar 2023 13:48:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] scsi: ufs: mcq: 2 minor cleanups
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230329101303.18377-1-avri.altman@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230329101303.18377-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 03:13, Avri Altman wrote:
> 2 (untested) minor mcq cleanups.

I cannot test this series. I hope someone else can.

Thanks,

Bart.

