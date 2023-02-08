Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2845E68EF75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBHNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC22B7DB4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675861215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZD4eF51TgC9oueoQn3RvNXVi7q+IJ98lRzwYnyNJW8=;
        b=GKGSFnsaoo6SBmXhk0afNU7oC26Dl05/QgnFPgX4boR5tN5KxrRVRkzns/nbq9Abbzagc/
        Z9lCc/Z/d0GGpEnF9Vo1SUEVebTyI4DMVqSB0pKjKg2aGgEROZlPEy6xvTzNoJtvR+2IMI
        wPpTCBGuVC5/3ECAgZbMfC+1iT2dHik=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-nyJJ4nuiMl6_FE5Eo2OeAg-1; Wed, 08 Feb 2023 08:00:13 -0500
X-MC-Unique: nyJJ4nuiMl6_FE5Eo2OeAg-1
Received: by mail-ej1-f69.google.com with SMTP id ge13-20020a170907908d00b008aac038968aso1946707ejb.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZD4eF51TgC9oueoQn3RvNXVi7q+IJ98lRzwYnyNJW8=;
        b=tE1eRYZ2yzukjYKK4W/37rgOmDukPWNa/CAAGDuW0tV5OFx9Ond1Cx/97StQkMOAyn
         oLVvSG7W9YGsUNeEOt0AZiWv0zOZasR5DXzSTl29fNL+JIz9NxKcGsN8pmp8OtjETLAL
         694Hc57VOSQ5KahmwHNaJz6DQvwcDexunKUuIrdyvBF1bqge+8yaFaQRQycNO2rjjKHm
         f/lawgIgUNN8yIRtR62rRwcL9eAsgSH1SGjH7CabkiCXp0+7c2Ma/7VeEI2HtLlrd+WS
         frFAXFcPeXmNcHtnwBzAi9MSb2hncX0nmzrkYHkw2Iwf9OD2HlejXE6L3SToFClJ69Jl
         nWUw==
X-Gm-Message-State: AO0yUKVz1kEQpff6Wte/9E/fmj0c938tISd5OLLO+rp2X3UAstZL3x7L
        ISPzUr+rDj0ahyp/EGgPr6ajHkqIzEizGfDAoMh3g5n4NDh0Lm/tl8axl2ZleuCXOr+YwRlwyY9
        TGV2k5gK7g2+cOcmEyUtBfIPN
X-Received: by 2002:a17:907:160e:b0:8aa:c035:a651 with SMTP id hb14-20020a170907160e00b008aac035a651mr4776195ejc.37.1675861212230;
        Wed, 08 Feb 2023 05:00:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+Y3v6ZDYs6fJVD6bZp4jFnLUDSB+F47FHl799qXTEy7dorD0nLqLTYAKPJs+2DVrLfitMtjQ==
X-Received: by 2002:a17:907:160e:b0:8aa:c035:a651 with SMTP id hb14-20020a170907160e00b008aac035a651mr4776167ejc.37.1675861212053;
        Wed, 08 Feb 2023 05:00:12 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id de48-20020a1709069bf000b0088cf92eb0e1sm8267710ejc.150.2023.02.08.05.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:00:11 -0800 (PST)
Date:   Wed, 8 Feb 2023 08:00:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20230208075747-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
 <Y+MAPHZNLeBY13Pj@mit.edu>
 <20230208041913-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:44:25AM +0000, Reshetova, Elena wrote:
> Because for the
> drivers that CoCo guest happens to need, there is no way to fix this problem by 
> either of these mechanisms (we cannot disable the code that we need), unless somebody
> writes a totally new set of coco specific drivers (who needs another set of 
> CoCo specific virtio drivers in the kernel?). 

I think it's more about pci and all that jazz, no?
As a virtio maintainer I applied patches adding validation and intend to
do so in the future simply because for virtio specifically people
build all kind of weird setups out of software and so validating
everything is a good idea.

-- 
MST

