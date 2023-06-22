Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8073A0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjFVMbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFVMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8211171C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687437050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stc8evGnDDpmXjdbQdBrRjBtyPvD68x7ziZzLCZcBJs=;
        b=Fotf6dZdJVY0xMyw0NLZdpDKa7A/fulzJrM6YgFPdPqRV6nKDOI4FocbHO1q1+pVFXk9wG
        H4Mx+nZ+8Lf+eYs5X4oz01mroQtzsZSNGTsc3/F2q+mq4onY1o3z7v8nTJi/6T3wNej1j+
        /a5FtHVh5PDC7hp5Kd/GFCcxTf0RmZ4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-uHVifh60PXWlO6H4I5sxsA-1; Thu, 22 Jun 2023 08:30:48 -0400
X-MC-Unique: uHVifh60PXWlO6H4I5sxsA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f86d450b01so3876258e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437047; x=1690029047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stc8evGnDDpmXjdbQdBrRjBtyPvD68x7ziZzLCZcBJs=;
        b=YLriNXNgYfcupjgx5FK6mwUiut8MVZDjyDmZBUpp/zZpm31o3MQOAjUmeiN6FiXE9n
         8Fiu5+/d2bg7cvf0K5h0AWAV+Gl5npW+g/nO49qk2YZXHd+2BDJqqgPnfQ7TEpb8Y2KT
         rZmc0i+talvglyKYRC6coPchlPeJQTIpYiZ4qqilyBBHSbe6Czwc0v5q1DnD/nqbRHA7
         tyrxbw/FvVzvU6+G/R6N1wqwl1Dls3s5/Dc0+EfTOY1SXNdxVFgMKCTUygemOAfbWQLq
         Nk04d4cNifPejptilBjGfDU9CSuJ3oUW3NOc2Qtf+ya3xxPLTLJFQNTI46zXzVCEYf6g
         IktQ==
X-Gm-Message-State: AC+VfDxKqIrkuvDBU1R8qDaZi/MnPV0mH/cfkrkSkpchSZrqV5/oZxy+
        iTrrk9eg/uK5oCEjoKyC+bYHBMOtLm5/NyJADzakqYBhPKcftb8watDVGpwmsMmmQ3fQjsKLRY1
        x8v+RD0N0FoDWeCExrSS6G2SI
X-Received: by 2002:a19:5e41:0:b0:4f8:49a7:2deb with SMTP id z1-20020a195e41000000b004f849a72debmr10149665lfi.8.1687437047149;
        Thu, 22 Jun 2023 05:30:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7biiNx9ILW7ILK23qr0T8GMiDK1wNbm4GZ3fgXl387sQPGqC4MxiUus7jFn4U2cw9kCo72bw==
X-Received: by 2002:a19:5e41:0:b0:4f8:49a7:2deb with SMTP id z1-20020a195e41000000b004f849a72debmr10149647lfi.8.1687437046661;
        Thu, 22 Jun 2023 05:30:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b0030f9c3219aasm6910388wrp.47.2023.06.22.05.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:30:46 -0700 (PDT)
Message-ID: <bc82a1d3-07cd-53b0-7f1d-0f71850cdb14@redhat.com>
Date:   Thu, 22 Jun 2023 14:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for mgag200 and ast
 drivers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        javierm@redhat.com, lyude@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230530142615.57014-1-jfalempe@redhat.com>
 <9fdd63d2-12c6-d589-8b24-3c9333ed98da@suse.de>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <9fdd63d2-12c6-d589-8b24-3c9333ed98da@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 09:08, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.05.23 um 16:26 schrieb Jocelyn Falempe:
>> I've contributed to these two drivers, fixing bugs and performance
>> issues.
> 
> Thanks for the work you're doing.
> 
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 


Applied to drm-misc-next

-- 

Jocelyn

