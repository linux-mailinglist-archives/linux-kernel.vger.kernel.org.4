Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F86C148B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCTOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCTOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24933268E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679321944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpIu4sepM07Kopfud0ivEOBiwO1magXEs5WlH8ZDDFY=;
        b=A+K4wbGtWgD1V0sHok0wT2F+n2HvKz6vLQDLq/2NnzeoGdo8tkRYSlqrNU894sfVEOBHBe
        mcYgcVeVkqY2ElrdeKXA+BkHILBIlswTNP8QpruVcP9oB8xYky8zUndXpn+L6QU8gTONwv
        iv+WESLKuXGXBHkRRO9cnEFUAXBLLuc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-WjVjE815PpOUHbwJ8YqRgw-1; Mon, 20 Mar 2023 10:19:03 -0400
X-MC-Unique: WjVjE815PpOUHbwJ8YqRgw-1
Received: by mail-ed1-f71.google.com with SMTP id es16-20020a056402381000b004fa3e04c882so17617373edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpIu4sepM07Kopfud0ivEOBiwO1magXEs5WlH8ZDDFY=;
        b=iPukozj97F6HKMMYLNX89KlRlT5gONHUwpxvtWWHXq80GURBOn58ump01HHVi6JBf4
         DljKxmWQW9dXbjrjH0ORNAGV1C6vxytAwS51noVnqm9HNX4uKW1XXygokG27lCdqd3VB
         VaXDEt5A38/g/HAI2IwjqOiCry4FZzRlzfFBtY37EiCXQ/QnNvlfKd35yXTKNPgkGRkZ
         4aqKO7Vv6WWB0HloOKp7P0UFP852Fi1CRlHxvt2OspXW4ffXPyCezz5O561yXV//uk6R
         e/u0uK6YZqxxT5YSJa4+AzIIkvqYQyKuGNXWFGwxOL03ZQ4PNLe4zKSvdLWTFgv979Bw
         rYMA==
X-Gm-Message-State: AO0yUKXz5UEMdGMKc1s3igaK++7Ea+A8nJzkoujz4t84DTtqohMAJK3/
        tFRXObO8xN/Kr/igYjG7bq8to0ZwZAITdiQZt4197BS/oyCSxHC1eAdqqM5HKoIbwWw8Aajq0ji
        5/Z+n82/lU0Wx21znhBgkNWy42GVoVRqc
X-Received: by 2002:a17:906:c2c9:b0:930:2530:5f47 with SMTP id ch9-20020a170906c2c900b0093025305f47mr8894886ejb.11.1679321941608;
        Mon, 20 Mar 2023 07:19:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set+DtqHnkRjz5U7GES9J3C1zgX5/8MRmt8UD1epGGfgQUfJLVo55jkDa8GbJC17jZO46NUTqaw==
X-Received: by 2002:a17:906:c2c9:b0:930:2530:5f47 with SMTP id ch9-20020a170906c2c900b0093025305f47mr8894870ejb.11.1679321941375;
        Mon, 20 Mar 2023 07:19:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906825600b00925ce7c7705sm4457497ejx.162.2023.03.20.07.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:18:59 -0700 (PDT)
Message-ID: <87382b5e-f3f8-601c-77ff-ecd44d911042@redhat.com>
Date:   Mon, 20 Mar 2023 15:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] platform/x86/intel/pmt/telemetry: Add driver version
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230316225736.2856521-1-david.e.box@linux.intel.com>
 <20230316225736.2856521-2-david.e.box@linux.intel.com>
 <CAHp75VcP5jf4Tt-U7cs77gnTcUpQbQ+exXjOOc5epPRDfT0h0Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcP5jf4Tt-U7cs77gnTcUpQbQ+exXjOOc5epPRDfT0h0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/17/23 14:35, Andy Shevchenko wrote:
> On Fri, Mar 17, 2023 at 12:57 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
>>
>> Add a driver version number to make it easier to track changes in
>> backported kernels.
> 
> Sorry, but NAK. As Greg KH said, we do not use this anymore (in Git
> era) ­— the SHA from the Git _is_ the version of the driver.

I agree with Andy per driver version numbers are really not useful.

Generally speaking the version number will get updated say once
per upstream kernel-release in a separate commit, but there is
no guarantee that commit will get cherry-picked together with
other cherry-picked fixes.

So for downstream kernels these version numbers really don't
have any meaning and as such are useless.

Regards,

Hans

