Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED4709CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjESQyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjESQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:54:38 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50633183;
        Fri, 19 May 2023 09:54:32 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so2361094a12.3;
        Fri, 19 May 2023 09:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515271; x=1687107271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+6sL1zh81H7p+vovqWIWNUf8ZF820CXjdaBKyZVEoU=;
        b=AThduqBjaOIgNxr59hNXhWKoru8UZ8GOHD8u3zk37gbv7gDynLuiTVDaGKiXEttj0m
         zB5VW+J0W6lMdr9pe8u+NeT+q14jC2EwdSt8YMI5+eelbxdvtZga6kiz2YqOZAPVNIJx
         ZWUw993T8QPPu6n9JHXPXEWABkfSfLtipeVAzzewucETyQ3pK2dZdgGfzR/cpquLciHN
         HsuD7oQCbcNHSqE1fGul/+hQboR4gABASo9xF6GWpmgjKZqzt6rz+XYh739zc34xI3ud
         2cJyBvuP7E+icZi3vwKSMbVycO7G/Hj5g46yfdp2qItgRHrDwmo4IcEX0M1LVBdcG9eG
         g3FA==
X-Gm-Message-State: AC+VfDyOU1PI6rN+wZ5y9Qcc7WiLRusrUegSz9KSOofJc3PP7X4S2d9s
        PBjhGyI09mWcWHlizwRpNhY=
X-Google-Smtp-Source: ACHHUZ5xQWXcqU5uPdGu1VrDpxJcpNDxqBkEmGqAsrAA9IeiDyVyt3PCTj43IT2YKCmNW27myH6IbA==
X-Received: by 2002:a17:902:7fc9:b0:1ab:63e:67b0 with SMTP id t9-20020a1709027fc900b001ab063e67b0mr2690758plb.54.1684515271361;
        Fri, 19 May 2023 09:54:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:42a4:88db:5ed8:43d0? ([2620:15c:211:201:42a4:88db:5ed8:43d0])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902b08600b001ae46ccd19esm3695287plr.63.2023.05.19.09.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:54:30 -0700 (PDT)
Message-ID: <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
Date:   Fri, 19 May 2023 09:54:28 -0700
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
 <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
 <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
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

On 5/19/23 09:06, John Garry wrote:
> Sure, what I describe is ideal, but I still just dislike passing both 
> sensebuf and hdr into scsi_execute_cmd(). The semantics of how 
> scsi_execute_cmd() treats them is vague.

Is this something that can be addressed by improving the 
scsi_execute_cmd() documentation?

Thanks,

Bart.

