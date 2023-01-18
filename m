Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198FD672069
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjARPBF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Jan 2023 10:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjARPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:00:32 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3216049B;
        Wed, 18 Jan 2023 06:55:53 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id v6so40854960ejg.6;
        Wed, 18 Jan 2023 06:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b48v8QljjeQEvg4WS7Gp0aF7ulXCUr3rAEntulrG8ig=;
        b=aoRLmaHoo6taw0BIhgPX2qkGb9FANR4kEm2BjiX8UgiVQPxmUX34pp9NhwMe9NT1qq
         MqgXT0WVDikGvkpP6S1Y+//7FyFGnrYQ+umaX42C7VC84vfHSQ+POQv28mSp0/gQHPTo
         dli3loN5caI4UTjVOJRtYHdsiX7XDYcHS7N2jcJ4rECRTKAvnLGbYw8SbYFVi1J89BoR
         SW0sH1hfnrvpdzXKwY2cYbaS6GOZvMlKtVlorQ9PTlT8q0FDS+4uslKCZZdDDDKw8Lbn
         B42TasX/hOZhXZsnm6DQKLyzmEsCqqwNPD1f318SS8oZ888JZxrR5t2jCE3dDJNXvs5L
         4XWQ==
X-Gm-Message-State: AFqh2kqT1WO07Sxr5Xrg0jm/dabRKllbVkscqjJNB+TZqbZzWMIldn83
        QlBoT3ylhtOvYl410SmuhfoyMHyTi6+saIugAZ0=
X-Google-Smtp-Source: AMrXdXtOAWIZIC5HT7/4nUTX9+gkurr4UMHBJyjTiC9rCjfjB+4K7GJaxInxHkN7JLsJn9RV0QkqAMishSZNR3BLDx4=
X-Received: by 2002:a17:906:eb1b:b0:86e:abe4:5acf with SMTP id
 mb27-20020a170906eb1b00b0086eabe45acfmr727417ejb.615.1674053751661; Wed, 18
 Jan 2023 06:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20230117155724.22940-1-jgross@suse.com> <CAJZ5v0iCAT2W-m1T-v1wSBw+GQerhMAp1hT6SioJ53RQY=oA3g@mail.gmail.com>
 <7f969b09-438b-cee3-be4c-e08b97457b12@intel.com> <CAJZ5v0iOmZouhSb_ap0MA3-sk6RWJ7MRpTuGekrJrvOn-Y4JYQ@mail.gmail.com>
 <43d0f8b1-0d2e-0e0f-d794-0048641d84f1@intel.com>
In-Reply-To: <43d0f8b1-0d2e-0e0f-d794-0048641d84f1@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jan 2023 15:55:39 +0100
Message-ID: <CAJZ5v0iNS2fV=xKJCVCK1wRjUxkNVUORLxhqFwCBr8Psgyx17w@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 1:15 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/17/23 09:08, Rafael J. Wysocki wrote:
> > On Tue, Jan 17, 2023 at 5:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >> On 1/17/23 08:47, Rafael J. Wysocki wrote:
> >>>> Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
> >>>> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> >>>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>>> ---
> >>>> V2:
> >>>> - new approach, avoid calling acpi_get_wakeup_address()
> >>> I'll queue this up for 6.3 if the x86 people don't object.
> >> That 'Fixes:' patch looked to me like it was applied during the 6.2
> >> merge window.  I would have expected a fix to go up for 6.2 final.
> > Right, sorry.  Definitely, 6.2-rc material.
>
> I think the original issue went up in x86/boot, so how about I queue
> this in x86/urgent?  Rafael, should I add an ack from you on it?

Yes, please.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
