Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6B68939F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjBCJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:26:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2B5C0E5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675416352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnduDc6Rpr9xpj+zpBLdT5wXh2NwNpe5gny76xfCzIQ=;
        b=Nh35i/9szJLFG7vXSuOtzkZuvyXMitwyX1EfOkI7ftm1ro+xWqFRbOvytg8N1UEqbIuZn1
        du1SDGI7xyWEZ69N6RtKNeXBjddP18LxbJBduHhZ7Lgs0/HxaupKZ7TalQ2i5cJr46SjxY
        HKkuIzRkpP743icR2z7MxnOktLjexyU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-W6a5WFwfO2Oxk8sSFot66g-1; Fri, 03 Feb 2023 04:25:50 -0500
X-MC-Unique: W6a5WFwfO2Oxk8sSFot66g-1
Received: by mail-ej1-f72.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so3516643ejb.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnduDc6Rpr9xpj+zpBLdT5wXh2NwNpe5gny76xfCzIQ=;
        b=LcNTKYowYBf0c/KBjhJb1c+oPAOtWdRt6dgNjhw+28jvbUDXOl0GRHraSoDC0oIp+i
         AYeCmbaaYdn+8z64Eb0Ip22hzbjuOQS9ZZFZ6aruAkSr1I6euyVH3nixEV/ry7NPRtNX
         qwq/wxUrEIRCBUTlp4l4n7/pVZkyRZzEYDQ7r6aodRhas0EbVH7735ok7hdQjASgpcvL
         qsazN6XlS0XX1cH0irJrv6Wuf9tMHkX17DG9iBT0AJxVLJErFOzxz+f+5LvfoaufPhxA
         estBLPz9BUo4vYb/IKliJa00WzEixOgfaRCnqHMp2Qrn17Sn0WuGNAbSasVz57R/5Fc4
         XeAA==
X-Gm-Message-State: AO0yUKUaUSWkwdiXMHgR0Ufi8C45v/fKmV/uYflbobdkC9IMfnaIU+D3
        pbQmCquRJSuGBSPU76kRnigLG7n447EBRo1NTbm5iF6wVRoIf/Nz05NGuvhU0adKWXA3q3G11t7
        0YMI/vAY28dKdGJsZX5yofVo1
X-Received: by 2002:a17:906:9f18:b0:88d:ba89:1855 with SMTP id fy24-20020a1709069f1800b0088dba891855mr3898066ejc.38.1675416349336;
        Fri, 03 Feb 2023 01:25:49 -0800 (PST)
X-Google-Smtp-Source: AK7set9Fz23akz5qDbcVCijsJi+YvA5JMmznb3rtTdiKFlGYpAM+nvj9HeTSbsYr/Ny7lJMBTwZAxg==
X-Received: by 2002:a17:906:9f18:b0:88d:ba89:1855 with SMTP id fy24-20020a1709069f1800b0088dba891855mr3898059ejc.38.1675416349216;
        Fri, 03 Feb 2023 01:25:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7d1cd000000b004a028d443f9sm838884edp.55.2023.02.03.01.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:25:48 -0800 (PST)
Message-ID: <1fbd2b2e-49a8-ffea-6715-217d4fe278d5@redhat.com>
Date:   Fri, 3 Feb 2023 10:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: build warning after merge of the drivers-x86 tree
Content-Language: en-US, nl
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230203135303.32da1fc6@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230203135303.32da1fc6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/3/23 03:53, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drivers-x86 tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/media/v4l2-subdev.h:1088: warning: Function parameter or member 'privacy_led' not described in 'v4l2_subdev'
> 
> Introduced by commit
> 
>   10d96e289fbd ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")

Thank you for reporting this. It seems I didn't have much luck with my
latest for-next push.

I'm testing an updated for-next with this fixed now and I'll push that
out shortly.

Regards,

Hans


