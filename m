Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC37C74AD5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGGIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGGIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8141FEF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688719824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvhYF/rnQ9Q9FlESAs3rIUXc/r8fN/uEOaJ2PUqHY1c=;
        b=ZyIxiIsvgWCfrk2xpAjeTMpNcc1D1vSNW68VyxP08NM/i++DjNz5en/h13VapUx8al9uQ+
        yV3/YRi60z+cE8vOeJtRLEeGvVrS+AxqQ/UE7pqb3WFbN4CXvyZA/icUbyZv2D1R7jPhaX
        7YStGw3jMlTXfDpn0mbNA80AWvG25II=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-UVdQLKokNYixZn1T3XzrnQ-1; Fri, 07 Jul 2023 04:50:22 -0400
X-MC-Unique: UVdQLKokNYixZn1T3XzrnQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40328438392so17630281cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688719821; x=1691311821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvhYF/rnQ9Q9FlESAs3rIUXc/r8fN/uEOaJ2PUqHY1c=;
        b=kzzy7FYIjNmmWEmQYfLXK9nZYief+kS8qms6YVYdTvnLGeBDTniF1x46YvqHq+lI6+
         1cOJMvU/EPa2Wt15BV6Q0Q5CrGEBIrQx5XszYnEQDjelKADtQeXRubZ96fAmUkGqJ5NH
         4+PaZOW0tg+u1Z9fdXwYdzXdgCtCzVELCSZVbQxV6i54Q2bUo9FkJNorfA/sooWddZuT
         yrwpXGvNdhKhxSHfv4Gxq1qC1HIK4gE8V/FBt4S/qv3ToRWKULoAaGEYkicgBWatwAv/
         8xLEoFBxRO57IWhozQAJVThJrNYXs7C+URydkmY5L4BUTck+pMqwzKWv0f1Yz4x9Qfj8
         gjvw==
X-Gm-Message-State: ABy/qLbrlmO8HHcjUQU/FeLwCY3Z69eMp0Me/D7AhzAv3N5nUrhh98Vo
        iYHxFGmTEkLo4TSVGk1bhkAejqdxcQWbQuFUL4rsrTRzJ8Nj9qGqiyMjpA4sTCIxXGdf1pO/fY3
        7t7zasy9GyZWRLp78q7E0EW0=
X-Received: by 2002:ac8:4e96:0:b0:400:84a9:a0a5 with SMTP id 22-20020ac84e96000000b0040084a9a0a5mr5117187qtp.52.1688719821618;
        Fri, 07 Jul 2023 01:50:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNQkkqADRC0X7jsXNbnJO2I9arLpnWYJiv9igytdJ6RB4AJLzQiymUb7qKfGGuR1Eu2wEBAA==
X-Received: by 2002:ac8:4e96:0:b0:400:84a9:a0a5 with SMTP id 22-20020ac84e96000000b0040084a9a0a5mr5117167qtp.52.1688719821382;
        Fri, 07 Jul 2023 01:50:21 -0700 (PDT)
Received: from [192.168.9.29] (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id q25-20020ac84119000000b0040335131048sm1523246qtl.93.2023.07.07.01.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 01:50:21 -0700 (PDT)
Message-ID: <b3ef657d-22a9-a52f-821e-55fc5faf1ca5@redhat.com>
Date:   Fri, 7 Jul 2023 10:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 2/2] fpga: bridge: fix kernel-doc
To:     Randy Dunlap <rdunlap@infradead.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20230706142755.124879-1-marpagan@redhat.com>
 <20230706142755.124879-3-marpagan@redhat.com>
 <a3da8412-2e13-6b25-346b-da53414f5dba@infradead.org>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <a3da8412-2e13-6b25-346b-da53414f5dba@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-06 23:35, Randy Dunlap wrote:
> HI--
> 
> On 7/6/23 07:27, Marco Pagani wrote:
>> Fix the following warnings issued by the kernel-doc script:
>>
>> drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
>> drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
>> drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
>> drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
>> drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'
>>
>> - Extend the return description of of_fpga_bridge_get() to include the
>>   case when try_module_get() fails.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-bridge.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a6c25dee9cc1..0b76c67c50e5 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -87,12 +87,13 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>>  /**
>>   * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
>>   *
>> - * @np: node pointer of an FPGA bridge
>> - * @info: fpga image specific information
>> + * @np: node pointer of an FPGA bridge.
>> + * @info: fpga image specific information.
> 
> Those are not sentences. There is no reason that a period ('.') is needed
> to end those lines. OTOH, the maintainers can do as they like with it.
> 
> The rest looks good. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I added a period at the end of each argument description to follow
the style recommended in the "Function documentation" section of the
kernel-doc documentation.

Thanks,
Marco

[...]

