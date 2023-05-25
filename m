Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58260710FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbjEYPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjEYPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:37:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51573195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:37:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d341bdedcso1757549b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685029029; x=1687621029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WqkV3Ised6qPUj0IUXWS1rMcCw5ypfMdkirIeeecQyA=;
        b=hq/GsZj1vX7ahRVOXRYxEbQv5QqDWy/5/4fqAndh2UeMlDK2u1LPc+HfY5qmxBEldm
         9LbilrKqRhW1IMUjlKg9uI7MxmmuojIyjOJs2qaZb/nGtvuTz9SNpU940kTU9GDa4zki
         b0RoJUgEXHnB1N8fjZEhD/j0YOn0qy+xqYeDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029029; x=1687621029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqkV3Ised6qPUj0IUXWS1rMcCw5ypfMdkirIeeecQyA=;
        b=ilZsAw+X0wNdajny7Xt18uc9i6hnTjvndh2XBf6Di5Y9r0ivRL8XeWERD4dWhq2v3B
         No9Ewo9sJLuwQxLbLUMvDYw2H2qyvxu7pS6DH1CDUvaBVR8S1eFgt5B+d6cmjD/wSncr
         QS/017n1UwqCzTlwr4RrUf/4vEuvnKEjWrU5IGvmrZ+4rKqC7yUTEZtzX3Ajn6GqRPp6
         /Z9Ons7erTymLrQIVt1OxZUCDhpUISgAqJChPLHsKtBVeR0xcuyipOMFZsQLUKjztwaC
         Off5S2HUNV0IeVKqch6/D2IUu/KJXcqco9RAKbz/SfBkXytFDpwAfhUcpjVKM6SY7txx
         BdEQ==
X-Gm-Message-State: AC+VfDyt34BBjxFxPjdpbQHrpmZ7YZ/67Q1Uh9pY9CjXDn1u4KpJT7k6
        dvcHE1TsuPZa+cv/8ZEHbbvuNQ==
X-Google-Smtp-Source: ACHHUZ7bXnRAGuRKthd2+1NcJsj/KXMZ/vOwewd1hvIggUIH1Dhz1QJuOVCzcVj/gn07mx09sMaViw==
X-Received: by 2002:a05:6a20:8215:b0:10a:f8d3:2cf3 with SMTP id w21-20020a056a20821500b0010af8d32cf3mr13858750pzb.7.1685029028760;
        Thu, 25 May 2023 08:37:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r18-20020a62e412000000b0064afdc88465sm1307623pfh.213.2023.05.25.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:37:08 -0700 (PDT)
Date:   Thu, 25 May 2023 08:37:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        "Russell, Kent" <Kent.Russell@amd.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: enable more strict compile checks
Message-ID: <202305250832.0127ABAC@keescook>
References: <20230524191955.252212-1-hamza.mahfooz@amd.com>
 <CADnq5_Mz6aPFYGnr8J8C8UeTpbo7JDg+uvjqAxo7o4vmTGej2A@mail.gmail.com>
 <DM6PR12MB3996C4248CBC968A7B08341583419@DM6PR12MB3996.namprd12.prod.outlook.com>
 <BL1PR12MB589849F37FBE98A3A06A316185419@BL1PR12MB5898.namprd12.prod.outlook.com>
 <3fefc712-913a-a391-bc7b-c0c75eff1c3d@amd.com>
 <CADnq5_OdWbg6zKjPrRwd2QSDnHgFuThF+OQHM=tVWj-2ySCu_A@mail.gmail.com>
 <e26351ed-ba64-b7e1-5165-de40622e0d30@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e26351ed-ba64-b7e1-5165-de40622e0d30@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, May 24, 2023 at 04:27:31PM -0400, Hamza Mahfooz wrote:
> + Kees
> 
> On 5/24/23 15:50, Alex Deucher wrote:
> > On Wed, May 24, 2023 at 3:46 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> > > 
> > > Sure, I think we tried enabling warnings as errors before and had to
> > > revert it because of weird compiler quirks or the variety of compiler
> > > versions that need to be supported.
> > > 
> > > Alex, are you planning to upstream this, or is this only to enforce more
> > > internal discipline about not ignoring warnings?
> > 
> > I'd like to upstream it.  Upstream already has CONFIG_WERROR as a
> > config option, but it's been problematic to enable in CI because of
> > various breakages outside of the driver and in different compilers.
> > That said, I don't know how much trouble enabling it will cause with
> > various compilers in the wild.

-Wmisleading-indentation is already part of -Wall, so this is globally
enabled already.

-Wunused is enabled under W=1, and it's pretty noisy still. If you can
get builds clean in drm, that'll be a good step towards getting it
enabled globally. (A middle ground with less to clean up might be
-Wunused-but-set-variable)

I agree about -Werror: just stick with CONFIG_WERROR instead.

-Kees

> > 
> > Alex
> > 
> > > 
> > > Regards,
> > >     Felix
> > > 
> > > 
> > > On 2023-05-24 15:41, Russell, Kent wrote:
> > > > 
> > > > [AMD Official Use Only - General]
> > > > 
> > > > 
> > > > (Adding Felix in CC)
> > > > 
> > > > I’m a fan of adding it to KFD as well. Felix, can you foresee any
> > > > issues here?
> > > > 
> > > > Kent
> > > > 
> > > > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
> > > > *Ho, Kenny
> > > > *Sent:* Wednesday, May 24, 2023 3:23 PM
> > > > *To:* Alex Deucher <alexdeucher@gmail.com>; Mahfooz, Hamza
> > > > <Hamza.Mahfooz@amd.com>
> > > > *Cc:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry
> > > > <Harry.Wentland@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Siqueira,
> > > > Rodrigo <Rodrigo.Siqueira@amd.com>; linux-kernel@vger.kernel.org;
> > > > dri-devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; Daniel
> > > > Vetter <daniel@ffwll.ch>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; David Airlie <airlied@gmail.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>
> > > > *Subject:* Re: [PATCH v2] drm/amd/display: enable more strict compile
> > > > checks
> > > > 
> > > > [AMD Official Use Only - General]
> > > > 
> > > > [AMD Official Use Only - General]
> > > > 
> > > > (+ Felix)
> > > > 
> > > > Should we do the same for other modules under amd (amdkfd)?  I was
> > > > going to enable full kernel werror in the kconfig used by my CI but
> > > > this is probably better.
> > > > 
> > > > Kenny
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > *From:*Alex Deucher <alexdeucher@gmail.com>
> > > > *Sent:* Wednesday, May 24, 2023 3:22 PM
> > > > *To:* Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> > > > *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> > > > Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Ho, Kenny <Kenny.Ho@amd.com>;
> > > > Pan, Xinhui <Xinhui.Pan@amd.com>; Siqueira, Rodrigo
> > > > <Rodrigo.Siqueira@amd.com>; linux-kernel@vger.kernel.org
> > > > <linux-kernel@vger.kernel.org>; dri-devel@lists.freedesktop.org
> > > > <dri-devel@lists.freedesktop.org>; Daniel Vetter <daniel@ffwll.ch>;
> > > > Deucher, Alexander <Alexander.Deucher@amd.com>; David Airlie
> > > > <airlied@gmail.com>; Wentland, Harry <Harry.Wentland@amd.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>
> > > > *Subject:* Re: [PATCH v2] drm/amd/display: enable more strict compile
> > > > checks
> > > > 
> > > > On Wed, May 24, 2023 at 3:20 PM Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > > wrote:
> > > > > 
> > > > > Currently, there are quite a number of issues that are quite easy for
> > > > > the CI to catch, that slip through the cracks. Among them, there are
> > > > > unused variable and indentation issues. Also, we should consider all
> > > > > warnings to be compile errors, since the community will eventually end
> > > > > up complaining about them. So, enable -Werror, -Wunused and
> > > > > -Wmisleading-indentation for all kernel builds.
> > > > > 
> > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > > > Cc: Kenny Ho <kenny.ho@amd.com>
> > > > > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > > > ---
> > > > > v2: fix grammatical error
> > > > > ---
> > > > >   drivers/gpu/drm/amd/display/Makefile | 2 ++
> > > > >   1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/display/Makefile
> > > > b/drivers/gpu/drm/amd/display/Makefile
> > > > > index 0d610cb376bb..3c44162ebe21 100644
> > > > > --- a/drivers/gpu/drm/amd/display/Makefile
> > > > > +++ b/drivers/gpu/drm/amd/display/Makefile
> > > > > @@ -26,6 +26,8 @@
> > > > > 
> > > > >   AMDDALPATH = $(RELATIVE_AMD_DISPLAY_PATH)
> > > > > 
> > > > > +subdir-ccflags-y += -Werror -Wunused -Wmisleading-indentation
> > > > > +
> > > > 
> > > > Care to enable this for the rest of amdgpu as well?  Or send out an
> > > > additional patch to do that?  Either way:
> > > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > 
> > > > Alex
> > > > 
> > > > >   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
> > > > >   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
> > > > >   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
> > > > > --
> > > > > 2.40.1
> > > > > 
> > > > 
> -- 
> Hamza
> 

-- 
Kees Cook
