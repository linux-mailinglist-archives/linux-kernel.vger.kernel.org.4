Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA86E388A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDPNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDPNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78193212E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681650752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecW/u7CjtCVSaHYPl096FXbBaM+YOFYAJMZvfjOeWGs=;
        b=cx0XHXlC+H5IFtWDZ+xVe4Gl/iBJ27p6xZWyqrTJXMTM/WUPzBud21p3bNLd5GaNuipVn9
        zU+z7Vb/HcqyzvI2/YUCRoPCtHpbjscE6bLeQjR/tgJPlISiCwieWahlEfqCQ2/Xq2Axy5
        se3sqeC59vGqf0XoXXy8FuO5KtpZpys=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-cv4rUWLVMUC-FK14ssodaQ-1; Sun, 16 Apr 2023 09:12:31 -0400
X-MC-Unique: cv4rUWLVMUC-FK14ssodaQ-1
Received: by mail-ed1-f72.google.com with SMTP id e30-20020a50a69e000000b0050690ba4f68so1942322edc.15
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 06:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650750; x=1684242750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecW/u7CjtCVSaHYPl096FXbBaM+YOFYAJMZvfjOeWGs=;
        b=FPkzVMpow5/s8KNlAI9xH5oqIPj53YnWsWwzALzLevLyTz3CUFfqSN+LBIDfzXmfcq
         tcWSRxoBG9VjUdJG5YU4nd8EvGMLkWW3queyZ7kEa/nfIn9MIOKuriMxIVCHTz6y4Cqz
         TCRWa5FiJl35a49v5/rii/KFABvy0nMZ1P9N45NmrmgZfvTVSc10hKUxdcUSian41YGf
         olKQ9dfLSZZrBa7gJ2xd7n4oQudybgGzMH2bF2A3RGxCN2AtrT2U7Z8hzbCAI7rCkeiO
         VPShePtNGUzZ6fzfj+Lm1WEwCo7U30xHuHxQHt4B/Y3ditEgEEdcEjvKY+wDmZVeFlBc
         KErg==
X-Gm-Message-State: AAQBX9d1uSujWYkEWjNOuZKWXld5dD21pCobg27nZV1nv0fXSVXedcdK
        Pyb3f58MUay+Cwk+9KndGe8rQ27f+2Y5SpLBMXFxI49He5/mgFvqaC+i9DxW0v7iFpstc6Unrrz
        +oPmbrrYTPlpLmFQOplaizcuB
X-Received: by 2002:a17:907:7809:b0:949:c05d:73b6 with SMTP id la9-20020a170907780900b00949c05d73b6mr4080296ejc.17.1681650750402;
        Sun, 16 Apr 2023 06:12:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zvy4OWUGG7/uKcn/guQnbp5MOYixLaUbua5xOk1r9lVf96E10h0El+lKgLR9svlpzbszXUTg==
X-Received: by 2002:a17:907:7809:b0:949:c05d:73b6 with SMTP id la9-20020a170907780900b00949c05d73b6mr4080287ejc.17.1681650750153;
        Sun, 16 Apr 2023 06:12:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id xh5-20020a170906da8500b0094edd8e38fasm3665933ejb.76.2023.04.16.06.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 06:12:29 -0700 (PDT)
Message-ID: <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
Date:   Sun, 16 Apr 2023 15:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] media: atomisp: Move a variable assignment behind a null
 pointer check in atomisp_cp_general_isp_parameters()
Content-Language: en-US, nl
To:     Andy Shevchenko <andy@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d8ed4e5d-49d4-ca7e-1283-1ec166bf643d@web.de>
 <ZDmJsemYldOsMMrH@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZDmJsemYldOsMMrH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/14/23 19:13, Andy Shevchenko wrote:
> On Thu, Apr 13, 2023 at 10:20:15PM +0200, Markus Elfring wrote:
>> Date: Thu, 13 Apr 2023 22:08:42 +0200
>>
>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function “atomisp_cp_general_isp_parameters”.
>>
>> Thus avoid the risk for undefined behaviour by moving the assignment
>> for the variable “cur_config” behind the null pointer check.
> 
> I don't think this is what is happening here. The check might be removed by
> optimizer in the compiler.

Right, Markus thank you for the patch.

Instead of this patch, can you please audit the callers of this
function? I expect that you will likely find that the callers
already unconditionally deref css_param themselves, or they
guarantee a non NULL value in other ways (e.g. address of local
variable).

So I expect that the check can simply be dropped completely,
which would be a much better fix.

Regards,

Hans





> 
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: ad85094b293e40e7a2f831b0311a389d952ebd5e ("Revert 'media: staging: atomisp: Remove driver'")
> 
> Wrong tag format.
> 
> Code-wise I'm not against this, but it's up to Hans.
> 

