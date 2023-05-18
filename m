Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8D7088BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjERTyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjERTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:54:29 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370EAE43;
        Thu, 18 May 2023 12:54:29 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2533b600d35so2450520a91.1;
        Thu, 18 May 2023 12:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684439668; x=1687031668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wdolwlpbuv2Z12HD1Qbe+hXD0bhyAObpIkruQgw9vI=;
        b=e9BiXNihF9FTyIjrZScNXkCH4Hn/NBHj4VVpn43Xf2oo6KyRJmLH1P2poO8C4jN6+f
         Se1Wb5OV9R7Ugrjya0wrr0vLQn8D+OTCVfClSTGj8NH+oh9QSGa6sdfbdph84Jmk1xsh
         5WMilT+4CsgQO+JJ7pPytLQ8RDHoUoNopPKXdD6u63uGn/O3OgC4bhjx5QToh6xeeJNq
         p88lwPzH+VQEGVoY5j1F++YkREd6ORnUc7Kbo/eEnIwgr+t8WBadF15Tn1g8kZ42wwLF
         o8cdpDOgfC40JON2ppLgeofts8Khr9djVy54ZZMXHc2tvoRgkElPLN5n2v39MhEhTGJ9
         tRew==
X-Gm-Message-State: AC+VfDzOWYDFC2Ea5wkyjl2ykJOLohykFgxVrCI0m3t1n2WLcwep/fFG
        iTu5drBqd1SdAxUGEWJ85fk=
X-Google-Smtp-Source: ACHHUZ5TQGnA/Statr8aMHj1h3GJXjV7HU3FBcQB+q5BARW6/JrZa8g/nC+IO/uynKlh4wlbluvaLA==
X-Received: by 2002:a17:90a:e393:b0:253:78a7:6d with SMTP id b19-20020a17090ae39300b0025378a7006dmr787435pjz.4.1684439668593;
        Thu, 18 May 2023 12:54:28 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a454e00b002528588560fsm75797pjm.13.2023.05.18.12.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 12:54:27 -0700 (PDT)
Message-ID: <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
Date:   Thu, 18 May 2023 12:54:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 03:57, John Garry wrote:
> I think it's better to fix up the callers.

+1

> Further to that, I dislike 
> how we pass a pointer to this local sshdr structure. I would prefer if 
> scsi_execute_cmd() could kmalloc() the mem for these buffers and the 
> callers could handle free'ing them - I can put together a patch for 
> that, to see what people think.

sizeof(struct scsi_sense_hdr) = 8. Using kmalloc() to allocate an eight 
byte data structure sounds like overkill to me. Additionally, making 
scsi_execute_cmd() allocate struct scsi_sense_hdr and letting the 
callers free that data structure will make it harder to review whether 
or not any memory leaks are triggered. No such review is necessary if 
the scsi_execute_cmd() caller allocates that data structure on the stack.

Bart.
