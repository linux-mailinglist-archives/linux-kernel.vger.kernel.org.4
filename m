Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E636447E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiLFPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLFPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:22:37 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC262E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:22:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso18377139pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UU8AMEdCApUKn2yCNu179y3IuDBUbfO2XN1Qp+qLAs8=;
        b=jG3sZcdZjSQIRjZkl/f7DOP3dlw758+HEdK7GWWq8fnj9XOdoNxOkBB2jC/8fB14wx
         9FNJy2pQnOLNPshZ0wncMGcgTjWilHuX1Bof33jsFVE2FkTXuTJbGdHUPK3/27UaGkvK
         M5eCBf9DWrA3/swfuE4dabHXjTiAR1WKAKwpHstU30D9ufiWl2NcIxhMoypIVrjzmYCl
         spyYHwWMmjSH6fjzFZEmEiwvpNMjodZFbFQeR2MIYjLq4JYYpySczgRZTnLObyGe9JnD
         k6I7+5uanHUHMcum9tuQsR/k+FU6BcxcU7gl4DPlzzQZx8dB4g0Mi3WATLONu2k2T3NX
         tEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU8AMEdCApUKn2yCNu179y3IuDBUbfO2XN1Qp+qLAs8=;
        b=dwHff0bBRnBYxLCJugZS+10Hzt413N/ZyKUShsNY85/SfTLUAn07ZYE7BGocIyY91j
         5UOmeURF3xthRympw9SrjtV8AnH7pK9MMQOeQIGxfI/dWJ/WoZqYOcyJOV1yHJ3YPsck
         DCczksHpRK2gqIc4DZrY7boOatfcBwwBmMO1j8EC1bgg/jnMZx+HKNxQ7FZCHFKBYXXN
         V6UqAw7gER9DQnU4elPBbBcRYI4abm5eL12YkJaAJDhPlpEUkHxZtVTMfSAHf+SlEAUC
         1H0I+pWpk+k3dDNGbGakliYUCrN94o/CbwgZSVZ/xMNMZhHxzlPimneo+2VCXeTjSTpD
         zaIQ==
X-Gm-Message-State: ANoB5pnGjDO/zOD8tLVk3AOg3fyi6ZZeojme4LA/5EZ/sldhB/g2H447
        HbWJyDipPtapc2WouzkjbxreWtVd3iuTiXWN
X-Google-Smtp-Source: AA0mqf4Ycm0ZpEHchEyW5wHkELYu+0YMn7TsJMJRfE0+nFFPq8XQvhmYhp2h5imhee7dmv/YvgeI/Q==
X-Received: by 2002:a17:90b:2544:b0:20a:f341:4ed9 with SMTP id nw4-20020a17090b254400b0020af3414ed9mr98991840pjb.11.1670340155171;
        Tue, 06 Dec 2022 07:22:35 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b00176b84eb29asm12790880plc.301.2022.12.06.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:22:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p2ZmD-004cnQ-5r;
        Tue, 06 Dec 2022 11:22:33 -0400
Date:   Tue, 6 Dec 2022 11:22:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
        kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
        cohuck@redhat.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
        eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
        Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y49eObpI7QoSnugu@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206135810.GA27689@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 02:58:10PM +0100, Christoph Hellwig wrote:

> Most importantly NVMe is very quiet on the relationship between
> VFs and PFs, and there is no way to guarantee that a PF is, at the
> NVMe level, much in control of a VF at all.  In other words this
> concept really badly breaks NVMe abstractions.

Yeah, I think the spec effort is going to be interesting for sure.

From a pure Linux and implementation perspective a decision must be
made early on how to label the DMAs for kernel/qemu vs VM controlled
items at the PCI TLP level.

> controlled functions (which could very well be, and in some designs
> are, additional PFs and not VFs) by controlling function.  

In principle PF vs VF doesn't matter much - the question is really TLP
labeling. If the spec says RID A is the controlling RID and RID B is
the guest RID, then it doesn't matter if they have a PF/VF
relationship or PF/PF relationship.

We have locking issues in Linux SW connecting different SW drivers for
things that are not a PF/VF relationship, but perhaps that can be
solved.

Using VF RID / VF PASID is appealing at first glance, but there is
list of PCI emulation details that have to be worked out for that to
be good. eg what do you do with guest triggered FLR? Or guest
triggered memory disable? How do you handle PCIe AER? Also lack of
PASID support in CPUs is problematic.

Lots of trade offs..

Jason
