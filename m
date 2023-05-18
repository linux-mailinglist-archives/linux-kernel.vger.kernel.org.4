Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8377083D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjEROTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEROTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCECA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684419530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2/iO6J14YtVUt4T4ndhV73ZmcEee58hQhg8A73F228=;
        b=WCaA9NiE0Ob/LFLPf9H9DMhqzSsaR0bZO/Nw1TAynJUh85RStZGipe8JjwP+OZlGutr6n8
        3pvPnyuRg45JPct7DnSrlXxLEPugCkDxpP7HKQwrcBDH3DkmwxRagvyY5XIqJ9e6tGrTBR
        32AXFLzXfL7mATAZx1G1rizLTAaYxDk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-0nGNihEvOAaXizxCXeuCIA-1; Thu, 18 May 2023 10:18:49 -0400
X-MC-Unique: 0nGNihEvOAaXizxCXeuCIA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6239a0f15e4so1312896d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684419528; x=1687011528;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2/iO6J14YtVUt4T4ndhV73ZmcEee58hQhg8A73F228=;
        b=HjFxxXy8tTVtc9A2Wajefs7NFIALvV1kUyAFxlpi6kg1iKvJO2cUZEE1ED20vMUWId
         9zkILBOU6kR6efCR/y0Ykz85GvxrjXr5I2QHAk86V7QImBMumtLAMkCUp9AQV8owwR0A
         vkE1Oo29emlGuxVSdpenRyCvvrO0tovUa1GkybgesI+Pl6sqqx43gqU3ByFyTlT2E4Nx
         GCd9NgTe5tcFTM58HAHTiO8YuKfEzdirIgqbAyKmUtzfjP5KQqAw4MLSKOQLpXYWCkae
         v5N3tMzUBz2rCxbDRf7Eg6U227ZLVweUaOqDjTcjbZ3VAjswQGbqM168S7fYgLR33v0r
         Qkgw==
X-Gm-Message-State: AC+VfDxF9fO3DINCfmX0o1fX2qq5H6RMckiWWymM2WpLfn+nf4Ts2B+O
        B2U5qJTpHgIvU5Hf07eSrRVlECdTLFo7xP1oMEVO9X3eOCe5xJv8gvSmG5YTHWTT00XK3W+ccDe
        QMUxbvRjJtvFtIhveYPio3ufTy279oLyw
X-Received: by 2002:a05:6214:f63:b0:619:c50b:8dc5 with SMTP id iy3-20020a0562140f6300b00619c50b8dc5mr6013300qvb.49.1684419528374;
        Thu, 18 May 2023 07:18:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fXSC86dNxaLQPrCvmm9qJg09KGdf4/co2HJ+1zjym/VhIXeewvWIx/2AOsssmkoGiStYeIQ==
X-Received: by 2002:a05:6214:f63:b0:619:c50b:8dc5 with SMTP id iy3-20020a0562140f6300b00619c50b8dc5mr6013267qvb.49.1684419528073;
        Thu, 18 May 2023 07:18:48 -0700 (PDT)
Received: from [192.168.1.31] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s5-20020ad45245000000b00621066bde91sm553739qvq.52.2023.05.18.07.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 07:18:47 -0700 (PDT)
Message-ID: <822eda9c-6b1b-8c27-27ee-6f2855a261a5@redhat.com>
Date:   Thu, 18 May 2023 07:18:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ALSA: emu10k1: set variables emu1010_routing_info and
 emu1010_pads_info storage-class-specifier to static
Content-Language: en-US
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230518123826.925752-1-trix@redhat.com> <ZGYvG2Sf9ZeeOmL6@ugly>
From:   Tom Rix <trix@redhat.com>
In-Reply-To: <ZGYvG2Sf9ZeeOmL6@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/23 6:58 AM, Oswald Buddenhagen wrote:
> On Thu, May 18, 2023 at 08:38:26AM -0400, Tom Rix wrote:
>> smatch reports
>  ^^^^^^ is this the best word to use here?

I have been running smatch against the whole tree for a while, using 
this preamble.

Many fixes later, for the most part the tree has been cleaned of this 
class of problems.

Tom

>
>> sound/pci/emu10k1/emumixer.c:519:39: warning: symbol
>>  'emu1010_routing_info' was not declared. Should it be static?
>> sound/pci/emu10k1/emumixer.c:859:36: warning: symbol
>>  'emu1010_pads_info' was not declared. Should it be static?
>>
>> These variables are only used in their defining file, so it should be 
>> static
>                               ^^ they
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>>
> Reviewed-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> (also amending one of the still pending patches. thanks!)
>
> regards
>

