Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AAF746F50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGDLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA802DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688468535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HfNTIm0/zjqQbBSKsVy9e/unxC3NwZYrTlYCyvLgCg=;
        b=F6GVX8SnFZTtunl5II7HDpFBrC7bdYGeLI0Ld40nnd2mz7m+TXSBkzUyZlx1/+hxTEVgFt
        mteliN47WD6n6EVDv5f+eFiEl5+KRhyD/R1do/e1CFm7AsjfD8YOXKzDmlkvo0kKBbsc3M
        vLcFfq7PkKF22UcprUb8uBkPhBtwvdE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-A4R334aAM3uHrJwt8fIJJA-1; Tue, 04 Jul 2023 07:02:14 -0400
X-MC-Unique: A4R334aAM3uHrJwt8fIJJA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-988643252e0so391097266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688468533; x=1691060533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HfNTIm0/zjqQbBSKsVy9e/unxC3NwZYrTlYCyvLgCg=;
        b=i2yscfPP4X7LHJbGd41nrAyBBy+2S12ApgTA/mlkI2vXhLGDrM53CEgQfAUQ0xEszV
         BmLcaHYqJBVJMkb8xSKATzrXQAAWZYPUKggancehoYSYMLhf7TmNbTyNKdY2MT013ftV
         TcwyYxtXDAIdXZojYu7CIj9f9lRvJiVLxofjeDAwZ+fFJvkGV+lU3clBx/8gD/1VTWdW
         qldCgE+GYXcpRLCYi9hN1k1btdzKJpxe7mBTzI286x0YRzu/i1olUIbTBLpCWe+7a62Y
         uQ794ZJlMTBoTjoHEU0GSi5JDSrISTqWUPWNOL4TilaqRgwBQBrxqDechAawKmbm2+vD
         U2BA==
X-Gm-Message-State: ABy/qLbe7Hpyp6FP5OO77y1m0FXDXKseg+0L6yzQzGEM11QpXnT81Vaf
        al2VeYi0J/5fRuD45Fkb/pgrA2ne7B6CjOtOuahcgKp2ZpGqTs3WT2V3YQyRakQ28gpJ0Hn0hsp
        Lt2mcpO57Qw0XUmfKvAHn8j5p
X-Received: by 2002:a17:907:20ac:b0:96b:e93:3aa8 with SMTP id pw12-20020a17090720ac00b0096b0e933aa8mr10150537ejb.21.1688468533299;
        Tue, 04 Jul 2023 04:02:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkMN8NHoPT3RdilD6mH+P4XF9QEtvXol5QNe4hUn3JKE/pSNlPDiu6GS+5pUB5hahMMI4NvA==
X-Received: by 2002:a17:907:20ac:b0:96b:e93:3aa8 with SMTP id pw12-20020a17090720ac00b0096b0e933aa8mr10150524ejb.21.1688468532977;
        Tue, 04 Jul 2023 04:02:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906565200b00992e265495csm5810961ejr.212.2023.07.04.04.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 04:02:12 -0700 (PDT)
Message-ID: <decdc3d2-8e30-3ca9-d64c-4c76b8f160ca@redhat.com>
Date:   Tue, 4 Jul 2023 13:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Armin Wolf <W_Armin@gmx.de>
Cc:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
 <TnTqU2wwXh3DG07kYUwMAe0hdBiaKiuoMOqBCBIttT27lXdw-KZVV8fZ7x-Zrg_Ux8mJUHClgyFHRbDoCRmhaOI7GwOPhUPYBRLzThV8iYI=@protonmail.com>
 <b4dc2571-1163-805a-f92b-30dcc8b69246@gmx.de>
 <ZJQJqHbZy+00qhsz@smile.fi.intel.com> <ZJRh9o1a0k0yMbOG@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZJRh9o1a0k0yMbOG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 6/22/23 17:00, Andy Shevchenko wrote:
> On Thu, Jun 22, 2023 at 11:43:20AM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 21, 2023 at 11:50:51PM +0200, Armin Wolf wrote:
> 
> ...
> 
>> I think that WARN_ON() is a bit bogus. First of all, it can be easily
>> transformed to BUG()-equivalent with panic_on_oops and hence kill the
>> entire system. If we need the message about wrong GUID format, it should
>> be done elsewhere (modpost ?). I.o.w. we shan't expect that code,
>> controlled by us, shoots to our foot.
> 
> Additional info. There will be another driver elsewhere that may use similar
> API and also needs GUID in device ID table.
> 
> Looking into that implementation it seems that validation should be made in
> file2alias.c for WMI and reused by that driver.
> 
> So, taking into account that we have no wrong IDs so far, I would drop
> WARN_ON() here and guarantee that file2alias.c will be changed to validate
> the GUID one way or the other.
> 
> Would it work? Hans, what is your comment here?


I agree that warning on malformed GUIDs does not belong here and
your patch already drops the WARN_ON while switching to the new
guid_parse_and_compare() helper.

So I'll go and merge this into my fixes branch once rc1 is out.

Regards,

Hans


