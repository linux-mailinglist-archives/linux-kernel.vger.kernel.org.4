Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BD5FC790
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJLOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJLOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:38:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C0422FF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:38:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o22so10152532qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0eqSs8D8Zyq93HxhcB9uauCbxkxsD79LqnsXThBZU4=;
        b=nBlGzmppneJVftZVAdRUc8SDMtu28+R52PjX0hqulIEfS4QZ9X3ZxOsFb+wI9VyrWn
         L/LUAF4zAGuwresjaJtPbsUQzAbxfPQ0W2hprNo7mjdNFp4BPvQT9n9LBcPQkREsO7Af
         6b9iZUi3QgZnvK6cGojAjMQUAd6i+J3tln76arHaaeh3g/AUeFxxwDOr6ngw2zlZt5LZ
         JI28ohC7AeIA6B2gAXCA3RPFGhJ/s3wMBSxnkdNKGiphQAntDwcnxELsJvGLiKgoJ22n
         PfjHbfxSykYX0msc93QSe97LiewYxQf7oVnf6O3oXEw2GKmjUiydwB8oUe6E42DMK7Y0
         zXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0eqSs8D8Zyq93HxhcB9uauCbxkxsD79LqnsXThBZU4=;
        b=mIhI1/ea0sfM59kpY+rAnphzGYU6ksL9SFw3S0jMZcCYBXpoZakbTipvgnmSvlfOzA
         7y0HyVeNauFEF4LOxAdbW8AdFOiZ4wxLhrBYZr82nO8kHwyXXiWrEpo3xKY2n+ho6VQT
         A+DqdZPD/YmJkMccqpltsfI/L9aX3ETehEkY2gebjJkva/Na3OekBK77IMMNmTwB6oOV
         L4AKFa/kQLXMyutWjnylU8xN7LUr5p28Kii3NXDb65+NAbarczczVA+6GOHFEzVBr+BM
         m6vofPXLR/A6+WxSKCZNjMmLMP9D7F8pLqdprD46MWllk5Pnv3bbMNRuQ95Um+1PIsR0
         hLdg==
X-Gm-Message-State: ACrzQf08hGb3cr6UM/rrBGeHsgG++8tAaNFfQeqrdWFTumTNCxh7vvyG
        hojzZgR80ld4vp7q3gV1TuvrYQ==
X-Google-Smtp-Source: AMsMyM4+AIWJQxWBA4Jv0JHMqvqHYDWJctiOTgcBHB44Ww27YolyE0l6UFRUO8aTgAryoalNdC720g==
X-Received: by 2002:a37:34e:0:b0:6ea:2cef:131f with SMTP id 75-20020a37034e000000b006ea2cef131fmr16541977qkd.554.1665585512620;
        Wed, 12 Oct 2022 07:38:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006bc192d277csm16352660qko.10.2022.10.12.07.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 07:38:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oicsP-001y84-7s;
        Wed, 12 Oct 2022 11:38:29 -0300
Date:   Wed, 12 Oct 2022 11:38:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Radovanovic, Aleksandar" <aleksandar.radovanovic@amd.com>
Cc:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC PATCH v3 4/7] bus/cdx: add cdx-MSI domain with gic-its
 domain as parent
Message-ID: <Y0bRZTP9Kc6mdCiu@ziepe.ca>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <20220906134801.4079497-1-nipun.gupta@amd.com>
 <20220906134801.4079497-5-nipun.gupta@amd.com>
 <87h71juxuk.wl-maz@kernel.org>
 <DM6PR12MB30820EE430405FF50C7F856BE8229@DM6PR12MB3082.namprd12.prod.outlook.com>
 <MN2PR12MB43586084670E14691920952889229@MN2PR12MB4358.namprd12.prod.outlook.com>
 <Y0a65a9leWXpKfTo@ziepe.ca>
 <MN2PR12MB4358A871519748CD7A6DB7A089229@MN2PR12MB4358.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4358A871519748CD7A6DB7A089229@MN2PR12MB4358.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:37:54PM +0000, Radovanovic, Aleksandar wrote:
> > On Wed, Oct 12, 2022 at 10:34:23AM +0000, Radovanovic, Aleksandar wrote:
> > 
> > 
> > > As for GITS_TRANSLATER, we can take up to 4 different IOVAs, which
> > > limits us to 4 CDX devices (should be sufficient for current HW
> > > use-cases). Also, it means that the address part must be the same for
> > > all vectors within a single CDX device. I'm assuming this is OK as it
> > > is going to be a single interrupt and IOMMU domain anyway.
> > 
> > This is not at all how MSI is supposed to work.
> 
> In the general case, no, they're not.

I don't mean that you can hack this to work - I mean that in MSI the
addr/data is supposed to come from the end point itself, not from some
kind of shared structure. This is important because the actual act of
generating the write has to be coherent with the DMA the device is
doing, as the MSI write must push any DMA data to visibility to meet
the "producer / consumer" model.

So it is really weird/wrong to have a HW design where the MSI
infrastructure is shared across many devices.

Jason
