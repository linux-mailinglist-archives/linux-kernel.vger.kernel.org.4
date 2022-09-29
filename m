Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67055EFBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiI2R1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiI2R1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:27:21 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A771D88F7;
        Thu, 29 Sep 2022 10:27:20 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso6592934pjf.5;
        Thu, 29 Sep 2022 10:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=49qp+heZEryBDi4E6l3bbGg+YlRJd6kyFipm/Dx+3lY=;
        b=dc95+uQVTKjlIlgvPzgv2fkEIhseGULh8viBdR8+iEmfcxs/L7VMU/qQ1RU4xJw7+U
         ImXQzpZgRaP+iGCJDr6J/D/DyW8DDUgtC/1l+Mc1hwuto3rCpj4GIolv4eNI8sOUu1Mk
         3rZPkD/wt7a0eRBgVxXUK6P/QLQUS2ueK+QzhWRkxa3rHYLjD1G4C1DD898zWnxI+PD7
         Svmt/m0lcaUrq3dIx2ROg3lMPeT/bpffQlfyyLNZs4SMcWtEs11oL2ERxKeLaV+j7DPK
         SL36amiUQt7KF8PmLN9AtgMfgAIb/4plUlNUH0pBNe+NoI7mSz8Y5gjhyvGyzCjCHzE7
         4gvw==
X-Gm-Message-State: ACrzQf3O+sbiIw8Nrv5ZGSyIKF6ZcdF0lGiVJj4qGJxj/JjgFIsBoRJ9
        YSVV82h4ctRsOSYdMIZpVE4=
X-Google-Smtp-Source: AMsMyM49r2YsAcmEWTWdQjIsGDmiiWsT/TgxuLjKU5yytl15VTnKDIxrm5yBxG1+a+3LDN/5jBnthQ==
X-Received: by 2002:a17:902:f548:b0:178:44b:4ea9 with SMTP id h8-20020a170902f54800b00178044b4ea9mr4509518plf.77.1664472439943;
        Thu, 29 Sep 2022 10:27:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2e63:ed10:2841:950e? ([2620:15c:211:201:2e63:ed10:2841:950e])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b0017a1145eec7sm132225ple.157.2022.09.29.10.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:27:19 -0700 (PDT)
Message-ID: <67e70e00-3a79-c8b0-525a-92071a015366@acm.org>
Date:   Thu, 29 Sep 2022 10:27:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org> <YzOe3pYmn5qO9lFb@T590>
 <2acc2220-65dc-4af5-ffd3-997f779d41c0@acm.org> <YzTwgxX+WMuJyAJy@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YzTwgxX+WMuJyAJy@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 18:10, Ming Lei wrote:
> On Wed, Sep 28, 2022 at 12:27:07PM -0700, Bart Van Assche wrote:
>> How about removing support for calling scsi_device_put() from atomic context
>> as is done in the untested patch below?
> 
> That can't work.
> 
> The problem is that no existed mechanism can guarantee that kobject reference
> drops to zero inside module_exit().

Hi Ming,

I agree that the patch in my previous email won't address potential calls of
.release functions while a module is being unloaded or after a module has been
unloaded. However, that's not the purpose of that patch. The purpose of that
patch is to rework all code that modifies members of the scsi host template.

Thanks,

Bart.
