Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6267520A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjATKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjATKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:08:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8009D8B31E;
        Fri, 20 Jan 2023 02:08:38 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6CD116602AAA;
        Fri, 20 Jan 2023 10:08:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674209316;
        bh=mGZMRhz079cBUS3es9XAvPfXNBT914As8zfpB8Pu9n4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZWHBopnaIcDi261qkYCZ/g4fD7bEZ1Ek8PwKjhKVuNsNx1nenWz+K7ID4TSR7SWO5
         XFvWgQ2lRRZE5EzQkG92UzEV8UExou8CWSm5mjZJPVQTZuHO+7+6X3vUv8rJCsVc85
         iubV3oJ1y0d+jEIMqMySOLl0Zyx2y9f6RX8DV78Vt9W19exCH3eumax91ZnZZ5qCrJ
         LA/ahTmOejcx+9iWNauPHVSAz0xPmhcAJSLTeUpATtXNBKMcdF4SszpfmF4WURSDHV
         cU9sHbYnW0giNFNPwFCJLP0GQa8bbkAbt6oI+Eyo4IoEijpplAPvWdmk7FHtahrGSy
         DFhERHKe3a5FQ==
Date:   Fri, 20 Jan 2023 11:08:33 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Matthew Brost <matthew.brost@intel.com>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, corbet@lwn.net,
        tzimmermann@suse.de,
        "Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= (Intel)" 
        <thomas_os@shipmail.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bskeggs@redhat.com,
        jason@jlekstrand.net, nouveau@lists.freedesktop.org,
        airlied@redhat.com, christian.koenig@amd.com
Subject: Re: [PATCH drm-next 13/14] drm/nouveau: implement new VM_BIND UAPI
Message-ID: <20230120110833.76cc7864@collabora.com>
In-Reply-To: <Y8jOCE/PyNZ2Z6aX@DUT025-TGLU.fm.intel.com>
References: <20230118061256.2689-1-dakr@redhat.com>
        <20230118061256.2689-14-dakr@redhat.com>
        <e371e8a1-88f8-1309-07ca-f48f4157fec8@shipmail.org>
        <8e10b46c-f934-8eee-904e-b3d8a7644a71@redhat.com>
        <Y8jOCE/PyNZ2Z6aX@DUT025-TGLU.fm.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 04:58:48 +0000
Matthew Brost <matthew.brost@intel.com> wrote:

> > For the ops structures the drm_gpuva_manager allocates for reporting the
> > split/merge steps back to the driver I have ideas to entirely avoid
> > allocations, which also is a good thing in respect of Christians feedback
> > regarding the huge amount of mapping requests some applications seem to
> > generate.
> >  
> 
> It should be fine to have allocations to report the split/merge step as
> this step should be before a dma-fence is published, but yea if possible
> to avoid extra allocs as that is always better.
> 
> Also BTW, great work on drm_gpuva_manager too. We will almost likely
> pick this up in Xe rather than open coding all of this as we currently
> do. We should probably start the port to this soon so we can contribute
> to the implementation and get both of our drivers upstream sooner.

Also quite interested in using this drm_gpuva_manager for pancsf, since
I've been open-coding something similar. Didn't have the
gpuva_region concept to make sure VA mapping/unmapping requests don't
don't go outside a pre-reserved region, but it seems to automate some
of the stuff I've been doing quite nicely.
