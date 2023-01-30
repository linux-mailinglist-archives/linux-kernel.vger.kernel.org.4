Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80D681497
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjA3PRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjA3PQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:16:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CB37556
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2kjRBE9UKCBXQY30JsYq6YWQr5DUvJD0QimN47cIKM=;
        b=Qui2lVUIjM/e7t6NqXeFCHZGtw5SNX6/vtKS0gMtN4rkLNPTN9q+y/d24FcySfSa+zNXmc
        2SwRNmjUcADoSabMB7HwZU9O6iQ1Y1xWZdHHknAisDYmiZI7stHOiIGkIwZTylNWgpPqwF
        eSmu5Vkp756SHNdVlpYFrHFm4MP0Lvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-12be0FyCMhSGc9ymLNEfNA-1; Mon, 30 Jan 2023 10:14:51 -0500
X-MC-Unique: 12be0FyCMhSGc9ymLNEfNA-1
Received: by mail-wm1-f69.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso4506213wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2kjRBE9UKCBXQY30JsYq6YWQr5DUvJD0QimN47cIKM=;
        b=LpAjTGKEWIedTPq/CRr8134ER6Noi3Nl+qY4bXat7MnoUc4zOOePKQgIsVErWc8uo1
         LPlVrYrBP0zXToXClHcRKiBBzBvbypQ5KtA7QLSP+RRXukpd1aUCzktUoo0xaqqglyjN
         RA/rs85NTYeCrWmJICUp09hPALLKiPk+dookxAcDxis5zkq1oKwmpDSfb/K7M1nCHauX
         q28deFJXtXUncV7liQ4VBvwUm71KRC4TYEqynvDvoICwA+d1bMzEm6HcoEg6cD/d5Z5g
         r1MllLPZFkQ4vF0Ky6CrVZf2X4Q5ojMyQaLJ5VDAIMuvxxaN76ZJIYv7/wkBN+EkHR79
         6+Yw==
X-Gm-Message-State: AO0yUKWtbHQXzm/ORmqsuQWqYGlhnO3V0eHjSMLZQ6i3w/yUgAT6kDyV
        eRfQcJImYCQb7tJRCDOKSdteWE9pGKPeJruW8O9u++7n655SwwVHa7ecKIsmfgQWfQr3YBOz8YU
        +LBHAirGwGgpPpE0tzyWaj2gK
X-Received: by 2002:a05:600c:46ca:b0:3dc:5390:6499 with SMTP id q10-20020a05600c46ca00b003dc53906499mr5836128wmo.1.1675091690658;
        Mon, 30 Jan 2023 07:14:50 -0800 (PST)
X-Google-Smtp-Source: AK7set/WOOsBPhtnJOL1eweoIstR30lA3PseamBTWifpvvRSPHKnTRSjopwyGEKKuEEuhs/8HZcygA==
X-Received: by 2002:a05:600c:46ca:b0:3dc:5390:6499 with SMTP id q10-20020a05600c46ca00b003dc53906499mr5836101wmo.1.1675091690402;
        Mon, 30 Jan 2023 07:14:50 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c180a00b003daf672a616sm12758048wmp.22.2023.01.30.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:14:49 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:14:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20230130101426-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <m2pmaw5jv4.fsf@redhat.com>
 <20230130120052.7wfb5i2vql5ibkso@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130120052.7wfb5i2vql5ibkso@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:00:52PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jan 30, 2023 at 12:36:34PM +0100, Christophe de Dinechin wrote:
> > Is there for example anything that precludes TDX or SEV from executing
> > code in the bounce buffers?
> 
> In TDX, attempt to fetch instructions from shared memory (i.e. bounce
> buffer) will cause #GP, only data fetch is allowed. Page table also cannot
> be placed there and will cause the same #GP.

Same with SEV IIRC.

-- 
MST

