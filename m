Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36D7189EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEaTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEaTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:14:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD67107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:14:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6b34d2fdcso36593631cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685560445; x=1688152445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0tywlLlHZmN2sb1VXP3e/xTGJtBP4rtM1yXFljfO7I=;
        b=ElUCH1LpTJHtkSCpamXz3jwnnOkpxNLsLN8nx7oiDLy9hx53VnFli4EjzZz8Sav69f
         MrDWZ36frz2K016iKV8291YRTmkXZCNs79ckPQyRyoChIgIhmxHW+D3Hg+md/5ppcSHm
         iAMO+RW6Jx1og9XK9MG7FWd7cnLfQHmzHcl0//gxK9723wd9H3sKnKj3K9m7lU1oCu0R
         UsGTQ1MBGXAd5tErFLFtSd3nibLDOJ42dlDpIe+pKGP4oTYGfLOQGbLRu34ISc2Uun3Q
         XC/ny8h6vpNuAxaB5By8r6QfSq17hNwjt8mP7u7zugPHZWfTDGD/mxj6NDjdmFepDREk
         z9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560445; x=1688152445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0tywlLlHZmN2sb1VXP3e/xTGJtBP4rtM1yXFljfO7I=;
        b=eiQ7XVUt3XidIxcC755SdBCa0jf0UwSHv9Biou3nlPQWuTLJtIkemcJaMPl3lzUJ6X
         ikbMVdIBbYSKrU7Lvpg8OxB/RgsBnV+gVvYglZe2c9tO//9SQ+OTeDkEK3eRhsTXdWJQ
         5Y7Dj7TSQN27x9V65mPPTjHRO78o3juY7ZSit/f8boOVhOHdwankojjMoJw4eqKazuVQ
         3aAxf8r/gnMZkyhsAmTS52I+31eq68YA7mhIDx8u+bCr7J4BZl8KTTbt8rcIEgb7SsRk
         s6dIQFNnbOb/ZomWtxSNJb+ZBE/u9jqzyDqFXXgu0OxTt2pjfy+Ojkwr7CMLn3DeErOJ
         oVGQ==
X-Gm-Message-State: AC+VfDzOQYMyFPr5VmdQ57q3frLnHxrmDsBUUIrEL6dW63Nzb4Ni3x/s
        jEJt/29nNtBci4bIYl1o4gbuYh3n6yXxgoAuXtM=
X-Google-Smtp-Source: ACHHUZ6cpQLrHNwS+2SmmQFahiElKqp1WZDxoi2ZVEf2d22+YdLH0Lu2HdHD64oOTK+T40VqBdI0Pw==
X-Received: by 2002:ac8:7c4d:0:b0:3f4:ff4e:c5ed with SMTP id o13-20020ac87c4d000000b003f4ff4ec5edmr7340582qtv.47.1685560444973;
        Wed, 31 May 2023 12:14:04 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id cp10-20020a05622a420a00b003f4a76d4981sm6296426qtb.66.2023.05.31.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:14:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4RGl-0017ZO-JH;
        Wed, 31 May 2023 16:14:03 -0300
Date:   Wed, 31 May 2023 16:14:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Juxin Gao <gaojuxin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
Message-ID: <ZHeceyZ9eUC27WcE@ziepe.ca>
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas>
 <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <20230528165738.GF2814@thinkpad>
 <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
 <20230529053919.GB2856@thinkpad>
 <CAAhV-H6EPkGJchA4pg=zctmmt=9LboaFqKhFgQxZKNxJxQVT7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6EPkGJchA4pg=zctmmt=9LboaFqKhFgQxZKNxJxQVT7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:52:29PM +0800, Huacai Chen wrote:

> > But IMO what you are proposing seems like usecase driven and may not work all
> > the time due to architecture limitation. This again proves that the existing
> > solution is sufficient enough.

> Yes, it's a usecase driven solution, so I provide a cmdline parameter
> to let the user decide.

The NIC drivers should be consuming interrupts based on the number of
queues they are using, and that is something you can control from the
command line, eg ethtool IIRC. Usually it defaults to the number of
CPUs.

Basically, you want to enable the user to configure the system with a
user specified reduced number of NIC queues, and we already have way
to do that.

Jason
