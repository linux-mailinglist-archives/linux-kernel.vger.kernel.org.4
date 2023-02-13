Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB0694C55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBMQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:20:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734B9BB89
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:20:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bu23so12814519wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mU6qexec1f+zW1Aeu9DqeQ3wCbZhG3XkDMyBKrA/AhY=;
        b=rGZytAFH5tU1B2Ez3XLa4cBOuC5134xTXtiuE/1CpMSdG0KA9H9/4Q+ezQLTEtEO9Y
         2vsnTvioW9fTVChIZyVAtYNqKRYHQTJRbTxmuzZw1bEB+vtOFkll19tUeaUAa2MQykz8
         cnPo2w8JrdRM+KMuAZ6kH1SpCi+eAxHrV5NeW1HXrSu+DZ2C6/UGam+8CAXZeJzw/0r2
         11PaBZjThIeVBsCpanU0F5eRZPGZeFKTsWeYFQUTVTTQbg2Kz9umPrcGMbdetA9D0sgx
         m3/WJR1AV2MWxPZ/WSxPlaoNFE+gVL8jKCxFYT7FjeuvqTm8LhbzRGAV0G7pmSSACxxc
         8dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU6qexec1f+zW1Aeu9DqeQ3wCbZhG3XkDMyBKrA/AhY=;
        b=eaFKDADKp+iDZoFeZgONWI2k78313bUSaqyynkJIT2JDgv2O1l3f9/WspwSg8LuZgW
         eEr9//Ocw53KdcMnQwnWlTZtmmPmh324osFR/jS2Iyl5ZoBruLRNVJ2Z9EuI20gQJPkK
         NthyFLkAJYSTlVJ6DZF7INpqpD7ecEGUfJ7vrLAGFj+X/MmFolBeDuD/IYGt2BSZGiJ2
         t1c+RywwxnE3eM8cnot/wJnGJ5Vfw+lFWnVPBw/J7oOyrB43R0SHOBRAeQg2PK/PsXz+
         LLjR2fycIxIP04F8nD0b8FCvrxi+iw8GGFlqOWxeFukglFtRC1hhJ1/DBDToHVsVvPbw
         bSWA==
X-Gm-Message-State: AO0yUKXZV656bEIkGV1vCqf94Upg6SvKRTb2Rw7OABGGRwrGrvIPSX6N
        +qYgl6AB8lGuH7ktbUzLXMqs1Q==
X-Google-Smtp-Source: AK7set88Z4d+kQoR+XPHcDnhnHuiZEwDV8NKjTkfl3hZQajOHXmlATBaIEFqj5Emv8wZzo1a1Yloyg==
X-Received: by 2002:a05:6000:10c6:b0:2c4:67b:36b7 with SMTP id b6-20020a05600010c600b002c4067b36b7mr14483562wrx.54.1676305240013;
        Mon, 13 Feb 2023 08:20:40 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id e14-20020adfe7ce000000b002c54f367fe4sm6231303wrn.100.2023.02.13.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 08:20:39 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:20:29 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+pjTR80bnl9rMK1@myrica>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:02:06PM -0800, Jacob Pan wrote:
> Custom allocator feature was introduced to support VT-d's virtual
> command, an enlightened interface designed for VMs to allocate PASIDs
> from the host.
> 
> As we remove/withdraw the VT-d virtual command feature, the sole user
> of custom allocator, we can safely remove the custom allocator as well.
> Effectively, this will return IOASID core to the original simple global
> namespace allocator.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

You can also drop the spinlock.h include. With that:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
private data helpers") removed the last user of ioasid_set_data(). I guess
that could be dropped too, unless you plan to still use it?

We could also merge ioasid.c into iommu-sva.c at this point, since I
haven't seen any interest for having multiple IOASID sets on Arm, but I'm
not sure what the current plan is for vSVA on x86.

Thanks,
Jean

