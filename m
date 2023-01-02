Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405B565B6C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjABSwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC526E4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672685472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEBrukFBGp6hybe2G68udkPzWSggmxuhkhbF0JC3TdM=;
        b=encyUlNiZqrQilqvPHDcxFexwDNUeiHv9f8QEw6Qp/jE8rGuEHNONLUKSTMvlIXls1CNFL
        p7KYgkenuIFl4owP2woovJAOt5q14cqHK4qst1bZSMGjyA1ql2SqABvbnMfhN1GPNtM9Zd
        Kqb2okVaBNyAllqoNF3SH7E+uy9DOkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-gpHydpP7MgqOPXDuNG3q1g-1; Mon, 02 Jan 2023 13:51:11 -0500
X-MC-Unique: gpHydpP7MgqOPXDuNG3q1g-1
Received: by mail-wr1-f70.google.com with SMTP id h24-20020adfaa98000000b0028abfe5b8d9so1075967wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 10:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEBrukFBGp6hybe2G68udkPzWSggmxuhkhbF0JC3TdM=;
        b=TsgFpMbj1ZWslEgoLAuP/7bzXUudxLJBo4l/QPMpX3iqoN+M2eVYnY/Y1zmIPBKIjs
         ZwSnoEtlBQs0RTOwJrJiXgLYKjJnStFryvtak+5C/H6hqAvF7yMFriyr4cj6WdhYAJQg
         pqitN6oll6fE9DdHIckHyADI1kUj7KpQJHkyT5EHQcxbxvoLXErn3KMWKNuubA9G7PHG
         9uct9aOyH8tJbJ6C1bQrrdLSXutUnINBYUl059dIwQWcQ9pE4znMJ2h6VUZt0fDbPGs3
         Pile4hoJj9mCKP/tMnqHzhYtfq7O8ljYTT2zMUlvX2ZR15hA0UYETJYIkaWeB2bbu38W
         IbEg==
X-Gm-Message-State: AFqh2ko8wGNj/e0YkFiZ0JDd7iT0H3SUZjYgmumwB2nMwsqUb9GjOFJz
        nyHl0OiW0m5kBNaQ25/UXRJXbp+BdD4w+YMQgENfg1x7wc+vA36+K1UusrHeCIgHem9TqHDhFNV
        ceSBXcftdpBibw+dIZZPFeega
X-Received: by 2002:a05:600c:c0d:b0:3d9:7667:c0e4 with SMTP id fm13-20020a05600c0c0d00b003d97667c0e4mr21144511wmb.31.1672685470457;
        Mon, 02 Jan 2023 10:51:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvp2sP5F4qJR+gLqHpo+Zpkru9OLDJeTxpx+iJMU4nUmeUljLJQnIVw0WwpC9JObG0zQnguIg==
X-Received: by 2002:a05:600c:c0d:b0:3d9:7667:c0e4 with SMTP id fm13-20020a05600c0c0d00b003d97667c0e4mr21144497wmb.31.1672685470243;
        Mon, 02 Jan 2023 10:51:10 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003d9bd56e9c1sm2356977wmo.11.2023.01.02.10.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 10:51:09 -0800 (PST)
Message-ID: <da5c9ec8-da44-3dff-11c7-2160e335227f@redhat.com>
Date:   Mon, 2 Jan 2023 19:51:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/4] drm: panel: Add Himax HX8394 panel controller
 driver
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
 <20221230113155.3430142-3-javierm@redhat.com>
 <20221230154043.7v3zmzqdrnouqzd2@core>
 <7120dfd4-305f-69ac-fee8-123196ed06a9@redhat.com>
 <20230102105915.gbfhletcm4dunrlf@core>
 <eead4707-e73f-f648-edc6-8415bbb25b8b@redhat.com>
 <20230102152041.7rc2uts7o37fnsen@core>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230102152041.7rc2uts7o37fnsen@core>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 16:20, Ondřej Jirman wrote:
> On Mon, Jan 02, 2023 at 02:51:42PM +0100, Javier Martinez Canillas wrote:
>> Hello Ondřej,
>>
>> [...]
>>
>> My goal was to have some initial support in mainline even if there could be some
>> issues. IMO it is better to use upstream as a baseline and attempt to support the
>> PPP incrementally.
>>
>> But since you are aware of the issues and know what are the available fixes, I'll
>> let you continue with the effort and take care of the patches. Hopefully there may
>> be things that will be helpful, such as the binding schema patch and the collected
>> tags. I can also take care of pushing the DRM bits to the drm-misc-next tree once
>> you feel that those are ready to get merged.
> 
> Ok. The panel driver itself works fine with some changes in other DRM drivers.
> In fact, it will not need any changes, assuming the to be proposed fixes to
> dw-mipi-dsi will pass, too. So I don't have many objections against this driver
> itself.
>

Exactly, that is what I was trying to say. Awesome that you agree with that.

> I'm not sure I should be giving reviewed-by to driver I co-wrote. :) Anyway,

Indeed :)

> I checked it again, and only issue I found was that shutdown callback tries
> to disable the panel even if it may already be disabled, which will lead to
> unbalanced calls to regulator_disable functions, which may produce some needless
> warnings on shutdown/reboot.
> 
> So if you want to commit this driver now, go ahead. DT will need one more round.
> 
> As you say, the overall usable support for Pinephone Pro in mainline is still
> way off into the future, so I agree it's not necessary to get hung up on these
> issues. I can do a DT revision + add in the other suggested DRM patches, so that
> there's at least a searchable public record of the remaining issues.
> 

Perfect, sounds like a plan. I'll re-spin a v5 that only includes the panel
patches then and drop the DTS. Thanks again for your feedback and comments!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

