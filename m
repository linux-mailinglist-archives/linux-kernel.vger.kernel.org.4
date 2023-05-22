Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883970BFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjEVNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjEVNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:31:49 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A89B7;
        Mon, 22 May 2023 06:31:47 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1101869b3a.2;
        Mon, 22 May 2023 06:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684762306; x=1687354306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHYEd02GTyq7nAlTVtvxKLhdJyZw7c4OhrepDRgpNdU=;
        b=PTnxmtfU9loHX8OPnf6tJpjGd2AHu9G25NEJFkG6da61B3PiJejPqBNnasNg9KvJVu
         I9lVxUWpiU5/KwIZLgP9BUt6ul/Ji2H7/dyOuXj5xaAxYab209s/mc+M+t+ABTXJY0Sy
         ZxgRCIQ89YjLDP0eZ+CS+dkSZRouAADV/3LzkEtHmKDFzHOFsnGCnbi3XRrUfLPi9sH9
         FLb/Wumxk1E4QYqxiZbDYh9PEZ/erE0uhM8rJs3jDc7PVNIq6RaI4yjJr6b/vyf+9mH2
         WIdc1lOu65JaGvkCtHboBB3FJCLOkKGLNYVxUb1WNDjrkPYH00kMSfGQprdGui38u05P
         knpg==
X-Gm-Message-State: AC+VfDx4Qx4Y8BgT217b0dlrtnQF75sRK+oMZTh9MpryOiSEpnN8dhdz
        u+hGssfUBXQ5rG+R/M27JcB0gtTKsAQ=
X-Google-Smtp-Source: ACHHUZ64ycLv6MYTMBnDHVm5SH0u65hNtk5tgJL558kYtj9S/PGdn1U65sA69VOELpHjq4hUQpiTfQ==
X-Received: by 2002:aa7:88c4:0:b0:64c:c65f:7322 with SMTP id k4-20020aa788c4000000b0064cc65f7322mr13598959pff.30.1684762306295;
        Mon, 22 May 2023 06:31:46 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78708000000b0064d27a28451sm4137878pfo.100.2023.05.22.06.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 06:31:45 -0700 (PDT)
Message-ID: <191c7661-c47f-5aba-97b9-ff698bda4bc7@acm.org>
Date:   Mon, 22 May 2023 06:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
 <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
 <611e1210-d89b-9046-ac3f-68a89af6159e@oracle.com>
 <ff04d098-17cc-42c5-cf72-2128fb43114e@acm.org>
 <73e3da3d-ed90-6c38-3c8c-13653bd89944@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <73e3da3d-ed90-6c38-3c8c-13653bd89944@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/22/23 02:55, John Garry wrote:
> On 19/05/2023 18:39, Bart Van Assche wrote:
>>        *args->resid = scmd->resid_len;
>> -    if (args->sense)
>> -        memcpy(args->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
>> +    if (args->sense) {
>> +        *args->sense = scmd->sense_buffer;
>> +        scmd->sense_buffer = NULL;
> 
> I think that you will agree that this is not a good pattern to follow. 
> We cannot have SCSI core allocating the sense buffer but a driver 
> freeing it.

Why not? Something similar can happen anywhere in the kernel anywhere 
reference counting is used.

Bart.

