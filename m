Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073768E331
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBGV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGV4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1EE3A5BA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675806910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ns5gbnLKn7zHOFaovfJzTuDPPi31RWqzHCdX60ieJbU=;
        b=ZSilrOmE0+nZvFp7s6UN5fVoYB7GKidDdBzPslSHDMRnLMtu6GZvvX2LmWQUTGu6Kvt3Yd
        1tjVLGf+/tuVSoNIM8rPG3GXlX+dPDF35fbRLSbMJIxuDGn+VHlbZtc9EGPuEe7uvhBQxM
        2LuFf58YDRPdVPSYi55yFG7JcJc8niI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-etq72OqYPNiTH7CdAKj8Bw-1; Tue, 07 Feb 2023 16:55:09 -0500
X-MC-Unique: etq72OqYPNiTH7CdAKj8Bw-1
Received: by mail-wm1-f72.google.com with SMTP id iz20-20020a05600c555400b003dc53fcc88fso67453wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns5gbnLKn7zHOFaovfJzTuDPPi31RWqzHCdX60ieJbU=;
        b=iIpqPnrz6wdu2hieon8O6NtInrroJS2QkT8Ik3gqEXwGrH+HatTHpKb2NNGF33RDr/
         /aRELBpMt6VMxk0FCzGebIqcC0jGkNS0nfPim4glwmt5rCPxY4hb/F60DChd7poGJzEy
         Ivg19iKKuTMw/lE3ofUkwdSSzCK8NIsDYEmvw3SJ5qznqgzScn070aJGCACAD4RnE7Ym
         pNI+gNj+XXj0qp30+C4ss/tLVmiJNxYgy++dHT2ZHcJNdDIlEUg+xaLtsY7b2U/0ZToq
         6qgvIjcJOwr9Hp3iNIZh1JeURsH1cON/Q8WEK4jZXq7H5zaWuMLYmudbf30+Y4+IUB4q
         pmig==
X-Gm-Message-State: AO0yUKWqQhyNcZd4gjcCg15ffGW5tVFXh4K5rUjMdcYio4SU4crqlbN2
        WZkdOIVhJBhDcFsUFPVtM77ZNvgtBJ3GABr6rA575rBAf3deMnSs8bTzBbWUbs56ptr9EXyqWgk
        eT0O6BrZG/LTDWWKgf51H3kru
X-Received: by 2002:adf:e80e:0:b0:2bf:f44b:7a29 with SMTP id o14-20020adfe80e000000b002bff44b7a29mr3760648wrm.40.1675806908266;
        Tue, 07 Feb 2023 13:55:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9fLl/1R5rJGBWgHb0QWMHHDY5vy4t3o0CvEvD9BeBmDvf9BeYOTUlFuO7kX7ZNygt81a0bVA==
X-Received: by 2002:adf:e80e:0:b0:2bf:f44b:7a29 with SMTP id o14-20020adfe80e000000b002bff44b7a29mr3760626wrm.40.1675806908075;
        Tue, 07 Feb 2023 13:55:08 -0800 (PST)
Received: from redhat.com ([2.52.8.17])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b002c3e7474b0fsm6558116wrc.13.2023.02.07.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:55:07 -0800 (PST)
Date:   Tue, 7 Feb 2023 16:55:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20230207165103-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:53:34PM -0600, Carlos Bilbao wrote:
> Given the limitations of current approach, does anyone have any other ideas
> for filtering devices prior to their initialization?

/me mumbles ... something something ... bpf ...

-- 
MST

