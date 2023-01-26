Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3C67D285
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAZRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E060210EC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674752706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uygk/TB6aRJ5udgfPiXIitKn8ol0O3ncYcf3EIjL8nc=;
        b=UktVdToOuFbQS6K4jdZ1cJu2OEXR2GH7qMe7BesD067JvaOmwG1ufcQeGD8geIGSPDDJNi
        kwA9+qxsYRF51MbXkW3CiC/UcfPaYTPXTZjvHJcMkRp3Jx7HvNDYau3UU+pHpiJZ2pxn2R
        44xHTyl++969oY4G8jDaY8+ZaXab8XU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-yObyfYSiO--DGPUFQ_jkWg-1; Thu, 26 Jan 2023 12:05:05 -0500
X-MC-Unique: yObyfYSiO--DGPUFQ_jkWg-1
Received: by mail-yb1-f198.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so2465464ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uygk/TB6aRJ5udgfPiXIitKn8ol0O3ncYcf3EIjL8nc=;
        b=E28SIPB4cPoDKJ3CYhUOjx0rKsMAF24gYgzaZ+Bir4F+VPaJmwHMtkO6zBxnnKvxnO
         8+jeIlBWS6Uft9AbBkN6JFOm3IVi+9wNTsz5F6N/ojdY//MNVkgQqY46S8e/VKtTXmRR
         jCVcMDRLVLkckJUBHlZ4YwJwmlWLLscUognQeUqSs4NA2ffk9YS4xP4Eds42ecvSanSo
         EGitljVMHQP3TeFegZCKVp1CrDdhL4IxYTyV0g51Rz3mXHFbkSsFboGrBSXP6vYekDyB
         GRn6tV1VeO1o/nSnfo/GPbd2iy01+mhOb0PGFtG4eNWKz55FCKth/lcLa7usWEt+4JZK
         s1pg==
X-Gm-Message-State: AO0yUKXr38K2TKsFXBfrhq/mSJiljvLx7XOx71Rx6nfzggK/ypUWbr6J
        4KZLcw4oDZyf6n490T65L0A5fskMuZ6T6MnIiwrc9D2Ak9uEmTXUNlOJ3vkFjKbPNl8SUcwOjbI
        LtpuG766EgivhKJuqIm4pK9tQ
X-Received: by 2002:a05:7500:5715:b0:f3:b68d:b213 with SMTP id by21-20020a057500571500b000f3b68db213mr175539gab.34.1674752704379;
        Thu, 26 Jan 2023 09:05:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/snjTAhZTvFSQrDxGRK/HEmBt77TtZYQdFf00pbY3E0ID5SkfmPFixZbbPoye6ZmAGuyD63g==
X-Received: by 2002:a05:7500:5715:b0:f3:b68d:b213 with SMTP id by21-20020a057500571500b000f3b68db213mr175514gab.34.1674752703941;
        Thu, 26 Jan 2023 09:05:03 -0800 (PST)
Received: from [192.168.1.16] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id c85-20020ae9ed58000000b007057cc1e87bsm1166681qkg.136.2023.01.26.09.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 09:05:03 -0800 (PST)
Message-ID: <3e3f4bee-4fba-7ab7-b104-7c13d89db102@redhat.com>
Date:   Thu, 26 Jan 2023 12:05:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.de>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com
References: <20221026194122.11761-1-mpdesouza@suse.com>
 <Y2D4ZgWqB0E9viPy@alley> <20230123173331.2rvelrrbkaitw56r@daedalus>
 <Y8/+bGqjHsi8LEfI@alley> <Y9Kr3vb2s3m0MbEQ@alley>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/4] livepatch: Add garbage collection for shadow
 variables
In-Reply-To: <Y9Kr3vb2s3m0MbEQ@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 11:35, Petr Mladek wrote:
> 
> Josh accepted the idea in the end so we could actually push the entire
> patchset. I am not sure if anyone else would like to review it
> so I going to wait a bit longer.
> 
> Resume:
> 
> I am going to push the entire patchset the following week (Wednesday?)
> unless anyone asks for more time or finds a problem.
> 

Hi Petr,

Re docs: patches (3) and (4) change the klp_shadow_* API.  There should
be updates (and possibly examples) to
Documentation/livepatch/shadow-vars.rst.

Having this for v1/v2 would have made review a lot easier, though I
understand not wanting to waste cycles on documenting dead ends.

-- 
Joe

