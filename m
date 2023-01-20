Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257F76754DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjATMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC881BC2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674218714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YWTNOPUOumy5aDePbdwVljMsaDB1wMCPYL0DgkBFZF8=;
        b=G3mVpUvhkhrnR8H6woWhYuC8ffGn8Vp/koQzqI77Cb+8D8slGPUsrSdu4rf/GtYrLd9Qnt
        41ra1gKbD+5/cBFQ8thbdqYEhuLTXzuv1xtJKFE3RcCcTW8BBFvOcOvC3+7ekFZ2SVAR9Y
        nUAvN2XHVb3bvbb98VVqwkcBrq2oEDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-ZjrgSoRYM7uDCaxvK7uF-w-1; Fri, 20 Jan 2023 07:45:11 -0500
X-MC-Unique: ZjrgSoRYM7uDCaxvK7uF-w-1
Received: by mail-wm1-f69.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso2986639wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWTNOPUOumy5aDePbdwVljMsaDB1wMCPYL0DgkBFZF8=;
        b=c2TrH1TnJsTgE/K7XFu/Z3y9YVXh01LXUY5y3zVwEPWGglG9fw6YBPtCVhtCWsB5Rr
         kEbhk4vne8tC8d/dTSIluy4QjZDBXYcP+pZOEa8k5hDr/89TN5T9LUmL1bq1nMbn8tCV
         45EHmq4LwdjFPdTz5gWcggbIeQXMOWct3gZjjz+QwbXI9imKwziFgpC4bmus68JyVj6G
         HILCCPjFfc8Lj1VnE91HypZEDzqhi+Jlhccq1CG54p8uf3p6JrGr6WAmv1DiN5DpX/eD
         MNw5BZERniEIwmRDmwLaYze9HF6TiumIbbkBnr/lX5/7Rlmd1I5ByvpmYGFQqwu04AnY
         EFRQ==
X-Gm-Message-State: AFqh2krXH8OUAYHayophD9sq5g110uwvjxZovjnG1puiaqhAjrqyg4lh
        9s2uubjafsd/Bl7NywjiKdvCvffitAc1wVysmfPAoJSJ36Bhx4iyEjsWg85XcpECk9hI0FhVZrU
        8THUMIhX66T7kGp6A8Fi4KgL6
X-Received: by 2002:a5d:5955:0:b0:2bd:e87c:e831 with SMTP id e21-20020a5d5955000000b002bde87ce831mr11862725wri.69.1674218709868;
        Fri, 20 Jan 2023 04:45:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFTBS2vpkIrxrS4rpXlcCJkUPLp7KgbaNRpa66vaoAYh2QvTIbam4nZFlOHaCWilzFiSDtYQ==
X-Received: by 2002:a5d:5955:0:b0:2bd:e87c:e831 with SMTP id e21-20020a5d5955000000b002bde87ce831mr11862700wri.69.1674218709503;
        Fri, 20 Jan 2023 04:45:09 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id q17-20020a056000137100b002be4ff0c917sm2099412wrz.84.2023.01.20.04.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:45:08 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:45:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
Message-ID: <20230120074120-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
 <Y8lgIS+jygB7SGrn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lgIS+jygB7SGrn@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:22:09PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
> > In handle_control_message(), we look at the ->event field twice, which
> > gives a malicious VMM a window in which to switch it from PORT_ADD to
> > PORT_REMOVE, triggering a null dereference further down the line:
> 
> How is the other VMM have full control over the full message here?
> Shouldn't this all have been copied into our local memory if we are
> going to be poking around in it?  Like I mentioned in my other review,
> copy it all once and then parse it.  Don't try to mess with individual
> fields one at a time otherwise that way lies madness...
> 
> thanks,
> 
> greg k-h

I agree and in fact, it is *already* copied since with malicious
device we generally use a bounce buffer.
Having said that, the patch is actually a cleanup, e.g. it's clearer
to byte-swap only once.
Just don't oversell it as a security thing.


-- 
MST

