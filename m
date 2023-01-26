Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0767167CF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAZO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAZO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB262249
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674745124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4P3EekWE0wh4v7Y6JRDBM+Ls4fIcP2CQOrYJI/TUYM=;
        b=DbFSrA4YgucYOC7Jc5zzsl1hBtLqrrXRwmbCRAbEgGnM+O3L0vZWeJ8wZr8pfFZN2WNzWf
        0h33fFKUujXw+2v62YZ5kfnEc/lNXGaoKoJ7Fia4TuYcI7cSkRwpUzWlQqrW98nYKW+tuW
        3L8ljezPnSp+tzrwPcup1HKIqKAT1fY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-7rfmPQ_DMRWAoDzFO-cLIQ-1; Thu, 26 Jan 2023 09:58:42 -0500
X-MC-Unique: 7rfmPQ_DMRWAoDzFO-cLIQ-1
Received: by mail-wm1-f69.google.com with SMTP id r15-20020a05600c35cf00b003d9a14517b2so2944185wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4P3EekWE0wh4v7Y6JRDBM+Ls4fIcP2CQOrYJI/TUYM=;
        b=0TqIq+niYVpG3IR6VsIXpt56BhAQPGOUEUNQV7GDX0OK/41mW0ktAH1fL3TnoEzp9G
         Ol9rKEpOAE89P3hSghPSOxj62nOfu78XS2xTNhyr/faa8+eAiHO5Ivrz3Azp28AUHSVR
         ERz8VRj0MIVU3Vi0IYS3e/uHYCF4xay6m1xBBdc02NQtcRvCNb/SAUWkmtZYhHhCISYV
         iRQELc6o5VQuGC/3qVgqB5fEAObdhj6L/EubAKXOoZvzrTXlDgswtUOzblOOUcLPdn5C
         5BMtUEBTkxmY/fwtGQl6XS7WTiEf9d7WlDPImPhlHnJFgYPI4mWpgTHLAKdjxRMn7F95
         dafw==
X-Gm-Message-State: AFqh2krK0l17JQtrw8aQlKROsw3yDo/s5eyoyDCBa0eU2goBiWAmt8/0
        OgYcNvq++aon43X290gvgWQ01ETH/ZOSNzj2gFV/yMeHJK0k7SyQcHGGzJLaarIo3BLU9J57blH
        AhacoDlRXoLknluzCDK6bOj7E
X-Received: by 2002:a05:600c:1604:b0:3c6:e61e:ae74 with SMTP id m4-20020a05600c160400b003c6e61eae74mr37552767wmn.4.1674745121776;
        Thu, 26 Jan 2023 06:58:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUHkTSF1aTLNZRATAUakPRX7lKJA20hKwBlcnoeqfg7B5Un3oBMDMpd5xsKa7o2OIjjRAhdA==
X-Received: by 2002:a05:600c:1604:b0:3c6:e61e:ae74 with SMTP id m4-20020a05600c160400b003c6e61eae74mr37552740wmn.4.1674745121600;
        Thu, 26 Jan 2023 06:58:41 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003db2e3f2c7csm12219398wms.0.2023.01.26.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:58:41 -0800 (PST)
Date:   Thu, 26 Jan 2023 14:58:38 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <Y9KVHnHnig4jwNPx@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E5Cg7mreDx737N@redhat.com>
 <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard Weinberger (richard.weinberger@gmail.com) wrote:
> On Wed, Jan 25, 2023 at 3:22 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Any virtual device exposed to the guest that can transfer potentially
> > sensitive data needs to have some form of guest controlled encryption
> > applied. For disks this is easy with FDE like LUKS, for NICs this is
> > already best practice for services by using TLS. Other devices may not
> > have good existing options for applying encryption.
> 
> I disagree wrt. LUKS. The cryptography behind LUKS protects persistent data
> but not transport. If an attacker can observe all IO you better
> consult a cryptographer.
> LUKS has no concept of session keys or such, so the same disk sector will
> always get encrypted with the very same key/iv.

Are you aware of anything that you'd use instead?

Are you happy with dm-verity for protection against modification?

Dave

> -- 
> Thanks,
> //richard
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

