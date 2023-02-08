Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE668EB78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBHJcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjBHJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1512459C7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675848671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fL9GfO9S2K1ILUcSG3jhywAqIETi3NhaIzZtWMIxF3Q=;
        b=P0s1FomlJRvTOCSkQGx5TPFKElrcYW2kvOaBo/8axrp7jp8+dnQzQl/tpMNWu7vDJIAHog
        5/GRzeXd/GurbaseqzuFTGuUcJ+UluUZAbt6JkRT0Rwc1JWhHPsqVxFkjDM3uXqNSX30cs
        mqkjwO18kPn7v7aQTwBLorfoM2r6O7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-oSUDGgM4O0qBfvkqcPpr6w-1; Wed, 08 Feb 2023 04:31:10 -0500
X-MC-Unique: oSUDGgM4O0qBfvkqcPpr6w-1
Received: by mail-wr1-f71.google.com with SMTP id g15-20020adfd1ef000000b002c3daec14f3so2008700wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL9GfO9S2K1ILUcSG3jhywAqIETi3NhaIzZtWMIxF3Q=;
        b=uCIhNu6eOVv0hAMrWuUDudxR6/v3ehGyHmyumiYNXuoy7KtdbS78dnvvtDlSH8QXRa
         cqlX6e8tZDIpVZU9SiloDlqoFx9Dn+dmPX50LUrAiEb+r3AqpuH1vjWqNEIxPQOXtj1N
         xHeFry4tmqso/HcgR1Ow+NEsndDpqf0ZzfmWqvQy+xi/rkNFlHKwY1HXcB56jSsJVXth
         76URHekWZ2t3Yrz/wQ4vbdqIkgtSzV5pCYVZxh4A+WNQQeLI9+UmRNBtNKPeq41BDVlw
         WjDKRWDQaX664VZiR1QhEAmaf/A7+PsxT+x8IIofNujUIMrImvBSCjlV46JEuG5N0YXS
         my9Q==
X-Gm-Message-State: AO0yUKWejo34WtU0Mk2vuflROKbPXaneQ8N03fJzHdJIF8ky5PZ16Pwj
        9VMVMS1tUQAoK4ZNeVhfucSA30LKUUX725vtkap7wedZ20kLV/6o88ndriK/XaJDYuGyPF3ucv2
        SicMi8m+weEb/Qq1DfHygpL0q
X-Received: by 2002:a05:6000:1292:b0:2c3:ee54:329c with SMTP id f18-20020a056000129200b002c3ee54329cmr5741586wrx.20.1675848668861;
        Wed, 08 Feb 2023 01:31:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+Cv8zXvOPTnPh2THy62/kNJt0WXub9wk7PPNyX7ucyEWbsPyMRJbfOjX0YmN8S3uIeh5SNdw==
X-Received: by 2002:a05:6000:1292:b0:2c3:ee54:329c with SMTP id f18-20020a056000129200b002c3ee54329cmr5741562wrx.20.1675848668686;
        Wed, 08 Feb 2023 01:31:08 -0800 (PST)
Received: from redhat.com ([2.52.156.127])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d6d06000000b002be099f78c0sm13818376wrq.69.2023.02.08.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:31:07 -0800 (PST)
Date:   Wed, 8 Feb 2023 04:31:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20230208041913-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
 <Y+MAPHZNLeBY13Pj@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+MAPHZNLeBY13Pj@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:51:56PM -0500, Theodore Ts'o wrote:
> Why not just simply compile a special CoCo kernel that doesn't have
> any drivers that you don't trust.

Or at least, start with that? You can then gradually expand that until
some config is both acceptable to distros and seems sufficiently trusty
to the CoCo project. Lots of kernel features got upstreamed this way.
Requirement to have an arbitrary config satisfy CoCo seems like a very
high bar to clear.

-- 
MST

