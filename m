Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6855B690D85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjBIPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBIPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E865681
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675957646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99X2d/7PnkDB3y5oN6cAQuHXSUMM+INOtp1CuXvzmRI=;
        b=aFxULGl1d+fJp8h3HlShyXaYcA+KLFHlTk/Dvy20d7Sw2XDscHN2z1N5J1wWNxyhe8DZMq
        QLgjmLrn/jGxuwHm92CTLEVuolZvQJFno/8d9YiRzoB1h/XdnEbYbWhtyfzpg37FygMv2F
        Yh8MEOELc0dNsLBDZnn4X/dZZatGXMQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-7LEumk4WNcK8yBPhlpASRw-1; Thu, 09 Feb 2023 10:47:23 -0500
X-MC-Unique: 7LEumk4WNcK8yBPhlpASRw-1
Received: by mail-ed1-f71.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so1713653edz.21
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99X2d/7PnkDB3y5oN6cAQuHXSUMM+INOtp1CuXvzmRI=;
        b=FgctNgrKYaeKmWFCy+SgyPHGeMT84dHcBjBwLLKJQXPQXKujDSmv5iqOJ7a79Z0Jlh
         jkWMpcOnMCVPP9otPrWjoj8KBWb4euH6uDw6HklZAHE1l/Jzcv+eRB0wHbyFW2PJ56Jw
         CdZBE6ybmCde3PARmBkQBDrDk9/VcUto4mu5WueKHGZvBq5pdQzNi1Vh4eIYMotcFwfP
         AV/7/Re0WDjutQCDMZj0DiHnNg/7TqjJ7JWLYiYbpvJdTYUHB+QBFoO/rr+CWtSoq58W
         kFY6Jwtm8SbRpTUuXCuZa2OH9Qj7/IU6hkA0UNv+cCslQixDgvOXYiqfvsMocDf92ccs
         wVAg==
X-Gm-Message-State: AO0yUKW1ZT8qcZfZJNy1ZuntKtUkcx5cPj2uR0k+aGixUtnTMr056Nqc
        X9GwlytHdy6KYNJn31IFqmt2z8hXIkACy5BkWUDwkzyZoNLLS0Myj9TtPjdau0KuBrwVwfHc2ze
        a4x5/+QY6ys8s9pJaVefEItdl
X-Received: by 2002:a17:906:798:b0:88f:6a7e:5fe8 with SMTP id l24-20020a170906079800b0088f6a7e5fe8mr13388232ejc.22.1675957642176;
        Thu, 09 Feb 2023 07:47:22 -0800 (PST)
X-Google-Smtp-Source: AK7set8bH9yXuyJR9Eq5RXP63IN3huxAmn1Eoy+f/b6jPBUGaB8xRuruSmBZGeDEKDCr9mS4qoPgqg==
X-Received: by 2002:a17:906:798:b0:88f:6a7e:5fe8 with SMTP id l24-20020a170906079800b0088f6a7e5fe8mr13388216ejc.22.1675957642021;
        Thu, 09 Feb 2023 07:47:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id se26-20020a170906ce5a00b0086621d9d9b0sm1012318ejb.81.2023.02.09.07.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:47:21 -0800 (PST)
Message-ID: <f04fb55c-5fa8-f38d-d6e0-7ba29c1973f6@redhat.com>
Date:   Thu, 9 Feb 2023 16:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: drm: panel-orientation-quirks: Add quirk for Lenovo IdeaPad Duet
 3 10IGL5
Content-Language: en-US, nl
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrell,

On 2/3/23 19:32, Darrell Kavanagh wrote:
> Hi,
> 
> This is another Lenovo with detachable keyboard and 1200x1920 screen
> mounted sideways.
> 
> The following has been tested with 6.2.0-rc6.
> 
> Thanks,
> Darrell

Thank you for your patch. Note that instead of "Hi, ... Thanks, Darrell"
there should be a message describing the what and why of the patch
here, see e.g. :

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/drm_panel_orientation_quirks.c?id=653f2d94fcda200b02bd79cea2e0307b26c1b747

I also notice that the diff output below has a bit weird file-paths,
so this patch is clearly not the output of "git format-patch" +
"git send-email" on a standard linux source tree git clone.

The whole kernel patch workflow can be a bit daunting if you are just
trying to submit a small quirk like this.

So you can either try again if you want to, or I can fix all of this up
for you if that is preferred.

If you want me to fix this up for you, there is one thing which I still
need from you, your patch is missing a Signed-off-by line in the commit-message.
I can only accept patches with a Signed-off-by line in the commit-message like
this:

Signed-off-by: Your Real Name <email@your.domain>

By adding this line you indicate that you are the author of the code and
are submitting it under the existing license for the file which you are
modifying (typically GPL-2.0) or that you have permission from the author
to submit it under this license. See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

If you want me to fix this up for you, please reply to this email
with the proper Signed-off-by: ... line for me to add to the commit
message.

Regards,

Hans




> 
> index 3659f04..590bb7b 100644
> --- a/kernel/drm_panel_orientation
> _quirks.c
> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
> D330-10IGM"),
>                 },
>                 .driver_data = (void *)&lcd1200x1920_rightside_up,
> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> +               .matches = {
> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
> +               },
> +               .driver_data = (void *)&lcd1200x1920_rightside_up,
>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
>                 .matches = {
>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> 

