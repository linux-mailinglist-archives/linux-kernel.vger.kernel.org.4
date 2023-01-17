Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260CE66E479
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjAQRJG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Jan 2023 12:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjAQRI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:08:59 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF79F442CD;
        Tue, 17 Jan 2023 09:08:57 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id v30so46004161edb.9;
        Tue, 17 Jan 2023 09:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPyMGuc6WmbllLPUUtMOqHDNFpRwlSVCoSN3HKjZ3rg=;
        b=3L3GsOlhm4ba4rnFwseRLW9jG57drZltSyFJHGniEJs3kVwITCVVh7gUjsbdqTqZ/g
         c4NUuhx2cdz28bksJTYICoWikomNolX9Tbsks4+tjLi3FGR3Mg6WjIw5f2MyXHI6/ISo
         ZdVgLdyRsgC7n12e+SqEV1dpQ7KriWz0EyNwF7enSo+j7UgB+FJxuJrUSUGo1C+vquZT
         AIUyGuDqUKICvdCye8WhZN+MPkpJI32sRziAAaavKUJvQQLlOe12l0PRsWJNjt1k197Z
         2OMH8+wew0E9QifO62bTKpmirgX3mL+33aky1yfL58BrXDiccRyIGphlxclAWg4uj1k4
         5geA==
X-Gm-Message-State: AFqh2kp3uAP8fABNHtcVAY2G6qsfV82Zr7j+KRjg98MxUcreCI2147UW
        o2bWzljTPCu2uHbTro2yNshd0PItrUDHffQ0tr0=
X-Google-Smtp-Source: AMrXdXum5EtFAv4AdKWJj3btghyyzSUTsH9PN61eg6VsPlnPwUhjQeIaUrN0TpyORIIQEMfEWYtRmy0oVRXcmxrVmSA=
X-Received: by 2002:a05:6402:40d6:b0:46d:53d7:d1f6 with SMTP id
 z22-20020a05640240d600b0046d53d7d1f6mr434129edb.211.1673975336249; Tue, 17
 Jan 2023 09:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20230117155724.22940-1-jgross@suse.com> <CAJZ5v0iCAT2W-m1T-v1wSBw+GQerhMAp1hT6SioJ53RQY=oA3g@mail.gmail.com>
 <7f969b09-438b-cee3-be4c-e08b97457b12@intel.com>
In-Reply-To: <7f969b09-438b-cee3-be4c-e08b97457b12@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 18:08:45 +0100
Message-ID: <CAJZ5v0iOmZouhSb_ap0MA3-sk6RWJ7MRpTuGekrJrvOn-Y4JYQ@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: fix suspend with Xen PV
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/17/23 08:47, Rafael J. Wysocki wrote:
> >> Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
> >> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> ---
> >> V2:
> >> - new approach, avoid calling acpi_get_wakeup_address()
> > I'll queue this up for 6.3 if the x86 people don't object.
>
> That 'Fixes:' patch looked to me like it was applied during the 6.2
> merge window.  I would have expected a fix to go up for 6.2 final.

Right, sorry.  Definitely, 6.2-rc material.
