Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017555BEBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiITRNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:13:46 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BE5FAF2;
        Tue, 20 Sep 2022 10:13:44 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d82so3334668pfd.10;
        Tue, 20 Sep 2022 10:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LS+xvqH5TidkBm9cBo74q89x2X9YMXuEfVMD6zijR4Y=;
        b=xb1zjZixp5HlY+1ocq/NN8zz71jHw7p0RnjmtMToSPK3cGJY2Lv+i++FOy4JvlPuEb
         xWKY26Z2EciILHgG9dfX7wJJ2A+KoTBEUmdAfnSKribbrf3wSCS5Y2b3RvivYGsK9ZQH
         7s5fCmtaUJ5DBERd7MvJzuyDKG3iFSQPyxxGvmPpIJgY70Zhk5ijCu9QWZx32I7j2Jty
         JTzX+BXhyrtTMIRuiEHYr5ExxP3/4Byav/7zaZzEreHLCQJXenqcCN/urTPX8jxg/Nu+
         8lr6o6ir7jzORy+r4pomTBblwaS5MJvyt1Qsvshd7u33RHa4c8Syn7JT5Rcj4SiT1yPV
         RD1g==
X-Gm-Message-State: ACrzQf0y+Wvz6ymlES3XfB3pHtnSWNVSjUpZtrSpr8Hexhi+MOoS6W0U
        T1u707b0JagxWn5A1H5VqfA=
X-Google-Smtp-Source: AMsMyM5MG/c6tCB0kAWoINlDQsFGlE7peDpe9Jodz1n2GIU+i1UA3gUDB8pJQ7DdRIgNvMo5zrTsPw==
X-Received: by 2002:a63:5d0c:0:b0:43b:a2df:858 with SMTP id r12-20020a635d0c000000b0043ba2df0858mr2909730pgb.442.1663694023429;
        Tue, 20 Sep 2022 10:13:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c7e0:1691:74c9:2e9? ([2620:15c:211:201:c7e0:1691:74c9:2e9])
        by smtp.gmail.com with ESMTPSA id i8-20020aa796e8000000b0053db6f7d2f1sm121469pfq.181.2022.09.20.10.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 10:13:42 -0700 (PDT)
Message-ID: <a4084b27-dd2d-10df-493c-35998eed664c@acm.org>
Date:   Tue, 20 Sep 2022 10:13:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220914225621.415631-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 15:56, Bart Van Assche wrote:
> Some kernel modules call device_del() from their module exit code and
> schedule asynchronous work from inside the .release callback without waiting
> until that callback has finished. As an example, many SCSI LLD drivers call
> scsi_remove_host() from their module exit code. scsi_remove_host() may
> invoke scsi_device_dev_release_usercontext() asynchronously.
> scsi_device_dev_release_usercontext() uses the host template pointer and
> that pointer usually exists in static storage in the SCSI LLD. Support
> using the module reference count to keep the module around until
> asynchronous module exiting has completed by waiting in the delete_module()
> system call until the module reference count drops to zero.

Hi Luis,

I'd like to know your opinion about this patch since you are the 
maintainer of the kernel module system.

Thanks,

Bart.
