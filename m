Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D731567B8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjAYRtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjAYRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C56A245
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674668876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1uz/WvR1kntJCHUcdHEFPXiKPk90yS9eZtHwp4ILXA=;
        b=cbceCvAdpuLN+vpDyPUNmIzYpz8PJQ+9AjVXIvZaooLPS3JF+llMqptkSOs9BcfYyP+i2H
        wYnDKlDsMmeAuiYaP5H7BDyHnqE8JkhSzAeKPCwNHAqL93786T4iLAESxwUSzhYpqOBN7f
        RE0ddher+JA6BQ3k/jxMUj0CGqnZZtM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-yt_1lmg3NTOalMh-qgkslg-1; Wed, 25 Jan 2023 12:47:55 -0500
X-MC-Unique: yt_1lmg3NTOalMh-qgkslg-1
Received: by mail-ej1-f70.google.com with SMTP id du14-20020a17090772ce00b0087108bbcfa6so12438906ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1uz/WvR1kntJCHUcdHEFPXiKPk90yS9eZtHwp4ILXA=;
        b=wEJekzwSCpM8yp2XJDRIst0BJCfF76sPKN+5cSiZegC+KsrCBsRYIV/4Z+biWsxTFD
         V63x3OGcGe3cN6Bdp0OIfWAk21Hj9TNmKZlSfNGbcgN3anqfvigke+eZNE3NW78Qtw0e
         2E0M/FmXOLLp7RWHuFGKPHh5ej0aEgX+N9/mruCo/j1JPHyOuRlevFzjcKpZ3qzIvNmB
         lGxGrswr1fYStJF0iayCJeEcIQMdZ829e8IBwp5cNZlLx4BDMrbqMM1A8X/xD1bwX0mc
         UZxIlVdz5rHTNtUe90kJvi8eqrL7h1glyL3/CqzaHkfoj7E9eBmo9SaeFCiTZOHs7hld
         2u1A==
X-Gm-Message-State: AFqh2krYMVCC9inH8vHSkQ17uV88ZlVuhgsmkjQ04sZ3qplLqLIgXGZR
        RRFI5rsHxLiLAWjhIQH6HBjsWCOVRix+5eUnAoNoAYc/3en684YlpWdWrjvvLDqiy5YqghVH8X7
        MjuVCvKH1KvjgcrHHDLmHj6WE
X-Received: by 2002:a17:906:d8ab:b0:86f:50ff:ef25 with SMTP id qc11-20020a170906d8ab00b0086f50ffef25mr34825541ejb.63.1674668873975;
        Wed, 25 Jan 2023 09:47:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu83KIXwbXDlz56GSTdcHSfE99QpzGf+xdVZqmgb3riyzbl08F66jpRPNN+enycBK7H3mnwIg==
X-Received: by 2002:a17:906:d8ab:b0:86f:50ff:ef25 with SMTP id qc11-20020a170906d8ab00b0086f50ffef25mr34825532ejb.63.1674668873829;
        Wed, 25 Jan 2023 09:47:53 -0800 (PST)
Received: from redhat.com ([2.52.134.175])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906265900b007ae10525550sm2660416ejc.47.2023.01.25.09.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:47:53 -0800 (PST)
Date:   Wed, 25 Jan 2023 12:47:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <20230125124543-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <Y9FHsvVoPbgMR2s3@kroah.com>
 <20230125103816-mutt-send-email-mst@kernel.org>
 <20230125160203.z4ttwlgclfd54pc6@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125160203.z4ttwlgclfd54pc6@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:02:03PM +0300, Kirill A. Shutemov wrote:
> On Wed, Jan 25, 2023 at 10:45:48AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Jan 25, 2023 at 04:16:02PM +0100, Greg Kroah-Hartman wrote:
> > > Everyone wants a subset, different from other's subset, which means you
> > > need them all.  Sorry.
> > 
> > Well if there's a very popular system (virtual in this case) that needs
> > a specific config to work well, then I guess
> > arch/x86/configs/ccguest.config or whatever might be acceptable, no?
> > Lots of precedent here.
> 
> OS vendors want the single kernel that fits all sizes: it should be
> possible (and secure) to run a generic disto kernel within TDX/SEV guest.

If they want that, sure. But it then becomes this distro's
responsibility to configure things in a sane way. At least if
there's a known good config that's a place to document what
is known to work well. No?

-- 
MST

