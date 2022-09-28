Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549C5EE434
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiI1SSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiI1SSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:18:22 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D410B5AA;
        Wed, 28 Sep 2022 11:17:41 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id bh13so12936357pgb.4;
        Wed, 28 Sep 2022 11:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BwwaY79I9QcIrTb81yb3ikNlh+MhC+I08Q+Grdnb0GI=;
        b=Hit7QaGhy3FkjeM9epr9YXAQFSpfqDEIo/05Xoby3EQUpIl3O+mfA9Ra1GS3a9oZ43
         60hqxukRmJLHGyBF+697Ll/ohwcWX3qD3kHHA0GZnfgIAgoArfhrdRoIeBSeIhCe7fFJ
         KCRo9v1/TMQFfsNzOXEI434VH7Ou12CwGiB4Xdf/y+/a0CwZCxsJtkGDNk42Dff4Ntwf
         YNPgCiqnInyeZ2q5h2wgud5q+QQyRdyDe9pf7NuB1B2ZvYdpNbKBO4JQC/g9aZXofF9Y
         SAybu3H53X7LL/Ik5iXnptJJ+WnsQJtqAtwCl2VsitX5s8mAPMfSQIGLM/H2GqPyrqn0
         GT5g==
X-Gm-Message-State: ACrzQf3HihdHaoeIgARhvERjC4Mx0a58cIE+mItyMLjEDlJxkwxwKRNd
        CFHKheG21DSkOeJUoH4g2sQ=
X-Google-Smtp-Source: AMsMyM5s8ZNMA/P6QTvoMBHJMPScb7WEDokxM2aeLSmDwrz3/Y9hlZPT64DFm4NVh6oHzcvmbZQuZg==
X-Received: by 2002:a63:5f08:0:b0:434:c081:37eb with SMTP id t8-20020a635f08000000b00434c08137ebmr29927750pgb.40.1664389026723;
        Wed, 28 Sep 2022 11:17:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cba:f1a9:6ef8:3759? ([2620:15c:211:201:4cba:f1a9:6ef8:3759])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b00178143a728esm3994552plg.275.2022.09.28.11.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:17:05 -0700 (PDT)
Message-ID: <33ee1c3a-d37a-b81f-68be-d1901c7dd6e8@acm.org>
Date:   Wed, 28 Sep 2022 11:17:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YzOPJHSQsPtc5o0Y@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 17:02, Luis Chamberlain wrote:
> On Tue, Sep 20, 2022 at 10:13:40AM -0700, Bart Van Assche wrote:
>> On 9/14/22 15:56, Bart Van Assche wrote:
>>> Some kernel modules call device_del() from their module exit code and
>>> schedule asynchronous work from inside the .release callback without waiting
>>> until that callback has finished. As an example, many SCSI LLD drivers call
>>> scsi_remove_host() from their module exit code. scsi_remove_host() may
>>> invoke scsi_device_dev_release_usercontext() asynchronously.
>>> scsi_device_dev_release_usercontext() uses the host template pointer and
>>> that pointer usually exists in static storage in the SCSI LLD. Support
>>> using the module reference count to keep the module around until
>>> asynchronous module exiting has completed by waiting in the delete_module()
>>> system call until the module reference count drops to zero.
>>
>> Hi Luis,
>>
>> I'd like to know your opinion about this patch since you are the maintainer
>> of the kernel module system.
> 
> See this patch which extends the documentation of try_module_get():
> 
> https://lkml.kernel.org/r/20211029184500.2821444-7-mcgrof@kernel.org
> 
> You can ignore discussion around the thread as sadly it is just
> irrelevant stuff not about that patch. But the logic it spells out
> is still true.
> 
> So, in short, using try_module_get() on exit is actually the wrong
> thing to do and it is no surprise it would fail. I haven't gotten
> yet around to reviewing Mauro's driver API which let's you unbind
> drivers, but it sounds related so I CC'd you on that.
> 
> So I'd like to ask instead if an alternative to using try_module_get()
> on exit would be better here and for the future.

Hi Luis,

The extended documentation of try_module_get() is very helpful. But 
please note that this patch is not related to try_module_get() at all. 
See also patch 7/7 in this series 
(https://lore.kernel.org/linux-scsi/20220914225621.415631-8-bvanassche@acm.org/).

Thanks,

Bart.

