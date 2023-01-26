Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6467D1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAZQbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjAZQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42937376D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674750558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uQ5AeqRdHoqDiMiO534YbFssRp+d+rc3l3U4CDokNu0=;
        b=iS1zAoXImPje6u9tF4h2fGdsSdnhWR5X6q7dlIAbsL2zr6uURSMBetNmqIfWhomLgnZ5E4
        2Av9q6IsCfBRWZnhqRMgK+02Lzg8ANWET2ny89nP1QWafG0wAQXGBHI2B8P/wOhHwXtINu
        KjoxdWPd+prPVtD0AxTPsvRHqR5nW9o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-AoaTtJXIO3SNqtak7escPQ-1; Thu, 26 Jan 2023 11:29:15 -0500
X-MC-Unique: AoaTtJXIO3SNqtak7escPQ-1
Received: by mail-wm1-f71.google.com with SMTP id z22-20020a05600c0a1600b003db00dc4b69so3076222wmp.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ5AeqRdHoqDiMiO534YbFssRp+d+rc3l3U4CDokNu0=;
        b=uFKgz+U/vNJEiapyfsIVKF1ZvlBrqoSE8N4/q1EnP7w5BHrNMOeE3MP5sUdqLh6ZMd
         mYC6haHA8CHM/JGEVq/hElxwWTMlT2EiFItCrIipMyvgnSOC1ktBOn7CIrppTcRhpveS
         tB/zSTKs5sHNadmikuwmk59tf4HRbeZ/ifjlyagxwZQ6D1Q/ooXMYVigrH0CNnvbxeyW
         JzjsZM0jgLhv/2QrX+Lq8rS7BYObuVWyeH6/Ob5/CT1kSXeTSIWikYGLf6sMDyq3noXr
         HHS6EafApsr07qfn1pDoER4+wwMGWtS/ZDrBlZiIicUcQNSvoWVAEKqdVzzzAypJPybV
         2q9g==
X-Gm-Message-State: AFqh2kpiYkDCiMdeycIrd29iTmKad94rkbEZjMgdmlBG5hdXpblZ1riE
        +DoCnUNsRlulgKOxz7i2D2xvm3GlxzduU2Bv4HKizq0vatcoGOplF+zMHs3sLdapQCzcGsBDt/p
        gATXIRe/C98o1viQvljKI9LFV
X-Received: by 2002:a05:600c:1c9d:b0:3da:db4:6105 with SMTP id k29-20020a05600c1c9d00b003da0db46105mr36614916wms.37.1674750554561;
        Thu, 26 Jan 2023 08:29:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu/XUMPJtU5iYBp8WyqQ43Iwj8Vmxw+tnCVJfRHeV2qUt/JRWJYMx6HGI88x+KBLozOr/fmeg==
X-Received: by 2002:a05:600c:1c9d:b0:3da:db4:6105 with SMTP id k29-20020a05600c1c9d00b003da0db46105mr36614890wms.37.1674750554324;
        Thu, 26 Jan 2023 08:29:14 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c05c800b003c65c9a36dfsm1742661wmd.48.2023.01.26.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:29:13 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:29:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <20230126105618-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> And this is a very special aspect of 'hardening' since it is about hardening a kernel
> under different threat model/assumptions. 

I am not sure it's that special in that hardening IMHO is not a specific
threat model or a set of assumptions. IIUC it's just something that
helps reduce severity of vulnerabilities.  Similarly, one can use the CC
hardware in a variety of ways I guess. And one way is just that -
hardening linux such that ability to corrupt guest memory does not
automatically escalate into guest code execution.

If you put it this way, you get to participate in a well understood
problem space instead of constantly saying "yes but CC is special".  And
further, you will now talk about features as opposed to fixing bugs.
Which will stop annoying people who currently seem annoyed by the
implication that their code is buggy simply because it does not cache in
memory all data read from hardware. Finally, you then don't really need
to explain why e.g. DoS is not a problem but info leak is a problem - when
for many users it's actually the reverse - the reason is not that it's
not part of a threat model - which then makes you work hard to define
the threat model - but simply that CC hardware does not support this
kind of hardening.

-- 
MST

