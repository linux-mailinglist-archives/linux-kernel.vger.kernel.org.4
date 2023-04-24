Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB1A6E702B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjDSAGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDSAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:06:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FCF5FD1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:06:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id m21so20583302qtg.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1681862810; x=1684454810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpuY+WskmAn+VVWJJI2pgXSztphoZSgNLq8dJrlS3IM=;
        b=HVrJI9fXJg8c8a2nI+ZnBYLNhaxub1sGuEKORhbVoArXG359MV+i5So3frfRU4utOK
         6DVBx9PubjftuRhVfNHR7qDljpkH3F65UNnT5J0ka7oIbNjqG56z3khWQMOXQDhhOgn0
         B488pcKAgtKc9seA4PcGbZGX+EaVQv9PtejbYOsabMa1M3JZcEPK+pcAd2EJeyc4znmD
         kf56XG24XH1SkyrvKXIcpGxKt+uVtC2+XSTtFJWXs1elytDy05JyHHKWwKUrV/7Mj55x
         UAI32OXvU9VvN2LEZzU67ITzMkdbN3p1HphjwdBd8CvOaQc6T2/lEgBFf6LQYdycA/5z
         yefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681862810; x=1684454810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpuY+WskmAn+VVWJJI2pgXSztphoZSgNLq8dJrlS3IM=;
        b=Da8traEl639CgmRnUfXgdrLjUGNw3nnfqv8YlBMD0VfBE76VKo+5CWcirDkfpaeKE5
         zBmFc8bbcMYoybJ0CoVjXnmDt5mE9O/58C5w9eMPgiJBp7QN6ZaO5kTCC/f9wO7uYOw4
         JYz5kjQPr+pkL0s3atE4aIkxQjdkfm1s/m0w06qzUHMdfpmKN3I/P+RVjP8B9cQs/nWm
         NzNE/YPPTGfwQP6D64OQBR91znDDflT2T8PkvtS4T/mpzUxuTmBnbSBiu5CnINk0RVlE
         Xcw468zL02Pczkgq4NcrIs7pqj3KMYXi4qMUl0Jx9+aEaivI8x5LgXPVLX2drJBfEYYt
         HSPQ==
X-Gm-Message-State: AAQBX9dd7+PoZceNZbcPcpEq2ocWdqBB8A9e+nIlP2omqb5M0Uu3BUcF
        EPD4GnOIBKCv8mhPrz5VNegpWQ==
X-Google-Smtp-Source: AKy350ZhaCe4sJbWTtYSSixblUX61kgUSsqtrRHdPbEKDZ69Z7vRe1LMsv/eS9ckRD6Ye7NC/FkmRw==
X-Received: by 2002:a05:622a:1a9d:b0:3bd:140c:91ed with SMTP id s29-20020a05622a1a9d00b003bd140c91edmr3371586qtc.52.1681862810557;
        Tue, 18 Apr 2023 17:06:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id m13-20020ac807cd000000b003ec47cc3613sm854892qth.85.2023.04.18.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 17:06:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1povLU-00CL50-I7;
        Tue, 18 Apr 2023 21:06:48 -0300
Date:   Tue, 18 Apr 2023 21:06:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v4] vfio/cdx: add support for CDX bus
Message-ID: <ZD8wmF4DALTRyWmO@ziepe.ca>
References: <20230418113655.25207-1-nipun.gupta@amd.com>
 <ZD6IiHjWQOv47ZMg@ziepe.ca>
 <CH3PR12MB8308DE1607789063D04B3529E89D9@CH3PR12MB8308.namprd12.prod.outlook.com>
 <20230418144020.6b8368db.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418144020.6b8368db.alex.williamson@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:40:20PM -0600, Alex Williamson wrote:
> On Tue, 18 Apr 2023 12:50:13 +0000
> "Gupta, Nipun" <Nipun.Gupta@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Tuesday, April 18, 2023 5:40 PM
> > > To: Gupta, Nipun <Nipun.Gupta@amd.com>
> > > Cc: alex.williamson@redhat.com; linux-kernel@vger.kernel.org;
> > > kvm@vger.kernel.org; masahiroy@kernel.org; nathan@kernel.org;
> > > ndesaulniers@google.com; nicolas@fjasle.eu; git (AMD-Xilinx) <git@amd.com>;
> > > Anand, Harpreet <harpreet.anand@amd.com>; Jansen Van Vuuren, Pieter
> > > <pieter.jansen-van-vuuren@amd.com>; Agarwal, Nikhil
> > > <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH v4] vfio/cdx: add support for CDX bus
> > > 
> > > Caution: This message originated from an External Source. Use proper caution
> > > when opening attachments, clicking links, or responding.
> > > 
> > > 
> > > On Tue, Apr 18, 2023 at 05:06:55PM +0530, Nipun Gupta wrote:
> > >   
> > > > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > > > index 89e06c981e43..aba36f5be4ec 100644
> > > > --- a/drivers/vfio/Kconfig
> > > > +++ b/drivers/vfio/Kconfig
> > > > @@ -57,6 +57,7 @@ source "drivers/vfio/pci/Kconfig"
> > > >  source "drivers/vfio/platform/Kconfig"
> > > >  source "drivers/vfio/mdev/Kconfig"
> > > >  source "drivers/vfio/fsl-mc/Kconfig"
> > > > +source "drivers/vfio/cdx/Kconfig"  
> > > 
> > > keep sorted  
> > 
> > Since it is not sorted as of now, should a separate patch to be created for
> > sorting, before adding vfio-cdx?
> 
> These are essentially in chronological order rather than alphabetical,
> so I don't really understand this request from Jason.  Perhaps if it
> was already alphabetical the request would be justified, but I don't
> see any obligation here.

Ah, well knee jerk, I keep sorting these things, guess I haven't go
here yet.

Best practice is to sort lists like this.

Jason
