Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519A6DCB75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDJTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDJTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784321980
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681154178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPFo235kyBYgg2fLMT3ZW1ogJR9rn6lHcH28gnhO+so=;
        b=jMD8wY8fFpshfFsuYeq2eFLck9gGpu9C+Va13Hy/iKy3hm0TvDS3yMUoa34P+RrpVz4dKa
        2QOI1ZcJgMaWYRZPZ05dbgdQYdpDJnhITlgE/J3af5HIAscKJX39Y/rr+vnzblXYM7Hq3G
        1ZZpwGoiPNjMuAx04Cm8/4koIRecIoc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-YschVbAsNsm5x_Bar8v_LQ-1; Mon, 10 Apr 2023 15:16:17 -0400
X-MC-Unique: YschVbAsNsm5x_Bar8v_LQ-1
Received: by mail-wm1-f71.google.com with SMTP id h8-20020a05600c314800b003ef649aa8c7so704177wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681154176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPFo235kyBYgg2fLMT3ZW1ogJR9rn6lHcH28gnhO+so=;
        b=TE3TfGY6TNbYOcmdgIorCmpjRsKsQSq8722kttEpgouG6V10ZhOS3f3rPHHgyfFfW0
         3GsJBFTsJBUOo4HgMx+tfefSY2TEu+uaoN4nE8vJCMHZSHhacG1JqwWycbx0/0KTfB5+
         mhGvvBoMwC+xgLhuO8Hfw7JYNQkyMIycKWCaa4i1rSt8argfHxS7dOyWQW2OcckF6/nQ
         Nkjx6Gm4SQUOf/STxuxcKAIKLypt0Lb2d+wUHvimzuu50tyzjqyuddZFZMQDUU2WWZ4X
         XNuNt3x9jkpMT65LIlK8xsUY516uRjmVB2+qfEFMy4cjmYNlSjnXehTO0dUrDtPDau7B
         1AUw==
X-Gm-Message-State: AAQBX9ej+CiwUVFpyC3bclBw+rlhF7aL+myEr+pdyg3q5b//86KGcXxE
        y0GPGxLmONNpQXJnd6C8/DhqrrhOxSMoqHwOW1AhIh1blVs4AZUfS4YHflqARqFGXX6nZ1IyAtf
        1ISQu3yHPDq2XSQ/MIqyfhpJP
X-Received: by 2002:a7b:cd10:0:b0:3e2:19b0:887d with SMTP id f16-20020a7bcd10000000b003e219b0887dmr7974060wmj.25.1681154176079;
        Mon, 10 Apr 2023 12:16:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yj4C6u1lvqj5x8nYc4rUtnI/cLoYn4IqOCfzJdLFCUYWU4OgKl1a1UOtM9Oz4tcJga59u2Qw==
X-Received: by 2002:a7b:cd10:0:b0:3e2:19b0:887d with SMTP id f16-20020a7bcd10000000b003e219b0887dmr7974048wmj.25.1681154175783;
        Mon, 10 Apr 2023 12:16:15 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003ede04deb14sm18677422wmq.48.2023.04.10.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 12:16:15 -0700 (PDT)
Date:   Mon, 10 Apr 2023 15:16:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230410151532-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
 <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:03:01AM -0700, Guenter Roeck wrote:
> On 4/10/23 02:56, Michael S. Tsirkin wrote:
> > On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
> > > On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> > > > Statically allocated array of pointed to hwmon_channel_info can be made
> > > > const for safety.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > 
> > > > ---
> > > > 
> > > > This depends on hwmon core patch:
> > > > https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> > > > 
> > > > Therefore I propose this should also go via hwmon tree.
> > > 
> > > I am not going to apply patches for 10+ subsystems through the hwmon tree.
> > > This can only result in chaos. The dependent patch is available at
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> > 
> > Doesn't it cause build errors or warnings there?
> > 
> 
> Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
> on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
> I have not seen any such reports, and I don't immediately see why that would be
> the case. Please elaborate.
> 
> Guenter


I'm not saying that, I just assumed the vdpa patch fixes build.
If build is ok we can just wait for hwmon patch to get upstream. No
rush.

> > > or wait until after the next commit window to apply this patch.
> > > 
> > > Thanks,
> > > Guenter
> > > 
> > > > 
> > > > Cc: Jean Delvare <jdelvare@suse.com>
> > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > Cc: linux-hwmon@vger.kernel.org
> > > > ---
> > > >    drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> > > > index e695e36ff753..65304354b34a 100644
> > > > --- a/drivers/vdpa/solidrun/snet_hwmon.c
> > > > +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> > > > @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
> > > >    	.read_string = snet_hwmon_read_string
> > > >    };
> > > > -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> > > > +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
> > > >    	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
> > > >    			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
> > > >    	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> > 

